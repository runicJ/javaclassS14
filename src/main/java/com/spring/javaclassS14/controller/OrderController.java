package com.spring.javaclassS14.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.OrderService;
import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PageVO;
import com.spring.javaclassS14.vo.PaymentVO;
import com.spring.javaclassS14.vo.UserVO;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    OrderService orderService;
    @Autowired
    UserService userService;
    @Autowired
    PageProcess pageProcess;

    @RequestMapping(value="/productOrder", method=RequestMethod.POST)
    public String processOrderFromCart(HttpServletRequest request, HttpSession session, Model model,
                                       @RequestParam(name="charge", defaultValue="0") int charge,
                                       @RequestParam(name="couponIdx", required = false) Integer couponIdx,
                                       @RequestParam(name="pointUse", defaultValue="0") int pointUse) {
    	
    	Integer userIdx = (Integer) session.getAttribute("sUidx");

        if (userIdx == null) {
        	return "redirect:/msg/userLoginNo";  // 로그인 필요
        }

        Enumeration<String> parameterNames = request.getParameterNames();
        List<OrderVO> orderVOS = new ArrayList<>();

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            System.out.println("paramName: " + paramName);
            if (paramName.startsWith("isChecked_")) {
                int cartIdx = Integer.parseInt(paramName.substring(10));
                int isChecked = Integer.parseInt(request.getParameter(paramName));
                System.out.println("cartIdx: " + cartIdx + ", isChecked: " + isChecked);

                if (isChecked == 1) {
                    List<CartItem> cartItems = orderService.getCartItemsByCartIdx(cartIdx);
                    if (cartItems == null) {
                        throw new NullPointerException("CartItems is null for cartIdx: " + cartIdx);
                    } 
                    else {
                        System.out.println("cartItems: " + cartItems.toString());
                    }

                    for (CartItem cartItem : cartItems) {
                        OrderVO orderVo = createCartItem(cartItem, userIdx, charge, couponIdx, pointUse, cartIdx);
                        orderVOS.add(orderVo);
                    }
                }
            }
        }
        if (orderVOS.isEmpty()) {
            return "redirect:/msg/productCartEmpty";
        }
        
        session.setAttribute("sOrderVOS", orderVOS);

        String userId = (String) session.getAttribute("sUid");
        UserVO userVO = userService.getUserIdCheck(userId);
        model.addAttribute("userVO", userVO);

        return "order/order";
    }

    private OrderVO createCartItem(CartItem cartItem, int userIdx, int charge, Integer couponIdx, int pointUse, int cartIdx) {
        OrderVO orderVO = new OrderVO(); 
        orderVO.setProductIdx(cartItem.getProductIdx());
        orderVO.setOrderProductIdx(cartItem.getOptionIdx());
        orderVO.setOrderQuantity(cartItem.getQuantity());
        orderVO.setPrice(cartItem.getProductPrice());
        orderVO.setOptionIdx(cartItem.getOptionIdx());
        orderVO.setUserIdx(userIdx);
        orderVO.setTotalPrice(cartItem.getProductPrice() * cartItem.getQuantity());
        orderVO.setCouponIdx(couponIdx != null ? couponIdx : 0);
        orderVO.setPointUse(pointUse);
        orderVO.setProductThumb(cartItem.getProductThumb());
        orderVO.setProductName(cartItem.getProductName());
        orderVO.setProductPrice(cartItem.getProductPrice());
        orderVO.setOptionGroupName(cartItem.getOptionGroupName());
        orderVO.setOptionName(cartItem.getOptionName());
        orderVO.setQuantity(cartItem.getQuantity());
        orderVO.setCharge(charge);
        orderVO.setCartIdx(cartIdx);
        return orderVO;
    }

    @RequestMapping(value="/payment", method=RequestMethod.POST)
    public String processPayment(PaymentVO paymentVO, HttpSession session, Model model) {
        // 결제 정보가 올바르게 들어왔는지 확인
        if (paymentVO == null || paymentVO.getAmount() <= 0) {
            return "redirect:/msg/paymentError";
        }

        session.setAttribute("sPaymentVO", paymentVO);
        return "order/paymentOk";
    }
    
    @Transactional
    @RequestMapping(value="/paymentResult", method=RequestMethod.GET)
    public String finalizeOrder(HttpSession session, Model model) {
        List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");
        PaymentVO paymentVO = (PaymentVO) session.getAttribute("sPaymentVO");

        if (orderVOS == null || paymentVO == null) {
            return "redirect:/msg/paymentError";  // 필요한 세션 정보가 없으면 에러 페이지로 리다이렉트
        }

        try {
            // 주문번호 생성
            String orderNumber = generateOrderNumber();
            System.out.println("Generated orderNumber: " + orderNumber);

            // 전체 주문의 총 금액 계산
            int totalOrderPrice = orderVOS.stream().mapToInt(vo -> vo.getPrice() * vo.getOrderQuantity()).sum();

            // 대표 OrderVO에 총 금액과 주문번호를 설정하여 orders_p에 저장
            OrderVO orderMeta = new OrderVO();
            orderMeta.setOrderNumber(orderNumber);
            orderMeta.setTotalPrice(totalOrderPrice);
            orderMeta.setUserIdx(orderVOS.get(0).getUserIdx());
            orderMeta.setCouponIdx(orderVOS.get(0).getCouponIdx());
            orderMeta.setPointUse(orderVOS.get(0).getPointUse());

            // orders_p에 총 금액 저장
            int orderIdx = orderService.setOrder(orderMeta);
            if (orderIdx <= 0) {
                throw new RuntimeException("Failed to create order in orders_p.");
            }

            // 각 OrderVO에 대해 상품 정보 저장
            for (OrderVO vo : orderVOS) {
                vo.setOrderNumber(orderNumber);
                vo.setOrderIdx(orderIdx); // 저장된 orderIdx 설정
                vo.setReceiverName(paymentVO.getBuyer_name());
                vo.setReceiverTel(paymentVO.getBuyer_tel());
                vo.setReceiverAddress(paymentVO.getBuyer_addr());

                // 상품 정보 저장
                System.out.println("Saving order product with orderIdx: " + orderIdx);
                orderService.setOrderProduct(vo);

                // 배송 정보 저장
                orderService.setDelivery(vo);

                // 장바구니에서 상품 삭제
                orderService.setCartDeleteAll(vo.getCartIdx());
            }

            // 결제 금액 설정
            paymentVO.setAmount(totalOrderPrice < 50000 ? totalOrderPrice + 3000 : totalOrderPrice);

            // 유저 포인트 적립 처리
            orderService.setUserPointPlus((int) (paymentVO.getAmount() * 0.01), orderVOS.get(0).getUserIdx());

            // 최종 정보를 세션에 저장
            session.setAttribute("sPaymentVO", paymentVO);
            session.setAttribute("orderTotalPrice", paymentVO.getAmount());

            return "redirect:/msg/paymentResultOk";  // 결제 성공 메시지 페이지로 리다이렉트

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/msg/paymentError";  // 에러 발생 시 에러 페이지로 리다이렉트
        }
    }

    // 주문번호 생성 메서드
    public static String generateOrderNumber() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String datePart = LocalDateTime.now().format(formatter);
        Random random = new Random();
        int randomNumber = 10000 + random.nextInt(90000);
        return datePart + "-" + randomNumber;
    }

    // 결재완료 되고난 후 주문/배송 테이블에 처리가 끝난 주문상품에 대한 결제정보 보여주기
    @SuppressWarnings("unchecked")
    @RequestMapping(value="/paymentResultOk", method=RequestMethod.GET)
    public String paymentResultOkGet(HttpSession session, Model model) {
        List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");
        model.addAttribute("orderVOS", orderVOS);
        session.removeAttribute("sOrderVOS");
        
        // 구매한 총 금액(여러개의 상품이라도 주문번호는 1개를 부여했다)은 배송테이블에 있기에 주문고유번호로 배송테이블에서 구매한 총 금액을 가져온다.
        int totalDeliveryOrder = orderService.getTotalDeleveryOrder(orderVOS.get(orderVOS.size() - 1).getOrderIdx());
        model.addAttribute("totalDeliveryOrder", totalDeliveryOrder);
        
        return "order/paymentResult";
    }
    
    // 배송지 정보 보여주기
    @RequestMapping(value="/orderDelivery", method=RequestMethod.GET)
    public String orderDeliveryGet(@RequestParam String orderIdx, Model model) {
        List<OrderVO> vos = orderService.getOrderDelivery(orderIdx); // 같은 주문번호로 구매된 상품이 2개 이상 있을 수 있기에 List 객체로 가져온다.
        
        // 주문 정보가 없는 경우 처리
        if (vos == null || vos.isEmpty()) {
            model.addAttribute("msg", "해당 주문 정보를 찾을 수 없습니다.");
            return "order/orderError"; // 에러 페이지로 이동
        }

        // 첫 번째 주문 정보 사용
        OrderVO orderVO = vos.get(0);

        // 결제 정보 가져오기 (orderService 또는 별도의 paymentService에서 가져올 수 있음)
        PaymentVO paymentVO = orderService.getPaymentByOrderIdx(orderIdx); // 결제 정보 조회

        // 결제 정보가 없는 경우 처리
        if (paymentVO == null) {
            model.addAttribute("msg", "결제 정보를 찾을 수 없습니다.");
            return "order/orderError"; // 에러 페이지로 이동
        }

        // 결제 방법 판별
        String payMethod = paymentVO.getImp_uid() != null && paymentVO.getImp_uid().startsWith("C") ? "카드결제" : "은행(무통장)결제";

        // 모델에 주문 및 결제 정보 추가
        model.addAttribute("payMethod", payMethod);
        model.addAttribute("orderVO", orderVO);
        model.addAttribute("paymentVO", paymentVO);

        return "order/orderDelivery";
    }
    
}

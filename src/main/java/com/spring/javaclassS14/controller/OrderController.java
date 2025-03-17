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
import com.spring.javaclassS14.vo.OrderProductVO;
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
        List<OrderProductVO> orderProductVOS = new ArrayList<>(); // 주문 상품 리스트
        OrderVO orderVO = null; // 주문 정보
        int totalOrderPrice = 0;  // 주문 전체 가격 변수

        while (parameterNames.hasMoreElements()) {
            String paramName = parameterNames.nextElement();
            System.out.println("paramName: " + paramName);

            if (paramName.startsWith("isChecked_")) {
                int cartIdx = Integer.parseInt(paramName.substring(10));
                int isChecked = Integer.parseInt(request.getParameter(paramName));
                System.out.println("cartIdx: " + cartIdx + ", isChecked: " + isChecked);

                if (isChecked == 1) {
                    List<CartItem> cartItems = orderService.getCartItemsByCartIdx(cartIdx);

                    if (cartItems == null || cartItems.isEmpty()) {
                        throw new NullPointerException("CartItems is null or empty for cartIdx: " + cartIdx);
                    } else {
                        System.out.println("cartItems: " + cartItems.toString());
                    }

                    if (orderVO == null) {
                        // **주문 정보(OrderVO) 생성 (한 번만 실행됨)**
                        orderVO = createOrder(userIdx, charge, couponIdx, pointUse, cartIdx, cartItems);
                    }

                    for (CartItem cartItem : cartItems) {
                        // 개별 상품 totalPrice 계산
                        int productTotalPrice = cartItem.getProductPrice() * cartItem.getQuantity();
                        totalOrderPrice += productTotalPrice;  // 전체 주문 가격 누적

                        OrderProductVO orderProductVO = createOrderProduct(cartItem, orderVO.getOrderIdx());
                        orderProductVO.setTotalPrice(productTotalPrice);  // 개별 상품 totalPrice 설정
                        orderProductVOS.add(orderProductVO);
                    }
                }
            }
        }

        if (orderProductVOS.isEmpty()) {
            return "redirect:/msg/productCartEmpty";
        }
        
        // 주문 전체 가격을 orderVO에 저장
        orderVO.setTotalPrice(totalOrderPrice);  // 전체 주문 가격을 `orders_p`에 저장
        
        // **세션에 주문 정보 및 주문 상품 정보 저장**
        session.setAttribute("sOrderVO", orderVO);
        session.setAttribute("sOrderProducts", orderProductVOS);

        // **사용자 정보 조회하여 JSP로 전달**
        String userId = (String) session.getAttribute("sUid");
        UserVO userVO = userService.getUserIdCheck(userId);
        model.addAttribute("userVO", userVO);

        return "order/order";
    }
    
    private OrderProductVO createOrderProduct(CartItem cartItem, int orderIdx) {
        OrderProductVO orderProductVO = new OrderProductVO();
        orderProductVO.setOrderIdx(orderIdx);
        orderProductVO.setProductIdx(cartItem.getProductIdx());
        orderProductVO.setOptionIdx(cartItem.getOptionIdx());
        orderProductVO.setOrderQuantity(cartItem.getQuantity());
        orderProductVO.setPrice(cartItem.getProductPrice());
        orderProductVO.setProductThumb(cartItem.getProductThumb());
        orderProductVO.setProductName(cartItem.getProductName());
        orderProductVO.setOptionGroupName(cartItem.getOptionGroupName());
        orderProductVO.setOptionName(cartItem.getOptionName());
        return orderProductVO;
    }
    
    private OrderVO createOrder(int userIdx, int charge, Integer couponIdx, int pointUse, int cartIdx, List<CartItem> cartItems) {
        OrderVO orderVO = new OrderVO();
        orderVO.setUserIdx(userIdx);
        orderVO.setTotalPrice(cartItems.stream().mapToInt(item -> item.getProductPrice() * item.getQuantity()).sum());
        orderVO.setCouponIdx(couponIdx != null ? couponIdx : 0);
        orderVO.setPointUse(pointUse);
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

        // **세션에서 주문 상품 리스트 가져오기**
        List<OrderProductVO> orderProductVOS = (List<OrderProductVO>) session.getAttribute("sOrderProducts");

        // 상품명이 여러 개일 경우 "첫 번째 상품 외 N개" 형태로 변환
        String goodsName;
        if (orderProductVOS == null || orderProductVOS.isEmpty()) {
            goodsName = "상품명 없음";
        } else if (orderProductVOS.size() == 1) {
            goodsName = orderProductVOS.get(0).getProductName();  // 단일 상품이면 그대로 사용
        } else {
            goodsName = orderProductVOS.get(0).getProductName() + " 외 " + (orderProductVOS.size() - 1) + "개";
        }

        // 변환된 상품명을 PaymentVO에 저장
        paymentVO.setName(goodsName);
        session.setAttribute("sPaymentVO", paymentVO);

        System.out.println("결제 요청 상품명: " + goodsName); // 디버깅 로그

        return "order/paymentOk";
    }
    
    @Transactional
    @RequestMapping(value="/paymentResult", method=RequestMethod.GET)
    public String finalizeOrder(HttpSession session, Model model) {
        System.out.println("✅ paymentResult 컨트롤러 실행됨");

        OrderVO orderMeta = (OrderVO) session.getAttribute("sOrderVO");
        List<OrderProductVO> orderProductVOS = (List<OrderProductVO>) session.getAttribute("sOrderProducts");
        PaymentVO paymentVO = (PaymentVO) session.getAttribute("sPaymentVO");

        if (orderMeta == null || orderProductVOS == null || orderProductVOS.isEmpty() || paymentVO == null) {
            System.out.println("🚨 필요한 세션 데이터가 없음! paymentError로 이동");
            return "redirect:/msg/paymentError";
        }

        try {
            // 주문번호 생성 및 저장
            String orderNumber = generateOrderNumber();
            orderMeta.setOrderNumber(orderNumber);
            int orderIdx = orderService.setOrder(orderMeta);
            System.out.println("🔹 저장된 orderIdx: " + orderIdx);
            if (orderIdx <= 0) {
                System.out.println("🚨 주문 저장 실패!");
                return "redirect:/msg/paymentError";
            }

            // 주문 상품 저장
            for (OrderProductVO orderProductVO : orderProductVOS) {
                orderProductVO.setOrderIdx(orderIdx);
                orderService.setOrderProduct(orderProductVO);
            }

            // 배송 정보 저장
            orderMeta.setOrderIdx(orderIdx);
            orderMeta.setReceiverName(paymentVO.getBuyer_name());
            orderMeta.setReceiverTel(paymentVO.getBuyer_tel());
            orderMeta.setReceiverAddress(paymentVO.getBuyer_addr());
            orderService.setDelivery(orderMeta);

            // 장바구니 비우기
            orderService.setCartDeleteAll(orderMeta.getCartIdx());

            // 결제 금액 설정
            int totalOrderPrice = orderMeta.getTotalPrice();
            paymentVO.setAmount(totalOrderPrice < 50000 ? totalOrderPrice + 3000 : totalOrderPrice);

            // 포인트 적립
            orderService.setUserPointPlus((int) (paymentVO.getAmount() * 0.01), orderMeta.getUserIdx());

            // **주문 정보 다시 조회하여 세션 저장**
            List<OrderVO> orderVOS = orderService.getOrderByUserIdx(orderMeta.getUserIdx());
            System.out.println("🔍 주문 정보 조회 후 세션 저장: " + orderVOS);
            session.setAttribute("sOrderVOS", orderVOS);
            session.setAttribute("sPaymentVO", paymentVO);
            session.setAttribute("orderTotalPrice", paymentVO.getAmount());

            System.out.println("✅ 결제 성공! `paymentResultOk` 페이지로 이동합니다.");
            return "redirect:/msg/paymentResultOk";

        } catch (Exception e) {
            System.out.println("🚨 주문 처리 중 예외 발생!");
            e.printStackTrace();
            return "redirect:/msg/paymentError";
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
    @RequestMapping(value="/paymentResultOk", method=RequestMethod.GET)
    public String paymentResultOkGet(HttpSession session, Model model) {
        // 세션에서 주문 정보 가져오기
        List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");

        // 주문 정보가 없을 경우 예외 처리
        if (orderVOS == null || orderVOS.isEmpty()) {
            return "redirect:/msg/orderNotFound"; // 주문 정보 없음 메시지 페이지로 이동
        }

        model.addAttribute("orderVOS", orderVOS);
        session.removeAttribute("sOrderVOS");

        // 마지막 주문의 주문번호 가져오기 (최신 주문)
        OrderVO lastOrder = orderVOS.get(orderVOS.size() - 1);
        int lastOrderIdx = lastOrder.getOrderIdx();

        // 배송 테이블에서 해당 주문번호의 총 주문 금액 가져오기
        int totalDeliveryOrder = orderService.getTotalDeleveryOrder(lastOrderIdx);
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

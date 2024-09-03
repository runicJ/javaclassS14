package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

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

    // 결제 완료 후 주문 내역 저장 및 처리
    @Transactional
	@SuppressWarnings("unchecked")
    @RequestMapping(value="/paymentResult", method=RequestMethod.GET)
    public String finalizeOrder(HttpSession session, Model model) {
        List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");
        PaymentVO paymentVO = (PaymentVO) session.getAttribute("sPaymentVO");

        if (orderVOS == null || paymentVO == null) {
            return "redirect:/msg/paymentError";  // 세션에서 필요한 정보를 찾지 못할 경우 에러 처리
        }

        // 결제 완료된 주문 정보 저장 및 처리
        for (OrderVO vo : orderVOS) {
            // PaymentVO에서 buyer_addr를 receiverAddress로 사용
            vo.setReceiverName(paymentVO.getBuyer_name());
            vo.setReceiverTel(paymentVO.getBuyer_tel());
            vo.setReceiverAddress(paymentVO.getBuyer_addr());  // buyer_addr를 receiverAddress로 사용

            orderService.setOrder(vo);  // 주문 정보 저장
            orderService.setOrderProduct(vo);  // 주문 상품 정보 저장
            orderService.setCartDeleteAll(vo.getCartIdx());  // 장바구니에서 주문된 상품 삭제
            orderService.setDelivery(vo);
        }

        // 총 주문 금액 계산
        int totalOrderPrice = orderVOS.stream().mapToInt(OrderVO::getTotalPrice).sum();
        if (totalOrderPrice < 50000) {
            paymentVO.setAmount(totalOrderPrice + 3000);  // 배송비 추가
        } 
        else {
            paymentVO.setAmount(totalOrderPrice);
        }

        // 유저 포인트 적립 처리
        orderService.setUserPointPlus((int) (paymentVO.getAmount() * 0.01), orderVOS.get(0).getUserIdx());

        // 최종 정보를 세션에 저장
        session.setAttribute("sPaymentVO", paymentVO);
        session.setAttribute("orderTotalPrice", paymentVO.getAmount());

        return "redirect:/msg/paymentResultOk";  // 결제 성공 메시지 페이지로 리다이렉트
    }

    // 결재완료되고난후 주문/배송 테이블에 처리가 끝난 주문상품에 대한 결제정보 보여주기
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
    
    // 나의 주문 내역 및 상태 보기
    @RequestMapping(value = "/myOrder", method = RequestMethod.GET)
    public String getMyOrder(Model model, HttpServletRequest request, HttpSession session,
                             @RequestParam(required = false) String startOrder,
                             @RequestParam(required = false) String endOrder,
                             @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
                             @RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
                             @RequestParam(name = "conditionOrderStatus", defaultValue = "전체", required = false) String conditionOrderStatus) {

        Integer userIdx = (Integer) session.getAttribute("sUidx");
        if (userIdx == null) {
            model.addAttribute("msg", "로그인이 필요합니다. 다시 로그인 해주세요.");
            return "redirect:/user/login";
        }

        // 조건을 '@'로 연결하여 검색 조건으로 사용
        String searchString = (startOrder != null ? startOrder : "") + "@" + 
                              (endOrder != null ? endOrder : "") + "@" + 
                              conditionOrderStatus;

        // 총 레코드 수 및 페이징 정보 계산
        PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrderStatus", userIdx, searchString);

        // 주문 목록 조회
        List<OrderVO> vos = orderService.getMyOrderStatus(pageVO.getStartIndexNo(), pageSize, userIdx, startOrder, endOrder, conditionOrderStatus);
        
        // 모델에 조회된 결과 추가
        model.addAttribute("vos", vos);
        model.addAttribute("startOrder", startOrder);
        model.addAttribute("endOrder", endOrder);
        model.addAttribute("conditionOrderStatus", conditionOrderStatus);
        model.addAttribute("pageVO", pageVO);

        return "order/myOrder";
    }
}

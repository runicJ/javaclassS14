package com.spring.javaclassS14.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PageVO;
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

    // 장바구니에서 '주문하기' 버튼을 클릭 시 처리
    @RequestMapping(value="/CartList", method=RequestMethod.POST)
    public String processOrderFromCart(HttpServletRequest request, HttpSession session, Model model,
                                       @RequestParam(name="baesong", defaultValue="0") int baesong) {
        String userId = (String) session.getAttribute("sMid");
        
        // 주문 고유번호 생성
        OrderVO maxIdx = orderService.getOrderMaxIdx();
        int idx = (maxIdx != null) ? maxIdx.getOrderIdx() + 1 : 1;

        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
        String orderIdx = sdf.format(new Date()) + idx;

        // 선택된 항목들을 배열로 처리
        String[] idxChecked = request.getParameterValues("idxChecked");
        List<OrderVO> orderVOS = new ArrayList<>();

        for (String strIdx : idxChecked) {
            CartVO cartVo = orderService.getCartIdx(Integer.parseInt(strIdx));
            for (CartItem cartItem : cartVo.getItems()) {
                OrderVO orderVo = createOrderVoFromCartItem(cartItem, orderIdx, userId, baesong);
                orderVOS.add(orderVo);
            }
        }
        session.setAttribute("sOrderVOS", orderVOS);

        UserVO userVO = userService.getUserIdCheck(userId);
        model.addAttribute("userVO", userVO);

        return "order/order";
    }

    private OrderVO createOrderVoFromCartItem(CartItem cartItem, String orderIdx, String userId, int baesong) {
        OrderVO orderVO = new OrderVO();
        orderVO.setProductIdx(cartItem.getProductIdx());
        orderVO.setOrderProductIdx(cartItem.getOptionIdx());
        orderVO.setOrderQuantity(cartItem.getQuantity());
        orderVO.setPrice(cartItem.getProductPrice());
        orderVO.setOptionIdx(cartItem.getOptionIdx());
        orderVO.setOrderIdx(Integer.parseInt(orderIdx));
        orderVO.setUserId(userId);
        orderVO.setTotalPrice(cartItem.getProductPrice() * cartItem.getQuantity());
        return orderVO;
    }

    // 결제시스템 호출 및 처리
    @RequestMapping(value="/payment", method=RequestMethod.POST)
    public String processPayment(OrderVO orderVo, HttpSession session, Model model) {
        model.addAttribute("orderVO", orderVo);
        session.setAttribute("sOrderVO", orderVo);
        return "order/paymentOk";
    }

    // 결제 완료 후 주문 내역 저장 및 처리
    @Transactional
    @RequestMapping(value="/paymentResult", method=RequestMethod.GET)
    public String finalizeOrder(HttpSession session, Model model) {
        List<OrderVO> orderVOS = (List<OrderVO>) session.getAttribute("sOrderVOS");
        OrderVO orderVO = (OrderVO) session.getAttribute("sOrderVO");

        session.removeAttribute("sOrderVO");

        for (OrderVO vo : orderVOS) {
            orderService.setOrder(vo);
            orderService.setCartDeleteAll(vo.getOrderProductIdx());
        }

        orderVO.setReceiverAddress(orderVO.getReceiverAddress());
        orderVO.setReceiverTel(orderVO.getReceiverTel());

        int totalOrderPrice = orderVOS.stream().mapToInt(OrderVO::getTotalPrice).sum();
        if (totalOrderPrice < 50000) {
            orderVO.setTotalPrice(totalOrderPrice + 3000);
        } else {
            orderVO.setTotalPrice(totalOrderPrice);
        }

        orderService.setDelivery(orderVO);
        orderService.setUserPointPlus((int)(orderVO.getTotalPrice() * 0.01), orderVOS.get(0).getUserId());

        session.setAttribute("sOrderVO", orderVO);
        session.setAttribute("orderTotalPrice", orderVO.getTotalPrice());

        return "redirect:/msg/paymentResultOk";
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
    public String dbOrderDeliveryGet(@RequestParam String orderIdx, Model model) {
        List<OrderVO> vos = orderService.getOrderDelivery(orderIdx); // 같은 주문번호로 구매된 상품이 2개 이상 있을 수 있기에 List 객체로 가져온다.
        
        OrderVO vo = vos.get(0); // 같은 배송지라면 0번째것 하나만 vo에 담아서 처리한다.
        String payMethod = vo.getImp_uid().startsWith("C") ? "카드결제" : "은행(무통장)결제";
        
        model.addAttribute("payMethod", payMethod);
        model.addAttribute("vo", vo);
        
        return "order/orderDelivery";
    }
    
    // 나의 주문 내역 보기
    @RequestMapping(value="/myOrder", method=RequestMethod.GET)
    public String dbMyOrderGet(HttpServletRequest request, HttpSession session, Model model,
                               @RequestParam(required = false) String startJumun, 
                               @RequestParam(required = false) String endJumun, 
                               @RequestParam(name="pag", defaultValue="1", required=false) int pag,
                               @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
                               @RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false) String conditionOrderStatus) {
        
        String mid = (String) session.getAttribute("sMid");
        int level = (int) session.getAttribute("sLevel");
        if (level == 0) mid = "전체";
        
        PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "dbMyOrder", mid, "");
        
        // 오늘 구매한 내역을 초기화면에 보여준다.
        List<OrderVO> vos = orderService.getMyOrderList(pageVO.getStartIndexNo(), pageSize, mid);
        
        model.addAttribute("vos", vos);                
        model.addAttribute("startJumun", startJumun);
        model.addAttribute("endJumun", endJumun);
        model.addAttribute("conditionOrderStatus", conditionOrderStatus);
        model.addAttribute("pageVO", pageVO);
        
        return "order/myOrder";
    }
    
    // 현재 주문 상태 보여주기
    @RequestMapping(value="/myOrderStatus", method=RequestMethod.GET)
    public String myOrderStatusGet(Model model, HttpServletRequest request, HttpSession session, 
                                   @RequestParam(required = false) String startJumun, 
                                   @RequestParam(required = false) String endJumun, 
                                   @RequestParam(name="pag", defaultValue="1", required=false) int pag,
                                   @RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize,
                                   @RequestParam(name="conditionOrderStatus", defaultValue="전체", required=false) String conditionOrderStatus) {
        String mid = (String) session.getAttribute("sMid");
        int level = (int) session.getAttribute("sLevel");
        
        if (level == 0) mid = "전체";
        String searchString = startJumun + "@" + endJumun + "@" + conditionOrderStatus;
        PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "myOrderStatus", mid, searchString); // 4번째인자에 '아이디/조건'(을)를 넘겨서 part를 아이디로 검색처리하게 한다.
        
        List<OrderVO> vos = orderService.getMyOrderStatus(pageVO.getStartIndexNo(), pageSize, mid, startJumun, endJumun, conditionOrderStatus);
        model.addAttribute("vos", vos);                
        model.addAttribute("startJumun", startJumun);
        model.addAttribute("endJumun", endJumun);
        model.addAttribute("conditionOrderStatus", conditionOrderStatus);
        model.addAttribute("pageVO", pageVO);
        
        return "order/myOrder";
    }
}

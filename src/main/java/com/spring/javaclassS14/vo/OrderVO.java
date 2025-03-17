package com.spring.javaclassS14.vo;

import java.util.List;

import lombok.Data;

@Data
public class OrderVO {
    // 주문 정보 (order_p)
    private int orderIdx;
    private int userIdx;
    private String userId;
    private int totalPrice;
    private Integer couponIdx;
    private int pointUse;
    private String orderStatus;
    private String orderDate;
    private String orderNumber;

    private String paymentStatus;
    private String paymentMethod;
    private String transactionId;
    
    // 배송 관련 정보
    private String receiverName;
    private String receiverTel;
    private String receiverAddress;
    private String country;

    // 주문 상품 목록 (1:N 관계)
    private List<OrderProductVO> orderProducts;
    
    private int charge;   // 배송비
    private int cartIdx;  // 장바구니 번호
}

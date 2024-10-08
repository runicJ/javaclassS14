package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class OrderVO {
	
	// order_p
    private int orderIdx;
    private int userIdx;
    private String userId;
    private int totalPrice;
    private Integer couponIdx;
    private int pointUse;
    private String orderStatus;
    private String orderDate;
    private String orderNumber;
    
    // 주문 및 상품 정보
    private String productThumb;
    private String productName;
    private int productPrice;
    private String optionGroupName;
    private String optionName;
    private int quantity;
    private int charge;

    // order_product
    // 주문 상품 관련 정보
    private int orderProductIdx;
    private int productIdx;
    private int orderQuantity;
    private int price;
    private int optionIdx;
    private int cartIdx;

    // 배송 관련 정보
    private String receiverName;
    private String receiverTel;
    private String receiverAddress;
    private String country;
    
}

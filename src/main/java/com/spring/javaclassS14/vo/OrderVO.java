package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class OrderVO {
	
	// order_p
    private int orderIdx;
    private int userIdx;
    private int totalPrice;
    private int couponIdx;
    private int pointUse;
    private String orderStatus;
    private String orderDate;
    
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

}

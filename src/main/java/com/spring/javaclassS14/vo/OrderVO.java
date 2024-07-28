package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class OrderVO {
    private int orderIdx;
    private String userId;
    private int totalPrice;
    private int couponIdx;
    private int pointUse;
    private String orderStatus;
    private String orderDate;

    // order_product
    private int orderProductIdx;
    private int productIdx;
    private int orderQuantity;
    private int price;
    private int optionIdx;

    // 결제 및 배송 관련 필드 추가
    private String receiverName;
    private String receiverTel;
    private String receiverAddress;
    private String country;
    private String imp_uid;
    private String merchant_uid;
    private int paid_amount;
    private String apply_num;
}

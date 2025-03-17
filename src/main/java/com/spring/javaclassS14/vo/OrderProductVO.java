package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class OrderProductVO {
    // 주문 상품 정보 (order_product)
    private int orderProductIdx;
    private int orderIdx;  // 주문번호 (연결)
    private int productIdx;
    private String productName;
    private String productThumb;
    private int orderQuantity;
    private int price;
    private int optionIdx;
    private String optionGroupName;
    private String optionName;
    private int totalPrice;
    
    // totalPrice 자동 계산 메서드 추가
    public void updateTotalPrice() {
        this.totalPrice = this.price * this.orderQuantity;
    }
}

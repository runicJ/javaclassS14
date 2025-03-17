package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class CartItem {
    private int productIdx;
    private int optionIdx;
    private int quantity;
    private boolean isSoldOut;
    private String addedDate;
    private String optionName; // 추가
    private String optionGroupName; // 추가
    private String productThumb; // 추가
    private String productName; // 추가
    private int productPrice;
    private int totalPrice; // 추가 (개별 상품의 총 가격)
    private String productTags;
    private String couponIdx;
    private String pointUse;

    // 생성자에서 totalPrice 자동 계산
    public CartItem() {
        updateTotalPrice();
    }
    
    public String getIsSoldOutAsString() {
        return isSoldOut ? "y" : "n";
    }
    
    // 수량이 변경될 때 자동으로 totalPrice 업데이트
    public void setQuantity(int quantity) {
        this.quantity = quantity;
        updateTotalPrice();
    }

    // 상품 가격이 변경될 때 자동으로 totalPrice 업데이트
    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
        updateTotalPrice();
    }
    
    // totalPrice 자동 계산 메서드 추가
    public void updateTotalPrice() {
        this.totalPrice = this.productPrice * this.quantity;
    }
}

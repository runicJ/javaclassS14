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

    public String getIsSoldOutAsString() {
        return isSoldOut ? "y" : "n";
    }
}

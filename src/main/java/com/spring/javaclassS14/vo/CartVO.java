package com.spring.javaclassS14.vo;

import java.util.List;

import lombok.Data;

@Data
public class CartVO {
	
    private int cartIdx;
    private int userIdx;
    private String userId;
    private List<CartItem> items;
	
}
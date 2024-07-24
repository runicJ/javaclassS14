package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class CartVO {
	
	private int cartIdx;
	private String userId;
	private int productIdx;
	private String quantity;
	private String addedDate;
	private String isSoldOut;
	private int optionIdx;
	
}

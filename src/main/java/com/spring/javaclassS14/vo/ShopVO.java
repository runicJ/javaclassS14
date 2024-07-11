package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class ShopVO {
	private int productTopIdx;
	private String productTopName;
	private String useYn;
	private String hasMid;
	
	private int productMidIdx;
	private String productMidName;
}

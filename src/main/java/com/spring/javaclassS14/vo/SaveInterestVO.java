package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class SaveInterestVO {
	// 북마크
	private int bookmarkIdx;
	private int userIdx;
	private String userId;
	private String partUrl;
	private String addDate;
	
	// 관심 제품
	private int likedIdx;
	private int productIdx;
	private String likedAddDate;
	
	private String productName;
	private String productPrice;
	private String productStock;
}

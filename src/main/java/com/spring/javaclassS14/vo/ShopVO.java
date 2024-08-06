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
	
	private int productIdx;
	private String productCode;
	private String productName;
	private String productDetails;
	private String productStatus;
	private int productPrice;
	private int productDiscount;
	private String productPointFlag;
	private int productStock;
	private String stockDate;
	private int productQuantity;
	private String productOptFlag;
	private String productBrand;
	private String productCountry;
	private String asInfo;
	private String productThumb;
	private String shipAddress;
	private int returnFee;
	private String productTags;
	private int storeIdx;
	private int favoriteCount;
	private String createdDate;
	private String updatedDate;
	private String content;
	
	private int optionGroupIdx;
	private String optionGroupName;

	private int optionIdx;
	private String optionName;
	private int addPrice;
	
	private int createDiff;
	private int productCnt;
	
	private int isLiked;
	private double averageStar;
	private double averageRating;
}

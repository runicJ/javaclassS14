package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class ReviewVO {
	
	private int reviewIdx;
	private int productIdx;
	private String userId;
	private String nickName;
	private int orderIdx;
	private int re_step;
	private int re_order;
	private int star;
	private String reviewContent;
	private String reviewDate;
	
	private String userImage;
	private int productReviewCnt;
	private double averageStar;
}

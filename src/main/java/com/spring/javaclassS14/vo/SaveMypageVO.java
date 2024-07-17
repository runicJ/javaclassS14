package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class SaveMypageVO {
	// 북마크
	private int bookmarkIdx;
	private String userId;
	private String partUrl;
	private String addDate;
	
	// 관심 제품
	private int likedIdx;
	private int productIdx;
	private String likedAddDate;
}

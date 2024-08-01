package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class CsworkVO {
	// 공지사항
	private int noticeIdx;
	private String noticeTitle;
	private String content;
	private String createDate;
	private String noticeStatus;
	
}

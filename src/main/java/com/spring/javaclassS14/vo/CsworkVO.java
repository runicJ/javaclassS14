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

	// 문의하기
	private int qnaIdx;
	private String userId;  // nn
	private String qnaTitle;  // nn
	private String qnaContent;  // nn
	private String qnaDate;  // d
	private String qnaAnswerFlag;  // d
	private String qnaAnswerContent;
	private String qnaAnswerDate;
	private String qnaCategory;
	private String email;
}

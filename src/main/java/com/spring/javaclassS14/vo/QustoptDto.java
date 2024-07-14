package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class QustoptDto {
	//제공 답변 번호
	private int optNo;
	//설문질문번호
	private int questNo;
	//답변내용
	private String optContent;
	//표기순서
	private int optOrder;
}

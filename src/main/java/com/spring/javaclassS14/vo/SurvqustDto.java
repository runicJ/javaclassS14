package com.spring.javaclassS14.vo;

import java.util.List;

import lombok.Data;

@Data
public class SurvqustDto {
	//설문질문번호
	private int questNo;
	//설문조사번호
	private int survNo;
	//질문내용
	private String questContent;
	//질문유형
	private String questType;
	//표기순서
	private int questOrder;
	//옵션내용
	private List<QustoptDto> qustoptList;
	// 응답 리스트
	private List<AnswerDto> answerList;
}

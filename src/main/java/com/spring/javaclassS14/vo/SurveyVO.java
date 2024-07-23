package com.spring.javaclassS14.vo;

import java.util.List;

import lombok.Data;

@Data
public class SurveyVO {
	//<SurveyDto>
	private String userId;
	private String nickName;
	// 설문 조사 번호
	private int survNo;
	// 설문 제목
	private String survTitle;
	// 설문 설명
	private String survDesc;
	// 사용 여부
	private String useYn;
	// 삭제 여부
	private String delYn;
	// 질문내용
	private List<SurveyVO> survqustList;
	
	//<SurvqustDto>
	//설문질문번호
	private int questNo;
	//설문조사번호
	//private int survNo;
	//질문내용
	private String questContent;
	//질문유형
	private String questType;
	//표기순서
	private int questOrder;
	//옵션내용
	private List<SurveyVO> qustoptList;
	// 응답 리스트
	private List<SurveyVO> answerList;
	
	
	//<QustoptDto>
	//제공 답변 번호
	private int optNo;
	//설문질문번호
	//private int questNo;
	//답변내용
	private String optContent;
	//표기순서
	private int optOrder;
	
	
	//<AnswerDto>
	// 응답 합계
	private int count;
	// 응답 번호
	private int answNo;
	// 설문 질문 번호
	private int qustNo;
	// 응답한 회원 ID
	private String memId;
	// 응답 내용
	private String answCont;
	// 긴 응답 내용
	private String answLong;
	// 응답 날짜
	private String answDate;
}

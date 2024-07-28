package com.spring.javaclassS14.vo;

import java.util.List;
import lombok.Data;

@Data
public class SurveyQuestionVO {
    private int questNo;       // 설문 질문 번호
    private int survNo;        // 설문 조사 번호
    private String questContent; // 질문 내용
    private String questType;    // 질문 유형
    private int questOrder;      // 표기 순서
    private List<SurveyOptionVO> options; // 옵션 목록
    private List<SurveyAnswerVO> answerList; // 응답 리스트
}

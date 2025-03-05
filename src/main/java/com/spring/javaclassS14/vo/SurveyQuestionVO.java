package com.spring.javaclassS14.vo;

import java.util.List;
import lombok.Data;

@Data
public class SurveyQuestionVO {
    private int questIdx;       // 질문 ID
    private int surveyIdx;      // 설문 ID (어떤 설문에 속하는지)
    private String questContent; // 질문 내용
    private String questType;    // 질문 유형 (short, long, select, radio, check)
    private int questOrder;      // 설문 내에서의 순서

    private List<SurveyOptionVO> options; // ✅ 선택형 질문의 경우, 옵션 리스트 (1:N)
    private List<SurveyAnswerVO> answerList; // ✅ 해당 질문에 대한 응답 리스트 (1:N)
}
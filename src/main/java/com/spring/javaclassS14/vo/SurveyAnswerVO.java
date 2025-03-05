package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class SurveyAnswerVO {
    private int answNo;      // 응답 번호 (PK)
    private int questNo;     // 질문 ID (어떤 질문에 대한 응답인지)
    private int userIdx;     // 응답한 사용자 번호
    private String userId;   // 응답한 사용자 ID
    private String answCont; // 객관식 응답 값 (체크박스, 라디오 버튼 등)
    private String answLong; // 주관식 응답 값 (긴 답변)
    private String answDate; // 응답한 날짜
}
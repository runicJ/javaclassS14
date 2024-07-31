package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class SurveyAnswerVO {
    private int answNo;      // 응답 번호
    private int questNo;     // 설문 질문 번호
    private String userId;    // 응답한 회원 ID
    private String answCont; // 응답 내용
    private String answLong; // 긴 응답 내용
    private String answDate; // 응답 날짜
}

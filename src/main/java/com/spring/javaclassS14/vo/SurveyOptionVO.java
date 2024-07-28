package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class SurveyOptionVO {
    private int optNo;       // 제공 답변 번호
    private int questNo;     // 설문 질문 번호
    private String optContent; // 답변 내용
    private int optOrder;    // 표기 순서
}

package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class SurveyOptionVO {
    private int optionIdx;      // 옵션 ID
    private int questIdx;       // 해당 옵션이 속한 질문 ID
    private String optContent;  // 옵션 내용 (예: "예", "아니오", "보통")
    private int optOrder;       // 옵션 표시 순서
}
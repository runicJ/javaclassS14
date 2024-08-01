package com.spring.javaclassS14.vo;

import java.util.List;
import lombok.Data;

@Data
public class SurveyVO {
    private String userId;
    private String nickName;
    private int surveyIdx;      // 설문 조사 번호
    private String surveyTitle;// 설문 제목
    private String surveyDesc; // 설문 설명
    private String surveyThumb;
    private String useFlag;    // 사용 여부
    private String delFlag;    // 삭제 여부
    private String createDate;    // 삭제 여부
    private String modDate;    // 삭제 여부
    private List<SurveyQuestionVO> questList;  // 질문 목록
}
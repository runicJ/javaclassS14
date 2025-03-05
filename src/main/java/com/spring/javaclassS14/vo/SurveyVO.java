package com.spring.javaclassS14.vo;

import java.util.List;
import lombok.Data;

@Data
public class SurveyVO {
    private String userId;       // 설문 작성자 ID
    private int userIdx;         // 설문 작성자 번호
    private String nickName;     // 설문 작성자 닉네임
    private int surveyIdx;       // 설문 조사 ID
    private String surveyTitle;  // 설문 제목
    private String surveyDesc;   // 설문 설명
    private String surveyThumb;  // 썸네일 이미지
    private String useFlag;      // 사용 여부 (Y/N)
    private String delFlag;      // 삭제 여부 (Y/N)
    private String createDate;   // 생성 날짜
    private String modDate;      // 수정 날짜
    
    private List<SurveyQuestionVO> questList; // ✅ 설문에 포함된 질문 목록 (1:N 관계)
}
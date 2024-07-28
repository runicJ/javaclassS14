package com.spring.javaclassS14.vo;

import java.util.List;
import lombok.Data;

@Data
public class SurveyVO {
    private String userId;
    private String nickName;
    private int survNo;      // 설문 조사 번호
    private String survTitle;// 설문 제목
    private String survDesc; // 설문 설명
    private String useYn;    // 사용 여부
    private String delYn;    // 삭제 여부
    private List<SurveyQuestionVO> survqustList;  // 질문 목록
}
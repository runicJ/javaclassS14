package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.AnswerDto;
import com.spring.javaclassS14.vo.SurveyDto;


public interface ResSurvService {
	
	//응답하기
	void insertAnswer(List<AnswerDto> answerList) ;
	
	// 접속 회원 설문 응답 여부 확인
	public int resSurvYn(SurveyDto surveyDto);
	
}

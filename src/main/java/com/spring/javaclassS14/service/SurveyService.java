package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyVO;

public interface SurveyService {
	
	// 설문 만들기
	public int setSurveyInput(MultipartFile file, SurveyVO surveyVO);
	
	public SurveyVO getSurveyForm(int surveyIdx);
	
	// 설문 삭제하기
	public void delOneSurvey(int survNo);
	
	// 설문 수정 전 내용 삭제하기
	public void delOldSurvey(int survNo);
	
	// 설문 수정 후 내용 insert하기
	public void insertNewSurv(SurveyVO surveyDto);
	
	// 응답하기
	public int setSurveyAnswerInput(List<SurveyAnswerVO> answerList);
	
	// 접속 회원 설문 응답 여부 확인
	public int resSurvYn(SurveyVO surveyDto);
	
	// 설문 리스트 가져오기
	public List<SurveyVO> getSurveyEventList();
	
	// 설문 리스트 개수 가져오기
	public int getSurveyCnt();
	
	// 내 설문 리스트 가져오기
	public List<SurveyVO> getSurveyList(String userId);
	
	// 내 설문 리스트 개수 가져오기
	//public int getMyCnt(String userId);
	
	// 설문 결과 가져오기
	public SurveyVO getSurvRslt(int survNo);

	public SurveyVO getOneSurvey(String nickName, int survNo);

}

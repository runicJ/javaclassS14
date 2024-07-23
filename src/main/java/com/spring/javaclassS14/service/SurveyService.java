package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyVO;

public interface SurveyService {
	
	// RegSurvService
	//회원정보(닉네임) 가져오기
	public String getUserInfo(String userId);
	//설문 만들기
	public void insertSurv(SurveyVO surveyDto);
	//설문 수정에서 기존정보 불러오기
	public SurveyVO getSurvey(int survNo);
	//설문 삭제하기
	public void delOneSurvey(int survNo);
	
	//설문 수정 전 내용 삭제하기
	public void delOldSurvey(int survNo);
	
	//설문 수정 후 내용 insert하기
	public void insertNewSurv(SurveyVO surveyDto);
	
	
	// ResSurvService
	//응답하기
	public void insertAnswer(List<SurveyVO> answerList) ;
	
	// 접속 회원 설문 응답 여부 확인
	public int resSurvYn(SurveyVO surveyDto);

	
	// SurvListService
	public List<com.spring.javaclassS14.vo.SurveyVO> getSurvList(SearchVo searchVo);
	
	public int getListCnt(SearchVo searchVo);
	
	public List<SurveyVO> getMyList(SearchVo searchVo);
	
	public int getMyCnt(SearchVo searchVo);
	
	public SurveyVO getSurvRslt(int survNo);
	
	public SurveyVO getOneSurvey(int survNo);
}

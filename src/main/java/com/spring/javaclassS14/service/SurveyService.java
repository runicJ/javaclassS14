package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyVO;

public interface SurveyService {
	
	// 설문 만들기
	public void insertSurv(SurveyVO surveyDto);
	
	// 설문 수정에서 기존정보 불러오기
	public SurveyVO getSurvey(int survNo);
	
	// 설문 삭제하기
	public void delOneSurvey(int survNo);
	
	// 설문 수정 전 내용 삭제하기
	public void delOldSurvey(int survNo);
	
	// 설문 수정 후 내용 insert하기
	public void insertNewSurv(SurveyVO surveyDto);
	
	// 응답하기
	public void insertAnswer(List<SurveyAnswerVO> answerList);
	
	// 접속 회원 설문 응답 여부 확인
	public int resSurvYn(SurveyVO surveyDto);
	
	// 설문 리스트 가져오기
	public List<SurveyVO> getSurvList(SearchVo searchVo);
	
	// 설문 리스트 개수 가져오기
	public int getListCnt(SearchVo searchVo);
	
	// 내 설문 리스트 가져오기
	public List<SurveyVO> getMyList(SearchVo searchVo);
	
	// 내 설문 리스트 개수 가져오기
	public int getMyCnt(SearchVo searchVo);
	
	// 설문 결과 가져오기
	public SurveyVO getSurvRslt(int survNo);

	public SurveyVO getOneSurvey(String nickName, int survNo);

}

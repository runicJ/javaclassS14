package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyDto;

public interface SurvListService {
	public List<com.spring.javaclassS14.vo.SurveyDto> getSurvList(SearchVo searchVo);
	
	public int getListCnt(SearchVo searchVo);
	
	public List<SurveyDto> getMyList(SearchVo searchVo);
	
	public int getMyCnt(SearchVo searchVo);
	
	public SurveyDto getSurvRslt(int survNo);
	
	public SurveyDto getOneSurvey(int survNo);
}

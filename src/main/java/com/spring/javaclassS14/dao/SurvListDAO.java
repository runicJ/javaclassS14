package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.AnswerDto;
import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyDto;
import com.spring.javaclassS14.vo.SurvqustDto;

public interface SurvListDAO {

	public List<SurveyDto> getSurvList(@Param("searchVo") SearchVo searchVo);
	public int getListCnt(@Param("searchVo") SearchVo searchVo);
	public List<SurveyDto> getMyList(@Param("searchVo") SearchVo searchVo);
	public int getMyCnt(@Param("searchVo") SearchVo searchVo);
	public SurveyDto getOneSurv(@Param("survNo") int survNo);
	public List<SurvqustDto> getSurvQust(@Param("survNo") int survNo);
	public List<AnswerDto> getLongAnswer(@Param("survNo") int qustNo);
	public List<AnswerDto> getAnswer(@Param("survNo") int qustNo);
	public String getRegNick(@Param("surveyDto") SurveyDto surveyDto);

}

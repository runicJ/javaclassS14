package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.QustoptDto;
import com.spring.javaclassS14.vo.SurveyDto;
import com.spring.javaclassS14.vo.SurvqustDto;

public interface RegSurvDAO {
	
    public String getUserInfo(@Param("userId") String userId);
    public void insertSurv(@Param("surveyDto") SurveyDto surveyDto);
    public void insertSurvqust(@Param("survqustDto") SurvqustDto survqustDto);
    public void insertQustopt(@Param("qustoptDto") QustoptDto qustoptDto);
    public SurveyDto getSurvey(@Param("survNo") int survNo);
    public List<SurvqustDto> getSurvqustList(@Param("survNo") int survNo);
    public List<QustoptDto> getQustoptList(@Param("qustNo") int qustNo);
    public void delOneSurvey(@Param("survNo") int survNo);
    public void delSurvqust(@Param("survNo") int survNo);
    public void delQustopt(@Param("survNo") int survNo);
    public void delAnswer(@Param("survNo") int survNo);
    public void updateNewSurv(@Param("surveyDto") SurveyDto surveyDto);
    public void insertNewSurvqust(@Param("survqustDto") SurvqustDto survqustDto);
	
}

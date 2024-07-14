package com.spring.javaclassS14.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.AnswerDto;
import com.spring.javaclassS14.vo.SurveyDto;

public interface ResSurvDAO {

	void insertAnswer(@Param("answer") AnswerDto answer);

	int resSurvYn(@Param("surveyDto") SurveyDto surveyDto);

}

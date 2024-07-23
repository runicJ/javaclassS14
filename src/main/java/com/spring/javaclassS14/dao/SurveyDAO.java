package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyVO;

public interface SurveyDAO {
	
	// SurvListDAO
	public List<SurveyVO> getSurvList(@Param("searchVo") SearchVo searchVo);
	public int getListCnt(@Param("searchVo") SearchVo searchVo);
	public List<SurveyVO> getMyList(@Param("searchVo") SearchVo searchVo);
	public int getMyCnt(@Param("searchVo") SearchVo searchVo);
	public SurveyVO getOneSurv(@Param("survNo") int survNo);
	public List<SurveyVO> getSurvQust(@Param("survNo") int survNo);
	public List<SurveyVO> getLongAnswer(@Param("survNo") int qustNo);
	public List<SurveyVO> getAnswer(@Param("survNo") int qustNo);
	public String getRegNick(@Param("surveyDto") SurveyVO surveyDto);
	
	// RegSurvDAO
    public String getUserInfo(@Param("userId") String userId);
    public void insertSurv(@Param("surveyDto") SurveyVO surveyDto);
    public void insertSurvqust(@Param("survqustDto") SurveyVO survqustDto);
    public void insertQustopt(@Param("qustoptDto") SurveyVO qustoptDto);
    public SurveyVO getSurvey(@Param("survNo") int survNo);
    public List<SurveyVO> getSurvqustList(@Param("survNo") int survNo);
    public List<SurveyVO> getQustoptList(@Param("qustNo") int qustNo);
    public void delOneSurvey(@Param("survNo") int survNo);
    public void delSurvqust(@Param("survNo") int survNo);
    public void delQustopt(@Param("survNo") int survNo);
    public void delAnswer(@Param("survNo") int survNo);
    public void updateNewSurv(@Param("surveyDto") SurveyVO surveyDto);
    public void insertNewSurvqust(@Param("survqustDto") SurveyVO survqustDto);
    
    // ResSurvDAO
    public void insertAnswer(@Param("answer") SurveyVO answer);
    public int resSurvYn(@Param("surveyDto") SurveyVO surveyDto);
}

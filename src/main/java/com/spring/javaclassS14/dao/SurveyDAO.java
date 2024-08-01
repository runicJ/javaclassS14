package com.spring.javaclassS14.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyOptionVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
import com.spring.javaclassS14.vo.SurveyVO;

public interface SurveyDAO {
	
	// RegSurvDAO
	public int setSurveyInput(@Param("surveyVO") SurveyVO surveyVO);
	
	public void setQuestionInput(@Param("questionVO") SurveyQuestionVO questionVO);
	
	public void setOptionInput(@Param("optionVO") SurveyOptionVO optionVO);
	
	public SurveyVO getSurveyForm(@Param("surveyIdx") int surveyIdx);
	
	public List<SurveyQuestionVO> getSurveyQuestList(@Param("surveyIdx") int surveyIdx);
	
	public List<SurveyOptionVO> getQuestOptList(@Param("questIdx") int questIdx);
	
	public void delOneSurvey(@Param("survNo") int survNo);
	public void delSurvqust(@Param("survNo") int survNo);
	public void delQustopt(@Param("questNo") int questNo);
	public void delAnswer(@Param("questNo") int questNo);
	public void updateNewSurv(@Param("surveyDto") SurveyVO surveyDto);
	public void insertNewSurvqust(@Param("survqustDto") SurveyQuestionVO survqustDto);
	
    // SurvListDAO
    public List<SurveyVO> getSurveyEventList();
    
    public int getSurveyCnt();
    
    public List<SurveyVO> getSurveyList(@Param("userId") String userId);
    public SurveyVO getOneSurv(@Param("survNo") int survNo);
    public List<SurveyQuestionVO> getSurvQust(@Param("survNo") int survNo);
    public List<SurveyAnswerVO> getLongAnswer(@Param("questNo") int questNo);
    public List<SurveyAnswerVO> getAnswer(@Param("questNo") int questNo);
    
    // ResSurvDAO
    public int setSurveyAnswerInput(@Param("answer") SurveyAnswerVO answer);
    
    public int resSurvYn(@Param("surveyDto") SurveyVO surveyDto);

	public List<SurveyVO> getsurveyEventList();

}

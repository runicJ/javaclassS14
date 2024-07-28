package com.spring.javaclassS14.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyOptionVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
import com.spring.javaclassS14.vo.SurveyVO;

public interface SurveyDAO {
    // SurvListDAO
    List<SurveyVO> getSurvList(@Param("searchVo") SearchVo searchVo);
    int getListCnt(@Param("searchVo") SearchVo searchVo);
    List<SurveyVO> getMyList(@Param("searchVo") SearchVo searchVo);
    int getMyCnt(@Param("searchVo") SearchVo searchVo);
    SurveyVO getOneSurv(@Param("survNo") int survNo);
    List<SurveyQuestionVO> getSurvQust(@Param("survNo") int survNo);
    List<SurveyAnswerVO> getLongAnswer(@Param("questNo") int questNo);
    List<SurveyAnswerVO> getAnswer(@Param("questNo") int questNo);

    // RegSurvDAO
    void insertSurv(@Param("surveyDto") SurveyVO surveyDto);
    void insertSurvqust(@Param("survqustDto") SurveyQuestionVO survqustDto);
    void insertQustopt(@Param("qustoptDto") SurveyOptionVO qustoptDto);
    SurveyVO getSurvey(@Param("survNo") int survNo);
    List<SurveyQuestionVO> getSurvqustList(@Param("survNo") int survNo);
    List<SurveyOptionVO> getQustoptList(@Param("questNo") int questNo);
    void delOneSurvey(@Param("survNo") int survNo);
    void delSurvqust(@Param("survNo") int survNo);
    void delQustopt(@Param("questNo") int questNo);
    void delAnswer(@Param("questNo") int questNo);
    void updateNewSurv(@Param("surveyDto") SurveyVO surveyDto);
    void insertNewSurvqust(@Param("survqustDto") SurveyQuestionVO survqustDto);

    // ResSurvDAO
    void insertAnswer(@Param("answer") SurveyAnswerVO answer);
    int resSurvYn(@Param("surveyDto") SurveyVO surveyDto);
}

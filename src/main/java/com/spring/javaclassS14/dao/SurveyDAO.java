package com.spring.javaclassS14.dao;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyOptionVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
import com.spring.javaclassS14.vo.SurveyVO;

public interface SurveyDAO {

    // 설문 저장 (새로운 설문을 DB에 추가)
	public int setSurveyInput(SurveyVO surveyVO);

    // 특정 설문의 기본 정보 조회
    public SurveyVO getSurveyForm(@Param("surveyIdx") int surveyIdx);

    // 특정 설문에 포함된 질문 리스트 조회
    public List<SurveyQuestionVO> getSurveyQuestList(@Param("surveyIdx") int surveyIdx);

    // 특정 질문에 대한 선택지 리스트 조회
    public List<SurveyOptionVO> getQuestOptList(@Param("questIdx") int questIdx);

    // 설문 응답을 한 번에 저장 (Batch Insert)
    public int setSurveyAnswerInputBatch(@Param("answerList") List<SurveyAnswerVO> answerList);

    // 설문 삭제 (delFlag = 'Y' 업데이트)
    public void delOneSurvey(@Param("surveyIdx") int surveyIdx);

    // 특정 설문의 전체 결과 조회
    public SurveyVO getOneSurv(@Param("surveyIdx") int surveyIdx);

    // 사용자의 설문 응답 여부 확인
    public int resSurvYn(@Param("userIdx") int userIdx, @Param("surveyIdx") int surveyIdx);

    // 설문 수정 (제목 및 설명 수정)
    public void updateSurvey(SurveyVO surveyVO);

    // 페이징 적용된 설문 리스트 조회
    public List<SurveyVO> getSurveyEventListPaged(@Param("currentPage") int currentPage, @Param("cntPerPage") int cntPerPage);

    // 설문 수정 시 기존 데이터 삭제 (질문, 옵션, 응답 포함)
    public void delOldSurvey(@Param("surveyIdx") int surveyIdx);

    // 설문 수정 후 새로운 데이터 삽입
    public void insertNewSurv(SurveyVO surveyVO);

    // 특정 관리자의 설문 목록 조회
    public List<SurveyVO> getSurveyList(@Param("userIdx") int userIdx);

    // 설문 리스트 조회 메서드
	public List<SurveyVO> getSurveyEventList();

    // 특정 질문에 대한 응답 통계 조회
    public List<SurveyAnswerVO> getSurveyAnswerStats(@Param("questIdx") int questIdx, @Param("surveyIdx") int surveyIdx);

	public int getTotalSurveys(@Param("userIdx") int userIdx);

	public int saveSurveyQuestion(SurveyQuestionVO questionVO);

	public int saveSurveyOption(SurveyOptionVO optionVO);

	public int getLastSurveyId();

	public int getLastQuestId();

	public int insertSurveyAnswersBatch(@Param("answerList") List<SurveyAnswerVO> answerList);

	public int countUserSurveyAnswers(@Param("userIdx") int userIdx, @Param("surveyIdx") int surveyIdx);

	public void updateUseFlag(@Param("surveyIdx") int surveyIdx, @Param("useFlag") String useFlag);
}
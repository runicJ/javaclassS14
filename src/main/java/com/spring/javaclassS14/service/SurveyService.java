package com.spring.javaclassS14.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyOptionVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
import com.spring.javaclassS14.vo.SurveyVO;

public interface SurveyService {

    // 설문 리스트 조회
    public List<SurveyVO> getSurveyEventList();
    
    // 특정 설문 폼 조회
    public SurveyVO getSurveyForm(int surveyIdx);

    // 설문 응답 저장 (Batch Insert)
    public int setSurveyAnswerInputBatch(List<SurveyAnswerVO> answerList);

    // 설문 삭제 (delFlag = 'Y' 업데이트)
    public void delOneSurvey(int surveyIdx);

    // 설문 결과 조회
    public SurveyVO getSurvRslt(int surveyIdx);

    // 설문 수정 (제목/설명 수정 가능)
    public void updateSurvey(SurveyVO surveyVO);

    // 페이징 적용된 설문 리스트 조회
    public List<SurveyVO> getSurveyEventListPaged(int currentPage, int cntPerPage);

    // 관리자 전용 - 설문 저장
    public int setSurveyInput(MultipartFile fName, SurveyVO surveyVO, HttpServletRequest request);

    // 관리자 전용 - 특정 설문 조회
    public SurveyVO getOneSurvey(int surveyIdx);

    // 관리자 전용 - 설문 삭제 전 기존 데이터 삭제
    public void delOldSurvey(int surveyIdx);

    // 관리자 전용 - 설문 수정 (새로운 설문 데이터 삽입)
    public void insertNewSurv(SurveyVO surveyVO);

    // 관리자 전용 - 특정 관리자 설문 목록 조회
    public List<SurveyVO> getSurveyList(Integer userIdx);

    // 설문지 갯수
	public int getTotalSurveys(int userIdx);

	public boolean checkUserSurveyAnswered(int userIdx, int surveyIdx);

    // 설문 응답 여부 확인
	public int resSurvYn(int userIdx, int surveyIdx);
}
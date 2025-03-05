package com.spring.javaclassS14.service;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.dao.SurveyDAO;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyOptionVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
import com.spring.javaclassS14.vo.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService {

    @Autowired
    SurveyDAO surveyDAO;

    @Transactional
    @Override
    public int setSurveyInput(MultipartFile fName, SurveyVO surveyVO, HttpServletRequest request) {
        int res = 0;
        try {
            // 저장 경로 설정
            String realPath = request.getSession().getServletContext().getRealPath("/resources/data/survey/");
            System.out.println("파일 저장 경로: " + realPath);

            File uploadDir = new File(realPath);
            if (!uploadDir.exists()) uploadDir.mkdirs(); // 디렉토리 없으면 생성

            // 파일 저장 처리
            if (fName != null && !fName.isEmpty()) {
                String saveFileName = System.currentTimeMillis() + "_" + fName.getOriginalFilename();
                File saveFile = new File(realPath, saveFileName);
                fName.transferTo(saveFile); // 파일 저장
                System.out.println("파일 저장 성공: " + saveFile.getAbsolutePath());
                surveyVO.setSurveyThumb(saveFileName); // 저장된 파일명을 DB에 저장
            } else {
                surveyVO.setSurveyThumb("noImage.png"); // 기본 썸네일 설정
            }

            // 설문 정보 DB 저장
            res = surveyDAO.setSurveyInput(surveyVO);

        } catch (Exception e) { // Exception으로 변경
            e.printStackTrace();
            return 0; // 파일 저장 실패 시 0 반환
        }

        return res;
    }


    @Override
    public SurveyVO getSurveyForm(int surveyIdx) {
        SurveyVO surveyVO = surveyDAO.getSurveyForm(surveyIdx);
        List<SurveyQuestionVO> questions = surveyDAO.getSurveyQuestList(surveyIdx);
        surveyVO.setQuestList(questions);

        for (SurveyQuestionVO question : questions) {
            question.setOptions(surveyDAO.getQuestOptList(question.getQuestIdx()));
        }
        return surveyVO;
    }

    @Override
    public int setSurveyAnswerInputBatch(List<SurveyAnswerVO> answerList) {
        return surveyDAO.setSurveyAnswerInputBatch(answerList);
    }

    @Override
    public void delOneSurvey(int surveyIdx) {
        surveyDAO.delOneSurvey(surveyIdx);
    }

    // 설문 결과 조회
    @Override
    public SurveyVO getSurvRslt(int surveyIdx) {
        SurveyVO survey = surveyDAO.getOneSurv(surveyIdx);

        if (survey == null) return null;

        // 질문 목록 가져오기
        List<SurveyQuestionVO> questions = surveyDAO.getSurveyQuestList(surveyIdx);
        for (SurveyQuestionVO question : questions) {
            // 각 질문의 응답 데이터 가져오기
            List<SurveyAnswerVO> answers = surveyDAO.getSurveyAnswerStats(question.getQuestIdx());
            question.setAnswerList(answers);
        }

        survey.setQuestList(questions);
        return survey;
    }

    @Override
    public int resSurvYn(SurveyVO surveyDto) {
        return surveyDAO.resSurvYn(surveyDto);
    }

    @Override
    public void updateSurvey(SurveyVO surveyVO) {
        surveyDAO.updateSurvey(surveyVO);
    }

    @Override
    public List<SurveyVO> getSurveyEventListPaged(int currentPage, int cntPerPage) {
        return surveyDAO.getSurveyEventListPaged(currentPage, cntPerPage);
    }

    @Override
    public SurveyVO getOneSurvey(int surveyIdx) {
        return surveyDAO.getOneSurv(surveyIdx);
    }

    @Override
    public void delOldSurvey(int surveyIdx) {
        surveyDAO.delOldSurvey(surveyIdx);
    }

    @Override
    public void insertNewSurv(SurveyVO surveyVO) {
        surveyDAO.insertNewSurv(surveyVO);
    }

    @Override
    public List<SurveyVO> getSurveyList(Integer userIdx) {
        return surveyDAO.getSurveyList(userIdx);
    }

    @Override
    public List<SurveyVO> getSurveyEventList() {
        return surveyDAO.getSurveyEventList(); // DAO 호출하여 데이터 가져오기
    }

}
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
        // 파일 저장 처리
        String realPath = request.getSession().getServletContext().getRealPath("/resources/data/survey/");
        File uploadDir = new File(realPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        if (fName != null && !fName.isEmpty()) {
            try {
                String saveFileName = System.currentTimeMillis() + "_" + fName.getOriginalFilename();
                File saveFile = new File(realPath, saveFileName);
                fName.transferTo(saveFile);
                surveyVO.setSurveyThumb(saveFileName);
            } catch (IOException e) {
                e.printStackTrace();
                throw new RuntimeException("파일 저장 실패!");
            }
        } else {
            surveyVO.setSurveyThumb("noImage.png");
        }

        // 설문 저장 후 surveyIdx 가져오기
        int surveyIdx = surveyDAO.setSurveyInput(surveyVO);
        if (surveyVO.getSurveyIdx() == 0) {  // MyBatis가 surveyVO에 값을 채우지 못한 경우
            surveyIdx = surveyDAO.getLastSurveyId();
        } else {
            surveyIdx = surveyVO.getSurveyIdx();
        }
        //System.out.println("surveyIdx: " + surveyIdx);

        // 질문 & 옵션 저장 (바로 DAO 호출)
        int order = 1;
        for (SurveyQuestionVO question : surveyVO.getQuestList()) {
            question.setSurveyIdx(surveyIdx);  // surveyIdx 설정
            question.setQuestOrder(order++);   // questOrder 값 설정 (1부터 증가)

            int result = surveyDAO.saveSurveyQuestion(question);
            if (result <= 0) {
                throw new RuntimeException("질문 저장 실패!");
            }

            int questIdx = surveyDAO.getLastQuestId(); // INSERT 후 LAST_INSERT_ID()로 ID 가져오기
            question.setQuestIdx(questIdx); // 올바른 questIdx 설정

            System.out.println("Saved Question - questIdx: " + questIdx + ", surveyIdx: " + surveyIdx);

            // 옵션 저장
            if (question.getOptions() != null && !question.getOptions().isEmpty()) {
                int optOrder = 1; // 옵션 순서 초기화
                for (SurveyOptionVO option : question.getOptions()) {
                    option.setQuestIdx(questIdx);
                    //option.setOptOrder(optOrder++); // 옵션 순서 증가
                    option.setOptOrder(optOrder); // 명확하게 optOrder 설정
                    System.out.println("Saving option - questIdx: " + questIdx + ", optOrder: " + optOrder);
                    
                    int optRes = surveyDAO.saveSurveyOption(option);
                    if (optRes <= 0) {
                        throw new RuntimeException("옵션 저장 실패! (questIdx: " + questIdx + ")");
                    }
                    optOrder++; // 옵션 순서 증가
                }
            }
        }
        return surveyIdx;
    }

    @Override
    public SurveyVO getSurveyForm(int surveyIdx) {
        SurveyVO surveyVO = surveyDAO.getSurveyForm(surveyIdx);
        
        if (surveyVO != null) {
            List<SurveyQuestionVO> questions = surveyDAO.getSurveyQuestList(surveyIdx);

            // 각 질문에 옵션을 추가
            for (SurveyQuestionVO question : questions) {
                List<SurveyOptionVO> options = surveyDAO.getQuestOptList(question.getQuestIdx());
                question.setOptions(options); // 옵션 추가
            }

            surveyVO.setQuestList(questions);
        }
        return surveyVO;
    }

	/*
	 * @Transactional
	 * 
	 * @Override public int setSurveyAnswerInputBatch(List<SurveyAnswerVO>
	 * answerList) { System.out.println("저장할 응답 개수: " + answerList.size());
	 * 
	 * if (answerList == null || answerList.isEmpty()) { throw new
	 * RuntimeException("응답 데이터가 없습니다."); }
	 * 
	 * System.out.println("저장할 응답 개수: " + answerList.size()); for (SurveyAnswerVO
	 * answer : answerList) { System.out.println("질문 번호: " + answer.getQuestIdx());
	 * System.out.println("사용자 ID: " + answer.getUserIdx());
	 * System.out.println("응답 내용: " + answer.getAnswerContent());
	 * System.out.println("장문 응답: " + answer.getAnswerLong());
	 * surveyDAO.setSurveyAnswerInputBatch(answer); } public boolean
	 * checkDuplicateAnswer(int userIdx, int questIdx) { return
	 * surveyDAO.checkDuplicateAnswer(userIdx, questIdx) > 0; } }
	 */
    
    @Transactional
    @Override
    public int setSurveyAnswerInputBatch(List<SurveyAnswerVO> answerList) {
        return surveyDAO.insertSurveyAnswersBatch(answerList);
    }

    @Override
    public boolean checkUserSurveyAnswered(int userIdx, int surveyIdx) {
        return surveyDAO.countUserSurveyAnswers(userIdx, surveyIdx) > 0;
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
        return surveyDAO.getSurveyEventList();
    }


	@Override
	public int getTotalSurveys(int userIdx) {
        return surveyDAO.getTotalSurveys(userIdx);
	}

	@Override
	public int resSurvYn(int userIdx, int surveyIdx) {
		return surveyDAO.resSurvYn(userIdx, surveyIdx);
	}

}
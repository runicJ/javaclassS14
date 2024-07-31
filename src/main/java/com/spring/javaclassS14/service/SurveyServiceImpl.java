package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    public int setSurveyInput(SurveyVO surveyVO) {
        System.out.println("===insertSurv ServiceImpl START===");
        
        int res = surveyDAO.setSurveyInput(surveyVO);
        
        if (res > 0) {
	        List<SurveyQuestionVO> questList = surveyVO.getQuestList();
	
	        if (questList.isEmpty()) {
	            System.out.println("questList EMPTY!!");
	        } 
	        else {
	            System.out.println("questList NOT EMPTY!!");
	
	            for (SurveyQuestionVO question : questList) {
	                question.setSurveyIdx(surveyVO.getSurveyIdx());
	                surveyDAO.setQuestionInput(question);
	
	                List<SurveyOptionVO> options = question.getOptions();
	
	                if (options == null || options.isEmpty()) {
	                    System.out.println("options EMPTY!!");
	                } 
	                else {
	                    System.out.println("options NOT EMPTY!!");
	
	                    for (SurveyOptionVO option : options) {
	                        option.setQuestIdx(question.getQuestIdx());
	                        surveyDAO.setOptionInput(option);
	                    }
	                }
	            }
	        }
        }
        System.out.println("===insertSurv ServiceImpl END===");
        
        return res;
    }

    @Override
    public SurveyVO getSurvey(int survNo) {
        System.out.println("===getSurvey ServiceImpl START===");
        SurveyVO surveyDto = surveyDAO.getSurvey(survNo);
        List<SurveyQuestionVO> survqustList = surveyDAO.getSurvqustList(survNo);
        surveyDto.setQuestList(survqustList);

        for (SurveyQuestionVO question : survqustList) {
            List<SurveyOptionVO> options = surveyDAO.getQustoptList(question.getQuestIdx());
            question.setOptions(options);
            List<SurveyAnswerVO> answers = surveyDAO.getAnswer(question.getQuestIdx());
            question.setAnswerList(answers);
        }
        System.out.println("===getSurvey ServiceImpl END===");
        return surveyDto;
    }

    @Override
    public void delOneSurvey(int survNo) {
        System.out.println("delSurvey Service START");
        surveyDAO.delOneSurvey(survNo);
        System.out.println("delSurvey Service END");
    }

    @Override
    public void delOldSurvey(int survNo) {
        System.out.println("delOldSurv Service START");
        surveyDAO.delQustopt(survNo);
        surveyDAO.delAnswer(survNo);
        surveyDAO.delSurvqust(survNo);
        System.out.println("delOldSurv Service END");
    }

    @Override
    public void insertNewSurv(SurveyVO surveyDto) {
        System.out.println("===insertNewSurv ServiceImpl START===");
        surveyDAO.updateNewSurv(surveyDto);
        List<SurveyQuestionVO> survqustList = surveyDto.getQuestList();

        for (SurveyQuestionVO question : survqustList) {
        	question.setSurveyIdx(surveyDto.getSurveyIdx());
            surveyDAO.insertNewSurvqust(question);

            List<SurveyOptionVO> options = question.getOptions();

            for (SurveyOptionVO option : options) {
                option.setQuestIdx(question.getQuestIdx());
                surveyDAO.setOptionInput(option);
            }
        }
        System.out.println("===insertNewSurv ServiceImpl END===");
    }

    @Override
    public void insertAnswer(List<SurveyAnswerVO> answerList) {
        System.out.println("서비스에서 list" + answerList);

        for (SurveyAnswerVO answer : answerList) {
            System.out.println("서비스에서 하나씩" + answer);
            surveyDAO.insertAnswer(answer);
        }
    }

    @Override
    public int resSurvYn(SurveyVO surveyDto) {
        return surveyDAO.resSurvYn(surveyDto);
    }

    @Override
    public List<SurveyVO> getSurveyEventList() {
        return surveyDAO.getSurveyEventList();
    }

    @Override
    public int getSurveyCnt() {
        return surveyDAO.getSurveyCnt();
    }

    @Override
    public List<SurveyVO> getSurveyList(String userId) {
        return surveyDAO.getSurveyList(userId);
    }

    @Override
    public SurveyVO getSurvRslt(int survNo) {
        SurveyVO surveyDto = surveyDAO.getOneSurv(survNo);

        if (surveyDto.getSurveyDesc() != null)
            surveyDto.setSurveyDesc(surveyDto.getSurveyDesc().replace("\n", "<br>"));

        List<SurveyQuestionVO> survqust = surveyDAO.getSurvQust(survNo);

        for (SurveyQuestionVO question : survqust) {
            if ("long".equals(question.getQuestType())) {
                List<SurveyAnswerVO> answer = surveyDAO.getLongAnswer(question.getQuestIdx());

                for (SurveyAnswerVO answ : answer) {
                    answ.setAnswLong(answ.getAnswLong().replace("\n", "<br>"));
                }

                question.setAnswerList(answer);
            } else {
                question.setAnswerList(surveyDAO.getAnswer(question.getQuestIdx()));
            }
        }

        surveyDto.setQuestList(survqust);
        return surveyDto;
    }

	@Override
	public SurveyVO getOneSurvey(String nickName, int survNo) {
        SurveyVO surveyDto = surveyDAO.getOneSurv(survNo);
        surveyDto.setNickName(nickName);
        return surveyDto;
	}


}
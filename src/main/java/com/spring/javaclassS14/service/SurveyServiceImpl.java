package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.SurveyDAO;
import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyOptionVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
import com.spring.javaclassS14.vo.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService {

    @Autowired
    SurveyDAO surveyDAO;

    @Override
    public void insertSurv(SurveyVO surveyDto) {
        System.out.println("===insertSurv ServiceImpl START===");
        surveyDAO.insertSurv(surveyDto);
        List<SurveyQuestionVO> survqustList = surveyDto.getSurvqustList();

        if (survqustList.isEmpty()) {
            System.out.println("survqustList EMPTY!!");
        } else {
            System.out.println("survqustList NOT EMPTY!!");

            for (SurveyQuestionVO question : survqustList) {
                question.setSurvNo(surveyDto.getSurvNo());
                surveyDAO.insertSurvqust(question);

                List<SurveyOptionVO> options = question.getOptions();

                if (options == null || options.isEmpty()) {
                    System.out.println("options EMPTY!!");
                } else {
                    System.out.println("options NOT EMPTY!!");

                    for (SurveyOptionVO option : options) {
                        option.setQuestNo(question.getQuestNo());
                        surveyDAO.insertQustopt(option);
                    }
                }
            }
        }
        System.out.println("===insertSurv ServiceImpl END===");
    }

    @Override
    public SurveyVO getSurvey(int survNo) {
        System.out.println("===getSurvey ServiceImpl START===");
        SurveyVO surveyDto = surveyDAO.getSurvey(survNo);
        List<SurveyQuestionVO> survqustList = surveyDAO.getSurvqustList(survNo);
        surveyDto.setSurvqustList(survqustList);

        for (SurveyQuestionVO question : survqustList) {
            List<SurveyOptionVO> options = surveyDAO.getQustoptList(question.getQuestNo());
            question.setOptions(options);
            List<SurveyAnswerVO> answers = surveyDAO.getAnswer(question.getQuestNo());
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
        List<SurveyQuestionVO> survqustList = surveyDto.getSurvqustList();

        for (SurveyQuestionVO question : survqustList) {
            question.setSurvNo(surveyDto.getSurvNo());
            surveyDAO.insertNewSurvqust(question);

            List<SurveyOptionVO> options = question.getOptions();

            for (SurveyOptionVO option : options) {
                option.setQuestNo(question.getQuestNo());
                surveyDAO.insertQustopt(option);
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
    public List<SurveyVO> getSurvList(SearchVo searchVo) {
        return surveyDAO.getSurvList(searchVo);
    }

    @Override
    public int getListCnt(SearchVo searchVo) {
        return surveyDAO.getListCnt(searchVo);
    }

    @Override
    public List<SurveyVO> getMyList(SearchVo searchVo) {
        return surveyDAO.getMyList(searchVo);
    }

    @Override
    public int getMyCnt(SearchVo searchVo) {
        return surveyDAO.getMyCnt(searchVo);
    }

    @Override
    public SurveyVO getSurvRslt(int survNo) {
        SurveyVO surveyDto = surveyDAO.getOneSurv(survNo);

        if (surveyDto.getSurvDesc() != null)
            surveyDto.setSurvDesc(surveyDto.getSurvDesc().replace("\n", "<br>"));

        List<SurveyQuestionVO> survqust = surveyDAO.getSurvQust(survNo);

        for (SurveyQuestionVO question : survqust) {
            if ("long".equals(question.getQuestType())) {
                List<SurveyAnswerVO> answer = surveyDAO.getLongAnswer(question.getQuestNo());

                for (SurveyAnswerVO answ : answer) {
                    answ.setAnswLong(answ.getAnswLong().replace("\n", "<br>"));
                }

                question.setAnswerList(answer);
            } else {
                question.setAnswerList(surveyDAO.getAnswer(question.getQuestNo()));
            }
        }

        surveyDto.setSurvqustList(survqust);
        return surveyDto;
    }

	@Override
	public SurveyVO getOneSurvey(String nickName, int survNo) {
        SurveyVO surveyDto = surveyDAO.getOneSurv(survNo);
        surveyDto.setNickName(nickName);
        return surveyDto;
	}

}
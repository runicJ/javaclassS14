package com.spring.javaclassS14.service;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.SurveyDAO;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyOptionVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
import com.spring.javaclassS14.vo.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService {

    @Autowired
    SurveyDAO surveyDAO;
    
    @Autowired
    AllProvide allProvide;

    @Transactional
    @Override
    public int setSurveyInput(MultipartFile fName, SurveyVO surveyVO) {
        int res = 0;

        try {
            // 파일 저장 처리
            String originalFilename = fName.getOriginalFilename();
            if (originalFilename != null && !originalFilename.isEmpty()) {
                String saveFileName = UUID.randomUUID().toString() + originalFilename.substring(originalFilename.lastIndexOf("."));
                allProvide.writeFile(fName, saveFileName, "survey");
                surveyVO.setSurveyThumb(saveFileName);
            } else {
                return res; // 파일이 없으면 0 반환
            }

            // 설문조사 입력
            res = surveyDAO.setSurveyInput(surveyVO);

            if (res > 0) {
                // 설문조사 ID 업데이트
                int surveyIdx = surveyVO.getSurveyIdx();
                List<SurveyQuestionVO> questList = surveyVO.getQuestList();
                
                if (questList != null && !questList.isEmpty()) {
                    for (SurveyQuestionVO question : questList) {
                        question.setSurveyIdx(surveyIdx);
                        surveyDAO.setQuestionInput(question);  // 질문 삽입
                        
                        List<SurveyOptionVO> options = question.getOptions();
                        if (options != null && !options.isEmpty()) {
                            for (SurveyOptionVO option : options) {
                                option.setQuestIdx(question.getQuestIdx());
                                surveyDAO.setOptionInput(option);  // 선택지 삽입
                            }
                        }
                    }
                } else {
                    System.out.println("No questions found to insert.");
                }
            } else {
                System.out.println("Survey insert failed.");
            }

        } catch (IOException e) {
            e.printStackTrace();
            return res; // 파일 저장 오류 발생 시 0 반환
        }

        return res;
    }

    // 설문조사 폼 열기
    @Override
    public SurveyVO getSurveyForm(int surveyIdx) {
        System.out.println("===getSurvey ServiceImpl START===");
        SurveyVO surveyVO = surveyDAO.getSurveyForm(surveyIdx);
        List<SurveyQuestionVO> surveyQuestVOS = surveyDAO.getSurveyQuestList(surveyIdx);
        surveyVO.setQuestList(surveyQuestVOS);

        for (SurveyQuestionVO SurveyQuestionVO : surveyQuestVOS) {
            List<SurveyOptionVO> options = surveyDAO.getQuestOptList(SurveyQuestionVO.getQuestIdx());
            SurveyQuestionVO.setOptions(options);
        }
        System.out.println("===getSurvey ServiceImpl END===");
        return surveyVO;
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
    public int setSurveyAnswerInput(List<SurveyAnswerVO> answerList) {
        System.out.println("서비스에서 list" + answerList);
        int res = 0;
        
        for (SurveyAnswerVO answer : answerList) {
            System.out.println("서비스에서 하나씩" + answer);
            res = surveyDAO.setSurveyAnswerInput(answer);
        }
		return res;
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
    public List<SurveyVO> getSurveyList(Integer userIdx) {
        return surveyDAO.getSurveyList(userIdx);
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
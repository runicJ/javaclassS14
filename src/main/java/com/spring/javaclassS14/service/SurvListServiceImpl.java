package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.SurvListDAO;
import com.spring.javaclassS14.vo.AnswerDto;
import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyDto;
import com.spring.javaclassS14.vo.SurvqustDto;

@Service
public class SurvListServiceImpl implements SurvListService{
	
	@Autowired
	SurvListDAO survListDAO;
	
	@Override
	public List<SurveyDto> getSurvList(SearchVo searchVo) {
		return survListDAO.getSurvList(searchVo);
	}

	@Override
	public int getListCnt(SearchVo searchVo) {
		return survListDAO.getListCnt(searchVo);
	}

	@Override
	public List<SurveyDto> getMyList(SearchVo searchVo) {
		return survListDAO.getMyList(searchVo);
	}

	@Override
	public int getMyCnt(SearchVo searchVo) {
		return survListDAO.getMyCnt(searchVo);
	}

	@Override
	public SurveyDto getSurvRslt(int survNo) {
		SurveyDto surveyDto = survListDAO.getOneSurv(survNo);
		
		// 개행 마크업 변경하여 출력
		if(surveyDto.getSurvDesc() != null)
			surveyDto.setSurvDesc(surveyDto.getSurvDesc().replace("\n", "<br>"));
		
		// 설문 질문 리스트
		List<SurvqustDto> survqust = survListDAO.getSurvQust(survNo);
		
		// 설문 질문마다 응답한 결과 리스트 삽입
		for(SurvqustDto qust : survqust) {
			if("long".equals(qust.getQuestType())) {
				List<AnswerDto> answer = survListDAO.getLongAnswer(qust.getQuestNo());
				
				// 개행 마크업 변경하여 출력
				for(AnswerDto answ : answer) {
					answ.setAnswLong(answ.getAnswLong().replace("\n", "<br>"));
				}
				
				qust.setAnswerList(answer);
			} else {
				qust.setAnswerList(survListDAO.getAnswer(qust.getQuestNo()));
			}
		}
		
		surveyDto.setSurvqustList(survqust);
		return surveyDto;
	}

	@Override
	public SurveyDto getOneSurvey(int survNo) {
		SurveyDto surveyDto = survListDAO.getOneSurv(survNo);
		surveyDto.setNickName(survListDAO.getRegNick(surveyDto));
		
		return surveyDto;
	}

}

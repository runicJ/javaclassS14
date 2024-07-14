package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.ResSurvDAO;
import com.spring.javaclassS14.vo.AnswerDto;
import com.spring.javaclassS14.vo.SurveyDto;

@Service
public class ResSurvServiceImpl implements ResSurvService{
	
	@Autowired
	ResSurvDAO ResSurvDAO;

	@Override
	public void insertAnswer(List<AnswerDto> answerList) {
		System.out.println("서비스에서 list"+answerList);

		for(AnswerDto answer: answerList) {
			System.out.println("서비스에서 하나씩"+answer);
			ResSurvDAO.insertAnswer(answer);
		}
		
	}

	@Override
	public int resSurvYn(SurveyDto surveyDto) {
		return ResSurvDAO.resSurvYn(surveyDto);
	}

}

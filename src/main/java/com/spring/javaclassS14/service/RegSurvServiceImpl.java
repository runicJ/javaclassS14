package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.RegSurvDAO;
import com.spring.javaclassS14.vo.QustoptDto;
import com.spring.javaclassS14.vo.SurveyDto;
import com.spring.javaclassS14.vo.SurvqustDto;

@Service
public class RegSurvServiceImpl implements RegSurvService {
	
	@Autowired
	RegSurvDAO regSurvDAO;
	
	@Override
	public String getUserInfo(String userId) {
		
		return regSurvDAO.getUserInfo(userId);
	}
	
	//설문만들기
	@Override
	public void insertSurv(SurveyDto surveyDto) {
		System.out.println("===insertSurv ServiceImpl START===");
		
		regSurvDAO.insertSurv(surveyDto);
		
		List<SurvqustDto> survqustList = surveyDto.getSurvqustList();
		
		
		if (survqustList.isEmpty()) {
			System.out.println("survqustList  EMPTY!!");
		} else {
			System.out.println("survqustList  NOT EMPTY!!");
			
			for(SurvqustDto vo : survqustList) {
				regSurvDAO.insertSurvqust(vo);
				
				List<QustoptDto> qustoptList = vo.getQustoptList();
				
				if(qustoptList==null || qustoptList.isEmpty()) {
					System.out.println("qustoptList EMPTY!!");
				} else {
					System.out.println("qustoptList NOT EMPTY!!");
					
					for(QustoptDto qo : qustoptList) {
						regSurvDAO.insertQustopt(qo);
					}
				}
				
			}
			
		}
		
		System.out.println("===insertSurv ServiceImpl END===");
	}

	@Override
	public SurveyDto getSurvey(int survNo) {
		System.out.println("===getSurvey ServiceImpl START===");
		
		System.out.println("survNo : "+survNo);
		SurveyDto surveyDto = regSurvDAO.getSurvey(survNo);
		
		List<SurvqustDto> survqustList = regSurvDAO.getSurvqustList(survNo);
		surveyDto.setSurvqustList(survqustList);
	
		
		for(SurvqustDto dto:survqustList) {
			System.out.println("SurvqustDto ==>  "+dto);
			
			int qustNo = dto.getQuestNo();
			List<QustoptDto> qustoptList = regSurvDAO.getQustoptList(qustNo);
			System.out.println("qustoptList ==> "+qustoptList);
			
			for(QustoptDto vo:qustoptList) {		
				System.out.println("qustoptDto ==>  "+vo);
			}
			
			dto.setQustoptList(qustoptList);
		}
		
		System.out.println("===getSurvey ServiceImpl END===");
		
		return surveyDto;
	}

	@Override
	public void delOneSurvey(int survNo) {
		System.out.println("delSurvey Service START");
		
		regSurvDAO.delOneSurvey(survNo);
		
		System.out.println("delSurvey Service END");
		
	}

	@Override
	public void delOldSurvey(int survNo) {
		System.out.println("delOldSurv Service START");
		
		regSurvDAO.delQustopt(survNo);
		regSurvDAO.delAnswer(survNo);
		regSurvDAO.delSurvqust(survNo);
				
		System.out.println("delOldSurv Service END");
		
	}

	@Override
	public void insertNewSurv(SurveyDto surveyDto) {
		System.out.println("===insertNewSurv ServiceImpl START===");
		
		regSurvDAO.updateNewSurv(surveyDto);
		System.out.println("surveyDto update완료!!");
		System.out.println("=> "+surveyDto.toString());
		
		List<SurvqustDto> survqustList = surveyDto.getSurvqustList();
		
		if (survqustList.isEmpty()) {
			System.out.println("survqustList  EMPTY!!");
		} else {
			System.out.println("survqustList  NOT EMPTY!!");
			
			for(SurvqustDto vo : survqustList) {
				vo.setSurvNo(surveyDto.getSurvNo());
				System.out.println("새로 insert할 SurvqustDto vo => "+vo);
				regSurvDAO.insertNewSurvqust(vo);
				System.out.println("새로 insert할 SurvqustDto vo insert 완료!!");
				
				List<QustoptDto> qustoptList = vo.getQustoptList();
				
				if(qustoptList==null || qustoptList.isEmpty()) {
					System.out.println("qustoptList EMPTY!!");
				} else {
					System.out.println("qustoptList NOT EMPTY!!");
					
					for(QustoptDto qo : qustoptList) {
						System.out.println("새로 insert할 QustoptDto qo => "+qo);
						regSurvDAO.insertQustopt(qo);
						System.out.println("새로 insert할 QustoptDto qo insert 완료!!");
					}
				}
				
			}
			
		}
		
		System.out.println("===insertNewSurv ServiceImpl END===");
		
	}


}

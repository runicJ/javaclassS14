package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.SurveyDAO;
import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyVO;

@Service
public class SurveyServiceImpl implements SurveyService {
	
	@Autowired
	SurveyDAO surveyDAO;
	
	@Override
	public String getUserInfo(String userId) {
		
		return surveyDAO.getUserInfo(userId);
	}
	
	// RegSurvServiceImpl
	//설문만들기
	@Override
	public void insertSurv(SurveyVO surveyDto) {
		System.out.println("===insertSurv ServiceImpl START===");
		
		surveyDAO.insertSurv(surveyDto);
		
		List<SurveyVO> survqustList = surveyDto.getSurvqustList();
		
		
		if (survqustList.isEmpty()) {
			System.out.println("survqustList  EMPTY!!");
		} else {
			System.out.println("survqustList  NOT EMPTY!!");
			
			for(SurveyVO vo : survqustList) {
				surveyDAO.insertSurvqust(vo);
				
				List<SurveyVO> qustoptList = vo.getQustoptList();
				
				if(qustoptList==null || qustoptList.isEmpty()) {
					System.out.println("qustoptList EMPTY!!");
				} else {
					System.out.println("qustoptList NOT EMPTY!!");
					
					for(SurveyVO qo : qustoptList) {
						surveyDAO.insertQustopt(qo);
					}
				}
				
			}
			
		}
		
		System.out.println("===insertSurv ServiceImpl END===");
	}

	@Override
	public SurveyVO getSurvey(int survNo) {
		System.out.println("===getSurvey ServiceImpl START===");
		
		System.out.println("survNo : "+survNo);
		SurveyVO surveyDto = surveyDAO.getSurvey(survNo);
		
		List<SurveyVO> survqustList = surveyDAO.getSurvqustList(survNo);
		surveyDto.setSurvqustList(survqustList);
	
		
		for(SurveyVO dto:survqustList) {
			System.out.println("SurvqustDto ==>  "+dto);
			
			int qustNo = dto.getQuestNo();
			List<SurveyVO> qustoptList = surveyDAO.getQustoptList(qustNo);
			System.out.println("qustoptList ==> "+qustoptList);
			
			for(SurveyVO vo:qustoptList) {		
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
		System.out.println("surveyDto update완료!!");
		System.out.println("=> "+surveyDto.toString());
		
		List<SurveyVO> survqustList = surveyDto.getSurvqustList();
		
		if (survqustList.isEmpty()) {
			System.out.println("survqustList  EMPTY!!");
		} else {
			System.out.println("survqustList  NOT EMPTY!!");
			
			for(SurveyVO vo : survqustList) {
				vo.setSurvNo(surveyDto.getSurvNo());
				System.out.println("새로 insert할 SurvqustDto vo => "+vo);
				surveyDAO.insertNewSurvqust(vo);
				System.out.println("새로 insert할 SurvqustDto vo insert 완료!!");
				
				List<SurveyVO> qustoptList = vo.getQustoptList();
				
				if(qustoptList==null || qustoptList.isEmpty()) {
					System.out.println("qustoptList EMPTY!!");
				} else {
					System.out.println("qustoptList NOT EMPTY!!");
					
					for(SurveyVO qo : qustoptList) {
						System.out.println("새로 insert할 QustoptDto qo => "+qo);
						surveyDAO.insertQustopt(qo);
						System.out.println("새로 insert할 QustoptDto qo insert 완료!!");
					}
				}
				
			}
			
		}
		
		System.out.println("===insertNewSurv ServiceImpl END===");
		
	}

	// ResSurvServiceImpl
	@Override
	public void insertAnswer(List<SurveyVO> answerList) {
		System.out.println("서비스에서 list"+answerList);

		for(SurveyVO answer: answerList) {
			System.out.println("서비스에서 하나씩"+answer);
			surveyDAO.insertAnswer(answer);
		}
		
	}

	@Override
	public int resSurvYn(SurveyVO surveyDto) {
		return surveyDAO.resSurvYn(surveyDto);
	}
	
	
	// SurvListServiceImpl
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
		
		// 개행 마크업 변경하여 출력
		if(surveyDto.getSurvDesc() != null)
			surveyDto.setSurvDesc(surveyDto.getSurvDesc().replace("\n", "<br>"));
		
		// 설문 질문 리스트
		List<SurveyVO> survqust = surveyDAO.getSurvQust(survNo);
		
		// 설문 질문마다 응답한 결과 리스트 삽입
		for(SurveyVO qust : survqust) {
			if("long".equals(qust.getQuestType())) {
				List<SurveyVO> answer = surveyDAO.getLongAnswer(qust.getQuestNo());
				
				// 개행 마크업 변경하여 출력
				for(SurveyVO answ : answer) {
					answ.setAnswLong(answ.getAnswLong().replace("\n", "<br>"));
				}
				
				qust.setAnswerList(answer);
			} else {
				qust.setAnswerList(surveyDAO.getAnswer(qust.getQuestNo()));
			}
		}
		
		surveyDto.setSurvqustList(survqust);
		return surveyDto;
	}

	@Override
	public SurveyVO getOneSurvey(int survNo) {
		SurveyVO surveyDto = surveyDAO.getOneSurv(survNo);
		surveyDto.setMemId(surveyDAO.getRegNick(surveyDto));
		
		return surveyDto;
	}
}

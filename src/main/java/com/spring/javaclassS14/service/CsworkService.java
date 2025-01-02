package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.AirVO;
import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.SaveInterestVO;

public interface CsworkService {

	public List<BranchVO> getBranchList();

	public List<SaveInterestVO> findTopNews(int limit);

	public List<String> getMenuOptions();

	public List<AirVO> getAirInfo();

	public List<CsworkVO> getNoticeList();

	public CsworkVO getNoticeInfo(int noticeIdx);

	public BranchVO getBranchSearch(String branchName);

	public int setQnaInput(CsworkVO qnaVO, String sUid);

	public int setFaqInput(CsworkVO csworkVO);

	public List<CsworkVO> getFaqList();

	public List<CsworkVO> getFaqTopList();

	public List<CsworkVO> getFaqSearchList(String category, String keyword);

	public int setBranchInput(String realPath, BranchVO branchVO);

	public List<AirVO> getAirStation();

	public List<AirVO> getAirQuality(String stationName);

	public List<CsworkVO> getQnaList();

	public void sendQnaResponse(int qnaIdx, String qnaAnswerContent) throws Exception;

	public List<BranchVO> getPurchaseList();

	public CsworkVO getQnaById(int qnaIdx);

	public boolean updateQnaAnswer(int qnaIdx, String qnaAnswerContent);

}

package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.AirVO;
import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CrawlingVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.SaveInterestVO;

public interface CsworkDAO {

	public List<BranchVO> getBranchList();

	public List<SaveInterestVO> findTopNews(int limit);

	public List<String> getMenuOptions();

	public List<CsworkVO> getNoticeList();

	public CsworkVO getNoticeInfo(@Param("noticeIdx") int noticeIdx);

	public BranchVO getBranchSearch(@Param("branchName") String branchName);

	public int setFaqInput(@Param("csworkVO") CsworkVO csworkVO);

	public List<CsworkVO> getFaqList();

	public List<CsworkVO> getFaqTopList();

	public List<CsworkVO> getFaqSearchList(@Param("faqCategory") String category, @Param("keyword") String keyword);

	public int setBranchInput(@Param("branchVO") BranchVO branchVO);

	public int insertQnaForGuest(@Param("qnaVO") CsworkVO qnaVO);

	public int insertQnaForMember(@Param("qnaVO") CsworkVO qnaVO);

	public List<AirVO> getAirStation();

	public List<CsworkVO> getQnaList();

	public void sendQnaResponse(@Param("qnaIdx") int qnaIdx, @Param("qnaAnswerContent") String qnaAnswerContent);

	public void updateQna(CsworkVO qna);

	public CsworkVO findById(int qnaIdx);

	public List<BranchVO> getPurchaseList();

}

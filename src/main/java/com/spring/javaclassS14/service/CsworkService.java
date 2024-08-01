package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.AirVO;
import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.SaveMypageVO;

public interface CsworkService {

	public List<BranchVO> getBranchList();

	public List<SaveMypageVO> findTopNews(int limit);

	public List<String> getMenuOptions();

	public List<AirVO> getAirInfo();

	public List<CsworkVO> getNoticeList();

	public CsworkVO getNoticeInfo(int noticeIdx);

	public BranchVO getBranchSearch(String branchName);

	public BranchVO getBranchSearch2(double latitude, double longitude);

}

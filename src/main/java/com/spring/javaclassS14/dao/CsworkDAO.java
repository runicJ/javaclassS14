package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CrawlingVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.SaveMypageVO;

public interface CsworkDAO {

	public List<BranchVO> getBranchList();

	public List<SaveMypageVO> findTopNews(int limit);

	public List<String> getMenuOptions();

	public List<CsworkVO> getNoticeList();

	public CsworkVO getNoticeInfo(@Param("noticeIdx") int noticeIdx);

	public BranchVO getBranchSearch(@Param("branchName") String branchName);

	public BranchVO getBranchSearch2(@Param("latitude") double latitude, @Param("longitude") double longitude);

}

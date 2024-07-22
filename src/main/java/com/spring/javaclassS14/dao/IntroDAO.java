package com.spring.javaclassS14.dao;

import java.util.List;

import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CrawlingVO;
import com.spring.javaclassS14.vo.SaveMypageVO;

public interface IntroDAO {

	public List<BranchVO> getBranchList();

	public List<SaveMypageVO> findTopNews(int limit);

}

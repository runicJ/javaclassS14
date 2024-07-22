package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CrawlingVO;
import com.spring.javaclassS14.vo.SaveMypageVO;

public interface IntroService {

	public List<BranchVO> getBranchList();

	public List<SaveMypageVO> findTopNews(int limit);

}

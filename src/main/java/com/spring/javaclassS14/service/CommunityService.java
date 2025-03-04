package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.CommunityVO;

public interface CommunityService {
	public List<CommunityVO> searchHospitals(String key, String keyword);
	public List<CommunityVO> getAllHospitals();
	public CommunityVO getHospitalById(int hospitalIdx);
	public boolean insertHospitalComment(CommunityVO comment);
	public List<CommunityVO> getHospitalComments();
}

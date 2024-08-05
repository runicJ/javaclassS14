package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.CommunityVO;

public interface CommunityService {
	public List<CommunityVO> searchHospitals(String key, String keyword, int minWaitingTime, int maxWaitingTime);
	public List<CommunityVO> getAllHospitals(int minWaitingTime, int maxWaitingTime);
	public CommunityVO getHospitalById(int hospitalIdx);
    public void setHospitalComment(CommunityVO cVO);
}

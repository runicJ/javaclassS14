package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.CommunityVO;

public interface CommunityDAO {
    public List<CommunityVO> searchHospitals(@Param("key") String key, @Param("keyword") String keyword);
    public List<CommunityVO> getAllHospitals();
    public CommunityVO getHospitalById(@Param("hospitalIdx") int hospitalIdx);
    public int insertHospitalComment(CommunityVO comment);
	public List<CommunityVO> getHospitalComments();
}

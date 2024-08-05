package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.CommunityVO;

public interface CommunityDAO {
    public List<CommunityVO> searchHospitals(@Param("key") String key, @Param("keyword") String keyword, @Param("minWaitingTime") int minWaitingTime, @Param("maxWaitingTime") int maxWaitingTime);
    public List<CommunityVO> getAllHospitals(@Param("minWaitingTime") int minWaitingTime, @Param("maxWaitingTime") int maxWaitingTime);
    public CommunityVO getHospitalById(@Param("hospitalIdx") int hospitalIdx);
    public void insertHospitalComment(@Param("cVO") CommunityVO cVO);
}

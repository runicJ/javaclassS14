package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.CommunityDAO;
import com.spring.javaclassS14.vo.CommunityVO;

@Service
public class CommunityServiceImpl implements CommunityService {

    @Autowired
    CommunityDAO communityDAO;

    @Override
    public List<CommunityVO> searchHospitals(String key, String keyword, int minWaitingTime, int maxWaitingTime) {
        return communityDAO.searchHospitals(key, keyword, minWaitingTime, maxWaitingTime);
    }

    @Override
    public List<CommunityVO> getAllHospitals(int minWaitingTime, int maxWaitingTime) {
        return communityDAO.getAllHospitals(minWaitingTime, maxWaitingTime);
    }

    @Override
    public CommunityVO getHospitalById(int hospitalIdx) {
        return communityDAO.getHospitalById(hospitalIdx);
    }

    @Override
    public void setHospitalComment(CommunityVO cVO) {
        communityDAO.insertHospitalComment(cVO);
    }
}

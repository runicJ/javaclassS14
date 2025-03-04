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
    public List<CommunityVO> searchHospitals(String key, String keyword) {
        return communityDAO.searchHospitals(key, keyword);
    }

    @Override
    public List<CommunityVO> getAllHospitals() {
        return communityDAO.getAllHospitals();
    }

    @Override
    public CommunityVO getHospitalById(int hospitalIdx) {
        return communityDAO.getHospitalById(hospitalIdx);
    }

	@Override
	public boolean insertHospitalComment(CommunityVO comment) {
        int result = communityDAO.insertHospitalComment(comment);
        return result > 0;
	}

	@Override
	public List<CommunityVO> getHospitalComments() {
	    return communityDAO.getHospitalComments();
	}
}

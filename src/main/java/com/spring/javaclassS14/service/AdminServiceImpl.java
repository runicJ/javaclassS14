package com.spring.javaclassS14.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.AdminDAO;
import com.spring.javaclassS14.vo.UserVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public ArrayList<UserVO> getUserList(int startIndexNo, int pageSize) {
		return adminDAO.getUserList(startIndexNo, pageSize);
	}

	@Override
	public ArrayList<UserVO> getDeleteUserList(int startIndexNo, int pageSize) {
		return adminDAO.getDeleteUserList(startIndexNo, pageSize);
	}

	@Override
	public int getDeleteUser(String delFlag, String userId) {
		return adminDAO.getDeleteUser(delFlag, userId);
	}
}

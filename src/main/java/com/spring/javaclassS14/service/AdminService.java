package com.spring.javaclassS14.service;

import java.util.ArrayList;

import com.spring.javaclassS14.vo.UserVO;

public interface AdminService {

	public ArrayList<UserVO> getUserList(int startIndexNo, int pageSize);

	public ArrayList<UserVO> getDeleteUserList(int startIndexNo, int pageSize);

	public int getDeleteUser(String delFlag, String userId);

}

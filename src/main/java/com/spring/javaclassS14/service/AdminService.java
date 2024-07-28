package com.spring.javaclassS14.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS14.vo.UserVO;

public interface AdminService {

	public List<UserVO> getUserList(int startIndexNo, int pageSize, String keyword, String sortOption);

	public ArrayList<UserVO> getDeleteUserList(int startIndexNo, int pageSize);

	public int getDeleteUser(String delFlag, String userId);

	public List<UserVO> getUserRegisterWay();

	public void allAction(String action, List<String> users);

}

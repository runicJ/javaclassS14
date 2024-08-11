package com.spring.javaclassS14.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.spring.javaclassS14.vo.UserVO;

public interface AdminService {

	public List<UserVO> getUserList(int startIndexNo, int pageSize, String keyword, String sortOption);

	public ArrayList<UserVO> getDeleteUserList(int startIndexNo, int pageSize);

	public int getDeleteUser(String delFlag, String userId);

	public List<UserVO> getUserRegisterWay();

	public void allAction(String action, List<String> users);

	public int getDeleteExUser();

	public int getRecentUser();

	public int getDeleteResUser();

	public int getOrderCnt();

	public int getShipCnt();

	public int getQnaCnt();

	public int getQnaGuestCnt();

	public int getQnaUserCnt();

	public int getProductQnaCnt();
	
	public List<Map<String, Object>> getWeeklySales();
    public List<Map<String, Object>> getDailySales();

}

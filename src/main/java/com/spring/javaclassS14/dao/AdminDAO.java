package com.spring.javaclassS14.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.UserVO;

public interface AdminDAO {

	public ArrayList<UserVO> getUserList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public ArrayList<UserVO> getDeleteUserList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int getDeleteUser(String delFlag, String userId);

}

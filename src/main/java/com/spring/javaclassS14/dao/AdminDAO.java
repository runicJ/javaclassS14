package com.spring.javaclassS14.dao;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.UserVO;

public interface AdminDAO {

	public ArrayList<UserVO> getUserList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("keyword") String keyword, @Param("sortOption") String sortOption);

	public ArrayList<UserVO> getDeleteUserList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public int getDeleteUser(String delFlag, String userId);

	public List<UserVO> getUserRegisterWay();

	public List<UserVO> getUserList(Map<String, Object> paramMap);

	public void updateUserStatus(@Param("userId") String userId, @Param("flag") String flag);

	public void deleteUser(@Param("userId") String userId);

	public int getdeleteExUser();

}

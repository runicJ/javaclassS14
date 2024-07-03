package com.spring.javalclassS14.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javalclassS14.vo.UserVO;

public interface UserDAO {

	public UserVO getUserIdCheck(@Param("user_id") String user_id);

	public UserVO getUserNickCheck(@Param("nickName") String nickName);

	public int setUserRegisterOk(@Param("vo") UserVO vo);

}

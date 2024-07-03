package com.spring.javaclassS14.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.UserVO;

public interface UserDAO {

	public UserVO getUserIdCheck(@Param("userId") String userId);

	public UserVO getUserNickCheck(@Param("nickName") String nickName);

	public UserVO getUserEmailCheck(@Param("email") String email);

	public int setUserRegisterOk(@Param("vo") UserVO vo);

}

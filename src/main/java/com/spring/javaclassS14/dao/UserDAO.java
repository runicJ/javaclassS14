package com.spring.javaclassS14.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.UserVO;

public interface UserDAO {

	public UserVO getUserIdCheck(@Param("userId") String userId);

	public UserVO getUserNickCheck(@Param("nickName") String nickName);

	public UserVO getUserEmailCheck(@Param("email") String email);

	public int setUserRegisterOk(@Param("vo") UserVO vo);

	public UserVO getUserNickNameEmailCheck(@Param("nickName") String nickName, @Param("email") String email);

	public void setKakaoUserInput(@Param("userId") String userId, @Param("userPwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);

	public void setUserPwdUpdate(@Param("userId") String userId, @Param("userPwd") String tempPwd);

	public int setUserDelete(@Param("userId") String userId);

	public int totRecCnt();

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

}

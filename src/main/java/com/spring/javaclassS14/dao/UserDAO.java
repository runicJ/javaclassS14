package com.spring.javaclassS14.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.UserVO;

public interface UserDAO {

	public UserVO getUserIdCheck(@Param("userId") String userId);

	public UserVO getUserNickCheck(@Param("nickName") String nickName);

	public UserVO getUserCheck(@Param("name") String name, @Param("email") String email);

	public int setUserRegisterOk(@Param("vo") UserVO vo);

	public UserVO getUserNickNameEmailCheck(@Param("nickName") String nickName, @Param("email") String email);

	public void setKakaoUserInput(@Param("userId") String userId, @Param("userPwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);

	public void setUserPwdUpdate(@Param("userId") String userId, @Param("userPwd") String tempPwd);

	public int setUserDelete(@Param("userId") String userId, @Param("deleteReason") String deleteReason);

	public int totRecCnt();

	public int recentLog(@Param("userIdx") int userIdx);
	
	public void setUserLog(@Param("userIdx") int userIdx, @Param("hostIp") String hostIp);

	public void insertDeletedUser(@Param("userId") String userId, @Param("email") String email, @Param("deleteReason") String deleteReason);

	public void updateDeletedUser(@Param("userId") String userId);

	public void cancelUserDelete(@Param("userId") String userId);

	public int setUserUpdate(@Param("vo") UserVO vo);

	public SaveInterestVO getBookmarkList(@Param("userIdx") Integer userIdx);

	public int checkUserBookmark(@Param("userIdx") int userIdx, @Param("partUrl") String partUrl);

	public void saveBookmarkToggle(@Param("userIdx") int userIdx, @Param("partUrl") String partUrl, @Param("bookmark") boolean bookmark);

	public int totRecCntKeyword(@Param("keyword") String keyword);

	public int totRecCntOption(Map<String, Object> paramMap);

	public int getUserEmailCheck(@Param("email") String email);

	public int setUpdateUser(@Param("vo") UserVO vo);
}

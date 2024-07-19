package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.SaveMypageVO;
import com.spring.javaclassS14.vo.UserVO;

public interface UserDAO {

	public UserVO getUserIdCheck(@Param("userId") String userId);

	public UserVO getUserNickCheck(@Param("nickName") String nickName);

	public UserVO getUserEmailCheck(@Param("email") String email);

	public int setUserRegisterOk(@Param("vo") UserVO vo);

	public UserVO getUserNickNameEmailCheck(@Param("nickName") String nickName, @Param("email") String email);

	public void setKakaoUserInput(@Param("userId") String userId, @Param("userPwd") String pwd, @Param("nickName") String nickName, @Param("email") String email);

	public void setUserPwdUpdate(@Param("userId") String userId, @Param("userPwd") String tempPwd);

	public int setUserDelete(@Param("userId") String userId, @Param("deleteReason") String deleteReason);

	public int totRecCnt();

	public int totRecCntSearch(@Param("search") String search, @Param("searchString") String searchString);

	public int recentLog(@Param("userId") String userId);
	
	public void setUserLog(@Param("userId") String userId, @Param("hostIp") String hostIp);

	public void insertDeletedUser(@Param("userId") String userId, @Param("deleteReason") String deleteReason);

	public void updateDeletedUser(@Param("userId") String userId);

	public List<UserVO> getAllDeletedUsers();
	
	public void cancelUserDelete(@Param("userId") String userId);

	public int setUserUpdate(@Param("vo") UserVO vo);

	public SaveMypageVO getBookmarkList(@Param("userId") String userId);

	public int checkUserBookmark(@Param("userId") String userId, @Param("partUrl") String partUrl);

	public void saveBookmarkToggle(@Param("userId") String userId, @Param("partUrl") String partUrl, @Param("bookmark") boolean bookmark);
	
//	public int setUserDelete(@Param("userId") String userId);
//	public void insertDeletedUser(@Param("userId") String userId, @Param("deleteReason") String deleteReason);

}

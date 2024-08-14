package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.vo.SaveInterestVO;
import com.spring.javaclassS14.vo.UserVO;

public interface UserService {

	public UserVO getUserIdCheck(String userId);

	public UserVO getUserNickCheck(String nickName);

	public String fileUpload(MultipartFile fName, String userId, String userImage);

	public int setUserRegisterOk(UserVO vo);

	public UserVO getUserCheck(String name, String email);

	public UserVO getUserNickNameEmailCheck(String nickName, String email);

	public void setKakaoUserInput(String userId, String pwd, String nickName, String email);

	public void setUserPwdUpdate(String userId, String tempPwd);

	public int setUserDelete(String userId, String deleteReason);
	
	//public int deleteUserWithReason(String userId, String deleteReason);

	public void setUserLog(String userId, String hostIp);

	public boolean isLoggedIn(String userId);
	
	public void updateDeletedUser(String userId);
	public List<UserVO> getAllDeletedUsers();
	
	public void cancelUserDelete(String userId);

	public int setUserUpdate(UserVO vo);

	public SaveInterestVO getBookmarkList(String userId);

	public boolean checkUserBookmark(String userId, String partUrl);

	public void saveBookmarkToggle(String userId, String partUrl, boolean bookmark);

	public int getUserEmailCheck(String email);

	public int setUpdateUser(UserVO userVO);

}

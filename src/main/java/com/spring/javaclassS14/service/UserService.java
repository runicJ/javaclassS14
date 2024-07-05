package com.spring.javaclassS14.service;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.vo.UserVO;

public interface UserService {

	public UserVO getUserIdCheck(String userId);

	public UserVO getUserNickCheck(String nickName);

	public String fileUpload(MultipartFile fName, String userId, String userImage);

	public int setUserRegisterOk(UserVO vo);

	public UserVO getUserEmailCheck(String email);

	public UserVO getUserNickNameEmailCheck(String nickName, String email);

	public void setKakaoUserInput(String userId, String pwd, String nickName, String email);

}

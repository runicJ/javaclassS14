package com.spring.javalclassS14.service;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javalclassS14.vo.UserVO;

public interface UserService {

	public UserVO getUserIdCheck(String user_id);

	public UserVO getUserNickCheck(String nickName);

	public String fileUpload(MultipartFile fName, String user_id, String user_image);

	public int setUserRegisterOk(UserVO vo);

}

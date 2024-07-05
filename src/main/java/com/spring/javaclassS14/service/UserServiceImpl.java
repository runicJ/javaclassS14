package com.spring.javaclassS14.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.UserDAO;
import com.spring.javaclassS14.vo.UserVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	AllProvide allProvide;
	
	@Override
	public UserVO getUserIdCheck(String userId) {
		return userDAO.getUserIdCheck(userId);
	}

	@Override
	public UserVO getUserNickCheck(String nickName) {
		return userDAO.getUserNickCheck(nickName);
	}
	
	@Override
	public UserVO getUserEmailCheck(String email) {
		return userDAO.getUserEmailCheck(email);
	}

	@Override
	public String fileUpload(MultipartFile fName, String userId, String userImage) {
		UUID uid = UUID.randomUUID();
		String sFileName = userId + "_" + uid.toString().substring(0,8) + "_" + fName.getOriginalFilename();
		
		try {
			allProvide.writeFile(fName, sFileName, "user");
			
			if(!userImage.equals("noImage.jpg")) allProvide.deleteFile(userImage, "user");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sFileName;
	}

	@Override
	public int setUserRegisterOk(UserVO vo) {
		return userDAO.setUserRegisterOk(vo);
	}

	@Override
	public UserVO getUserNickNameEmailCheck(String nickName, String email) {
		return userDAO.getUserNickNameEmailCheck(nickName, email);
	}

	@Override
	public void setKakaoUserInput(String userId, String pwd, String nickName, String email) {
		userDAO.setKakaoUserInput(userId, pwd, nickName, email);
		
	}

}

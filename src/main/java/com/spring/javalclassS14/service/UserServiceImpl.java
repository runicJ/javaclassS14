package com.spring.javalclassS14.service;

import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javalclassS14.common.AllProvide;
import com.spring.javalclassS14.dao.UserDAO;
import com.spring.javalclassS14.vo.UserVO;

public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	AllProvide allProvide;
	
	@Override
	public UserVO getUserIdCheck(String user_id) {
		return userDAO.getUserIdCheck(user_id);
	}

	@Override
	public UserVO getUserNickCheck(String nickName) {
		return userDAO.getUserNickCheck(nickName);
	}

	@Override
	public String fileUpload(MultipartFile fName, String user_id, String user_image) {
		UUID uid = UUID.randomUUID();
		String sFileName = user_id + "_" + uid.toString().substring(0,8) + "_" + fName.getOriginalFilename();
		
		try {
			allProvide.writeFile(fName, sFileName, "user");
			
			if(!user_image.equals("noImage.jpg")) allProvide.deleteFile(user_image, "user");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sFileName;
	}

	@Override
	public int setUserRegisterOk(UserVO vo) {
		return userDAO.setUserRegisterOk(vo);
	}

}

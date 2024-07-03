package com.spring.javalclassS14.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javalclassS14.service.UserService;
import com.spring.javalclassS14.vo.UserVO;

@Controller
@RequestMapping("/users")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@RequestMapping(value="/userRegister", method=RequestMethod.GET)
	public String userRegisterGet() {
		return "users/userRegister";
	}
	
	@RequestMapping(value="/userRegister", method=RequestMethod.POST)
	public String userRegisterPost(UserVO vo, MultipartFile fName) {
		if(userService.getUserIdCheck(vo.getUser_id()) != null) return "redirect:/message/uidCheckNo";
		if(userService.getUserNickCheck(vo.getNickName()) != null) return "redirect:/message/nickCheckNo";
		
		vo.setUser_pwd(passwordEncoder.encode(vo.getUser_pwd()));

		if(!fName.getOriginalFilename().equals("")) vo.setUser_image(userService.fileUpload(fName, vo.getUser_id(), ""));
		else vo.setUser_image("noImage.jpg");
		
		int res = userService.setUserRegisterOk(vo);
		
		if(res != 0) return "redirect:/message/userRegisterOk";
		else return "redirect:/message/userRegisterNo";
		
	}
		
}

package com.spring.javaclassS14.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.UserVO;

@Controller
@RequestMapping("/users")
public class UserController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@ResponseBody
	@RequestMapping(value="/uidCheck", method=RequestMethod.GET)
	public String uidCheckGet(String userId) {
		int res = 0;
		UserVO vo = userService.getUserIdCheck(userId);
		if(vo != null) res = 1; 
		
		return res + "";
	}
	
	@ResponseBody
	@RequestMapping(value="/nickCheck", method=RequestMethod.GET)
	public String nickCheckGet(String nickName) {
		int res = 0;
		UserVO vo = userService.getUserNickCheck(nickName);
		if(vo != null) res = 1; 
		
		return res + "";
	}
	
	@ResponseBody
	@RequestMapping(value="/emailCheck", method=RequestMethod.GET)
	public String emailCheckGet(String email) {
		int res = 0;
		UserVO vo = userService.getUserEmailCheck(email);
		if(vo != null) res = 1; 
		
		return res + "";
	}
	
	@RequestMapping(value="/userRegister", method=RequestMethod.GET)
	public String userRegisterGet() {
		return "users/userRegister";
	}
	
	@RequestMapping(value="/userRegister", method=RequestMethod.POST)
	public String userRegisterPost(UserVO vo, MultipartFile fName) {
		if(userService.getUserIdCheck(vo.getUserId()) != null) return "redirect:/msg/uidCheckNo";
		if(userService.getUserNickCheck(vo.getNickName()) != null) return "redirect:/msg/nickCheckNo";
		if(userService.getUserEmailCheck(vo.getEmail()) != null) return "redirect:/msg/emailCheckNo";
		
		vo.setUserPwd(passwordEncoder.encode(vo.getUserPwd()));

		if(!fName.getOriginalFilename().equals("")) vo.setUserImage(userService.fileUpload(fName, vo.getUserId(), ""));
		else vo.setUserImage("noImage.jpg");
		
		int res = userService.setUserRegisterOk(vo);
		
		if(res != 0) return "redirect:/msg/userRegisterOk";
		else return "redirect:/msg/userRegisterNo";
		
	}
	
	@RequestMapping(value="/userLogin", method=RequestMethod.GET)
	public String userLoginGet() {
		return "users/userLogin";
	}
	
	@RequestMapping(value="/userLogin", method=RequestMethod.POST)
	public String userLoginPost() {
		return "";
	}
		
}

package com.spring.javaclassS14.controller;

import javax.servlet.ServletRequest;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	@Autowired
	JavaMailSender mailSender;
	
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
	public String userLoginGet(HttpServletRequest request) {
		
		Cookie[] cookies = request.getCookies();
		
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++) {
				if(cookies[i].getName().equals("cUid")) {
					request.setAttribute("userId", cookies[i].getValue());
					break;
				}
			}
		}
		
		return "users/userLogin";
	}
	
	@RequestMapping(value="/userLogin", method=RequestMethod.POST)
	public String userLoginPost(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@RequestParam(name="userId", defaultValue = "admin", required = false) String userId,
			@RequestParam(name="userPwd", defaultValue = "1234", required = false) String userPwd,
			@RequestParam(name="idSave", defaultValue="on", required = false) String idSave
		) {
		UserVO vo = userService.getUserIdCheck(userId);
		
		if(vo != null && passwordEncoder.matches(userPwd, vo.getUserPwd())) {
			String strLevel = "";
			if(vo.getLevel() == 0) strLevel = "대가";
			else if(vo.getLevel() == 1) strLevel = "전문가";
			else if(vo.getLevel() == 2) strLevel = "숙련자";
			else if(vo.getLevel() == 3) strLevel = "지식인";
			
			session.setAttribute("sUid", userId);
			session.setAttribute("sNickName", vo.getNickName());
			session.setAttribute("sLevel", vo.getLevel());
			session.setAttribute("strLevel", strLevel);
			
			if(idSave.equals("on")) {
				Cookie cookieUid = new Cookie("cUid", userId);
				cookieUid.setPath("/");
				cookieUid.setMaxAge(60*60*24*7);
				response.addCookie(cookieUid);
			}
			else {
				Cookie[] cookies = request.getCookies();
				if(cookies != null) {
					for(int i=0; i<cookies.length; i++) {
						if(cookies[i].getName().equals("cUid")) {
							cookies[i].setMaxAge(0);
							response.addCookie(cookies[i]);
							break;
						}
					}
				}
			}
			return "redirect:/msg/userLoginOk?uid="+userId;
		}
		else return "redirect:/msg/userLoginNo";
	}
	
	@RequestMapping(value="/userLogout", method=RequestMethod.GET)
	public String userLogoutGet(HttpSession session) {
		String uid = (String) session.getAttribute("sUid");
		session.invalidate();
		
		return "redirect:/message/memberLogout?uid="+uid;
	}
		
}

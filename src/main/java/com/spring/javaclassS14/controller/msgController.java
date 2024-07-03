package com.spring.javaclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class msgController {

	@RequestMapping(value = "/msg/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag,
			@RequestParam(name="uid", defaultValue="", required=false) String uid
		) {
		if(msgFlag.equals("uidCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 아이디 입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 닉네임입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("emailCheckNo")) {
			model.addAttribute("msg", "이미 사용중인 이메일입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("userRegisterOk")) {
			model.addAttribute("msg", "회원가입이 완료되었습니다.\n로그인 페이지로 이동합니다.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userRegisterNo")) {
			model.addAttribute("msg", "회원가입 실패!");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("userLoginOk")) {
			model.addAttribute("msg", uid+" 님 환영합니다!");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("userLoginNo")) {
			model.addAttribute("msg", "로그인 실패!");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("memberLogout")) {
			model.addAttribute("msg", uid+" 님 로그아웃이 정상적으로 처리되었습니다.");
			model.addAttribute("url", "/users/userLogin");
		}
	
	return "include/msg";
	}
}
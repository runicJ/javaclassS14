package com.spring.javaclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class msgController {

	@RequestMapping(value = "/msg/{msgFlag}", method = RequestMethod.GET)
	public String getMessage(Model model,
			@PathVariable String msgFlag
		) {
		if(msgFlag.equals("uidCheckNo")) {
			model.addAttribute("msg", "중복된 아이디입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "중복된 닉네임입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("emailCheckNo")) {
			model.addAttribute("msg", "중복된 이메일입니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("userRegisterOk")) {
			model.addAttribute("msg", "회원가입 처리되었습니다.\n로그인 페이지로 이동합니다.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userRegisterNo")) {
			model.addAttribute("msg", "회원가입 실패!");
			model.addAttribute("url", "/users/userRegister");
		}
	
	return "include/msg";
	}
}
package com.spring.javalclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MessageController {

	@RequestMapping(value = "/message/{msgFlag}", method = RequestMethod.GET)
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
	
	return "include/message";
	}
}
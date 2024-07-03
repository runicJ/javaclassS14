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
			model.addAttribute("msg", "�ߺ��� ���̵��Դϴ�.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("nickCheckNo")) {
			model.addAttribute("msg", "�ߺ��� �г����Դϴ�.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("emailCheckNo")) {
			model.addAttribute("msg", "�ߺ��� �̸����Դϴ�.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("userRegisterOk")) {
			model.addAttribute("msg", "ȸ������ ó���Ǿ����ϴ�.\n�α��� �������� �̵��մϴ�.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userRegisterNo")) {
			model.addAttribute("msg", "ȸ������ ����!");
			model.addAttribute("url", "/users/userRegister");
		}
	
	return "include/msg";
	}
}
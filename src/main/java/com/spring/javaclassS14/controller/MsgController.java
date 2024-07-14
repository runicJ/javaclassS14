package com.spring.javaclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MsgController {

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
			model.addAttribute("msg", "회원가입이 완료되었습니다. 로그인 페이지로 이동합니다!");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userRegisterNo")) {
			model.addAttribute("msg", "회원가입에 실패하였습니다.");
			model.addAttribute("url", "/users/userRegister");
		}
		else if(msgFlag.equals("userLoginOk")) {
			model.addAttribute("msg", uid+" 님 환영합니다!");
			model.addAttribute("url", "/main");
		}
		else if(msgFlag.equals("userLoginNo")) {
			model.addAttribute("msg", "아이디 또는 비밀번호를 확인해 주세요!");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userLogout")) {
			model.addAttribute("msg", uid+" 님 로그아웃이 정상적으로 처리되었습니다.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("uidSameSearch")) {
			model.addAttribute("msg", "같은 아이디를 가진 회원이 존재합니다. \\n아이디 확인 후 다시 회원가입을 시도해 주세요.");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userLoginNewOk")) {
			model.addAttribute("msg", uid+" 님 로그인 되셨습니다.\\n신규 비밀번호가 발급되었습니다. 확인 후 회원정보를 변경해주세요.");
			model.addAttribute("url", "users/userMain");
		}
		else if(msgFlag.equals("adminNo")) {
			model.addAttribute("msg", "관리자만 접속하실 수 있습니다.");
			model.addAttribute("url", "/");
		}
		else if(msgFlag.equals("UserNo")) {
			model.addAttribute("msg", "회원 로그인후 사용하세요");
			model.addAttribute("url", "/users/userLogin");
		}
		else if(msgFlag.equals("userLevelNo")) {
			model.addAttribute("msg", "회원 등급을 확인하세요.");
			model.addAttribute("url", "/users/userMain");
		}
	
	return "include/msg";
	}
}
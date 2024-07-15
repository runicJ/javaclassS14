package com.spring.javaclassS14.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS14.service.IntroService;
import com.spring.javaclassS14.vo.BranchVO;

@Controller
@RequestMapping("/introduce")
public class IntroController {
	
	@Autowired
	IntroService introService;
	
	// 인사말
	@RequestMapping(value="greeting",method=RequestMethod.GET)
	public String greetingGet() {
		return "introduce/greeting";
	}
	
	// 홈페이지 소개
	@RequestMapping(value="introduce",method=RequestMethod.GET)
	public String introduceGet() {
		return "introduce/introduce";
	}
	
	// 설립목적
	@RequestMapping(value="purpose",method=RequestMethod.GET)
	public String purposeGet() {
		return "introduce/purpose";
	}
	
	// 지점 소개
	@RequestMapping(value="branch/branchMap",method=RequestMethod.GET)
	public String branchMapGet() {
		List<BranchVO> vos = introService.getBranchList();
				
		return "introduce/branch/branchMap";
	}
}

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
	
	@RequestMapping(value="introduce",method=RequestMethod.GET)
	public String introduceGet() {
		return "introduce/introduce";
	}
	
	@RequestMapping(value="purpose",method=RequestMethod.GET)
	public String purposeGet() {
		return "introduce/purpose";
	}
	
	@RequestMapping(value="branch/branchMap",method=RequestMethod.GET)
	public String branchMapGet() {
		List<BranchVO> vos = introService.getBranchList();
				
		return "introduce/branch/branchMap";
	}
}

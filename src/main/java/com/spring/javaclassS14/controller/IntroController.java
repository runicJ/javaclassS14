package com.spring.javaclassS14.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS14.service.IntroService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.ShopVO;

@Controller
@RequestMapping("/introduce")
public class IntroController {
	
	@Autowired
	IntroService introService;
	
	@Autowired
	ShopService shopService;
	
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
	
	// 지점 소개
	@RequestMapping(value="branch/branchMap",method=RequestMethod.GET)
	public String branchMapGet() {
		List<BranchVO> vos = introService.getBranchList();
				
		return "introduce/branch/branchMap";
	}
	
    @ModelAttribute
    public void addCommonAttributes(Model model) {
        List<ShopVO> categoryTopVOS = shopService.getCategoryTop();
        List<ShopVO> productTopMidVOS = shopService.getProductTopMidList();
        
        model.addAttribute("categoryTopVOS", categoryTopVOS);
        model.addAttribute("productTopMidVOS", productTopMidVOS);
    }
}

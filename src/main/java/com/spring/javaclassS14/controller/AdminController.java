package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.AdminService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.PageVO;
import com.spring.javaclassS14.vo.ShopVO;
import com.spring.javaclassS14.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ShopService shopService;
	
	// 관리자 페이지로 이동
	@RequestMapping(value="/adminMain", method=RequestMethod.GET)
	public String adminMainGet() {
		return "admin/adminMain";
	}
	
	// 회원리스트
	@RequestMapping(value="/userList", method=RequestMethod.GET)
	public String userListGet(Model model,
		@RequestParam(name="pag", defaultValue="1", required=false) int pag,
		@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "user", "", "");
		
		ArrayList<UserVO> vos = adminService.getUserList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/user/userList";
	}
	
	// 회원리스트
	@RequestMapping(value="/deleteUserList", method=RequestMethod.GET)
	public String deleteUserListGet(Model model,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "user", "", "");
		
		ArrayList<UserVO> vos = adminService.getDeleteUserList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/user/deleteUserList";
	}
	
	// 회원리스트
	@RequestMapping(value="/userDelete", method=RequestMethod.POST)
	public String userDeletePost(String delFlag, String userId) {
		int res = adminService.getDeleteUser(delFlag, userId);
		
		if(res != 0) return "redirect:/msg/userCheckOk?delFlag="+delFlag;
		else return "redirect:/msg/userCheckNo?delFlag="+delFlag;
	}
	
	// 제품 카테고리 관리 페이지 이동
	@RequestMapping(value="/productCategory", method=RequestMethod.GET)
	public String productCategoryGet(Model model) {
		List<ShopVO> vos = shopService.getCategoryList();
		
		model.addAttribute("vos",vos);
		return "admin/shop/productCategory";
	}
	
	// 제품 입력 페이지 이동
	@RequestMapping(value="/productInput", method=RequestMethod.GET)
	public String productInputGet() {
		return "admin/shop/productInput";
	}
		
}

package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.AdminService;
import com.spring.javaclassS14.service.RegSurvService;
import com.spring.javaclassS14.service.ResSurvService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.AnswerDto;
import com.spring.javaclassS14.vo.PageVO;
import com.spring.javaclassS14.vo.ShopVO;
import com.spring.javaclassS14.vo.SurveyDto;
import com.spring.javaclassS14.vo.SurvqustDto;
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
	
	@Autowired
	RegSurvService regSurvService;
	
	@Autowired
	ResSurvService resSurvService;
	
	/*
	 * 설문 만들기 View
	 */
	@RequestMapping(value="/survey/surveyInput", method=RequestMethod.GET)
	public String surveyInputGet(HttpSession session, Model model) {
		String nickName = (String) session.getAttribute("sNickName");
		model.addAttribute("nickName", nickName);
		return "admin/survey/surveyInput";
	}

	/*
	 * 설문 만들기 
	*/
	@ResponseBody
	@RequestMapping("survey/surveyInputOk")
	public String regSurv(@RequestBody SurveyDto surveyDto
			, @AuthenticationPrincipal UserDetails userInfo) throws Exception {	
		System.out.println("===regSurv Controller START");
		
		surveyDto.setUserId(userInfo.getUsername());
		System.out.println("surveyDto ==> "+surveyDto.toString());
		regSurvService.insertSurv(surveyDto);
		
		System.out.println("===regSurv Controller END===");
		return "admin/survey/surveyInput";
	}
	
	/*
	 * My Survey > 설문 수정하기 View
	 */
	@RequestMapping("/modSurvForm")
	public String modSurv(@RequestParam(value="survNo") Integer survNo
						 , @AuthenticationPrincipal UserDetails userInfo
						 , Model model) {
		System.out.println("===modSurv Controller START===");
		String memNick = regSurvService.getUserInfo(userInfo.getUsername());
		
		System.out.println("수정할 survNo : "+survNo+" memNick :"+memNick);
		
		SurveyDto surveyDto = regSurvService.getSurvey(survNo);
		System.out.println("뿌려줄 surveyDto ==> "+surveyDto.toString());
		
		surveyDto.setNickName(memNick);
		
		model.addAttribute("surveyDto",surveyDto);
		
		System.out.println("===modSurv Controller END===");
		return "survey/modSurv";
	}
	
	/*
	 * 설문 삭제하기
	 */
	@RequestMapping("/delSurv")
	public String delSurv(@AuthenticationPrincipal UserDetails userInfo
						  ,@RequestParam Map<String,String> param) {
		System.out.println("delSurv Controller START");
		
		int survNo = Integer.parseInt(param.get("survNo"));
		
		String memNick = regSurvService.getUserInfo(userInfo.getUsername());
		System.out.println("survNo : "+survNo+"  memNick : "+memNick);

		regSurvService.delOneSurvey(survNo);
		
		return "redirect:myList";
	}
	
	/*
	 * 설문 수정하기
	 */
	@RequestMapping("/updateSurv")
	@ResponseBody
	public void updateSurv(@AuthenticationPrincipal UserDetails userInfo
						  ,@RequestBody SurveyDto surveyDto) {
		System.out.println("updateSurv controller START");
		surveyDto.setUserId(userInfo.getUsername());
		
		int survNo = surveyDto.getSurvNo();
		regSurvService.delOldSurvey(survNo);
		regSurvService.insertNewSurv(surveyDto);
		
		System.out.println("updateSurv controller END");
	}
	
	/*
	 * 작성자 : Bonnie 
	 * 리스트 응답 폼 보여주기 View
	 * */
	@RequestMapping("/resForm")
	public String resForm(@RequestParam(value="survNo") Integer survNo
			, @AuthenticationPrincipal UserDetails userInfo,
			HttpServletRequest request , Model model) {
		SurveyDto surveyDto = regSurvService.getSurvey(survNo);
		String memNick = regSurvService.getUserInfo(surveyDto.getUserId());
		
		surveyDto.setNickName(memNick);
		if(surveyDto.getSurvDesc() != null) {
			surveyDto.setSurvDesc(surveyDto.getSurvDesc().replace("\n","<br>"));
		}
		
		model.addAttribute("surveyDto",surveyDto);
		model.addAttribute("memId", userInfo.getUsername());
		model.addAttribute("currentPage",request.getParameter("currentPage"));
		model.addAttribute("cntPerPage",request.getParameter("cntPerPage"));
		model.addAttribute("pageSize",request.getParameter("pageSize"));
		model.addAttribute("srchTyp",request.getParameter("srchTyp"));
		model.addAttribute("keyword",request.getParameter("keyword"));
		
		return "survey/resSurv";
	}
	
	@RequestMapping("/resSurv")
	@ResponseBody
	public String resSurv(@RequestBody SurvqustDto qustDto) {	
		List<AnswerDto> answerList = qustDto.getAnswerList();
		
		System.out.println(answerList);
		
		resSurvService.insertAnswer(answerList);
		
		return "redirect:/survList";
	}
	
}
package com.spring.javaclassS14.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javaclassS14.service.RegSurvService;
import com.spring.javaclassS14.service.ResSurvService;
import com.spring.javaclassS14.service.SurvListService;
import com.spring.javaclassS14.vo.AnswerDto;
import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyDto;
import com.spring.javaclassS14.vo.SurvqustDto;

@Controller
@RequestMapping("/survey")
public class SurveyController {
	
	@Autowired
	RegSurvService regSurvService;
	
	@Autowired
	ResSurvService resSurvService;
	
	@Autowired
	SurvListService survListService;

	// My Survey > 설문 수정하기 View
	@GetMapping("/modSurvForm")
	public String modSurv(@RequestParam(value="survNo") Integer survNo, @AuthenticationPrincipal UserDetails userInfo, Model model) {
		System.out.println("===modSurv Controller START===");
		String userNick = regSurvService.getUserInfo(userInfo.getUsername());
		
		System.out.println("수정할 survNo : "+survNo+" userNick :"+userNick);
		
		SurveyDto surveyDto = regSurvService.getSurvey(survNo);
		System.out.println("뿌려줄 surveyDto ==> "+surveyDto.toString());
		
		surveyDto.setNickName(userNick);
		
		model.addAttribute("surveyDto", surveyDto);
		
		System.out.println("===modSurv Controller END===");
		return "survey/modSurv";
	}

	// 리스트 응답 폼 보여주기 View
	@GetMapping("/resForm")
	public String resForm(@RequestParam(value="survNo") Integer survNo, @AuthenticationPrincipal UserDetails userInfo, HttpServletRequest request , Model model) {
		SurveyDto surveyDto = regSurvService.getSurvey(survNo);
		String userNick = regSurvService.getUserInfo(surveyDto.getUserId());
		
		surveyDto.setNickName(userNick);
		if(surveyDto.getSurvDesc() != null) {
			surveyDto.setSurvDesc(surveyDto.getSurvDesc().replace("\n","<br>"));
		}
		
		model.addAttribute("surveyDto", surveyDto);
		model.addAttribute("userId", userInfo.getUsername());
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("cntPerPage", request.getParameter("cntPerPage"));
		model.addAttribute("pageSize", request.getParameter("pageSize"));
		model.addAttribute("srchTyp", request.getParameter("srchTyp"));
		model.addAttribute("keyword", request.getParameter("keyword"));
		
		return "survey/resSurv";
	}

	// 응답하기 
	@PostMapping("/resSurv")
	@ResponseBody
	public String resSurv(@RequestBody SurvqustDto qustDto) {	
		List<AnswerDto> answerList = qustDto.getAnswerList();
		System.out.println(answerList);
		resSurvService.insertAnswer(answerList);
		return "redirect:/survey/surveyList";
	}
	
	// My Survey 접속
		@GetMapping("/survey/myList")
		public ModelAndView myList(@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
		                           @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
		                           @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
		                           @AuthenticationPrincipal UserDetails userInfo, HttpServletRequest request) throws UnsupportedEncodingException {
			ModelAndView mv = new ModelAndView();
			SearchVo searchVo = new SearchVo(currentPage, cntPerPage, pageSize);
			
			// Id 세팅
			searchVo.setRegId(userInfo.getUsername());
			request.setCharacterEncoding("utf-8");
		    
			searchVo.setKeyword(request.getParameter("keyword"));
			searchVo.setSrchTyp(request.getParameter("srchTyp"));
			
			int total = survListService.getMyCnt(searchVo);
			mv.addObject("total", total);
			searchVo.setTotalRecordCount(total);
			
			if(total != 0) {
				mv.addObject("survList", survListService.getMyList(searchVo));
			} else {
				mv.addObject("survList", null);
			}
			mv.addObject("pagination", searchVo);
			mv.setViewName("survey/myList");
			return mv;
		}
		

		// 해당 설문 응답 여부 확인
//		@PostMapping("/survey/checkRes")
//		@ResponseBody
//		public int checkRes(@RequestBody SurveyDto surveyDto) { 
//			System.out.println(surveyDto);
//			int cnt = survListService.resSurvYn(surveyDto);
//			return cnt;
//		}
}

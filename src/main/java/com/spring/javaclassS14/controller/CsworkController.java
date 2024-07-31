package com.spring.javaclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/cswork")
public class CsworkController {
	
	@RequestMapping(value="/event/eventList", method=RequestMethod.GET)
	public String eventListGet() {
		return "cswork/event/eventList";
	}
	
	@RequestMapping(value="/event/eventDetails", method=RequestMethod.GET)
	public String eventDetailsGet() {
		return "cswork/event/eventDetails";
	}
	
	@RequestMapping(value="/qna/adApply", method=RequestMethod.GET)
	public String adApplyGet() {
		return "cswork/qna/adApply";
	}
	
	@RequestMapping(value="/qna/branchApply", method=RequestMethod.GET)
	public String branchApplyGet() {
		return "cswork/qna/branchApply";
	}
	
	@RequestMapping(value="/qna/qnaApply", method=RequestMethod.GET)
	public String qnaApplyGet() {
		return "cswork/qna/qnaApply";
	}
}

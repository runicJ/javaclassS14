package com.spring.javaclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/cs")
public class CsController {
	
	@RequestMapping(value="/event/eventList", method=RequestMethod.GET)
	public String eventListGet() {
		return "cs/event/eventList";
	}
	
	@RequestMapping(value="/ad/adApply", method=RequestMethod.GET)
	public String adApplyGet() {
		return "cs/ad/adApply";
	}
}

package com.spring.javaclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/community")
public class CommunityController {
	
	@RequestMapping(value="hospitalList",method=RequestMethod.GET)
	public String greetingGet() {
		return "community/hospitalList";
	}

}

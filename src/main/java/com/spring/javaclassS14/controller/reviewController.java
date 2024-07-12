package com.spring.javaclassS14.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/review")
public class reviewController {
	
	@RequestMapping(value="/photoReview/photoGalleryList", method=RequestMethod.GET)
	public String photoGalleryListGet() {
		return "review/photoReview/photoGalleryList";
	}
	
	@RequestMapping(value="/photoReview/photoGalleryInput", method=RequestMethod.GET)
	public String photoGalleryInputGet() {
		return "review/photoReview/photoGalleryInput";
	}
	
	@RequestMapping(value="/photoReview/photoGalleryContent", method=RequestMethod.GET)
	public String photoGalleryContentGet() {
		return "review/photoReview/photoGalleryContent";
	}
		
}
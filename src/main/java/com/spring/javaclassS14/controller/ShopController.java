package com.spring.javaclassS14.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.AdminService;
import com.spring.javaclassS14.service.ShopService;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/productList", method=RequestMethod.GET)
	public String productListGet() {
		return "shop/productList";
	}
	
	@RequestMapping(value="/productCart", method=RequestMethod.GET)
	public String productCartGet() {
		return "shop/productCart";
	}
		
}

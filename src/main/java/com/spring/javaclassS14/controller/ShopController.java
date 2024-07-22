package com.spring.javaclassS14.controller;

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
import com.spring.javaclassS14.vo.ShopVO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/productList", method=RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="productPrice", defaultValue = "0", required = false) String productPrice){
		model.addAttribute("part", part);

		List<ShopVO> productVOS = shopService.getProductList(part, productPrice);	// 전체 상품리스트 가져오기
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("productPrice", productPrice);

		return "shop/productList";
	}
	
	@RequestMapping(value="/productCart", method=RequestMethod.GET)
	public String productCartGet() {
		return "shop/productCart";
	}
		
}

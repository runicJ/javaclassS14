package com.spring.javaclassS14.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS14.service.SearchService;
import com.spring.javaclassS14.vo.PhotoReviewVO;
import com.spring.javaclassS14.vo.ShopVO;

@Controller
@RequestMapping("/search")
public class SearchController {
    
    @Autowired
    private SearchService searchService;

    @GetMapping
    public String searchList(@RequestParam("keyword") String keyword, Model model) {
        List<ShopVO> products = searchService.searchProducts(keyword);
        List<PhotoReviewVO> photoReviews = searchService.searchPhotoReviews(keyword);
        
        model.addAttribute("keyword", keyword);
        model.addAttribute("products", products);
        model.addAttribute("photoReviews", photoReviews);
        
        return "search/searchList";
    }
}

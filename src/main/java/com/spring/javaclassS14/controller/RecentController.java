package com.spring.javaclassS14.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS14.service.RecentService;

@Controller
@RequestMapping("/recent")
public class RecentController {

    @Autowired
    private RecentService recentService;

    @ResponseBody
    @PostMapping("/saveBookmark")
    public String saveBookmark(@RequestParam String userId, @RequestParam String partUrl, @RequestParam String category) {
        int res = recentService.saveBookmark(userId, partUrl, category);
        return res + "";
    }

    @ResponseBody
    @PostMapping("/saveLikedProduct")
    public String saveLikedProductPost(@RequestParam String userId, @RequestParam int productIdx) {
        int res = recentService.saveLikedProduct(userId, productIdx);
        return res + "";
    }

    @GetMapping("/dashboard")
    public String getUserDashboard(Model model, @RequestParam String userId) {
        model.addAttribute("recentProductViews", recentService.getRecentProductViews(userId));
        model.addAttribute("recentSearches", recentService.getRecentSearches(userId));
        model.addAttribute("bookmarks", recentService.getBookmarks(userId, "research")); // 예시로 연구 북마크만 조회
        model.addAttribute("favoriteProducts", recentService.getFavoriteProducts(userId));
        return "user/dashboard";
    }
}

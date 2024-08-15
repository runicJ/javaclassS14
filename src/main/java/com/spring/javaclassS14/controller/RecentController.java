package com.spring.javaclassS14.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS14.service.RecentService;
import com.spring.javaclassS14.vo.RecentVO;

@Controller
@RequestMapping("/recent")
public class RecentController {

    @Autowired
    private RecentService recentService;

    // 북마크 저장
    @ResponseBody
    @PostMapping("/bookmarkToggle")
    public String saveBookmark(@RequestParam int userIdx, @RequestParam String partUrl, @RequestParam String category) {
        int res = recentService.saveBookmark(userIdx, partUrl, category);
        return res + "";
    }

    @PostMapping("/saveLikedProduct")
    @ResponseBody
    public Map<String, Object> saveInterestProduct(@RequestParam int productIdx, HttpSession session) {
        Integer userIdx = (Integer) session.getAttribute("sUidx");
        
        boolean isInterested = false;
        boolean success = false;
        String message = "";

        Map<String, Object> result = new HashMap<>();
        
        if (userIdx != null) {
            isInterested = recentService.toggleProductInterest(userIdx, productIdx);
            success = true;
            message = isInterested ? "관심등록 되었습니다." : "관심등록이 취소되었습니다.";
        } else {
            message = "로그인이 필요합니다.";
        }

        result.put("success", success);
        result.put("isInterested", isInterested);
        result.put("message", message);
        return result;
    }

    // 최근 검색어 저장
    @PostMapping("/saveRecentSearch")
    @ResponseBody
    public String saveRecentSearch(@RequestParam int userIdx, @RequestParam String searchTerm) {
        recentService.saveRecentSearch(userIdx, searchTerm);
        return "saved";
    }

    // 유저 대시보드 조회
    @GetMapping("/dashboard")
    public String getUserDashboard(Model model, @RequestParam int userIdx) {
        model.addAttribute("bookmarks", recentService.getBookmarks(userIdx, "research")); // 예시로 연구 북마크만 조회
        model.addAttribute("favoriteProducts", recentService.getFavoriteProducts(userIdx));
        return "user/dashboard";
    }

    // 최근 본 상품 조회
    @GetMapping("/recentViews")
    public String getRecentViews(Model model, @RequestParam int userIdx, @RequestParam(defaultValue = "5") int limit) {
        List<RecentVO> recentViews = recentService.getRecentViews(userIdx, limit);
        model.addAttribute("recentViews", recentViews);
        return "recent/recentViews";
    }

    // 최근 검색어 조회
    @GetMapping("/recentSearches")
    public String getRecentSearches(Model model, @RequestParam int userIdx, @RequestParam(defaultValue = "5") int limit) {
        List<RecentVO> recentSearches = recentService.getRecentSearches(userIdx, limit);
        model.addAttribute("recentSearches", recentSearches);
        return "recent/recentSearches";
    }
}

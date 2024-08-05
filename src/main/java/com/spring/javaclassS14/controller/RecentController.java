package com.spring.javaclassS14.controller;

import com.spring.javaclassS14.service.RecentService;
import com.spring.javaclassS14.vo.RecentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/recent")
public class RecentController {

    @Autowired
    private RecentService recentService;

    // 북마크 저장
    @ResponseBody
    @PostMapping("/saveBookmark")
    public String saveBookmark(@RequestParam String userId, @RequestParam String partUrl, @RequestParam String category) {
        int res = recentService.saveBookmark(userId, partUrl, category);
        return res + "";
    }

    // 좋아요 저장
    @ResponseBody
    @PostMapping("/saveLikedProduct")
    public String saveLikedProduct(@RequestParam String userId, @RequestParam int productIdx) {
        int res = recentService.saveLikedProduct(userId, productIdx);
        return res + "";
    }

    // 좋아요 토글
    @ResponseBody
    @PostMapping("/toggleLike")
    public String toggleLike(@RequestParam String userId, @RequestParam int productIdx) {
        boolean isLiked = recentService.toggleLike(userId, productIdx);
        return isLiked ? "liked" : "unliked";
    }

    // 최근 본 상품 저장
    @PostMapping("/saveRecentView")
    @ResponseBody
    public String saveRecentView(@RequestParam String userId, @RequestParam int productIdx) {
        recentService.saveRecentView(userId, productIdx);
        return "saved";
    }

    // 최근 검색어 저장
    @PostMapping("/saveRecentSearch")
    @ResponseBody
    public String saveRecentSearch(@RequestParam String userId, @RequestParam String searchTerm) {
        recentService.saveRecentSearch(userId, searchTerm);
        return "saved";
    }

    // 유저 대시보드 조회
    @GetMapping("/dashboard")
    public String getUserDashboard(Model model, @RequestParam String userId) {
        model.addAttribute("bookmarks", recentService.getBookmarks(userId, "research")); // 예시로 연구 북마크만 조회
        model.addAttribute("favoriteProducts", recentService.getFavoriteProducts(userId));
        return "user/dashboard";
    }

    // 최근 본 상품 조회
    @GetMapping("/recentViews")
    public String getRecentViews(Model model, @RequestParam String userId, @RequestParam(defaultValue = "5") int limit) {
        List<RecentVO> recentViews = recentService.getRecentViews(userId, limit);
        model.addAttribute("recentViews", recentViews);
        return "recent/recentViews";
    }

    // 최근 검색어 조회
    @GetMapping("/recentSearches")
    public String getRecentSearches(Model model, @RequestParam String userId, @RequestParam(defaultValue = "5") int limit) {
        List<RecentVO> recentSearches = recentService.getRecentSearches(userId, limit);
        model.addAttribute("recentSearches", recentSearches);
        return "recent/recentSearches";
    }
}

package com.spring.javaclassS14.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.javaclassS14.service.CommunityService;
import com.spring.javaclassS14.vo.CommunityVO;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    CommunityService communityService;

    // 병원 목록 및 검색을 처리하는 메서드
    @RequestMapping(value = "/hospitalList", method = RequestMethod.GET)
    public String hospitalListGet(Model model,
                                  @RequestParam(value = "key", required = false) String key,
                                  @RequestParam(value = "keyword", required = false) String keyword) {
        List<CommunityVO> hospitals;
        if (key != null && keyword != null) {
            hospitals = communityService.searchHospitals(key, keyword);
        } 
        else {
            hospitals = communityService.getAllHospitals();
        }
        model.addAttribute("hospitals", hospitals);
        return "community/hospitalList";
    }

    // 병원 리뷰 작성 페이지로 이동하는 메서드
    @RequestMapping(value = "/hospitalCommentInput", method = RequestMethod.GET)
    public String hospitalCommentGet(@RequestParam("hospitalIdx") int hospitalIdx, Model model) {
        CommunityVO hospital = communityService.getHospitalById(hospitalIdx);
        model.addAttribute("hospital", hospital);
        return "community/hospitalCommentInput";
    }
    
    @PostMapping("/hospitalComment")
    public String insertHospitalComment(CommunityVO comment, RedirectAttributes redirectAttributes, HttpSession session) {
    	Integer userIdx = (Integer) session.getAttribute("sUidx");
    	if(userIdx == null) {
    		redirectAttributes.addFlashAttribute("message", "로그인 후에 후기 등록이 가능합니다.");
    		return "redirect:/user/login";
    	}
    	
    	comment.setUserIdx(userIdx);
    	
    	boolean result = communityService.insertHospitalComment(comment);
    	if (result) {
    		redirectAttributes.addFlashAttribute("message", "후기가 성공적으로 등록되었습니다.");
    	} else {
    		redirectAttributes.addFlashAttribute("message", "후기 등록에 실패했습니다.");
    	}
    	return "redirect:/community/hospitalList";  // 저장 후 병원 목록으로
    }
    
    @GetMapping("/hospitalComments")
    public String getHospitalComments(Model model) {
    	List<CommunityVO> comments = communityService.getHospitalComments();
    	
    	for (CommunityVO comment : comments) {
    		comment.setMaskedUserId(maskUserId(comment.getUserId()));
    	}
    	
    	model.addAttribute("comments", comments);
    	return "community/hospitalComments";
    }
    
    // 아이디 마스킹
    private String maskUserId(String userId) {
    	if(userId == null || userId.length() < 3) {
    		return "***";
    	}
    	
    	int length = userId.length();
    	return userId.substring(0, 2) + "*".repeat(length - 3) + userId.charAt(length - 1);
    }
}

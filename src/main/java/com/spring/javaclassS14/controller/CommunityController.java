package com.spring.javaclassS14.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
                                  @RequestParam(value = "keyword", required = false) String keyword,
                                  @RequestParam(value = "minWaitingTime", required = false, defaultValue = "0") int minWaitingTime, // 기본값 설정
                                  @RequestParam(value = "maxWaitingTime", required = false, defaultValue = "100") int maxWaitingTime) { // 기본값 설정
        List<CommunityVO> hospitals;
        if (key != null && keyword != null) {
            hospitals = communityService.searchHospitals(key, keyword, minWaitingTime, maxWaitingTime);
        } else {
            hospitals = communityService.getAllHospitals(minWaitingTime, maxWaitingTime);
        }
        model.addAttribute("hospitals", hospitals);
        return "community/hospitalList";
    }

    // 병원 리뷰 작성 페이지로 이동하는 메서드
    @RequestMapping(value = "/hospitalComment", method = RequestMethod.GET)
    public String hospitalCommentGet(@RequestParam("hospitalIdx") int hospitalIdx, Model model) {
        CommunityVO hospital = communityService.getHospitalById(hospitalIdx);
        model.addAttribute("hospital", hospital);
        return "community/hospitalComment";
    }

    // 병원 리뷰를 작성하는 메서드
    @RequestMapping(value = "/hospitalComment", method = RequestMethod.POST)
    public String hospitalCommentPost(HttpSession session, CommunityVO cVO) {
        String userId = (String) session.getAttribute("sUid");
        if (userId != null) {
            cVO.setUserId(userId);
            communityService.setHospitalComment(cVO); // 후기 저장
        }
        return "redirect:/community/hospitalList"; // 리뷰 작성 후 병원 목록으로 리다이렉트
    }
}

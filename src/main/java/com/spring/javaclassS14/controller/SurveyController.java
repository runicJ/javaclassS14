package com.spring.javaclassS14.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javaclassS14.service.SurveyService;
import com.spring.javaclassS14.vo.SearchVo;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyVO;

@Controller
@RequestMapping("/survey")
public class SurveyController {
    
    @Autowired
    SurveyService surveyService;
/*
    // 리스트 응답 폼 보여주기 View
    @GetMapping("/resForm")
    public String resForm(@RequestParam(value="survNo") Integer survNo, HttpServletRequest request, HttpSession session, Model model) {
        SurveyVO surveyDto = surveyService.getSurvey(survNo);
        
        String userNick = (String) session.getAttribute("sNickName");  // Assuming the nickname is stored in the session
        surveyDto.setNickName(userNick);
        if(surveyDto.getSurvDesc() != null) {
            surveyDto.setSurvDesc(surveyDto.getSurvDesc().replace("\n","<br>"));
        }
        
        model.addAttribute("surveyDto", surveyDto);
        model.addAttribute("userId", session.getAttribute("sUid"));
        model.addAttribute("currentPage", request.getParameter("currentPage"));
        model.addAttribute("cntPerPage", request.getParameter("cntPerPage"));
        model.addAttribute("pageSize", request.getParameter("pageSize"));
        model.addAttribute("srchTyp", request.getParameter("srchTyp"));
        model.addAttribute("keyword", request.getParameter("keyword"));
        
        return "survey/resSurv";
    }

    // 응답하기 
    @PostMapping("/resSurv")
    @ResponseBody
    public String resSurv(@RequestBody List<SurveyAnswerVO> answerList) {    
        System.out.println(answerList);
        surveyService.insertAnswer(answerList);
        return "redirect:/survey/surveyList";
    }

    // 설문 리스트 접속
    @RequestMapping(value = "/survList", method=RequestMethod.GET)
    public ModelAndView survList(
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
            HttpServletRequest request) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        
        SearchVo searchVo = new SearchVo(currentPage, cntPerPage, pageSize);
        
        request.setCharacterEncoding("utf-8");
        String keyword = request.getParameter("keyword");
        
        if(keyword != null) {
            searchVo.setKeyword(keyword);
            searchVo.setSrchTyp(request.getParameter("srchTyp"));
        }
        
        int total = surveyService.getListCnt(searchVo);
        
        mv.addObject("total", total);
        
        searchVo.setTotalRecordCount(total);
        
        if(total != 0) {
            mv.addObject("survList", surveyService.getSurvList(searchVo));
        } else {
            mv.addObject("survList", null);
        }
        mv.addObject("pagination", searchVo);
        
        mv.setViewName("survey/survList");
        
        return mv;
    }
    
    // My Survey 접속
    @RequestMapping(value = "/myList", method=RequestMethod.GET)
    public ModelAndView myList(
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
            HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        
        SearchVo searchVo = new SearchVo(currentPage, cntPerPage, pageSize);
        
        // Id 세팅
        searchVo.setRegId((String) session.getAttribute("sUid"));
        
        request.setCharacterEncoding("utf-8");
        
        searchVo.setKeyword(request.getParameter("keyword"));
        searchVo.setSrchTyp(request.getParameter("srchTyp"));
        
        int total = surveyService.getMyCnt(searchVo);
        
        mv.addObject("total", total);
        
        searchVo.setTotalRecordCount(total);
        
        if(total != 0) {
            mv.addObject("survList", surveyService.getMyList(searchVo));
        } else {
            mv.addObject("survList", null);
        }
        mv.addObject("pagination", searchVo);
        
        mv.setViewName("survey/myList");
        
        return mv;
    }
    
    // 설문 결과 접속
    @RequestMapping("/survRslt")
    public ModelAndView survRslt(@RequestParam(value = "survNo") int survNo,
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
            HttpServletRequest request) { 
        
        ModelAndView mv = new ModelAndView();
        mv.setViewName("survey/survRslt");
        
        SearchVo searchVo = new SearchVo(currentPage, cntPerPage, pageSize);
        searchVo.setKeyword(request.getParameter("keyword"));
        searchVo.setSrchTyp(request.getParameter("srchTyp"));
        mv.addObject("pagination", searchVo);
        
        SurveyVO surveyDto = surveyService.getSurvRslt(survNo);
        
        mv.addObject("survey", surveyDto);
        
        return mv;
    }
    
    // 해당 설문 응답 여부 확인
    @PostMapping(value="/checkRes")
    @ResponseBody
    public int checkRes(SurveyVO surveyDto) { 
        System.out.println(surveyDto);
        int cnt = surveyService.resSurvYn(surveyDto);
        return cnt;
    }
    
    // 설문 정보 접속
    @RequestMapping(value = "/survInfo", method=RequestMethod.GET)
    public ModelAndView survInfo(
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
            @RequestParam(value = "survNo") int survNo,
            HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        
        String nickName = (String) session.getAttribute("sNickName");
        
        SearchVo searchVo = new SearchVo(currentPage, cntPerPage, pageSize);
        searchVo.setKeyword(request.getParameter("keyword"));
        searchVo.setSrchTyp(request.getParameter("srchTyp"));
        mv.addObject("pagination", searchVo);
        
        SurveyVO surveyDto = surveyService.getOneSurvey(nickName, survNo);
        
        surveyDto.setSurvDesc(surveyDto.getSurvDesc().replace("\n", "<br>"));
        
        mv.addObject("survey", surveyDto);
        mv.addObject("memId", session.getAttribute("sUid"));
        
        mv.setViewName("survey/survInfo");
        
        return mv;
    }
    */
}

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

import com.google.gson.Gson;
import com.spring.javaclassS14.service.SurveyService;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
import com.spring.javaclassS14.vo.SurveyVO;

@Controller
@RequestMapping("/survey")
public class SurveyController {
    
    @Autowired
    SurveyService surveyService;

    // 설문 리스트 접속
    @RequestMapping(value = "/surveyEventList", method=RequestMethod.GET)
    public ModelAndView surveyEventListGet(
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
            HttpServletRequest request) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        
        request.setCharacterEncoding("utf-8");
        
        int surveyCnt = surveyService.getSurveyCnt();
        
        mv.addObject("surveyCnt", surveyCnt);
        
        if(surveyCnt != 0) {
            mv.addObject("surveyVOS", surveyService.getSurveyEventList());
        } 
        else {
            mv.addObject("surveyVOS", null);
        }
        //mv.addObject("pagination", searchVo);
        
        mv.setViewName("survey/surveyEventList");
        
        return mv;
    }
    
    // 리스트 응답 폼 보여주기 View
    @GetMapping("/surveyAnswer")
    public String resForm(int surveyIdx, HttpServletRequest request, HttpSession session, Model model) {
        SurveyVO surveyVO = surveyService.getSurveyForm(surveyIdx);
        
        String userId = (String) session.getAttribute("userId");
        surveyVO.setUserId(userId);
        if(surveyVO.getSurveyDesc() != null) {
        	surveyVO.setSurveyDesc(surveyVO.getSurveyDesc().replace("\n","<br>"));
        }
        model.addAttribute("questListJson", new Gson().toJson(surveyVO.getQuestList()));
        model.addAttribute("surveyVO", surveyVO);
        
        return "survey/surveyAnswer";
    }

    // 응답하기 
    @ResponseBody
    @PostMapping("/surveyAnswer")
    public String resSurv(@RequestBody List<SurveyAnswerVO> answerList) {
        int res = surveyService.setSurveyAnswerInput(answerList);
        return res + "";
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
        
        //mv.addObject("pagination", searchVo);
        
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
    /*
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
        
        //mv.addObject("pagination", searchVo);
        
        SurveyVO surveyVO = surveyService.getOneSurvey(nickName, survNo);
        
        surveyVO.setSurveyDesc(surveyVO.getSurveyDesc().replace("\n", "<br>"));
        
        mv.addObject("surveyVO", surveyVO);
        mv.addObject("userId", session.getAttribute("sUid"));
        
        mv.setViewName("survey/survInfo");
        
        return mv;
    }
    */
}

package com.spring.javaclassS14.controller;

import java.util.List;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.google.gson.Gson;
import com.spring.javaclassS14.service.SurveyService;
import com.spring.javaclassS14.vo.SurveyAnswerVO;
import com.spring.javaclassS14.vo.SurveyVO;

@Controller
@RequestMapping("/survey")
public class SurveyController {

    @Autowired
    SurveyService surveyService;

    // 1. 설문 리스트 조회
    @GetMapping("/surveyEventList")
    public String surveyEventList(Model model) {
        List<SurveyVO> surveyList = surveyService.getSurveyEventList();
        model.addAttribute("surveyList", surveyList);
        return "survey/surveyEventList";
    }

    // 2. 특정 설문조사 조회 (설문 응답 페이지)
    @GetMapping("/surveyAnswer")
    public String getSurveyForm(@RequestParam("surveyIdx") int surveyIdx, HttpSession session, Model model) {
        SurveyVO surveyVO = surveyService.getSurveyForm(surveyIdx);
        String userId = (String) session.getAttribute("userId");
        surveyVO.setUserId(userId);

        if (surveyVO.getSurveyDesc() != null) {
            surveyVO.setSurveyDesc(surveyVO.getSurveyDesc().replace("\n", "<br>"));
        }

        model.addAttribute("surveyVO", surveyVO);
        model.addAttribute("questListJson", new Gson().toJson(surveyVO.getQuestList()));

        return "survey/surveyAnswer";
    }

    // 3. 설문 응답 저장 (Batch Insert)
    @ResponseBody
    @PostMapping("/surveyAnswer")
    public String saveSurveyAnswer(@RequestBody List<SurveyAnswerVO> answerList) {
        int result = surveyService.setSurveyAnswerInputBatch(answerList);
        return String.valueOf(result);
    }

    // 4. 설문 결과 조회
    @GetMapping("/survRslt")
    public String getSurveyResult(@RequestParam("surveyIdx") int surveyIdx, Model model) {
        SurveyVO surveyVO = surveyService.getSurvRslt(surveyIdx);
        model.addAttribute("survey", surveyVO);
        return "survey/survRslt";
    }

    // 5. 설문 응답 여부 확인 (사용자가 응답했는지 체크)
    @ResponseBody
    @PostMapping("/checkRes")
    public int checkSurveyResponse(@RequestBody SurveyVO surveyDto) { 
        return surveyService.resSurvYn(surveyDto);
    }

    // 6. 페이징을 고려한 설문 리스트 조회
    @GetMapping("/surveyEventListPaged")
    public String surveyEventListPaged(
        @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
        @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
        Model model) {
        
        List<SurveyVO> surveyList = surveyService.getSurveyEventListPaged(currentPage, cntPerPage);
        model.addAttribute("surveyList", surveyList);
        model.addAttribute("currentPage", currentPage);
        return "survey/surveyEventList";
    }
}
package com.spring.javaclassS14.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    // 1. 설문 리스트 조회
    @GetMapping("/surveyEventList")
    public String surveyEventList(Model model) {
        List<SurveyVO> surveyList = surveyService.getSurveyEventList();

        // 디버깅용
		/*
		 * System.out.println("설문 리스트 크기: " + surveyList.size()); for (SurveyVO survey :
		 * surveyList) { System.out.println("설문 ID: " + survey.getSurveyIdx() + ", 제목: "
		 * + survey.getSurveyTitle()); }
		 */

        model.addAttribute("surveyList", surveyList);
        return "survey/surveyEventList";
    }

    // 2. 특정 설문조사 조회 (설문 응답 페이지)
    @GetMapping("/surveyAnswer")
    public String getSurveyForm(@RequestParam("surveyIdx") int surveyIdx, HttpSession session, Model model) {
        SurveyVO surveyVO = surveyService.getSurveyForm(surveyIdx);
        
        if (surveyVO == null) {
            return "redirect:/survey/surveyEventList"; // 설문이 없으면 목록으로 이동
        }

        // 세션에서 userId 가져와서 저장
        String userId = (String) session.getAttribute("userId");
        surveyVO.setUserId(userId);

        // Debug: 설문 내용, 질문 리스트, 옵션 리스트 확인
        System.out.println("설문 제목: " + surveyVO.getSurveyTitle());
        if (surveyVO.getQuestList() != null) {
            System.out.println("질문 개수: " + surveyVO.getQuestList().size());

            for (SurveyQuestionVO question : surveyVO.getQuestList()) {
                System.out.println("질문: " + question.getQuestContent());
                System.out.println("옵션 개수: " + (question.getOptions() != null ? question.getOptions().size() : "없음"));
            }
        } else {
            System.out.println("질문 목록이 없습니다.");
        }

        // 설문 설명 개행 처리
        if (surveyVO.getSurveyDesc() != null) {
            surveyVO.setSurveyDesc(surveyVO.getSurveyDesc().replace("\n", "<br>"));
        }

        // 모델에 데이터 추가
        model.addAttribute("surveyVO", surveyVO);
        model.addAttribute("questListJson", new Gson().toJson(surveyVO.getQuestList())); // JSON 변환

        return "survey/surveyAnswer";
    }

    // 설문 응답 저장
    @ResponseBody
    @PostMapping("/surveyAnswer")
    public String saveSurveyAnswer(@RequestBody List<SurveyAnswerVO> answerList, HttpSession session) {
        Integer userIdx = (Integer) session.getAttribute("sUidx");

        if (userIdx == null) {
            return "error: 로그인 정보가 없습니다.";
        }

        if (answerList == null || answerList.isEmpty()) {
            return "error: 응답 데이터가 없습니다.";
        }

        // 설문 응답 중복 확인 (첫 번째 응답에서 surveyIdx 가져오기)
        Integer surveyIdx = answerList.get(0).getSurveyIdx();
        if (surveyIdx == null) {
            return "error: 잘못된 설문 ID입니다.";
        }

        boolean isAnswered = surveyService.checkUserSurveyAnswered(userIdx, surveyIdx);
        if (isAnswered) {
            return "이미 응답한 설문입니다.";
        }

        // 모든 답변에 userIdx 설정
        for (SurveyAnswerVO answer : answerList) {
            answer.setUserIdx(userIdx);
        }

        int result = surveyService.setSurveyAnswerInputBatch(answerList);
        return String.valueOf(result);
    }

    
    // 특정 설문에 대한 응답 여부 확인 API
    @GetMapping("/checkUserSurveyAnswered")
    public ResponseEntity<?> checkUserSurveyAnswered(@RequestParam(required = false) Integer surveyIdx, HttpSession session) {
        Integer userIdx = (Integer) session.getAttribute("sUidx");

        if (userIdx == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("error: 로그인 정보가 없습니다.");
        }

        if (surveyIdx == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error: 설문 ID가 없습니다.");
        }

        boolean isAnswered = surveyService.checkUserSurveyAnswered(userIdx, surveyIdx);
        return ResponseEntity.ok(isAnswered);
    }


		/*
		 * System.out.println("저장할 응답 개수: " + answerList.size());
		 * 
		 * for (SurveyAnswerVO answer : answerList) { System.out.println("질문 번호: " +
		 * answer.getQuestIdx()); System.out.println("사용자 ID: " + answer.getUserIdx());
		 * System.out.println("응답 내용: " + answer.getAnswerContent());
		 * System.out.println("장문 응답: " + answer.getAnswerLong()); }
		 */

    // 4. 설문 결과 조회
    @GetMapping("/survRslt")
    public String getSurveyResult(@RequestParam("surveyIdx") int surveyIdx, Model model) {
        SurveyVO surveyVO = surveyService.getSurvRslt(surveyIdx);
        model.addAttribute("survey", surveyVO);
        return "survey/survRslt";
    }

    // 5. 설문 응답 여부 확인 (사용자가 응답했는지 체크)
    @GetMapping("/checkRes")
    public ResponseEntity<?> checkSurveyResponse(@RequestParam Integer surveyIdx, HttpSession session) {
        Integer userIdx = (Integer) session.getAttribute("sUidx");

        if (userIdx == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("error: 로그인 정보가 없습니다.");
        }

        if (surveyIdx == null) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("error: 설문 ID가 없습니다.");
        }

        int result = surveyService.resSurvYn(userIdx, surveyIdx);
        return ResponseEntity.ok(result > 0); // 응답 여부를 Boolean 값으로 변환
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
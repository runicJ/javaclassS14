package com.spring.javaclassS14.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.ProductQnaService;
import com.spring.javaclassS14.vo.ProductQnaVO;

@Controller
@RequestMapping("/qna")
public class ProductQnaController {
  String msgFlag = "";
  
  @Autowired
  ProductQnaService productQnaService;
  
  @Autowired
  PageProcess pageProcess;
  
  @Autowired
  AllProvide allProvide;
  
  // QnA 작성 페이지
  @RequestMapping(value = "/qnaInput", method = RequestMethod.GET)
  public String qnaInputGet(HttpSession session, Model model) {
    Integer userIdx = (Integer) session.getAttribute("sUidx");

    if (userIdx == null) {
      return "redirect:/msg/userLoginNo";  // 로그인 필요
    }
    
    String email = productQnaService.getEmail(userIdx);
    
    model.addAttribute("email", email);
    return "shop/qnaInput";
  }
  
  // QnA 글쓰기 처리
  @Transactional
  @RequestMapping(value = "/qnaInput", method = RequestMethod.POST)
  public String qnaInputPost(ProductQnaVO vo, HttpSession session) {
    // 이미지 처리
    if (vo.getQnaContent().contains("src=\"/")) {
      allProvide.imgCheck(vo.getQnaContent(), "ckeditor", "qna");
      vo.setQnaContent(vo.getQnaContent().replace("/data/ckeditor/", "/data/qna/"));
    }

    int newIdx = productQnaService.getMaxIdx() + 1;
    vo.setProductQnaIdx(newIdx);

    // 질문글과 답변글 처리
    if (vo.getAnswerFlag().equals("n")) {
      vo.setProductQnaIdx(newIdx);
    }

    productQnaService.qnaInputOk(vo);
    
    // 답변 여부 처리
    if (vo.getAnswerFlag().equals("n")) {
    	productQnaService.qnaAdminInputOk(vo.getProductQnaIdx());
    } else {
    	productQnaService.qnaAdminAnswerUpdateOk(vo.getProductQnaIdx());
    }
    
    return "redirect:/msg/qnaInputOk";
  }
  
  // QnA 상세보기
  @RequestMapping(value = "/qnaContent", method = RequestMethod.GET)
  public String qnaContentGet(int productQnaIdx, HttpSession session, Model model) {
    Integer userIdx = (Integer) session.getAttribute("sUidx");

    if (userIdx == null) {
      return "redirect:/msg/userLoginNo";  // 로그인 필요
    }
    
    String email = productQnaService.getEmail(userIdx);
    ProductQnaVO vo = productQnaService.getQnaContent(productQnaIdx);
    
    model.addAttribute("email", email);
    model.addAttribute("vo", vo);
    
    return "shop/qnaContent";
  }
  
  // QnA 수정 폼 보기
  @RequestMapping(value = "/qnaUpdate", method = RequestMethod.GET)
  public String qnaUpdateGet(Model model, int productQnaIdx) {
    ProductQnaVO vo = productQnaService.getQnaContent(productQnaIdx);

    if (vo.getQnaContent().contains("src=\"/")) {
      allProvide.imgCheck(vo.getQnaContent(), "qna", "ckeditor");
    }
    
    model.addAttribute("vo", vo);
    return "shop/qnaUpdate";
  }
  
  // QnA 수정 처리
  @RequestMapping(value = "/qnaUpdate", method = RequestMethod.POST)
  public String qnaUpdatePost(ProductQnaVO vo) {
    if (vo.getQnaContent().contains("src=\"/")) {
      allProvide.imgCheck(vo.getQnaContent(), "ckeditor", "qna");
      vo.setQnaContent(vo.getQnaContent().replace("/data/qna/", "/data/ckeditor/"));
      vo.setQnaContent(vo.getQnaContent().replace("/data/ckeditor/", "/data/qna/"));
    }

    productQnaService.setQnaContentUpdate(vo);
    return "redirect:/msg/qnaUpdateOk";
  }
  
  // QnA 삭제 처리
  @RequestMapping(value = "/qnaDelete", method = RequestMethod.GET)
  public String qnaDeleteGet(int productQnaIdx) {
    ProductQnaVO vo = productQnaService.getQnaContent(productQnaIdx);
    
    if (vo.getQnaContent().contains("src=\"/")) {
      allProvide.imagesDelete(vo.getQnaContent(), "qna");
    }
    
    List<ProductQnaVO> qnaCheckVO = productQnaService.getQnaIdxCheck(vo.getProductQnaIdx());

    if (vo.getAnswerFlag().equals("y") || (vo.getAnswerFlag().equals("n") && qnaCheckVO.size() == 1)) {
    	productQnaService.setQnaDelete(productQnaIdx);
    } else {
    	productQnaService.setQnaCheckUpdate(productQnaIdx, "<font size='2' color='#ccc'>현재 삭제된 글입니다.</font>");
    }
    
    return "redirect:/msg/qnaDeleteOk";
  }
  
}

package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.PhotoReviewService;
import com.spring.javaclassS14.vo.PhotoReviewVO;

@Controller
@RequestMapping("/photoReview")
public class PhotoReviewController {
	
	@Autowired
	PhotoReviewService photoReviewService;
	
	@Autowired
	AllProvide allProvide;
	
	@Autowired
	PageProcess pageProcess;
	
	// 사진 여러장 보기 List
	@RequestMapping(value = "/photoReviewList", method = RequestMethod.GET)
	public String photoReviewListGet(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="choice", defaultValue = "최신순", required = false) String choice
		) {
		int startIndexNo = (pag - 1) * pageSize;
		
		String imsiChoice = "";
		if(choice.equals("최신순")) imsiChoice = "idx";
		else if(choice.equals("추천순")) imsiChoice = "goodCount";
		else if(choice.equals("조회순")) imsiChoice = "readNum";
		else if(choice.equals("댓글순")) imsiChoice = "replyCnt";	
		else imsiChoice = choice;
		
		//PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "photoReview", part, choice);
		List<PhotoReviewVO> vos = photoReviewService.getPhotoReviewList(startIndexNo, pageSize, part, imsiChoice);
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("choice", choice);
		return "photoReview/photoReviewList";
	}
	
	// 사진 여러장보기에서, 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
	@ResponseBody
	@RequestMapping(value = "/photoReviewListPaging", method = RequestMethod.POST)
	public ModelAndView photoReviewPagingPost(Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "12", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="choice", defaultValue = "최신순", required = false) String choice
		) {
		int startIndexNo = (pag - 1) * pageSize;
		
		String imsiChoice = "";
		if(choice.equals("최신순")) imsiChoice = "idx";
		else if(choice.equals("추천순")) imsiChoice = "goodCount";
		else if(choice.equals("조회순")) imsiChoice = "readNum";
		else if(choice.equals("댓글순")) imsiChoice = "replyCnt";	
		else imsiChoice = choice;
		
		//PageVO pageVo = pageProcess.totRecCnt(pag, pageSize, "photoReview", part, choice);
		List<PhotoReviewVO> vos = photoReviewService.getPhotoReviewList(startIndexNo, pageSize, part, imsiChoice);
		model.addAttribute("vos", vos);
		model.addAttribute("part", part);
		model.addAttribute("choice", choice);
		
		// ModelAndView에 담아서 return
		ModelAndView mv = new ModelAndView();
		mv.setViewName("photoReview/photoReviewListPaging");
		return mv;
	}
	
	// 사진 한장씩 전체 보기(나중에 올린순으로 보기)
	@RequestMapping(value = "/photoReviewSingle", method = RequestMethod.GET)
	public String photoReviewSingleGet(Model modelModel, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "1", required = false) int pageSize
		) {
		int startIndexNo = (pag - 1) * pageSize;
		List<PhotoReviewVO> vos = photoReviewService.setPhotoReviewSingle(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		return "photoReview/photoReviewSingle";
	}
	
	// 사진 한장씩 전체 보기(나중에 올린순으로 보기) - 한화면 마지막으로 이동했을때 다음 페이지 스크롤하기
	@ResponseBody
	@RequestMapping(value = "/photoReviewSinglePaging", method = RequestMethod.POST)
	public ModelAndView photoReviewSinglePagingPost(Model modelModel, Model model,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag, 
			@RequestParam(name="pageSize", defaultValue = "1", required = false) int pageSize
			) {
		int startIndexNo = (pag - 1) * pageSize;
		List<PhotoReviewVO> vos = photoReviewService.setPhotoReviewSingle(startIndexNo, pageSize);
		model.addAttribute("vos", vos);
		
	  // ModelAndView에 담아서 return
		ModelAndView mv = new ModelAndView();
		mv.setViewName("photoReview/photoReviewSinglePaging");
		return mv;
	}
	
	// 포토갤러리 사진 등록하기 폼보기
	@RequestMapping(value = "/photoReviewInput", method = RequestMethod.GET)
	public String photoReviewInputGet() {
		return "photoReview/photoReviewInput";
	}
	
	// 포토갤러리 사진 등록처리
	@RequestMapping(value = "/photoReviewInput", method = RequestMethod.POST)
	public String photoReviewInputPost(PhotoReviewVO vo, HttpServletRequest request) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		int res = photoReviewService.imgCheck(vo, realPath);
		if(res != 0) return "redirect:/message/photoReviewInputOk";
		else return "redirect:/message/photoReviewInputNo";
	}
	
	// 개별항목 상세보기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/photoReviewContent", method = RequestMethod.GET)
	public String photoReviewContentGet(HttpSession session, int idx, Model model, HttpServletRequest request) {
		// 게시글 조회수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "photoReview" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			photoReviewService.setPhotoReviewReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);

		// 조회자료 1건 담아서 내용보기로 보낼 준비
		PhotoReviewVO vo = photoReviewService.getPhotoReviewIdxSearch(idx);
		model.addAttribute("vo", vo);
		
		// ckeditor의 사진정보만 뽑아서 넘겨주기(content화면에서 여러장의 사진을 보이고자 함)
		List<String> photoList = photoReviewService.getPhotoReviewPhotoList(vo.getContent());
		//model.addAttribute("photoList", photoList);
		request.setAttribute("photoList", photoList);
		
		// 댓글 처리
		ArrayList<PhotoReviewVO> replyVos = photoReviewService.getPhotoReviewReply(idx);
		model.addAttribute("replyVos", replyVos);
		
		return "photoReview/photoReviewContent";
	}

	// 댓글달기
	@ResponseBody
	@RequestMapping(value = "/photoReviewReplyInput", method = RequestMethod.POST)
	public String photoReviewReplyInputPost(PhotoReviewVO vo) {
		return photoReviewService.setPhotoReviewReplyInput(vo) + "";
	}
	
	// 댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/photoReviewReplyDelete", method = RequestMethod.POST)
	public String photoReviewReplyDeletePost(int idx) {
		return photoReviewService.setPhotoReviewReplyDelete(idx) + "";
	}
	
	// 좋아요수 증가
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/photoReviewGoodCheck", method = RequestMethod.POST)
	public String photoReviewGoodCheckPost(HttpSession session, int idx) {
		String res = "0";
		// 좋아요 클릭수 1씩 증가시키기(중복방지)
		ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentGood");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "photoReview" + idx;
		if(!contentReadNum.contains(imsiContentReadNum)) {
			photoReviewService.setPhotoReviewGoodPlus(idx);
			contentReadNum.add(imsiContentReadNum);
			res = "1";
		}
		session.setAttribute("sContentGood", contentReadNum);
		return res;
	}

	// 내용 삭제하기
	@RequestMapping(value = "/photoReviewDelete", method = RequestMethod.GET)
	public String photoReviewDeleteGet(int idx) {
		int res = photoReviewService.setPhotoReviewDelete(idx);
	  if(res != 0) return "redirect:/message/photoReviewDeleteOk";
	  else return "redirect:/message/photoReviewDeleteNo";
	}

	
}

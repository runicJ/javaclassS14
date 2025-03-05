package com.spring.javaclassS14.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
		if(choice.equals("최신순")) imsiChoice = "photoReviewIdx";
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
		if(choice.equals("최신순")) imsiChoice = "photoReviewIdx";
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
	
	@RequestMapping(value = "/photoReviewInput", method = RequestMethod.POST)
	public String photoReviewInputPost(PhotoReviewVO vo, HttpSession session,
	                                   @RequestParam("uploadFiles") MultipartFile[] uploadFiles, 
	                                   HttpServletRequest request) {
	    Integer userIdx = (Integer) session.getAttribute("sUidx");
	    vo.setUserIdx(userIdx);
	    
	    System.out.println("photoReviewInputPost 실행 - vo: " + vo);

	    // 저장 경로 설정
	    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/photoReview/");
	    System.out.println("파일 저장 경로: " + realPath);

	    File uploadDir = new File(realPath);
	    if (!uploadDir.exists()) uploadDir.mkdirs();

	    List<String> fileNames = new ArrayList<>();

	    try {
	        for (MultipartFile file : uploadFiles) {
	            if (!file.isEmpty()) {
	                String saveFileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
	                File saveFile = new File(realPath, saveFileName);
	                file.transferTo(saveFile);
	                System.out.println("파일 저장 성공: " + saveFile.getAbsolutePath());
	                fileNames.add(saveFileName);
	            }
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        return "redirect:/msg/photoReviewInputNo";
	    }

	    // 파일이 업로드된 경우, 첫 번째 이미지를 썸네일로 지정
	    if (!fileNames.isEmpty()) {
	        vo.setThumbnail(fileNames.get(0)); // 첫 번째 이미지를 썸네일로 설정
	    } else {
	        vo.setThumbnail("noImage.png"); // 기본 썸네일 설정
	    }

	    // 업로드된 사진 개수 저장
	    vo.setPhotoCount(fileNames.size());

	    // 사진 파일명을 content 필드에 저장 (쉼표 구분)
	    vo.setContent(String.join(",", fileNames));

	    System.out.println("DB 저장 전 VO 값: " + vo);

	    // MyBatis를 이용한 DB 저장
	    int res = photoReviewService.photoReviewInput(vo);
	    System.out.println("DB 저장 결과: " + res);

	    if (res != 0) return "redirect:/msg/photoReviewInputOk";
	    else return "redirect:/msg/photoReviewInputNo";
	}
	
	// 개별항목 상세보기
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/photoReviewContent", method = RequestMethod.GET)
	public String photoReviewContentGet(HttpSession session, 
			@RequestParam("photoReviewIdx") int photoReviewIdx, Model model, HttpServletRequest request) {
		
		// 게시글 조회수 1씩 증가시키기(세션 활용한 중복방지)
	    ArrayList<String> contentReadNum = (ArrayList<String>) session.getAttribute("sContentIdx");
	    if (contentReadNum == null) contentReadNum = new ArrayList<>();
	    
	    String imsiContentReadNum = "photoReview" + photoReviewIdx;
	    if (!contentReadNum.contains(imsiContentReadNum)) {
	        photoReviewService.setPhotoReviewReadNumPlus(photoReviewIdx);
	        contentReadNum.add(imsiContentReadNum);
	    }
	    session.setAttribute("sContentIdx", contentReadNum);

	    // 게시글 상세 정보 조회
	    PhotoReviewVO vo = photoReviewService.getPhotoReviewIdxSearch(photoReviewIdx);
	    model.addAttribute("vo", vo);
		
	    // CKEditor 사진 목록 가져오기
	    List<String> photoList = photoReviewService.getPhotoReviewPhotoList(vo.getContent());
	    request.setAttribute("photoList", photoList);
		//request.setAttribute("photoList", photoList);
		
	    // 댓글 리스트 가져오기
	    ArrayList<PhotoReviewVO> replyVos = photoReviewService.getPhotoReviewReply(photoReviewIdx);
	    model.addAttribute("replyVos", replyVos);
		
		return "photoReview/photoReviewContent";
	}

	// 댓글달기
	@PostMapping("/photoReview/photoReviewReplyInput")
	@ResponseBody
	public String submitReply(
	        @RequestParam("photoReviewIdx") int photoReviewIdx,
	        @RequestParam("content") String content,
	        HttpSession session) {

	    Integer userIdx = (Integer) session.getAttribute("userIdx"); // 세션에서 userIdx 가져오기

	    if (userIdx == null) {
	        return "not_logged_in"; // 로그인하지 않은 사용자
	    }

	    int result = photoReviewService.insertPhotoReviewReply(userIdx, photoReviewIdx, content);
	    return result > 0 ? "1" : "0"; // 성공 시 "1", 실패 시 "0" 반환
	}
	
	// 댓글 삭제
	@PostMapping("/photoReview/photoReviewReplyDelete")
	@ResponseBody
	public String deletePhotoReviewReply(@RequestParam("photoReviewReplyIdx") int photoReviewReplyIdx, HttpSession session) {
	    Integer userIdx = (Integer) session.getAttribute("userIdx");

	    if (userIdx == null) {
	        return "not_logged_in"; // 로그인하지 않은 사용자
	    }

	    int result = photoReviewService.deletePhotoReviewReply(photoReviewReplyIdx, userIdx);
	    return result > 0 ? "1" : "0"; // 성공 시 "1", 실패 시 "0" 반환
	}
	
	/*
	 * // 좋아요수 증가
	 * 
	 * @SuppressWarnings("unchecked")
	 * 
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "/photoReviewGoodCheck", method = RequestMethod.POST)
	 * public String photoReviewGoodCheckPost(HttpSession session, int idx) { String
	 * res = "0"; // 좋아요 클릭수 1씩 증가시키기(중복방지) ArrayList<String> contentReadNum =
	 * (ArrayList<String>) session.getAttribute("sContentGood"); if(contentReadNum
	 * == null) contentReadNum = new ArrayList<String>(); String imsiContentReadNum
	 * = "photoReview" + idx; if(!contentReadNum.contains(imsiContentReadNum)) {
	 * photoReviewService.setPhotoReviewGoodPlus(idx);
	 * contentReadNum.add(imsiContentReadNum); res = "1"; }
	 * session.setAttribute("sContentGood", contentReadNum); return res; }
	 */

	// 내용 삭제하기
	@RequestMapping(value = "/photoReviewDelete", method = RequestMethod.GET)
	public String photoReviewDeleteGet(int idx) {
		int res = photoReviewService.setPhotoReviewDelete(idx);
	  if(res != 0) return "redirect:/msg/photoReviewDeleteOk";
	  else return "redirect:/msg/photoReviewDeleteNo";
	}

	@ResponseBody
	@RequestMapping(value="/photoReviewLikeCheck", method=RequestMethod.POST)
	public Map<String, Object> photoReviewLikeCheckPost(HttpSession session,  @RequestParam("photoReviewIdx") int photoReviewIdx) {

	    Map<String, Object> response = new HashMap<>();
	    Integer userIdx = (Integer) session.getAttribute("sUid");

	    if (userIdx == null) {
	        response.put("status", "not_logged_in");
	        return response;
	    }
	    
	    boolean hasLiked = photoReviewService.hasUserLiked(userIdx, photoReviewIdx);

	    boolean success;
	    if (hasLiked) {
	        success = photoReviewService.removeLike(userIdx, photoReviewIdx);
	        response.put("status", "unliked");
	    } else {
	        success = photoReviewService.addLike(userIdx, photoReviewIdx);
	        response.put("status", "liked");
	    }

	    if (!success) {
	        response.put("status", "error");
	        response.put("message", "좋아요 처리 중 오류가 발생했습니다.");
	        return response;
	    }

	    response.put("likeCount", photoReviewService.getLikeCount(photoReviewIdx));
	    return response;
	}
}

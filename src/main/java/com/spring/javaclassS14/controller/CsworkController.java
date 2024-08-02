package com.spring.javaclassS14.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS14.service.CsworkService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.ShopVO;

@Controller
@RequestMapping("/cswork")
public class CsworkController {
	
	@Autowired
	CsworkService csworkService;
	
	@Autowired
	ShopService shopService;
	
	// 인사말
	@RequestMapping(value="/greeting",method=RequestMethod.GET)
	public String greetingGet() {
		return "introduce/greeting";
	}
	
	// 홈페이지 소개
	@RequestMapping(value="/introduce",method=RequestMethod.GET)
	public String introduceGet() {
		return "introduce/introduce";
	}
	
	// 지점 소개
	@RequestMapping(value="/branchMap",method=RequestMethod.GET)
	public String branchMapGet(Model model,
			@RequestParam(name="branchName", defaultValue = "", required = false) String branchName) {
		BranchVO vo = new BranchVO();
		List<BranchVO> branchVOS = csworkService.getBranchList();
		
		if(branchName.equals("")) {
			vo.setLatitude(36.6224322807634);
			vo.setLongitude(127.332285985453);
			vo = csworkService.getBranchSearch2(vo.getLatitude(),vo.getLongitude());
		}
		else {
			vo = csworkService.getBranchSearch(branchName);
		}
		model.addAttribute("branchVOS", branchVOS);
		model.addAttribute("vo", vo);
		
		return "introduce/branchMap";
	}
	
    @ModelAttribute
    public void addCommonAttributes(Model model) {
        List<ShopVO> categoryTopVOS = shopService.getCategoryTop();
        List<ShopVO> productTopMidVOS = shopService.getProductTopMidList();
        
        model.addAttribute("categoryTopVOS", categoryTopVOS);
        model.addAttribute("productTopMidVOS", productTopMidVOS);
    }
    
	@RequestMapping(value="/notice/noticeList", method=RequestMethod.GET)
	public String noticeListGet(Model model) {
		
		List<CsworkVO> noticeVOS = csworkService.getNoticeList();
		
		model.addAttribute("noticeVOS", noticeVOS);
		return "cswork/notice/noticeList";
	}
	
	@RequestMapping(value="/notice/noticeDetails", method=RequestMethod.GET)
	public String noticeDetailsGet(Model model, int noticeIdx) {
		
		CsworkVO noticeVO = csworkService.getNoticeInfo(noticeIdx);
		System.out.println("noticeVO : " + noticeVO);
		model.addAttribute("noticeVO", noticeVO);
		return "cswork/notice/noticeDetails";
	}
	
	@RequestMapping(value="/notice/faqList", method=RequestMethod.GET)
	public String fapListGet(Model model) {

		return "cswork/notice/faqList";
	}
	
	@RequestMapping(value="/qna/adApply", method=RequestMethod.GET)
	public String adApplyGet() {
		return "cswork/qna/adApply";
	}
	
	@RequestMapping(value="/qna/branchApply", method=RequestMethod.GET)
	public String branchApplyGet() {
		return "cswork/qna/branchApply";
	}
	
	@RequestMapping(value="/qna/qnaApply", method=RequestMethod.GET)
	public String qnaApplyGet() {
		return "cswork/qna/qnaApply";
	}
	
	@RequestMapping(value="/qna/qnaInput", method=RequestMethod.POST)
	public String qnaInputPost(CsworkVO qnaVO) {
		int res = csworkService.setQnaInput(qnaVO);
		
		return res + "";
	}
	
	@RequestMapping(value="/faq/faqList", method=RequestMethod.GET)
	public String qnaInputGet(Model model) {
		List<CsworkVO> faqVOS = csworkService.getFaqList();
		List<CsworkVO> faqTop10VOS = csworkService.getFaqTopList();
		
		model.addAttribute("faqVOS",faqVOS);
		model.addAttribute("faqTop10VOS",faqTop10VOS);
		return "cswork/qna/faqList";
	}
	
	@ResponseBody
	@RequestMapping(value="/faq/faqList", method=RequestMethod.POST)
	public String qnaInputPost(Model model, @RequestParam String category, @RequestParam String keyword) {
		List<CsworkVO> faqVOS = csworkService.getFaqSearchList(category, keyword);
		
		model.addAttribute("faqVOS",faqVOS);
		return "cswork/qna/faqList";
	}
}

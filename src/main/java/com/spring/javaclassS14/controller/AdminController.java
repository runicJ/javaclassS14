package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.AdminService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.service.SurveyService;
import com.spring.javaclassS14.vo.PageVO;
import com.spring.javaclassS14.vo.ShopVO;
import com.spring.javaclassS14.vo.SurveyVO;
import com.spring.javaclassS14.vo.UserVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	PageProcess pageProcess;
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	ShopService shopService;
	
	// 관리자 페이지로 이동
	@RequestMapping(value="/adminMain", method=RequestMethod.GET)
	public String adminMainGet(Model model) {
		List<UserVO> wayVOS = adminService.getUserRegisterWay();
		
		model.addAttribute("wayVOS", wayVOS);
		return "admin/adminMain";
	}
	
	// 회원리스트
	@RequestMapping(value="/userList", method=RequestMethod.GET)
	public String userListGet(Model model,
		@RequestParam(name="pag", defaultValue="1", required=false) int pag,
		@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "user", "", "");
		
		ArrayList<UserVO> vos = adminService.getUserList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/user/userList";
	}
	
	// 탈퇴 회원리스트
	@RequestMapping(value="/deleteUserList", method=RequestMethod.GET)
	public String deleteUserListGet(Model model,
			@RequestParam(name="pag", defaultValue="1", required=false) int pag,
			@RequestParam(name="pageSize", defaultValue="5", required=false) int pageSize) {
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "user", "", "");
		
		ArrayList<UserVO> vos = adminService.getDeleteUserList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "admin/user/deleteUserList";
	}
	
	// 탈퇴 회원 처리
	@RequestMapping(value="/userDelete", method=RequestMethod.POST)
	public String userDeletePost(String delFlag, String userId) {
		int res = adminService.getDeleteUser(delFlag, userId);
		
		if(res != 0) return "redirect:/msg/userCheckOk?delFlag="+delFlag;
		else return "redirect:/msg/userCheckNo?delFlag="+delFlag;
	}
	
	@Autowired
	SurveyService surveyService;
	
	/*
	 * 설문 만들기 View
	 */
	@RequestMapping(value="/survey/surveyInput", method=RequestMethod.GET)
	public String surveyInputGet(HttpSession session, Model model) {
		String nickName = (String) session.getAttribute("sNickName");
		model.addAttribute("nickName", nickName);
		return "admin/survey/surveyInput";
	}

	/*
	 * 설문 만들기 
	*/
	@ResponseBody
	@RequestMapping("survey/surveyInputOk")
	public String regSurv(@RequestBody SurveyVO surveyDto
			, @AuthenticationPrincipal UserDetails userInfo) throws Exception {	
		System.out.println("===regSurv Controller START");
		
		surveyDto.setUserId(userInfo.getUsername());
		System.out.println("surveyDto ==> "+surveyDto.toString());
		surveyService.insertSurv(surveyDto);
		
		System.out.println("===regSurv Controller END===");
		return "admin/survey/surveyInput";
	}
	
	/*
	 * My Survey > 설문 수정하기 View
	 */
	@RequestMapping("/modSurvForm")
	public String modSurv(@RequestParam(value="survNo") Integer survNo
						 , @AuthenticationPrincipal UserDetails userInfo
						 , Model model) {
		System.out.println("===modSurv Controller START===");
		String memNick = surveyService.getUserInfo(userInfo.getUsername());
		
		System.out.println("수정할 survNo : "+survNo+" memNick :"+memNick);
		
		SurveyVO surveyDto = surveyService.getSurvey(survNo);
		System.out.println("뿌려줄 surveyDto ==> "+surveyDto.toString());
		
		surveyDto.setNickName(memNick);
		
		model.addAttribute("surveyDto",surveyDto);
		
		System.out.println("===modSurv Controller END===");
		return "survey/modSurv";
	}
	
	/*
	 * 설문 삭제하기
	 */
	@RequestMapping("/delSurv")
	public String delSurv(@AuthenticationPrincipal UserDetails userInfo
						  ,@RequestParam Map<String,String> param) {
		System.out.println("delSurv Controller START");
		
		int survNo = Integer.parseInt(param.get("survNo"));
		
		String memNick = surveyService.getUserInfo(userInfo.getUsername());
		System.out.println("survNo : "+survNo+"  memNick : "+memNick);

		surveyService.delOneSurvey(survNo);
		
		return "redirect:myList";
	}
	
	/*
	 * 설문 수정하기
	 */
	@RequestMapping("/updateSurv")
	@ResponseBody
	public void updateSurv(@AuthenticationPrincipal UserDetails userInfo
						  ,@RequestBody SurveyVO surveyDto) {
		System.out.println("updateSurv controller START");
		surveyDto.setUserId(userInfo.getUsername());
		
		int survNo = surveyDto.getSurvNo();
		surveyService.delOldSurvey(survNo);
		surveyService.insertNewSurv(surveyDto);
		
		System.out.println("updateSurv controller END");
	}
	
	/*
	 * 리스트 응답 폼 보여주기 View
	 * */
	@RequestMapping("/resForm")
	public String resForm(@RequestParam(value="survNo") Integer survNo
			, @AuthenticationPrincipal UserDetails userInfo,
			HttpServletRequest request , Model model) {
		SurveyVO surveyDto = surveyService.getSurvey(survNo);
		String memNick = surveyService.getUserInfo(surveyDto.getUserId());
		
		surveyDto.setNickName(memNick);
		if(surveyDto.getSurvDesc() != null) {
			surveyDto.setSurvDesc(surveyDto.getSurvDesc().replace("\n","<br>"));
		}
		
		model.addAttribute("surveyDto",surveyDto);
		model.addAttribute("memId", userInfo.getUsername());
		model.addAttribute("currentPage",request.getParameter("currentPage"));
		model.addAttribute("cntPerPage",request.getParameter("cntPerPage"));
		model.addAttribute("pageSize",request.getParameter("pageSize"));
		model.addAttribute("srchTyp",request.getParameter("srchTyp"));
		model.addAttribute("keyword",request.getParameter("keyword"));
		
		return "survey/resSurv";
	}
	
	@RequestMapping("/resSurv")
	@ResponseBody
	public String resSurv(@RequestBody SurveyVO qustDto) {	
		List<SurveyVO> answerList = qustDto.getAnswerList();
		
		System.out.println(answerList);
		
		surveyService.insertAnswer(answerList);
		
		return "redirect:/survList";
	}
	
	// 제품 카테고리 관리 페이지 이동
	@RequestMapping(value="/shop/productCategory", method=RequestMethod.GET)
	public String productCategoryGet(Model model) {
		List<ShopVO> topVOS = shopService.getCategoryTop();
		List<ShopVO> midVOS = shopService.getCategoryMid();
		
		model.addAttribute("topVOS", topVOS);
		model.addAttribute("midVOS", midVOS);
		return "admin/shop/productCategory";
	}
	
	// 대분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/shop/categoryTopInput", method = RequestMethod.POST)
	public String categoryTopInputPost(String productTopName) {
		ShopVO topVO = shopService.getCategoryTopHas(productTopName);
		
		if(topVO != null) return "0";
		
		int res = shopService.setCategoryTopInput(productTopName);
		return res + "";
	}
	
	// 대분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/shop/categoryTopDelete", method = RequestMethod.POST)
	public String categoryTopDeletePost(int productTopIdx) {
		// 대분류에 속한 중분류 확인
		List<ShopVO> midVOS = shopService.getMidInTopHas(productTopIdx);
		
		if(midVOS != null) return "0";
		
		int res = shopService.setCategoryTopDelete(productTopIdx);
		return res + "";
	}
	
	// 중분류 등록하기
	@ResponseBody
	@RequestMapping(value = "/shop/categoryMidInput", method = RequestMethod.POST)
	public String categoryMidInputPost(int productTopIdx, String productMidName) {
		
		ShopVO midVO = shopService.getCategoryMidHas(productMidName);
		
		if(midVO != null) return "0";
		
		int res = shopService.setCategoryMidInput(productTopIdx, productMidName);
		return res + "";
	}
	
	// 중분류 삭제하기
	@ResponseBody
	@RequestMapping(value = "/shop/categoryMidDelete", method = RequestMethod.POST)
	public String categoryMidDeletePost(int productMidIdx) {
		// 중분류에 속한 제품 확인
		ShopVO productVO = shopService.getProductInMidHas(productMidIdx);
		
		if(productVO != null) return "0";
		
		int res = shopService.setCategoryMidDelete(productMidIdx);
		return res + "";
	}
	
	// 대분류 선택하면 중분류항목 가져오기
	@ResponseBody
	@RequestMapping(value = "/shop/productMidName", method = RequestMethod.POST)
	public List<ShopVO> productMidNamePost(int productTopIdx) {
		return shopService.getMidInTopHas(productTopIdx);
	}
	
	// 제품 입력 페이지 이동
	@RequestMapping(value="/shop/productInput", method=RequestMethod.GET)
	public String productInputGet(Model model) {
		List<ShopVO> vos = shopService.getCategoryTop();
		
		model.addAttribute("vos",vos);
		return "admin/shop/productInput";
	}
	
	// 상품 등록 처리하기
	@RequestMapping(value = "/shop/productInput", method=RequestMethod.POST)
	public String productInputPost(MultipartFile file, ShopVO vo) {
		// 이미지파일 업로드 시에 ckeditor폴더에서 'dbShop/product'폴더로 복사처리 처리된 내용을 DB에 저장하기
		int res = shopService.imgCheckProductInput(file, vo);
		//System.out.println("res : " + res);
		if(res != 0) return "redirect:/msg/productInputOk";
		return "redirect:/msg/productInputNo";
	}

	// 등록된 모든 상품 리스트 보기(관리자화면에서...)
	@RequestMapping(value = "/shop/productList", method = RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="productPrice", defaultValue = "0", required = false) String productPrice){
		model.addAttribute("part", part);

		List<ShopVO> productVOS = shopService.getProductList(part, productPrice);	// 전체 상품리스트 가져오기
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("productPrice", productPrice);
		
		return "admin/shop/productList";
	}
	
	// 관리자화면에서 진열된 상품을 클릭하였을경우에 해당 상품의 상세내역 보여주기
	@RequestMapping(value = "/shop/productDetails", method = RequestMethod.GET)
	public String dbShopContentGet(Model model, int productIdx) {
		ShopVO productVO = shopService.getProduct(productIdx);			// 상품 1건의 정보를 불러온다.
		List<ShopVO> optionVOS = shopService.getAllOption(productIdx);	// 해당 상품의 모든 옵션 정보를 가져온다.
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		 
		return "admin/shop/productDetails";
	}
	
	// 옵션 등록창 보여주기(관리자 왼쪽메뉴에서 선택시,또는 상품리스트 상세보기에서 옵션등록클릭시 처리)
	@RequestMapping(value = "/shop/productOption", method = RequestMethod.GET)
	public String dbOptionGet(Model model,
			@RequestParam(name="productName", defaultValue = "", required=false) String productName) {
		if(productName.equals("")) {
			List<ShopVO> topVOS = shopService.getCategoryTop();
			model.addAttribute("topVOS", topVOS);
		}
		else {
			//System.out.println("productName : " + productName);
			ShopVO imsiVO = shopService.getProductNameOne(productName);
			//System.out.println("imsiVO : " + imsiVO);
			ShopVO productVO = shopService.getProductNameOneVO(imsiVO);
			//System.out.println("productVO : " + productVO);
			model.addAttribute("productVO", productVO);
		}
		return "admin/shop/productOption";
	}

	// 중분류 선택시에 해당하는 상품명 가져오기
	@ResponseBody
	@RequestMapping(value = "/shop/productName", method = RequestMethod.POST)
	public List<ShopVO> ProductNameGet(int productTopIdx, int productMidIdx) {
		return shopService.getProductName(productTopIdx, productMidIdx);
	}

	// 옵셥보기에서 상품선택 콤보상자에서 상품을 선택시 해당 상품의 정보를 보여준다.
	@ResponseBody
	@RequestMapping(value = "/shop/getProductInfo", method = RequestMethod.POST)
	public ShopVO getProductInfoGet(int productIdx) {
		return shopService.getProductInfo(productIdx);
	}
	
	// 옵셥보기에서 '옵션보기'버튼 클릭시 해당 상품의 옵션리스트를 보여준다.
	@ResponseBody
	@RequestMapping(value = "/shop/getOptionList", method = RequestMethod.POST)
	public List<ShopVO> getOptionListPost(int productIdx) {
		return shopService.getOptionList(productIdx);
	}
	
	// 옵션그룹 등록처리
    @RequestMapping(value = "/shop/optionGroupInput", method = RequestMethod.POST)
    public String optionGroupInputPost(Model model, 
    		@RequestParam("productIdx") int productIdx, 
    		@RequestParam("optionGroupName") String[] groupNames) {
        boolean success = shopService.productOptionGroup(productIdx, groupNames);
        if (success) {
            return "redirect:/msg/optionGroupInputOk";
        } 
        else {
            return "redirect:/msg/optionGroupSame";
        }
    }
    
    // 옵션 그룹 조회
    @ResponseBody
	@RequestMapping(value = "/shop/getOptionGroup", method = RequestMethod.GET)
    public List<ShopVO> optionGroupGet(@RequestParam("productIdx") int productIdx) {
        return shopService.getOptionGroup(productIdx);
    }
    
	// 옵션에 기록한 내용들을 등록처리하기
    @RequestMapping(value = "/shop/optionInput", method = RequestMethod.POST)
    public String optionInputPost(Model model,
                                  @RequestParam("optionGroupIdx") String[] optionGroupIdx,
                                  @RequestParam("optionName") String[] optionName,
                                  @RequestParam(value = "addPrice", required = false) String[] addPrice) {
        int res = 0;

        // 기본값 설정: 빈 값이나 null인 경우 0으로 설정
        for (int i = 0; i < addPrice.length; i++) {
            if (addPrice[i] == null || addPrice[i].trim().isEmpty()) {
                addPrice[i] = "0"; // 기본값 설정
            }
        }

        for (int i = 0; i < optionName.length; i++) {
            int groupIdx = Integer.parseInt(optionGroupIdx[i]);
            int price = Integer.parseInt(addPrice[i]);
            //System.out.println("grouopIdx : " + groupIdx);
            int optionCnt = shopService.getOptionSame(groupIdx, optionName[i]);
            if (optionCnt != 0) continue;

            res = shopService.setOptionInput(groupIdx, optionName[i], price);
        }
        if (res != 0) return "redirect:/msg/optionInputOk";
        else return "redirect:/msg/optionInputNo";
    }
    
    // 옵션그룹 삭제하기
	@ResponseBody
	@RequestMapping(value="/shop/optionGroupDelete", method = RequestMethod.POST)
	public String optionGroupDeletePost(int optionGroupIdx) {
		int res = 0;
		int optionCnt = shopService.getOptionHas(optionGroupIdx);
        if (optionCnt == 0) res = shopService.setoptionGroupDelete(optionGroupIdx);
        else res = 0;
        return res + "";
	}
	
	// 옵션 삭제하기
	@ResponseBody
	@RequestMapping(value="/shop/optionDelete", method = RequestMethod.POST)
	public String optionDeletePost(int optionIdx) {
        int res = shopService.setOptionDelete(optionIdx);
		return res + "";
	}

}
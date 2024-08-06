package com.spring.javaclassS14.controller;

import java.io.File;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.AdminService;
import com.spring.javaclassS14.service.CsworkService;
import com.spring.javaclassS14.service.OrderService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.service.SurveyService;
import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.BranchVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.OrderVO;
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
	UserService userService;
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	SurveyService surveyService;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	CsworkService csworkService;
	
	// 관리자 페이지로 이동
	@RequestMapping(value="/adminMain", method=RequestMethod.GET)
	public String adminMainGet(Model model) {
		List<UserVO> wayVOS = adminService.getUserRegisterWay();
		int deleteExUser = adminService.getdeleteExUser();
		
		model.addAttribute("deleteExUser", deleteExUser);
		model.addAttribute("wayVOS", wayVOS);
		return "admin/adminMain";
	}
	
	// 회원리스트
	@RequestMapping(value = "/user/userList", method = RequestMethod.GET)
	public String userListGet(@RequestParam(name = "keyword", defaultValue = "", required = false) String keyword,
				            @RequestParam(name = "sortOption", defaultValue = "createDate", required = false) String sortOption,
				            @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
				            @RequestParam(name = "pageSize", defaultValue = "5", required = false) int pageSize,
	                        Model model) {
	    PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "user", sortOption, keyword);
	    List<UserVO> vos = adminService.getUserList(pageVO.getStartIndexNo(), pageSize, keyword, sortOption);

	    model.addAttribute("vos", vos);
	    model.addAttribute("pageVO", pageVO);
	    model.addAttribute("sortOption", sortOption);
	    model.addAttribute("keyword", keyword);

	    return "admin/user/userList";
	}
	
	// 탈퇴 회원리스트
	@RequestMapping(value="/user/deleteUserList", method=RequestMethod.GET)
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
	/*
	@RequestMapping(value="/user/userDeleteFlag", method=RequestMethod.POST)
	public String userDeletePost(@RequestParam String delFlag, @RequestParam String userId) {
		
		int res = adminService.getDeleteUser(delFlag, userId);
		
		if(res != 0) return "redirect:/msg/userCheckOk?delFlag="+delFlag;
		else return "redirect:/msg/userCheckNo?delFlag="+delFlag;
	}
	*/
	
	@ResponseBody
    @GetMapping("/user/userInfo")
    public UserVO userInfoGet(@RequestParam String userId) {
    	UserVO user = userService.getUserIdCheck(userId);
    	System.out.println("UserVO1: " + user);
        return user;
    }

//    @PostMapping("/user/userUpdate")
//    public String updateUser(@ModelAttribute UserVO userVO, @RequestParam("fName") MultipartFile file) {
//        int res = userService.setUserUpdate(userVO, file);
//        return res != 0 ? "redirect:/msg/userUpdateOK" : "redirect:/msg/userUpdateNO";
//    }

    @PostMapping("/user/userDelete")
    public String deleteUser(@RequestParam String userId) {
        int res = userService.setUserDelete(userId, "");
        return res != 0 ? "redirect:/msg/userDeleteOK" : "redirect:/msg/userDeleteNO";
    }
    
    @PostMapping("/user/allAction")
    @ResponseBody
    public Map<String, String> allAction(@RequestParam("action") String action, @RequestParam("users") List<String> users) {
        Map<String, String> response = new HashMap<>();
        try {
            adminService.allAction(action, users);
            response.put("message", "작업이 성공적으로 완료되었습니다.");
        } catch (Exception e) {
            response.put("message", "작업 중 오류가 발생했습니다.");
        }
        return response;
    }
    /*
    @RequestMapping(value="/user/userStop", method=RequestMethod.POST)
    public String userStopPost() {
    	int res = adminService.setUserStop();
    	
    	return res != 0 ? "redirect:/msg/userStopOk" : "redirect:/msg/userStopNo";
    }
    */
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
			@RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
			@RequestParam(name="productPrice", defaultValue = "0", required = false) String productPrice,
            @RequestParam(name="minPrice", defaultValue = "0", required = false) int minPrice,
            @RequestParam(name="maxPrice", defaultValue = "10000000", required = false) int maxPrice,
            @RequestParam(name="starRating", defaultValue = "0", required = false) int starRating,
            @RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
            @RequestParam(name = "pageSize", defaultValue = "9", required = false) int pageSize) {
		model.addAttribute("part", part);
        model.addAttribute("sort", sort);

        // 페이지네이션 처리
        PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", sort, ""); // section을 "product"로 설정
        model.addAttribute("pageVO", pageVO);
        
        List<ShopVO> productVOS = shopService.getProductList(part, sort, productPrice, minPrice, maxPrice, starRating, pageVO.getStartIndexNo(), pageSize);
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
	
	
    // 설문 만들기 View (ADMIN과 MANAGER만 접근 가능)
    @RequestMapping(value="/survey/surveyInput", method = RequestMethod.GET)
    public String surveyInputGet(HttpSession session) {
        String userId = (String) session.getAttribute("sUid");
        if (userId.equals("admin")) {
            return "admin/survey/surveyInput";
        } 
        else {
            return "redirect:/msg/userAdminNo";
        }
    }

    // 설문 만들기 (ADMIN과 MANAGER만 접근 가능)
    @ResponseBody
    @RequestMapping(value="/survey/surveyInput", method=RequestMethod.POST)
    public String surveyInputPost(@RequestBody SurveyVO surveyVO, HttpSession session) {
        String userId = (String) session.getAttribute("sUid");
        System.out.println("survey" + surveyVO);
        System.out.println("surveyTitlesss" + surveyVO.getSurveyTitle());
        if (userId.equals("admin")) {
            //System.out.println("===regSurv Controller START");

            surveyVO.setUserId(userId);
            
            //System.out.println("surveyDto ==> " + surveyVO.toString());
            
            int res = surveyService.setSurveyInput(surveyVO);

            //System.out.println("===regSurv Controller END===");
            return res + "";
        } 
        else {
            return "redirect:/msg/userAdminNo";
        }
    }

	// My Survey 접속
    @RequestMapping(value = "/survey/surveyList", method=RequestMethod.GET)
    public ModelAndView surveyListGet(
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "cntPerPage", required = false, defaultValue = "10") int cntPerPage,
            @RequestParam(value = "pageSize", required = false, defaultValue = "10") int pageSize,
            HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
        ModelAndView mv = new ModelAndView();
        
        // Id 세팅
        String userId = (String) session.getAttribute("sUid");
        
        request.setCharacterEncoding("utf-8");

        mv.addObject("survList", surveyService.getSurveyList(userId));

        //mv.addObject("pagination", searchVo);
        
        mv.setViewName("admin/survey/surveyList");
        
        return mv;
    }
    

    // 설문 삭제하기 (ADMIN만 접근 가능)
    @RequestMapping(value="/survey/deleteSurvey", method=RequestMethod.POST)
    public String delSurv(@RequestParam("survNo") int survNo, HttpSession session) {
        String userId = (String) session.getAttribute("sUid");
        if (userId.equals("admin")) {
            //System.out.println("delSurv Controller START");

            surveyService.delOneSurvey(survNo);

            return "redirect:/admin/survey/surveyList";
        } else {
            return "redirect:/msg/adminNo";
        }
    }
/*
    // 설문 수정하기 (ADMIN과 MANAGER만 접근 가능)
    @RequestMapping(value="/survey/updateSurv", method=RequestMethod.POST)
    @ResponseBody
    public void updateSurv(@RequestBody SurveyVO surveyDto, HttpSession session) {
        String userId = (String) session.getAttribute("sUid");
        if (userId.equals("admin")) {
            System.out.println("updateSurv Controller START");

            surveyService.delOldSurvey(surveyDto.getSurvNo());
            surveyService.insertNewSurv(surveyDto);

            System.out.println("updateSurv Controller END");
        }
    }

    // My Survey > 설문 수정하기 View (ADMIN과 MANAGER만 접근 가능)
    @RequestMapping(value="/survey/modSurvForm", method=RequestMethod.GET)
    public String modSurv(@RequestParam(value="survNo") Integer survNo, HttpSession session, Model model) {
        String userId = (String) session.getAttribute("sUid");
        if (userId.equals("admin")) {
            System.out.println("===modSurv Controller START===");

            SurveyVO surveyDto = surveyService.getSurvey(survNo);
            model.addAttribute("surveyDto", surveyDto);

            System.out.println("===modSurv Controller END===");
            return "admin/survey/modSurv";
        } else {
            return "redirect:/accessDenied";
        }
    }
    */
    
	@RequestMapping(value = "/info/noticeInput", method=RequestMethod.GET)
	public String noticeInputGet() {
		return "admin/info/noticeInput";
	}

	// 공지 등록 처리하기
	@RequestMapping(value = "/info/noticeInput", method=RequestMethod.POST)
	public String noticeInputPost(MultipartFile file, CsworkVO csworkVO) {
		// 이미지파일 업로드 시에 ckeditor폴더에서 'dbShop/product'폴더로 복사처리 처리된 내용을 DB에 저장하기
		int res = shopService.imgCheckNoticeInput(file, csworkVO);
		//System.out.println("res : " + res);
		if(res != 0) return "redirect:/msg/noticeInputOk";
		return "redirect:/msg/noticeInputNo";
	}
	
	@RequestMapping(value = "/info/qnaList", method = RequestMethod.GET)
	public String qnaListGet(Model model) {
		List<CsworkVO> qnaVOS = csworkService.getQnaList();
		
		model.addAttribute("qnaVOS",qnaVOS);
		return "admin/info/qnaList";
	}
	
	@RequestMapping(value = "/info/faqInput", method = RequestMethod.GET)
	public String faqInputGet() {
		return "admin/info/faqInput";
	}
	
	@RequestMapping(value = "/info/faqInput", method = RequestMethod.POST)
	public String faqInputPost(CsworkVO csworkVO) {
		int res = csworkService.setFaqInput(csworkVO);
		
		return res != 0 ? "redirect:/msg/faqInputOk" : "redirect:/msg/faqInputNo";
	}
	
	@RequestMapping(value = "/order/orderList", method = RequestMethod.GET)
	public String orderListGet(Model model) {
		List<OrderVO> orderVOS = orderService.getOrderList();
		
		model.addAttribute("orderVOS", orderVOS);
		return "admin/order/orderList";
	}
	
	@RequestMapping(value = "/info/branchInput", method = RequestMethod.GET)
	public String branchInputGet() {
		
		return "admin/info/branchInput";
	}
	
	@RequestMapping(value = "/info/branchInput", method = RequestMethod.POST)
	public String branchInputGet(HttpServletRequest request, BranchVO branchVO, Model model) {
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/qrCode/");
		
        int res = csworkService.setBranchInput(realPath, branchVO);

		return res != 0 ? "redirect:/msg/branchInputOk" : "redirect:/msg/branchInputNo";
	}
	
	@RequestMapping(value = "/info/branchPurchase", method = RequestMethod.GET)
	public String branchPurchaseGet() {
		return "admin/info/branchPurchase";
	}
	
	// ckeditor폴더의 파일 리스트 보여주기
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/file/fileList", method = RequestMethod.GET)
	public String fileListGet(HttpServletRequest request, Model model) {
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		
		String[] files = new File(realPath).list();
		
		model.addAttribute("files", files);
		
		return "admin/file/fileList";
	}
	
	// 선택된 파일 삭제처리하기
	@SuppressWarnings("deprecation")
	@ResponseBody
	@RequestMapping(value = "/fileSelectDelete", method = RequestMethod.POST)
	public String fileSelectDeleteGet(HttpServletRequest request, String delItems) {
		// System.out.println("delItems : " + delItems);
		String realPath = request.getRealPath("/resources/data/ckeditor/");
		delItems = delItems.substring(0, delItems.length()-1);
		
		String[] fileNames = delItems.split("/");
		
		for(String fileName : fileNames) {
			String realPathFile = realPath + fileName;
			new File(realPathFile).delete();
		}
		
		return "1";
	}
	
    @PostMapping("/sendQnaResponse")
    @ResponseBody
    public Map<String, Object> sendQnaResponse(@RequestParam int qnaIdx, @RequestParam String qnaAnswerContent) {
        Map<String, Object> response = new HashMap<>();
        try {
            csworkService.sendQnaResponse(qnaIdx, qnaAnswerContent);
            response.put("success", true);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", e.getMessage());
        }
        return response;
    }

}
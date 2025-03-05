package com.spring.javaclassS14.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.javaclassS14.common.AllProvide;
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
import com.spring.javaclassS14.vo.SurveyOptionVO;
import com.spring.javaclassS14.vo.SurveyQuestionVO;
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
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;
	
	@Autowired
	AllProvide allProvide;
	
	// 관리자 페이지로 이동
	@RequestMapping(value="/adminMain", method=RequestMethod.GET)
	public String adminMainGet(Model model) {
		List<UserVO> wayVOS = adminService.getUserRegisterWay();
		int deleteExUser = adminService.getDeleteExUser();
		int recentUser = adminService.getRecentUser();
		int deleteResUser = adminService.getDeleteResUser();
		
		double percentage = 0;
	    String sign = "+";
	    if (recentUser != 0) {
	        percentage = ((double) deleteExUser / recentUser) * 100;
	        if (recentUser < deleteExUser) {
	            sign = "-";
	        }
	    }
	    
		model.addAttribute("percentage", String.format("%.2f", percentage) + "%");
		model.addAttribute("sign", sign);
		
		model.addAttribute("deleteExUser", deleteExUser);
		model.addAttribute("recentUser", recentUser);
		model.addAttribute("deleteResUser", deleteResUser);
		
        int orderCount = adminService.getOrderCnt();
        int shipCount = adminService.getShipCnt();
		
        model.addAttribute("orderCount", orderCount);
        model.addAttribute("shipCount", shipCount);
        
        int productQnaCount = adminService.getProductQnaCnt();
        
        model.addAttribute("productQnaCount", productQnaCount);
        
        int qnaGuestCount = adminService.getQnaGuestCnt();
        int qnaUserCount = adminService.getQnaUserCnt();
        int qnaCount = adminService.getQnaCnt();
        
        model.addAttribute("qnaGuestCount", qnaGuestCount);
        model.addAttribute("qnaUserCount", qnaUserCount);
        model.addAttribute("qnaCount", qnaCount);
        
        List<Map<String, Object>> weeklySales = adminService.getWeeklySales();
        List<Map<String, Object>> dailySales = adminService.getDailySales();

        model.addAttribute("weeklySales", weeklySales);
        model.addAttribute("dailySales", dailySales);
        
        List<UserVO> mailUserVOS = adminService.getMailUser();
        model.addAttribute("mailUserVOS", mailUserVOS);
        
		model.addAttribute("wayVOS", wayVOS);
		
		List<Map<String, Object>> monthlySales = adminService.getMonthlySale();
		//System.out.println("monthlySales : " + monthlySales);
		model.addAttribute("monthlySales", monthlySales);
		
		return "admin/adminMain";
	}
	
	@RequestMapping(value = "/sendCoupon", method = RequestMethod.POST)
	@ResponseBody
	public String sendCoupon(@RequestParam("userId") String userId) {
	    boolean success = adminService.sendCouponToUser(userId);
	    return success ? "Success" : "Failure";
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
	
	@ResponseBody
    @GetMapping("/user/userInfo")
    public UserVO userInfoGet(String userId) {
    	UserVO user = userService.getUserIdCheck(userId);
        return user;
    }

    @PostMapping("/user/userUpdate")
    public String updateUser(@RequestParam(value="pwdNew", required=false) String pwdNew, UserVO userVO, MultipartFile fName) {
    	
        if (pwdNew != null && !pwdNew.isEmpty()) {
            String hashedPassword = passwordEncoder.encode(pwdNew);
            userVO.setUserPwd(hashedPassword);
        }
    	
		if(fName.getOriginalFilename() != null && !fName.getOriginalFilename().equals("")) {
			userVO.setUserImage(userService.fileUpload(fName, userVO.getUserId(), userVO.getUserImage()));
		}

		int res = userService.setUpdateUser(userVO);
        
        return res != 0 ? "redirect:/msg/adminUserUpdateOK" : "redirect:/msg/adminUserUpdateNO";
    }

    @PostMapping("/user/userDelete")
    public ResponseEntity<String> userDelete(@RequestParam("action") String action, @RequestParam("userId") String userId) {
        if ("Ok".equals(action)) {
            // 탈퇴 승인
            userService.updateDeletedUser(userId);
            return new ResponseEntity<>("탈퇴가 승인되었습니다.", HttpStatus.OK);
        } 
        else if ("No".equals(action)) {
            // 탈퇴 취소
            userService.cancelUserDelete(userId);
            return new ResponseEntity<>("탈퇴가 취소되었습니다.", HttpStatus.OK);
        } else {
            return new ResponseEntity<>("잘못된 요청입니다.", HttpStatus.BAD_REQUEST);
        }
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
		// 이미지파일 업로드 시에 ckeditor폴더에서 'shop/product'폴더로 복사처리 처리된 내용을 DB에 저장하기
		int res = shopService.imgCheckProductInput(file, vo);
		//System.out.println("res : " + res);
		if(res != 0) return "redirect:/msg/productInputOk";
		return "redirect:/msg/productInputNo";
	}

	// 등록된 모든 상품 리스트 보기(관리자화면에서...)
	@RequestMapping(value = "/shop/productList", method = RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name="keyword", required = false, defaultValue = "") String keyword,
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
        
        List<ShopVO> productVOS = shopService.getProductList(part, sort, keyword, productPrice, minPrice, maxPrice, starRating, pageVO.getStartIndexNo(), pageSize);
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
	
	
    // 1. 설문 생성 페이지 (Admin만 접근 가능)
    @GetMapping("/survey/surveyInput")
    public String surveyInputGet(HttpSession session) {
        String userId = (String) session.getAttribute("sUid");
        if ("admin".equals(userId)) {
            return "admin/survey/surveyInput";
        }
        return "redirect:/msg/userAdminNo";
    }

    // 2. 설문 저장 (Admin만 가능)
    @ResponseBody
    @PostMapping("/survey/surveyInput")
    public String surveyInputPost(
            @RequestParam("fName") MultipartFile fName,
            @RequestParam("surveyVOJson") String surveyVOJson,
            HttpSession session, HttpServletRequest request) {

        Integer userIdx = (Integer) session.getAttribute("sUidx");

        if (userIdx != null && userIdx.equals(1)) {
            ObjectMapper objectMapper = new ObjectMapper();
            SurveyVO surveyVO = null;
            try {
                // JSON 데이터를 Map으로 변환
                Map<String, Object> jsonMap = objectMapper.readValue(surveyVOJson, Map.class);
                surveyVO = new SurveyVO();
                surveyVO.setSurveyTitle((String) jsonMap.get("surveyTitle"));
                surveyVO.setSurveyDesc((String) jsonMap.get("surveyDesc"));
                surveyVO.setUseFlag((String) jsonMap.get("useFlag"));
                surveyVO.setUserIdx(userIdx);

                // 질문 리스트 설정
                List<Map<String, Object>> questListMap = (List<Map<String, Object>>) jsonMap.get("questList");
                List<SurveyQuestionVO> questList = new ArrayList<>();
                for (Map<String, Object> questMap : questListMap) {
                    SurveyQuestionVO questionVO = new SurveyQuestionVO();
                    questionVO.setQuestIdx((Integer) questMap.get("questIdx"));
                    questionVO.setQuestType((String) questMap.get("questType"));
                    questionVO.setQuestContent((String) questMap.get("questContent"));

                    // 옵션 리스트 설정
                    List<Map<String, Object>> optionsMap = (List<Map<String, Object>>) questMap.get("options");
                    List<SurveyOptionVO> options = new ArrayList<>();
                    for (Map<String, Object> optionMap : optionsMap) {
                        SurveyOptionVO optionVO = new SurveyOptionVO();
                        optionVO.setOptionIdx((Integer) optionMap.get("optionIdx"));
                        optionVO.setOptContent((String) optionMap.get("optContent"));
                        options.add(optionVO);
                    }
                    questionVO.setOptions(options);
                    questList.add(questionVO);
                }
                surveyVO.setQuestList(questList);
            } catch (IOException e) {
                e.printStackTrace();
                return "error";
            }

            int res = surveyService.setSurveyInput(fName, surveyVO, request);
            return String.valueOf(res);
        } else {
            return "redirect:/msg/adminNo";
        }
    }

    // 3. 관리자용 설문 목록 조회 (My Survey)
    @GetMapping("/survey/surveyList")
    public ModelAndView surveyListGet(
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "cntPerPage", required = false, defaultValue = "9") int cntPerPage,
            HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {

        ModelAndView mv = new ModelAndView();
        Integer userIdx = (Integer) session.getAttribute("sUidx");

        request.setCharacterEncoding("utf-8");
        mv.addObject("survList", surveyService.getSurveyList(userIdx));
        mv.setViewName("admin/survey/surveyList");

        return mv;
    }

    // 4. 설문 삭제 (Admin만 가능)
    @PostMapping("/survey/deleteSurvey")
    public String delSurv(@RequestParam("surveyIdx") int surveyIdx, HttpSession session) {
        String userId = (String) session.getAttribute("sUid");
        if ("admin".equals(userId)) {
            surveyService.delOneSurvey(surveyIdx);
            return "redirect:/admin/survey/surveyList";
        }
        return "redirect:/msg/adminNo";
    }

    // 5. 설문 수정 (Admin만 가능)
    @PostMapping("/survey/updateSurvey")
    @ResponseBody
    public void updateSurv(@RequestBody SurveyVO surveyVO, HttpSession session) {
        String userId = (String) session.getAttribute("sUid");
        if ("admin".equals(userId)) {
            surveyService.delOldSurvey(surveyVO.getSurveyIdx());
            surveyService.insertNewSurv(surveyVO);
        }
    }

    // 6. 설문 수정 페이지 (Admin만 접근 가능)
    @GetMapping("/survey/modSurvForm")
    public String modSurv(@RequestParam(value = "surveyIdx") Integer surveyIdx, HttpSession session, Model model) {
        String userId = (String) session.getAttribute("sUid");
        if ("admin".equals(userId)) {
            SurveyVO surveyVO = surveyService.getOneSurvey(surveyIdx);
            model.addAttribute("surveyVO", surveyVO);
            return "admin/survey/modSurv";
        }
        return "redirect:/accessDenied";
    }
    
	@RequestMapping(value = "/info/noticeInput", method=RequestMethod.GET)
	public String noticeInputGet() {
		return "admin/info/noticeInput";
	}
	
	// 설문 결과 조회 페이지 (관리자 전용)
	@GetMapping("/survey/surveyResult")
	public String getSurveyResult(@RequestParam("surveyIdx") int surveyIdx, Model model) {
	    SurveyVO surveyVO = surveyService.getSurvRslt(surveyIdx);
	    
	    if (surveyVO == null) {
	        model.addAttribute("errorMessage", "해당 설문을 찾을 수 없습니다.");
	        return "admin/survey/surveyList"; // 목록 페이지로 리디렉트
	    }
	    
	    model.addAttribute("survey", surveyVO);
	    return "admin/survey/surveyResult"; // 결과 페이지로 이동
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
	
    // qnaIdx를 받아 해당 문의 내용을 가져오는 메소드
    @GetMapping("/info/getQnaDetails")
    public Map<String, Object> getQnaDetails(@RequestParam("qnaIdx") int qnaIdx) {
    	System.out.println("qnaIdx :: " + qnaIdx);
        Map<String, Object> response = new HashMap<>();
        try {
        	CsworkVO qnaData = csworkService.getQnaById(qnaIdx); // qnaIdx로 데이터 조회
            response.put("success", true);
            response.put("qnaData", qnaData);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "데이터를 가져오는 중 오류가 발생했습니다.");
        }
        return response;
    }

    // 사용자가 모달에서 작성한 답변을 데이터베이스에 저장하는 메소드
    @PostMapping("/info/sendQnaResponse")
    public Map<String, Object> sendQnaResponse(@RequestParam("qnaIdx") int qnaIdx,
                                               @RequestParam("qnaAnswerContent") String qnaAnswerContent) {
        Map<String, Object> response = new HashMap<>();
        try {
            // 답변 업데이트 로직 실행
            boolean updateSuccess = csworkService.updateQnaAnswer(qnaIdx, qnaAnswerContent);
            response.put("success", updateSuccess);
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "응답 전송 중 오류가 발생했습니다.");
        }
        return response;
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
	
	@PostMapping("/order/updateStatus")
	public ResponseEntity<String> updateOrderStatus(
			@RequestParam(value = "orderIdx", required = false) Integer orderIdx, 
			@RequestParam(value = "orderNumber", required = false) String orderNumber) {
		
		if(orderIdx == null && (orderNumber == null || orderNumber.trim().isEmpty())) {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
					.body("orderIdx 또는 orderNumber 둘 중 하나는 필수입니다.");
		}
		
		boolean isUpdated = orderService.updateOrderStatus(orderIdx, orderNumber);
		if(isUpdated) {
			return ResponseEntity.ok("주문 상태가 업데이트되었습니다.");
		}
		else {
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("업데이트 실패");
		}
	}
	
	@PostMapping("/order/cancel")
	public ResponseEntity<Map<String,String>> cancelOrder(@RequestParam("orderIdx") Integer orderIdx) {
		boolean isCanceled = orderService.cancelOrder(orderIdx);
		
		Map<String, String> response = new HashMap<>();  // 응답 객체 생성(응답을 JSON 형식으로 만들기 위해 Map 사용)
		if(isCanceled) {
			response.put("message", "주문이 성공적으로 취소되었습니다.");
			return ResponseEntity.ok(response);  // JSON 응답 반환
		} else {
			response.put("message", "주문 취소 실패");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
		}
	}
	
//	@GetMapping("/order/getOrderDetail")
//	public String getOrderDetail(@RequestParam("orderIdx") int orderIdx, Model model) {
//		OrderVO order = orderService.getOrderDetail(orderIdx);
//		model.addAttribute("order", order);
//		return "admin/orderDetail";  //jsp로 데이터를 전달
//	}
	
	@GetMapping("/order/getOrderDetail")
	public ResponseEntity<Map<String,Object>> getOrderDetail(@RequestParam("orderIdx") int orderIdx) {
		List<OrderVO> orderList = orderService.getOrderDetail(orderIdx);  // 리스트 형태로 반환
		
		if(orderList.isEmpty()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.body(Collections.singletonMap("message", "주문 정보를 찾을 수 없습니다."));
		}
		OrderVO order = orderList.get(0);
		
		Map<String, Object> response = new HashMap<>();
		response.put("order", order);
		response.put("items", orderList);  // 주문 상품 리스트 반환
		
		return ResponseEntity.ok(response);  // JSON 데이터 반환
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
	public String branchPurchaseGet(Model model) {
		List<BranchVO> bppVOS = csworkService.getPurchaseList();
		
		model.addAttribute("bppVOS",bppVOS);
		return "admin/info/branchPurchase";
	}
	
	// ckeditor폴더의 파일 리스트 보여주기
	@SuppressWarnings("deprecation")
	@RequestMapping(value = "/file/fileList", method = RequestMethod.GET)
	public String fileListGet(HttpServletRequest request, Model model) {
		String realPath = request.getRealPath("/resources/data/ckeditor/");
	    String[] files = new File(realPath).list();
		
	    if (files == null) {
	        files = new String[0]; // 폴더가 없거나 파일이 없을 때
	    }
	    
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

}
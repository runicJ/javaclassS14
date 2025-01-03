package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.OrderService;
import com.spring.javaclassS14.service.QnaService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PageVO;
import com.spring.javaclassS14.vo.QnaVO;
import com.spring.javaclassS14.vo.ReviewVO;
import com.spring.javaclassS14.vo.ShopVO;

@Controller
@RequestMapping("/shop")
public class ShopController {

    @Autowired
    ShopService shopService;
    @Autowired
    UserService userService;
    @Autowired
    PageProcess pageProcess;
    @Autowired
    OrderService orderService;
    @Autowired
    QnaService qnaService;

    @RequestMapping(value="/productList", method=RequestMethod.GET)
    public String productListGet(Model model,
            @RequestParam(name="keyword", required = false, defaultValue = "") String keyword,
            @RequestParam(name="part", defaultValue = "전체", required = false) String part,
            @RequestParam(name="sort", defaultValue = "productIdx desc", required = false) String sort,
            @RequestParam(name="productPrice", defaultValue = "0", required = false) String productPrice,
            @RequestParam(name="minPrice", defaultValue = "0", required = false) int minPrice,
            @RequestParam(name="maxPrice", defaultValue = "10000000", required = false) int maxPrice,
            @RequestParam(name="averageRating", defaultValue = "0", required = false) int averageRating,
            @RequestParam(name="pag", defaultValue = "1", required = false) int pag,
            @RequestParam(name="pageSize", defaultValue = "9", required = false) int pageSize) {
    	
//    	System.out.println("sort" + sort);
		model.addAttribute("part", part);
		model.addAttribute("sort", sort);
		model.addAttribute("averageRating", averageRating);
		model.addAttribute("minPrice", minPrice);
		model.addAttribute("maxPrice", maxPrice);
		
		// 페이지네이션 처리
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", part, ""); // section을 "product"로 설정
		model.addAttribute("pageVO", pageVO);
		
		// 페이지네이션을 적용하여 제품 리스트 가져오기
		List<ShopVO> productVOS = shopService.getProductList(part, sort, keyword, productPrice, minPrice, maxPrice, averageRating, pageVO.getStartIndexNo(), pageSize);
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("productPrice", productPrice);
		
		List<ShopVO> categoryTopVOS = shopService.getCategoryTop();
		model.addAttribute("categoryTopVOS", categoryTopVOS);
		
		List<ShopVO> productTopMidVOS = shopService.getProductTopMidList();
		model.addAttribute("productTopMidVOS", productTopMidVOS);
		
		List<String> topTags = shopService.getTopTags();
		model.addAttribute("topTags", topTags);
		
		return "shop/productList";
	}

    @RequestMapping(value="/productDetails", method=RequestMethod.GET)
    public String productDetailsGet(HttpSession session, Model model, int productIdx,
    		@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
            @RequestParam(name="pageSize", defaultValue = "10", required = false) int pageSize
    		) {
        ShopVO productVO = shopService.getProduct(productIdx);            // 상품 1건의 정보를 불러온다.
        List<ShopVO> optionGroupVOS = shopService.getOptionGroup(productIdx);
        List<ShopVO> optionVOS = shopService.getAllOption(productIdx);    // 해당 상품의 모든 옵션 정보를 가져온다.
        List<ReviewVO> reviewVOS = shopService.getAllReview(productIdx);
        
        Integer userIdx = (Integer) session.getAttribute("sUidx");
        if (userIdx != null && canRecordProductView(userIdx, productIdx)) {
            shopService.recordProductView(userIdx, productIdx);
        }
        
        Set<String> tags = new HashSet<String>();
        String[] productTags = productVO.getProductTags().split("#");
		for(String tag : productTags) {
			if(!tag.trim().isEmpty()) {
				tags.add("#" + tag.trim());
			}
		}
		List<ShopVO> relatedVOS = shopService.getRelatedProducts(new ArrayList<>(tags));

		model.addAttribute("optionGroupVOS", optionGroupVOS);
        model.addAttribute("productVO", productVO);
        model.addAttribute("optionVOS", optionVOS);
        model.addAttribute("reviewVOS", reviewVOS);
        model.addAttribute("relatedVOS", relatedVOS);

    	PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
    	List<QnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
    	model.addAttribute("vos", vos);
    	model.addAttribute("pageVO", pageVO);

        return "shop/productDetails";
    }
    
    private boolean canRecordProductView(Integer userIdx, int productIdx) {
        return shopService.canRecordProductView(userIdx, productIdx);
    }

    // 장바구니 담기 - 상품 상세정보보기창에서 '장바구니'버튼을 클릭시에 처리하는곳
    @RequestMapping(value="/productDetails", method=RequestMethod.POST)
    public String addToCartPost(CartVO vo, HttpSession session, String flag) {
    	Integer userIdx = (Integer) session.getAttribute("sUidx");
        
        if (userIdx == null) {
            return "redirect:/users/userLogin"; // 로그인하지 않은 상태라면 로그인 페이지로 리다이렉트
        }
        
        vo.setUserIdx(userIdx);
        
        // 기존 장바구니 항목을 가져온다.
        List<CartVO> existingCartItems = shopService.getProductCart(userIdx);
        
        for (CartItem newItem : vo.getItems()) {
            boolean isUpdated = false;
            for (CartVO existingCart : existingCartItems) {
                for (CartItem existingItem : existingCart.getItems()) {
                    if (existingItem.getProductIdx() == newItem.getProductIdx()) {
                        existingItem.setQuantity(existingItem.getQuantity() + newItem.getQuantity());
                        shopService.updateCart(existingItem, userIdx);
                        isUpdated = true;
                        break;
                    }
                }
                if (isUpdated) break;
            }

            if (!isUpdated) {
                CartVO newCart = new CartVO();
                newCart.setUserIdx(userIdx);
                List<CartItem> newItems = new ArrayList<>();
                newItems.add(newItem);
                newCart.setItems(newItems);
                shopService.addCart(newCart);
            }
        }
        
        if (flag.equals("order")) {
            return "redirect:/msg/cartOrderOk";
        } else {
            return "redirect:/msg/cartInputOk";
        }
    }
    
    // 장바구니 보기
    @RequestMapping(value="/productCart", method=RequestMethod.GET)
    public String viewProductCart(HttpSession session, Model model) {
    	Integer userIdx = (Integer) session.getAttribute("sUidx");
        List<CartVO> productCartVOS = shopService.getProductCart(userIdx);
        
        if(productCartVOS.isEmpty()) {
            return "redirect:/msg/cartEmpty";
        }
        
        // HashSet은 중복 불허 중복된 태그를 하나로 합치기 위해 사용(List는 중복된 태그 허용/Map은 출현 빈도 계산까지)
        Set<String> tags = new HashSet<String>();
        for (CartVO cart : productCartVOS) {
        	for(CartItem items : cart.getItems()) {
        		if(items.getProductTags() != null) {
        			String[] productTags = items.getProductTags().split("#");
        			for(String tag : productTags) {
        				if(!tag.trim().isEmpty()) {
        					tags.add("#" + tag.trim());
        				}
        			}
        		}
        	}
        }
        List<ShopVO> relatedVOS = shopService.getRelatedProducts(new ArrayList<>(tags));

        model.addAttribute("productCartVOS", productCartVOS);
        model.addAttribute("relatedVOS", relatedVOS);
        
        return "shop/productCart";
    }

    // 장바구니에서 주문 취소한 상품을 장바구니에서 삭제
    @ResponseBody
    @RequestMapping(value="/productCartDelete", method=RequestMethod.POST)
    public String deleteProductFromCart(int cartIdx) {
        int result = shopService.setProductCartDelete(cartIdx);
        return String.valueOf(result);
    }
    
    // 상세페이지 제품리뷰
    @ResponseBody
    @RequestMapping(value="/productReviewInput", method=RequestMethod.POST)
    public String productReviewInputPost(ReviewVO reviewVO) {
    	ReviewVO reviewParentVO = shopService.getProductParentReviewCheck(reviewVO.getProductIdx());
    	OrderVO orderCheckVO = orderService.getOrderCheck(reviewVO.getUserId(),reviewVO.getProductIdx());
    	
    	if(reviewParentVO == null) {
    		reviewVO.setRe_order(1);
    	}
    	else {
    		reviewVO.setRe_order(reviewParentVO.getRe_order() + 1);
    	}
    	reviewVO.setRe_step(0);
    	reviewVO.setOrderIdx(orderCheckVO.getOrderIdx());
    	
    	int res = orderCheckVO == null ? 0 : shopService.setProductReviewInput(reviewVO);
    	
    	return res + "";
    }
    
    // 대댓글 입력
    @ResponseBody
    @RequestMapping(value="/productReviewReInput", method=RequestMethod.POST)
    public String productReviewReInputPost(ReviewVO reviewVO) {
    	reviewVO.setRe_step(reviewVO.getRe_step()+1);
    	
    	shopService.setReviewOrderUpdate(reviewVO.getProductIdx(), reviewVO.getRe_order());
    	
    	reviewVO.setRe_order(reviewVO.getRe_order() + 1);
    	
    	int res = shopService.setProductReviewInput(reviewVO);
    	
    	return res + "";
    }
    
    // 장바구니에서 주문 취소한 상품을 장바구니에서 삭제
    @ResponseBody
    @RequestMapping(value="/productReviewDelete", method=RequestMethod.POST)
    public String productReviewDeletePost(int reviewIdx) {
    	int res = shopService.setProductReviewDelete(reviewIdx);
    	return res + "";
    }
}
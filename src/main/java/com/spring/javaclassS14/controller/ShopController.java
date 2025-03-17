package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
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
import com.spring.javaclassS14.service.ProductQnaService;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.OrderVO;
import com.spring.javaclassS14.vo.PageVO;
import com.spring.javaclassS14.vo.ProductQnaVO;
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
    ProductQnaService qnaService;

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
    	
    	//System.out.println("sort" + sort);
		model.addAttribute("part", part);
		model.addAttribute("sort", sort);
		model.addAttribute("averageRating", averageRating);
		model.addAttribute("minPrice", minPrice);
		model.addAttribute("maxPrice", maxPrice);
		
		// 페이지네이션 처리
		PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "product", part, keyword); // section을 "product"로 설정
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
        if (productVO.getProductTags() != null && !productVO.getProductTags().isEmpty()) {
            String[] productTags = productVO.getProductTags().split("\\s*#\\s*");  // 공백 처리까지
            for (String tag : productTags) {
                if (!tag.trim().isEmpty()) {
                    tags.add("#" + tag.trim());
                }
            }
        }
		List<ShopVO> relatedVOS = shopService.getRelatedProducts(new ArrayList<>(tags));

		model.addAttribute("optionGroupVOS", optionGroupVOS);
        model.addAttribute("productVO", productVO);
        model.addAttribute("optionVOS", optionVOS);
        model.addAttribute("reviewVOS", reviewVOS);
        model.addAttribute("relatedVOS", relatedVOS);

    	PageVO pageVO = pageProcess.totRecCnt(pag, pageSize, "qna", "", "");
    	List<ProductQnaVO> vos = qnaService.getQnaList(pageVO.getStartIndexNo(), pageSize);
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
            return "redirect:/users/userLogin"; // 로그인 필요
        }

        vo.setUserIdx(userIdx);

        // 기존 장바구니 항목 가져오기
        List<CartVO> existingCartItems = shopService.getProductCart(userIdx);

        for (CartItem newItem : vo.getItems()) {
            boolean isUpdated = false;
            int newOptionIdx = (newItem.getOptionIdx() == 0) ? 0 : newItem.getOptionIdx(); // 기본값 0 처리
            
            for (CartVO existingCart : existingCartItems) {
                for (CartItem existingItem : existingCart.getItems()) {
                    if (existingItem.getProductIdx() == newItem.getProductIdx() && 
                        existingItem.getOptionIdx() == newOptionIdx) { // 옵션이 동일할 경우만 수량 업데이트

                        int newQuantity = existingItem.getQuantity() + newItem.getQuantity();
                        existingItem.setQuantity(newQuantity);
                        
                        // `existingItem.getProductPrice()`가 null일 경우 기본값 처리
                        Integer productPriceWrapper = existingItem.getProductPrice(); // Integer 타입 사용
                        int productPrice = (productPriceWrapper != null) ? productPriceWrapper : 0; // null이면 0 할당
//                        int productPrice = Optional.ofNullable(existingItem.getProductPrice()).orElse(0);
                        existingItem.setTotalPrice(productPrice * newQuantity);

                        shopService.updateCart(existingItem, userIdx);
                        isUpdated = true;
                        break;
                    }
                }
                if (isUpdated) break;
            }

            // 옵션이 다를 경우 새로운 상품으로 추가
            if (!isUpdated) {
                CartVO newCart = new CartVO();
                newCart.setUserIdx(userIdx);
                List<CartItem> newItems = new ArrayList<>();

                Integer productPriceWrapper = newItem.getProductPrice(); // Integer 타입 사용
                int productPrice = (productPriceWrapper != null) ? productPriceWrapper : 0;
                newItem.setTotalPrice(productPrice * newItem.getQuantity());

                newItems.add(newItem);
                newCart.setItems(newItems);
                shopService.addCart(newCart);
            }
        }

        return flag.equals("order") ? "redirect:/msg/cartOrderOk" : "redirect:/msg/cartInputOk";
    }
    
    // 장바구니 보기
    @RequestMapping(value="/productCart", method=RequestMethod.GET)
    public String viewProductCart(HttpSession session, Model model) {
    	Integer userIdx = (Integer) session.getAttribute("sUidx");
        List<CartVO> productCartVOS = shopService.getProductCart(userIdx);
        
        if(productCartVOS.isEmpty()) {
            return "redirect:/msg/cartEmpty";
        }
        
        // 장바구니 전체 금액 계산 추가
        int orderTotalPrice = 0;
        for (CartVO cart : productCartVOS) {
            for (CartItem item : cart.getItems()) {
                orderTotalPrice += item.getTotalPrice(); 
            }
        }
        
        // HashSet은 중복 불허 중복된 태그를 하나로 합치기 위해 사용(List는 중복된 태그 허용/Map은 출현 빈도 계산까지) // 상품 추천 로직
        Set<String> tags = new HashSet<>();
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
        model.addAttribute("orderTotalPrice", orderTotalPrice); // 장바구니 총 금액 JSP로 전달
        
        return "shop/productCart";
    }

    @ResponseBody
    @RequestMapping(value="/productCartUpdate", method=RequestMethod.POST, produces = "application/json; charset=UTF-8")
    public Map<String, Object> updateProductQuantity(@RequestParam("cartIdx") int cartIdx,
                                                     @RequestParam("productIdx") int productIdx,
                                                     @RequestParam("quantity") int quantity,
                                                     HttpSession session) {
        Integer userIdx = (Integer) session.getAttribute("sUidx");
        Map<String, Object> response = new HashMap<>();

        if (userIdx == null) {
            response.put("status", "login");
            return response;
        }

        CartVO cart = shopService.getCartItem(cartIdx, productIdx, userIdx);
        System.out.println("🔹 cart 정보: " + cart);
        
        if (cart == null) {
            response.put("status", "error");
            return response;
        }

        System.out.println("🔹 cart items: " + cart.getItems());
        if (cart.getItems() == null || cart.getItems().isEmpty()) {
            response.put("status", "error");
            return response;
        }

        CartItem itemToUpdate = cart.getItems().stream()
            .filter(item -> item.getProductIdx() == productIdx)
            .findFirst()
            .orElse(null);

        System.out.println("🔹 itemToUpdate 정보: " + itemToUpdate);
        if (itemToUpdate == null) {
            response.put("status", "error");
            return response;
        }

        // 수량 업데이트 및 totalPrice 재계산
        itemToUpdate.setQuantity(quantity);
        itemToUpdate.updateTotalPrice();

        // DB 업데이트
        shopService.updateCartQuantity(cartIdx, productIdx, quantity, itemToUpdate.getTotalPrice(), userIdx);

        // 장바구니 총 금액 업데이트
        List<CartVO> updatedCart = shopService.getProductCart(userIdx);
        int totalPrice = updatedCart.stream()
            .flatMap(cartVO -> cartVO.getItems().stream())
            .mapToInt(CartItem::getTotalPrice)
            .sum();

        int shippingCost = (totalPrice >= 50000) ? 0 : 3000;
        int finalPrice = totalPrice + shippingCost;

        session.setAttribute("orderTotalPrice", finalPrice);

        response.put("status", "success");
        response.put("itemTotalPrice", itemToUpdate.getTotalPrice());
        response.put("cartIdx", cartIdx);
        response.put("totalPrice", totalPrice);
        response.put("shippingCost", shippingCost);
        response.put("finalPrice", finalPrice);

        return response;
    }
    
    // 장바구니에서 주문 취소한 상품을 장바구니에서 삭제
    @ResponseBody
    @RequestMapping(value="/productCartDelete", method=RequestMethod.POST)
    public String deleteProductFromCart(int cartIdx, HttpSession session) {
        int result = shopService.setProductCartDelete(cartIdx);

        // 장바구니 정보가 존재하는지 확인
        Integer userIdx = (Integer) session.getAttribute("sUidx");
        List<CartVO> updatedCart = shopService.getProductCart(userIdx);

        int orderTotalPrice = 0;
        if (updatedCart != null) { // Null 체크 추가
            for (CartVO cart : updatedCart) {
                for (CartItem item : cart.getItems()) {
                    orderTotalPrice += item.getTotalPrice();
                }
            }
        }

        session.setAttribute("orderTotalPrice", orderTotalPrice); // 세션에 총 금액 업데이트
        return String.valueOf(result);
    }
    
    // 상세페이지 제품리뷰
    @ResponseBody
    @RequestMapping(value="/productReviewInput", method=RequestMethod.POST)
    public String productReviewInputPost(ReviewVO reviewVO) {
    	ReviewVO reviewParentVO = shopService.getProductParentReviewCheck(reviewVO.getProductIdx());
    	//OrderVO orderCheckVO = orderService.getOrderCheck(reviewVO.getUserId(),reviewVO.getProductIdx());
    	
    	if(reviewParentVO == null) {
    	    reviewVO.setRe_order(1);
    	    reviewVO.setRe_step(0);
    	}
    	else {
    		reviewVO.setRe_order(reviewParentVO.getRe_order() + 1);
    	}
    	reviewVO.setRe_step(0);
    	//reviewVO.setOrderIdx(orderCheckVO.getOrderIdx());
    	
    	int res = shopService.setProductReviewInput(reviewVO);
    	
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
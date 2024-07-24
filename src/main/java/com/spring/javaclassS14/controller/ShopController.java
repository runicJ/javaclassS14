package com.spring.javaclassS14.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.vo.ShopVO;
import com.spring.javaclassS14.vo.CartVO;

@Controller
@RequestMapping("/shop")
public class ShopController {
	
	@Autowired
	ShopService shopService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value="/productList", method=RequestMethod.GET)
	public String productListGet(Model model,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part,
			@RequestParam(name="productPrice", defaultValue = "0", required = false) String productPrice){
		
		model.addAttribute("part", part);
		List<ShopVO> productVOS = shopService.getProductList(part, productPrice);	// 전체 상품리스트 가져오기
		model.addAttribute("productVOS", productVOS);
		model.addAttribute("productPrice", productPrice);
		
        List<ShopVO> categoryTopVOS = shopService.getCategoryTop();
        model.addAttribute("categoryTopVOS", categoryTopVOS);
        
		List<ShopVO> productTopMidVOS = shopService.getProductTopMidList();
		model.addAttribute("productTopMidVOS", productTopMidVOS);
		
		return "shop/productList";
	}
	
	@RequestMapping(value="/productDetails", method=RequestMethod.GET)
	public String productDetailsGet(Model model, int productIdx) {
		ShopVO productVO = shopService.getProduct(productIdx);			// 상품 1건의 정보를 불러온다.
		List<ShopVO> optionVOS = shopService.getAllOption(productIdx);	// 해당 상품의 모든 옵션 정보를 가져온다.
		
		model.addAttribute("productVO", productVO);
		model.addAttribute("optionVOS", optionVOS);
		
		return "shop/productDetails";
	}
	
	// 장바구니 담기 - 상품 상세정보보기창에서 '장바구니'버튼을 클릭시에 처리하는곳
	@RequestMapping(value="/addToCart", method=RequestMethod.POST)
	public String addToCartPost(CartVO vo, HttpSession session, String flag) {
		String userId = (String) session.getAttribute("sUid");
		// 같은 상품(옵션포함)을 주문했다면 새로운 항목으로 처리하지않고, 기존 상품의 수량만 구매수량만큼 증가처리한다.
		// 여러개의 상품을 구매했다면, optionName은 ','로 구분되어 넘어오게되고, DB에서 같은형식으로 저장처리되어 있다.(여러개의 같은품목을 구매시 배열에 담긴 문자열이 같다.(예:기본품목,리모콘)
		CartVO cartVO = shopService.getCartProductOptionSearch(vo.getProductIdx(), vo.getOptionIdx(), userId);	// 지금 구매한 항목을 기존 구매 카트에서와 비교를 위해검색
		int res = 0;
		if(cartVO != null) {	// 현재 구매상품이 기존 구매상품과 같은상품을 구매했을때만 이곳으로 들어온다. 즉, 이때 구매한 상품에 대하여 수량만 증가처리
			// 주문품목이 여러개를 구매했을경우, 수량과 같은 정보들(optonIdx,optionName,optoinPrice,optionNum)이 ','로 구분되어 DB에 저장되어 있다.(현재 구매후 넘어온 자료도 마찬가지이다.)
			String[] voOptionNums = vo.getQuantity().split(",");			// 지금(현재) 구매한 장바구니의 수량을 가져와서 ','를 기준으로 분리 
			String[] resOptionNums = cartVO.getQuantity().split(",");	// 기존에 구매했었던 장바구니의 수량을 가져와서 ','를 기준으로 분리
			int[] nums = new int[99];	// 주문한 상품에 대한 수량을 누적하기위한 배열확보
			String strNums = "";		// 주문수량 변경후 다시 기존정보와 묶어주기위해서 문자열변수 선언
			for(int i=0; i<voOptionNums.length; i++) {	// 지금 주문한 상품(옵션)의 건수만큼 반복 비교처리
				nums[i] += (Integer.parseInt(voOptionNums[i]) + Integer.parseInt(resOptionNums[i]));	// 현재 구매한 수량과 기존에 구매했던 상품의 수량을 합산해서 배열에 저장
				strNums += nums[i];
				if(i < nums.length - 1) strNums += ",";	// 구매상품이 2건 이상일때 기존상품 수량과의 구별을 위해 ','를 추가하고 있다.
			}
			if(strNums.indexOf(",") != -1) strNums = strNums.substring(0,strNums.length()-1);	// 여러개 상품을 구매했어ㄸ다고하면, 구매 했었던 상품 수량의 마지막 쉼표 제거하기
			vo.setQuantity(strNums);	// 새롭게 정비한 수량을 다시 vo에 set시켜준다.
			res = shopService.setShopCartUpdate(vo);	// 수량이 변경되었기에 기존 장바구니에서 지금 변경내역으로 update처리한다.
		}
		else {
			res = shopService.setShopCartInput(vo);	// 기존 장바구니에 없는 새로운 항목이면 insert처리하면 된다.
		}
		
		// 구매상품을 수량체크후(update또는 insert) 해당항목('장바구니보기' 또는 '주문 배송지 처리')으로 보내준다.
		if(res != 0) {
			if(flag.equals("order")) return "redirect:/message/cartOrderOk";	// 'flag'에 'order'이 넘어올경우는 '장바구니보기'로 가지않고 바로 '배송지'처리창으로 보낸다.(지금은 처리하지않음-장바구니보기로보냄)
			else return "redirect:/message/cartInputOk";	// '장바구니담기'버튼클릭시 장바구니에 구매상품의 정보를 담은후, 여기에서는 다시 쇼핑하기로 보냈다.(장바구니 보기로 이동해도 됨)
		}
		else return "redirect:/message/cartOrderNo";
	}
	
	@RequestMapping(value="/productCart", method=RequestMethod.GET)
	public String productCartGet() {
		return "shop/productCart";
	}
}

package com.spring.javaclassS14.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaclassS14.pagination.PageProcess;
import com.spring.javaclassS14.service.ShopService;
import com.spring.javaclassS14.service.UserService;
import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
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

    @RequestMapping(value="/productList", method=RequestMethod.GET)
    public String productListGet(Model model,
                                 @RequestParam(name="part", defaultValue = "전체", required = false) String part,
                                 @RequestParam(name="sort", defaultValue = "전체", required = false) String sort,
                                 @RequestParam(name="productPrice", defaultValue = "0", required = false) String productPrice){
        model.addAttribute("part", part);
        model.addAttribute("sort", sort);
        List<ShopVO> productVOS = shopService.getProductList(part, sort, productPrice);    // 전체 상품리스트 가져오기
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
        ShopVO productVO = shopService.getProduct(productIdx);            // 상품 1건의 정보를 불러온다.
        List<ShopVO> optionGroupVOS     = shopService.getOptionGroup(productIdx);
        List<ShopVO> optionVOS = shopService.getAllOption(productIdx);    // 해당 상품의 모든 옵션 정보를 가져온다.

        model.addAttribute("optionGroupVOS", optionGroupVOS);
        model.addAttribute("productVO", productVO);
        model.addAttribute("optionVOS", optionVOS);

        return "shop/productDetails";
    }

    // 장바구니 담기 - 상품 상세정보보기창에서 '장바구니'버튼을 클릭시에 처리하는곳
    @RequestMapping(value="/addToCart", method=RequestMethod.POST)
    public String addToCartPost(CartVO vo, HttpSession session, String flag) {
        String userId = (String) session.getAttribute("sUid");
        
        if (userId == null) {
            return "redirect:/users/userLogin"; // 로그인하지 않은 상태라면 로그인 페이지로 리다이렉트
        }
        
        vo.setUserId(userId);
        
        // 기존 장바구니 항목을 가져온다.
        List<CartVO> existingCartItems = shopService.getProductCart(userId);
        
        for (CartItem newItem : vo.getItems()) {
            boolean isUpdated = false;
            for (CartVO existingCart : existingCartItems) {
                for (CartItem existingItem : existingCart.getItems()) {
                    if (existingItem.getProductIdx() == newItem.getProductIdx()) {
                        existingItem.setQuantity(existingItem.getQuantity() + newItem.getQuantity());
                        shopService.updateCart(existingItem, userId);
                        isUpdated = true;
                        break;
                    }
                }
                if (isUpdated) break;
            }

            if (!isUpdated) {
                CartVO newCart = new CartVO();
                newCart.setUserId(userId);
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
        String userId = (String) session.getAttribute("sUid");
        List<CartVO> productCartVOS = shopService.getProductCart(userId);
        
        if(productCartVOS.isEmpty()) {
            return "redirect:/msg/cartEmpty";
        }
        
        model.addAttribute("productCartVOS", productCartVOS);
        return "shop/productCart";
    }

    // 장바구니에서 주문 취소한 상품을 장바구니에서 삭제
    @ResponseBody
    @RequestMapping(value="/productCartDelete", method=RequestMethod.POST)
    public String deleteProductFromCart(int cartIdx) {
        int result = shopService.setProductCartDelete(cartIdx);
        return String.valueOf(result);
    }

}
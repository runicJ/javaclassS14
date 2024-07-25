package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.vo.ShopVO;
import com.spring.javaclassS14.vo.CartVO;

public interface ShopService {

	public List<ShopVO> getCategoryTop();

	public List<ShopVO> getCategoryMid();

	public ShopVO getCategoryTopHas(String productTopName);

	public int setCategoryTopInput(String productTopName);
	
	public List<ShopVO> getMidInTopHas(int productTopIdx);

	public ShopVO getCategoryMidHas(String productMidName);

	public int setCategoryTopDelete(int productTopIdx);

	public int setCategoryMidInput(int productTopIdx, String productMidName);

	public ShopVO getProductInMidHas(int productMidIdx);

	public int setCategoryMidDelete(int productMidIdx);

	public List<ShopVO> getCategoryMidName(String categoryMidIdx);

	public int imgCheckProductInput(MultipartFile file, ShopVO vo);

	public List<ShopVO> getProductList(String part, String sort ,String productPrice);

	public ShopVO getProduct(int productIdx);

	public List<ShopVO> getAllOption(int productIdx);

	public ShopVO getProductNameOne(String productName);

	public ShopVO getProductNameOneVO(ShopVO imsiVO);

	public List<ShopVO> getProductName(int productTopIdx, int productMidIdx);

	public ShopVO getProductInfo(int productIdx);

	public List<ShopVO> getOptionList(int productIdx);

	public boolean productOptionGroup(int productIdx, String[] groupNames);

	public List<ShopVO> getOptionGroup(int productIdx);

	public int getOptionSame(int optionGroupIdx, String optionName);

	public int setOptionInput(int optionGroupIdx, String optionName, int addPrice);

	public int setoptionGroupDelete(int optionGroupIdx);

	public int setOptionDelete(int optionIdx);

	public int getOptionHas(int optionGroupIdx);

	public List<ShopVO> getNewProduct();

	public CartVO getCartProductOptionSearch(int productIdx, int optionIdx, String userId);

	public int setShopCartUpdate(CartVO vo);

	public int setShopCartInput(CartVO vo);

	public List<ShopVO> getProductTopMidList();

	public List<CartVO> getProductCart(String userId);

	public String setProductCartDelete(int productIdx);


}

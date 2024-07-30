package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.ReviewVO;
import com.spring.javaclassS14.vo.ShopVO;

public interface ShopDAO {

	public List<ShopVO> getCategoryTop();

	public List<ShopVO> getCategoryMid();

	public ShopVO getCategoryTopHas(@Param("productTopName") String productTopName);

	public int setCategoryTopInput(@Param("productTopName") String productTopName);

	public List<ShopVO> getMidInTopHas(@Param("productTopIdx") int productTopIdx);

	public ShopVO getCategoryMidHas(@Param("productMidName") String productMidName);

	public int setCategoryTopDelete(@Param("productTopIdx") int productTopIdx);

	public int setCategoryMidInput(@Param("productTopIdx") int productTopIdx, @Param("productMidName") String productMidName);

	public ShopVO getProductInMidHas(@Param("productMidIdx") int productMidIdx);

	public int setCategoryMidDelete(@Param("productMidIdx") int productMidIdx);

	public List<ShopVO> getCategoryMidName(@Param("categoryMainCode") String categoryMainCode);

	public ShopVO getProductMaxIdx();

	public int setProductInput(@Param("vo") ShopVO vo);

	public List<ShopVO> getProductList(@Param("part") String part, @Param("sort") String sort, @Param("productPrice") String productPrice);

	public ShopVO getProductNameOne(@Param("productName") String productName);

	public ShopVO getProductNameOneVO(@Param("imsiVO") ShopVO imsiVO);

	public List<ShopVO> getProductName(@Param("productTopIdx") int productTopIdx, @Param("productMidIdx") int productMidIdx);

	public ShopVO getProductInfo(@Param("productIdx") int productIdx);

	public List<ShopVO> getOptionList(@Param("productIdx") int productIdx);

	public int getOptionSame(@Param("optionGroupIdx") int optionGroupIdx, @Param("optionName") String optionName);

	public int setOptionInput(@Param("optionGroupIdx") int optionGroupIdx, @Param("optionName") String optionName, @Param("addPrice") int addPrice);

	public int getOptionGroupSame(@Param("productIdx") int productIdx, @Param("optionGroupName") String optionGroupName);

	public void setOptionGroupInput(@Param("productIdx") int productIdx, @Param("optionGroupName") String optionGroupName);

	public List<ShopVO> getOptionGroup(@Param("productIdx") int productIdx);

	public int setoptionGroupDelete(@Param("optionGroupIdx") int optionGroupIdx);

	public int setOptionDelete(@Param("optionIdx") int optionIdx);

	public int getOptionHas(@Param("optionGroupIdx") int optionGroupIdx);

	public ShopVO getProduct(@Param("productIdx") int productIdx);

	public List<ShopVO> getAllOption(@Param("productIdx") int productIdx);

	public List<ShopVO> getNewProduct();

	public int setShopCartUpdate(@Param("vo") CartVO vo);

	public int setShopCartInput(@Param("vo") CartVO vo);

	public List<ShopVO> getProductTopMidList();

	public int deleteCartItem(@Param("cartIdx") int cartIdx);

	public List<CartVO> getProductCart(@Param("userId") String userId);
	public CartItem getCartProductOptionSearch(@Param("productIdx") int productIdx, @Param("optionIdx") int optionIdx, @Param("userId") String userId);

	public int addCart(@Param("userId") String userId, @Param("cartItem") CartItem cartItem);

	public int updateCart(@Param("userId") String userId, @Param("cartItem") CartItem cartItem);

	public int setProductCartDelete(@Param("cartIdx") int cartIdx);

	public int checkOptionExists(@Param("optionIdx") int optionIdx);

	public int checkProductExists(@Param("productIdx") int productIdx);

	public int getUserCartCnt(@Param("userId") String userId);

	public List<ShopVO> getAllReview(@Param("productIdx") int productIdx);

	public Object setCartDeleteAll(@Param("orderProductIdx") int orderProductIdx);

	public ReviewVO getProductParentReviewCheck(@Param("productIdx") int productIdx);

	public int setProductReviewInput(@Param("reviewVO") ReviewVO reviewVO);

	public void setReviewOrderUpdate(@Param("productIdx") int productIdx, @Param("re_order") int re_order);

}

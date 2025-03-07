package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.spring.javaclassS14.vo.CartItem;
import com.spring.javaclassS14.vo.CartVO;
import com.spring.javaclassS14.vo.CsworkVO;
import com.spring.javaclassS14.vo.ReviewVO;
import com.spring.javaclassS14.vo.ShopVO;

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

	public int setShopCartUpdate(CartVO vo);

	public int setShopCartInput(CartVO vo);

	public List<ShopVO> getProductTopMidList();

	public List<CartVO> getProductCart(Integer userIdx);
	public CartItem getCartProductOptionSearch(int productIdx, int optionIdx, Integer userIdx);
	public int updateCart(CartItem cartItem, Integer userIdx);
	public int addCart(CartVO cartVO);

	public int setProductCartDelete(int cartIdx);

	public int getUserCartCnt(Integer userIdx);

	public void setCartDeleteAll(int orderProductIdx);

	public List<ReviewVO> getAllReview(int productIdx);

	public ReviewVO getProductParentReviewCheck(int productIdx);

	public int setProductReviewInput(ReviewVO reviewVO);

	public void setReviewOrderUpdate(int productIdx, int re_order);

	public List<ShopVO> getRelatedProducts(List<String> tags);

	public int setProductReviewDelete(int reveiwIdx);

	public int imgCheckNoticeInput(MultipartFile file, CsworkVO csworkVO);

	public List<ShopVO> getProductList(String part, String sort, String keyword, String productPrice, int minPrice, int maxPrice, int averageRating, int startIndexNo, int pageSize);

	public boolean canRecordProductView(Integer userIdx, int productIdx);

	public void recordProductView(Integer userIdx, int productIdx);

	public List<String> getTags();
	public String getTagsAsText();

	public List<String> getTopTags();

	public List<String> getTopPickTags();

	public List<ShopVO> getLikedProducts(int userIdx);

	public int removeLike(int userIdx, int productIdx);

}

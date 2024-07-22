package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

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

	public List<ShopVO> getProductList(String part, String productPrice);

	public ShopVO getProduct(int idx);

	public List<ShopVO> getAllOption(int idx);

	public ShopVO getProductNameOne(String productName);

	public ShopVO getProductNameOneVO(ShopVO imsiVO);

	public List<ShopVO> getProductName(int productTopIdx, int productMidIdx);

	public ShopVO getProductInfo(int productIdx);

	public List<ShopVO> getOptionGroupList(int productIdx);

	public List<ShopVO> getOptionList(int productIdx);

	public boolean productOptionGroup(int productIdx, String[] groupNames);

	public List<ShopVO> getOptionGroup(int productIdx);

	public int getOptionSame(int optionGroupIdx, String optionName);

	public int setOptionInput(int optionGroupIdx, String optionName, int addPrice);

}

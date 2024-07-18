package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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


}

package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.PhotoReviewVO;
import com.spring.javaclassS14.vo.ShopVO;

public interface SearchDAO {

	public List<ShopVO> searchProducts(@Param("keyword") String keyword);

	public List<PhotoReviewVO> searchPhotoReviews(@Param("keyword") String keyword);

}

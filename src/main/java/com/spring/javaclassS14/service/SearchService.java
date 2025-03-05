package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.PhotoReviewVO;
import com.spring.javaclassS14.vo.ShopVO;

public interface SearchService {

    public List<ShopVO> searchProducts(String keyword);

    public List<PhotoReviewVO> searchPhotoReviews(String keyword);
}

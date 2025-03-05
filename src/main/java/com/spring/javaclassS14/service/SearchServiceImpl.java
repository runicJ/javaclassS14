package com.spring.javaclassS14.service;

import com.spring.javaclassS14.dao.SearchDAO;
import com.spring.javaclassS14.vo.PhotoReviewVO;
import com.spring.javaclassS14.vo.ShopVO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SearchServiceImpl implements SearchService {

    @Autowired
    private SearchDAO searchDAO;

    @Override
    public List<ShopVO> searchProducts(String keyword) {
        return searchDAO.searchProducts(keyword);
    }

    @Override
    public List<PhotoReviewVO> searchPhotoReviews(String keyword) {
        return searchDAO.searchPhotoReviews(keyword);
    }
}

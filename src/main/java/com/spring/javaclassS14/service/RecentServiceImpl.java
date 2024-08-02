package com.spring.javaclassS14.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.RecentDAO;

@Service
public class RecentServiceImpl implements RecentService {
    @Autowired
    private RecentDAO recentDAO;

    @Override
    public void saveRecentProductView(String userId, int productIdx) {
        recentDAO.saveRecentProductView(userId, productIdx);
    }

    @Override
    public void saveRecentSearch(String userId, String searchTerm) {
        recentDAO.saveRecentSearch(userId, searchTerm);
    }

    @Override
    public int saveBookmark(String userId, String partUrl, String category) {
        return recentDAO.saveBookmark(userId, partUrl, category);
    }

    @Override
    public int saveLikedProduct(String userId, int productIdx) {
    	return recentDAO.saveLikedProduct(userId, productIdx);
    }

    @Override
    public List<Map<String, Object>> getRecentProductViews(String userId) {
        return recentDAO.getRecentProductViews(userId);
    }

    @Override
    public List<Map<String, Object>> getRecentSearches(String userId) {
        return recentDAO.getRecentSearches(userId);
    }

    @Override
    public List<Map<String, Object>> getBookmarks(String userId, String category) {
        return recentDAO.getBookmarks(userId, category);
    }

    @Override
    public List<Map<String, Object>> getFavoriteProducts(String userId) {
        return recentDAO.getFavoriteProducts(userId);
    }
}

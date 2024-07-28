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
    public void saveRecentProductView(int userId, int productIdx) {
        recentDAO.saveRecentProductView(userId, productIdx);
    }

    @Override
    public void saveRecentSearch(int userId, String searchTerm) {
        recentDAO.saveRecentSearch(userId, searchTerm);
    }

    @Override
    public void saveBookmark(int userId, String partUrl, String category) {
        recentDAO.saveBookmark(userId, partUrl, category);
    }

    @Override
    public void saveFavoriteProduct(int userId, int productIdx) {
        recentDAO.saveFavoriteProduct(userId, productIdx);
    }

    @Override
    public List<Map<String, Object>> getRecentProductViews(int userId) {
        return recentDAO.getRecentProductViews(userId);
    }

    @Override
    public List<Map<String, Object>> getRecentSearches(int userId) {
        return recentDAO.getRecentSearches(userId);
    }

    @Override
    public List<Map<String, Object>> getBookmarks(int userId, String category) {
        return recentDAO.getBookmarks(userId, category);
    }

    @Override
    public List<Map<String, Object>> getFavoriteProducts(int userId) {
        return recentDAO.getFavoriteProducts(userId);
    }
}

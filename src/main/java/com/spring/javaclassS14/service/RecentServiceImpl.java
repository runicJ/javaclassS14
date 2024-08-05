package com.spring.javaclassS14.service;

import com.spring.javaclassS14.dao.RecentDAO;
import com.spring.javaclassS14.vo.RecentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class RecentServiceImpl implements RecentService {

    @Autowired
    private RecentDAO recentDAO;

    @Override
    public void saveRecentView(String userId, int productIdx) {
        recentDAO.insertRecentView(userId, productIdx);
    }

    @Override
    public void saveRecentSearch(String userId, String searchTerm) {
        recentDAO.insertRecentSearch(userId, searchTerm);
    }

    @Override
    public List<RecentVO> getRecentViews(String userId, int limit) {
        return recentDAO.selectRecentViews(userId, limit);
    }

    @Override
    public List<RecentVO> getRecentSearches(String userId, int limit) {
        return recentDAO.selectRecentSearches(userId, limit);
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
    public boolean toggleLike(String userId, int productIdx) {
        return recentDAO.toggleLike(userId, productIdx);
    }

    @Override
    public List<RecentVO> getBookmarks(String userId, String category) {
        return recentDAO.getBookmarks(userId, category);
    }

    @Override
    public List<RecentVO> getFavoriteProducts(String userId) {
        return recentDAO.getFavoriteProducts(userId);
    }

	@Override
	public List<Map<String, Object>> getRecentSearch(String userId, int limit) {
        return recentDAO.getRecentSearch(userId, limit);
	}

	@Override
    public List<Map<String, Object>> getRecentViewProduct(String userId) {
        return recentDAO.getRecentViewProduct(userId);
    }

    public boolean toggleProductInterest(String userId, int productIdx) {
        int isInterested = recentDAO.isProductInterested(userId, productIdx);
        if (isInterested != 0) {
            recentDAO.removeProductInterest(userId, productIdx);
            return false;
        } else {
            recentDAO.addProductInterest(userId, productIdx);
            return true;
        }
    }
}

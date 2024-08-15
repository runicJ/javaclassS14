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
    public void saveRecentSearch(int userIdx, String searchTerm) {
        recentDAO.insertRecentSearch(userIdx, searchTerm);
    }

    @Override
    public List<RecentVO> getRecentViews(int userIdx, int limit) {
        return recentDAO.selectRecentViews(userIdx, limit);
    }

    @Override
    public List<RecentVO> getRecentSearches(int userIdx, int limit) {
        return recentDAO.selectRecentSearches(userIdx, limit);
    }

    @Override
    public int saveBookmark(int userIdx, String partUrl, String category) {
        return recentDAO.saveBookmark(userIdx, partUrl, category);
    }

    @Override
    public int saveLikedProduct(int userIdx, int productIdx) {
        return recentDAO.saveLikedProduct(userIdx, productIdx);
    }

    @Override
    public boolean toggleLike(int userIdx, int productIdx) {
        return recentDAO.toggleLike(userIdx, productIdx);
    }

    @Override
    public List<RecentVO> getBookmarks(int userIdx, String category) {
        return recentDAO.getBookmarks(userIdx, category);
    }

    @Override
    public List<RecentVO> getFavoriteProducts(int userIdx) {
        return recentDAO.getFavoriteProducts(userIdx);
    }

	@Override
	public List<Map<String, Object>> getRecentSearch(int userIdx, int limit) {
        return recentDAO.getRecentSearch(userIdx, limit);
	}

	@Override
    public List<Map<String, Object>> getRecentViewProduct(int userIdx) {
        return recentDAO.getRecentViewProduct(userIdx);
    }

    public boolean toggleProductInterest(int userIdx, int productIdx) {
        int isInterested = recentDAO.isProductInterested(userIdx, productIdx);
        if (isInterested != 0) {
            recentDAO.removeProductInterest(userIdx, productIdx);
            return false;
        } else {
            recentDAO.addProductInterest(userIdx, productIdx);
            return true;
        }
    }
}

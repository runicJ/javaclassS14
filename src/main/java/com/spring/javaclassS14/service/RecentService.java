package com.spring.javaclassS14.service;

import com.spring.javaclassS14.vo.RecentVO;
import java.util.List;
import java.util.Map;

public interface RecentService {
    public void saveRecentView(String userId, int productIdx);
    public void saveRecentSearch(String userId, String searchTerm);
    public List<RecentVO> getRecentViews(String userId, int limit);
    public List<RecentVO> getRecentSearches(String userId, int limit);
    // 기존 기능도 포함
    public int saveBookmark(String userId, String partUrl, String category);
    public int saveLikedProduct(String userId, int productIdx);
    public boolean toggleLike(String userId, int productIdx);
    public List<RecentVO> getBookmarks(String userId, String category);
    public List<RecentVO> getFavoriteProducts(String userId);
    public List<Map<String, Object>> getRecentSearch(String userId, int limit);
    public List<Map<String, Object>> getRecentViewProduct(String userId);
	public boolean toggleProductInterest(String userId, int productIdx);
}

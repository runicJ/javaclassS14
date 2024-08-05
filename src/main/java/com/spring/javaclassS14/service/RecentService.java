package com.spring.javaclassS14.service;

import com.spring.javaclassS14.vo.RecentVO;
import java.util.List;
import java.util.Map;

public interface RecentService {
    void saveRecentView(String userId, int productIdx);
    void saveRecentSearch(String userId, String searchTerm);
    List<RecentVO> getRecentViews(String userId, int limit);
    List<RecentVO> getRecentSearches(String userId, int limit);
    // 기존 기능도 포함
    int saveBookmark(String userId, String partUrl, String category);
    int saveLikedProduct(String userId, int productIdx);
    boolean toggleLike(String userId, int productIdx);
    List<RecentVO> getBookmarks(String userId, String category);
    List<RecentVO> getFavoriteProducts(String userId);
	List<Map<String, Object>> getRecentSearch(String userId, int limit);
	List<Map<String, Object>> getRecentProduct(String userId, int limit);
}

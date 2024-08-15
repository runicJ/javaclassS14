package com.spring.javaclassS14.service;

import com.spring.javaclassS14.vo.RecentVO;
import java.util.List;
import java.util.Map;

public interface RecentService {
    public void saveRecentSearch(int userIdx, String searchTerm);
    public List<RecentVO> getRecentViews(int userIdx, int limit);
    public List<RecentVO> getRecentSearches(int userIdx, int limit);
    // 기존 기능도 포함
    public int saveBookmark(int userIdx, String partUrl, String category);
    public int saveLikedProduct(int userIdx, int productIdx);
    public boolean toggleLike(int userIdx, int productIdx);
    public List<RecentVO> getBookmarks(int userIdx, String category);
    public List<RecentVO> getFavoriteProducts(int userIdx);
    public List<Map<String, Object>> getRecentSearch(int userIdx, int limit);
    public List<Map<String, Object>> getRecentViewProduct(int userIdx);
	public boolean toggleProductInterest(int userIdx, int productIdx);
}

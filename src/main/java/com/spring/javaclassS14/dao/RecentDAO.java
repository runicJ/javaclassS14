package com.spring.javaclassS14.dao;

import java.util.List;
import java.util.Map;

public interface RecentDAO {

	public void saveRecentProductView(String userId, int productIdx);

	public void saveRecentSearch(String userId, String searchTerm);

	public int saveBookmark(String userId, String partUrl, String category);

	public int saveLikedProduct(String userId, int productIdx);

	public List<Map<String, Object>> getRecentProductViews(String userId);

	public List<Map<String, Object>> getRecentSearches(String userId);

	public List<Map<String, Object>> getBookmarks(String userId, String category);

	public List<Map<String, Object>> getFavoriteProducts(String userId);

}

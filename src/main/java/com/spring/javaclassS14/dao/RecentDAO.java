package com.spring.javaclassS14.dao;

import java.util.List;
import java.util.Map;

public interface RecentDAO {

	public void saveRecentProductView(int userId, int productIdx);

	public void saveRecentSearch(int userId, String searchTerm);

	public void saveBookmark(int userId, String partUrl, String category);

	public void saveFavoriteProduct(int userId, int productIdx);

	public List<Map<String, Object>> getRecentProductViews(int userId);

	public List<Map<String, Object>> getRecentSearches(int userId);

	public List<Map<String, Object>> getBookmarks(int userId, String category);

	public List<Map<String, Object>> getFavoriteProducts(int userId);

}

package com.spring.javaclassS14.dao;

import com.spring.javaclassS14.vo.RecentVO;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface RecentDAO {
    public void insertRecentView(@Param("userId") String userId, @Param("productIdx") int productIdx);
    public void insertRecentSearch(@Param("userId") String userId, @Param("searchTerm") String searchTerm);
    public List<RecentVO> selectRecentViews(@Param("userId") String userId, @Param("limit") int limit);
    public List<RecentVO> selectRecentSearches(@Param("userId") String userId, @Param("limit") int limit);
    // 기존 기능도 포함
    public int saveBookmark(@Param("userId") String userId, String partUrl, @Param("category") String category);
    public int saveLikedProduct(@Param("userId") String userId, @Param("productIdx") int productIdx);
    public boolean toggleLike(@Param("userId") String userId, @Param("productIdx") int productIdx);
    public List<RecentVO> getBookmarks(@Param("userId") String userId, @Param("category") String category);
    public List<RecentVO> getFavoriteProducts(@Param("userId") String userId);
    public List<Map<String, Object>> getRecentSearch(@Param("userId") String userId, @Param("limit") int limit);
    public List<Map<String, Object>> getRecentViewProduct(@Param("userId") String userId);
	public int isProductInterested(@Param("userId") String userId, @Param("productIdx") int productIdx);
	public void removeProductInterest(@Param("userId") String userId, @Param("productIdx") int productIdx);
	public void addProductInterest(@Param("userId") String userId, @Param("productIdx") int productIdx);
}

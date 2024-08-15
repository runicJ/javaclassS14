package com.spring.javaclassS14.dao;

import com.spring.javaclassS14.vo.RecentVO;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

public interface RecentDAO {
    public void insertRecentView(@Param("userIdx") int userIdx, @Param("productIdx") int productIdx);
    public void insertRecentSearch(@Param("userIdx") int userIdx, @Param("searchTerm") String searchTerm);
    public List<RecentVO> selectRecentViews(@Param("userIdx") int userIdx, @Param("limit") int limit);
    public List<RecentVO> selectRecentSearches(@Param("userIdx") int userIdx, @Param("limit") int limit);
    // 기존 기능도 포함
    public int saveBookmark(@Param("userIdx") int userIdx, String partUrl, @Param("category") String category);
    public int saveLikedProduct(@Param("userIdx") int userIdx, @Param("productIdx") int productIdx);
    public boolean toggleLike(@Param("userIdx") int userIdx, @Param("productIdx") int productIdx);
    public List<RecentVO> getBookmarks(@Param("userIdx") int userIdx, @Param("category") String category);
    public List<RecentVO> getFavoriteProducts(@Param("userIdx") int userIdx);
    public List<Map<String, Object>> getRecentSearch(@Param("userIdx") int userIdx, @Param("limit") int limit);
    public List<Map<String, Object>> getRecentViewProduct(@Param("userIdx") int userIdx);
	public int isProductInterested(@Param("userIdx") int userIdx, @Param("productIdx") int productIdx);
	public void removeProductInterest(@Param("userIdx") int userIdx, @Param("productIdx") int productIdx);
	public void addProductInterest(@Param("userIdx") int userIdx, @Param("productIdx") int productIdx);
}

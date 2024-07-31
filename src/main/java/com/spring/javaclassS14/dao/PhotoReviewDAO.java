package com.spring.javaclassS14.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.PhotoReviewVO;

public interface PhotoReviewDAO {

	public int photoReviewInput(@Param("vo") PhotoReviewVO vo);

	public List<PhotoReviewVO> getPhotoReviewList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part, @Param("choice") String choice);

	public void setPhotoReviewReadNumPlus(@Param("idx") int idx);

	public PhotoReviewVO getPhotoReviewIdxSearch(@Param("idx") int idx);

	public ArrayList<PhotoReviewVO> getPhotoReviewReply(@Param("idx") int idx);

	public int setPhotoReviewReplyInput(@Param("vo") PhotoReviewVO vo);

	public int setPhotoReviewReplyDelete(@Param("idx") int idx);

	public void setPhotoReviewGoodPlus(@Param("idx") int idx);

	public int setPhotoReviewDelete(@Param("idx") int idx);

	public int[] getPhotoReviewIdxList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

	public PhotoReviewVO setPhotoReviewSingle(@Param("idx") int idx);

}

package com.spring.javaclassS14.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.PhotoReviewVO;

public interface PhotoReviewDAO {

    public int photoReviewInput(@Param("vo") PhotoReviewVO vo);

    public List<PhotoReviewVO> getPhotoReviewList(
        @Param("startIndexNo") int startIndexNo, 
        @Param("pageSize") int pageSize, 
        @Param("part") String part, 
        @Param("choice") String choice
    );

    public void setPhotoReviewReadNumPlus(@Param("photoReviewIdx") int photoReviewIdx);

    public PhotoReviewVO getPhotoReviewIdxSearch(@Param("photoReviewIdx") int photoReviewIdx);

    public ArrayList<PhotoReviewVO> getPhotoReviewReply(@Param("photoReviewIdx") int photoReviewIdx);

    public int setPhotoReviewReplyInput(@Param("vo") PhotoReviewVO vo);

    public int setPhotoReviewReplyDelete(@Param("photoReplyIdx") int photoReplyIdx);

    public void setPhotoReviewGoodPlus(@Param("photoReviewIdx") int photoReviewIdx);

    public int setPhotoReviewDelete(@Param("photoReviewIdx") int photoReviewIdx);

    public int[] getPhotoReviewIdxList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize);

    public PhotoReviewVO setPhotoReviewSingle(@Param("photoReviewIdx") int photoReviewIdx);

    public int checkUserLike(@Param("userIdx") Integer userIdx, @Param("photoReviewIdx") int photoReviewIdx);

    public void insertUserLike(@Param("userIdx") int userIdx, @Param("photoReviewIdx") int photoReviewIdx);

    public void deleteUserLike(@Param("userIdx") int userIdx, @Param("photoReviewIdx") int photoReviewIdx);

    public int getLikeCount(@Param("photoReviewIdx") int photoReviewIdx);

	public int insertPhotoReviewReply(@Param("userIdx") int userIdx, @Param("photoReviewIdx") int photoReviewIdx, @Param("content") String content);

	public int deletePhotoReviewReply(@Param("photoReviewReplyIdx") int photoReviewReplyIdx, @Param("userIdx") int userIdx);
}

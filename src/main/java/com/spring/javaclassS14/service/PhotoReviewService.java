package com.spring.javaclassS14.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS14.vo.PhotoReviewVO;

public interface PhotoReviewService {

    //public int imgCheck(PhotoReviewVO vo, String realPath);

    public List<PhotoReviewVO> getPhotoReviewList(int startIndexNo, int pageSize, String part, String choice);

    public void setPhotoReviewReadNumPlus(int photoReviewIdx);

    public PhotoReviewVO getPhotoReviewIdxSearch(int photoReviewIdx);

    public ArrayList<PhotoReviewVO> getPhotoReviewReply(int photoReviewIdx);

    public List<String> getPhotoReviewPhotoList(String content);

    public int setPhotoReviewReplyInput(PhotoReviewVO vo);

    public int setPhotoReviewReplyDelete(int photoReplyIdx);

    public void setPhotoReviewGoodPlus(int photoReviewIdx);

    public int setPhotoReviewDelete(int photoReviewIdx);

    public List<PhotoReviewVO> setPhotoReviewSingle(int startIndexNo, int pageSize);

    public boolean hasUserLiked(Integer userIdx, int photoReviewIdx);

    public boolean removeLike(int userIdx, int photoReviewIdx);

    public boolean addLike(int userIdx, int photoReviewIdx);

    public int getLikeCount(int photoReviewIdx);

	public int photoReviewInput(PhotoReviewVO vo);

	public int deletePhotoReviewReply(int photoReviewReplyIdx, int userIdx);

	public int insertPhotoReviewReply(int userIdx, int photoReviewIdx, String content);
}

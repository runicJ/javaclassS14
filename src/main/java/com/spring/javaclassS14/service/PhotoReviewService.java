package com.spring.javaclassS14.service;

import java.util.ArrayList;
import java.util.List;

import com.spring.javaclassS14.vo.PhotoReviewVO;

public interface PhotoReviewService {

	public int imgCheck(PhotoReviewVO vo, String realPath);

	public List<PhotoReviewVO> getPhotoReviewList(int startIndexNo, int pageSize, String part, String choice);

	public void setPhotoReviewReadNumPlus(int idx);

	public PhotoReviewVO getPhotoReviewIdxSearch(int idx);

	public ArrayList<PhotoReviewVO> getPhotoReviewReply(int idx);

	public List<String> getPhotoReviewPhotoList(String content);

	public int setPhotoReviewReplyInput(PhotoReviewVO vo);

	public int setPhotoReviewReplyDelete(int idx);

	public void setPhotoReviewGoodPlus(int idx);

	public int setPhotoReviewDelete(int idx);

	public List<PhotoReviewVO> setPhotoReviewSingle(int startIndexNo, int pageSize);

}

package com.spring.javaclassS14.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.imgscalr.Scalr;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.javaclassS14.common.AllProvide;
import com.spring.javaclassS14.dao.PhotoReviewDAO;
import com.spring.javaclassS14.vo.PhotoReviewVO;

@Service
public class PhotoReviewServiceImpl implements PhotoReviewService {
	
	@Autowired
	PhotoReviewDAO photoReviewDAO;
	
	@Autowired
	AllProvide allProvide;
	
	/*
	 * @Override public int imgCheck(PhotoReviewVO vo, String realPath) { int res =
	 * 0; if (!vo.getContent().contains("src=\"/")) return res;
	 * 
	 * int position = 31, photoCount = 0; boolean firstSw = true; String firstFile =
	 * "";
	 * 
	 * String nextImg = vo.getContent().substring(vo.getContent().indexOf("src=\"/")
	 * + position);
	 * 
	 * while (true) { photoCount++; String imgFile = nextImg.substring(0,
	 * nextImg.indexOf("\""));
	 * 
	 * if (firstSw) { firstFile = imgFile; vo.setThumbnail(firstFile); firstSw =
	 * false; }
	 * 
	 * String oriFilePath = realPath + "ckeditor/" + imgFile; String copyFilePath =
	 * realPath + "photoReview/" + imgFile;
	 * 
	 * File oriFile = new File(oriFilePath); if (oriFile.exists()) {
	 * allProvide.fileCopyCheck(oriFilePath, copyFilePath); }
	 * 
	 * if (!nextImg.contains("src=\"/")) break; nextImg =
	 * nextImg.substring(nextImg.indexOf("src=\"/") + position); }
	 * 
	 * vo.setPhotoCount(photoCount);
	 * vo.setContent(vo.getContent().replace("/data/ckeditor/",
	 * "/data/photoReview/"));
	 * 
	 * try { String fileExt = firstFile.substring(firstFile.lastIndexOf(".") + 1);
	 * String uploadPath = realPath + "photoReview/" + firstFile;
	 * 
	 * BufferedImage srcImg = ImageIO.read(new File(uploadPath)); int ow =
	 * srcImg.getWidth(); int oh = srcImg.getHeight();
	 * 
	 * int tw = 200, th = 150; int rw = ow, rh = (ow * th) / tw;
	 * 
	 * if (rh > oh) { rh = oh; rw = (oh * tw) / th; }
	 * 
	 * BufferedImage resizeImg = Scalr.resize(Scalr.crop(srcImg, (ow - rw) / 2, (oh
	 * - rh) / 2, rw, rh), tw, th); String thumbnail = firstFile.substring(0,
	 * firstFile.lastIndexOf(".")) + "_S." + fileExt;
	 * 
	 * File tFileName = new File(realPath + "photoReview/" + thumbnail);
	 * ImageIO.write(resizeImg, fileExt, tFileName);
	 * 
	 * vo.setThumbnail(thumbnail); } catch (IOException e) { e.printStackTrace(); }
	 * 
	 * res = photoReviewDAO.photoReviewInput(vo); return res; }
	 */
	
	@Override
	public int photoReviewInput(PhotoReviewVO vo) {
	    return photoReviewDAO.photoReviewInput(vo);
	}

	@Override
	public List<PhotoReviewVO> getPhotoReviewList(int startIndexNo, int pageSize, String part, String choice) {
		return photoReviewDAO.getPhotoReviewList(startIndexNo, pageSize, part, choice);
	}

	@Override
	public void setPhotoReviewReadNumPlus(int photoReviewIdx) {
	    photoReviewDAO.setPhotoReviewReadNumPlus(photoReviewIdx);
	}

	@Override
	public PhotoReviewVO getPhotoReviewIdxSearch(int photoReviewIdx) {
	    return photoReviewDAO.getPhotoReviewIdxSearch(photoReviewIdx);
	}

	@Override
	public ArrayList<PhotoReviewVO> getPhotoReviewReply(int photoReviewIdx) {
	    return photoReviewDAO.getPhotoReviewReply(photoReviewIdx);
	}

	@Override
	public List<String> getPhotoReviewPhotoList(String content) {
		List<String> photoList = new ArrayList<String>();
		
		if(content.indexOf("src=\"/") == -1) return photoList; // content안에 그림파일이 없으면 작업을 수행하지 않는다.
		//            0         1         2         3         4         5         6
		//            01234567890123456789012345678901234567890123456789012345678901234567890
		//<img alt="" src="/javaclassS/data/photoReview/210201125255+0900_m13.jpg" style="height:400px; width:600px" />
		
		int position = 35;
		
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		
		while(true) {
			String imgFile = nextImg.substring(0, nextImg.indexOf("\""));  // 순수한 그림파일만 가져온다.
			photoList.add(imgFile);
			if(nextImg.indexOf("src=\"/") == -1) break;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
		}
		return photoList;
	}

	@Override
	public int setPhotoReviewReplyInput(PhotoReviewVO vo) {
	    return photoReviewDAO.setPhotoReviewReplyInput(vo);
	}

	@Override
	public int setPhotoReviewReplyDelete(int photoReplyIdx) {
	    return photoReviewDAO.setPhotoReviewReplyDelete(photoReplyIdx);
	}

	@Override
	public void setPhotoReviewGoodPlus(int photoReviewIdx) {
	    photoReviewDAO.setPhotoReviewGoodPlus(photoReviewIdx);
	}

	@Transactional
	@Override
	public int setPhotoReviewDelete(int photoReviewIdx) {
	    PhotoReviewVO vo = photoReviewDAO.getPhotoReviewIdxSearch(photoReviewIdx);

	    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
	    String realPath = request.getSession().getServletContext().getRealPath("/resources/data/photoReview/");

	    int position = 35; // 경로 내 파일명 위치

	    if (vo != null && vo.getContent() != null && vo.getContent().contains("src=\"/")) {
	        String nextImg = vo.getContent().substring(vo.getContent().indexOf("src=\"/") + position);

	        while (true) {
	            String imgFile = nextImg.substring(0, nextImg.indexOf("\""));
	            File file = new File(realPath + imgFile);
	            
	            if (file.exists()) {
	                file.delete();
	            }

	            if (nextImg.indexOf("src=\"/") == -1) break;
	            else nextImg = nextImg.substring(nextImg.indexOf("src=\"/") + position);
	        }
	    }
	    
	    return photoReviewDAO.setPhotoReviewDelete(photoReviewIdx);
	}
	
	@Override
	public List<PhotoReviewVO> setPhotoReviewSingle(int startIndexNo, int pageSize) {
	    List<PhotoReviewVO> vos = new ArrayList<>();
	    int[] idxs = photoReviewDAO.getPhotoReviewIdxList(startIndexNo, pageSize);

	    for (int photoReviewIdx : idxs) {
	        PhotoReviewVO photoVo = photoReviewDAO.setPhotoReviewSingle(photoReviewIdx);
	        PhotoReviewVO vo = new PhotoReviewVO();

	        vo.setPhotoReviewIdx(photoVo.getPhotoReviewIdx());
	        vo.setPart(photoVo.getPart());
	        vo.setTitle(photoVo.getTitle());
	        vo.setPhotoCount(photoVo.getPhotoCount());
	        vo.setContent(photoVo.getContent());
	        
	        vos.add(vo);
	    }
	    return vos;
	}

	@Override
	public boolean hasUserLiked(Integer userIdx, int photoReviewIdx) {
	    return photoReviewDAO.checkUserLike(userIdx, photoReviewIdx) > 0;
	}

	/** 좋아요 추가 */
	@Override
	public boolean addLike(int userIdx, int photoReviewIdx) {
	    try {
	        photoReviewDAO.insertUserLike(userIdx, photoReviewIdx);
	        return true;
	    } catch (Exception e) {
	        return false;
	    }
	}

	/** 좋아요 취소 */
	@Override
	public boolean removeLike(int userIdx, int photoReviewIdx) {
	    try {
	        photoReviewDAO.deleteUserLike(userIdx, photoReviewIdx);
	        return true;
	    } catch (Exception e) {
	        return false;
	    }
	}

	/** 특정 게시글의 좋아요 개수 가져오기 */
	@Override
	public int getLikeCount(int photoReviewIdx) {
	    return photoReviewDAO.getLikeCount(photoReviewIdx);
	}

	@Override
	public int deletePhotoReviewReply(int photoReviewReplyIdx, int userIdx) {
	    return photoReviewDAO.deletePhotoReviewReply(photoReviewReplyIdx, userIdx);
	}

	@Override
	public int insertPhotoReviewReply(int userIdx, int photoReviewIdx, String content) {
	    return photoReviewDAO.insertPhotoReviewReply(userIdx, photoReviewIdx, content);
	}	
}

package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class PhotoGalleryVO {
	// photoGallery.sql
	private int idx;
	private String userId;
	private String part;
	private String title;
	private int photoCount;
	private String hostIp;
	private String pDate;
	private int goodCount;
	private int readNum;
	
	// photoStorage.sql
	private int storageIdx;
	private String thumbnail;
	
	// photoReply.sql
	private int replyIdx;
	private String replyMid;
	private int replyPhotoIdx;
	private String content;
	private String prDate;
	
	private int replyCnt;	// 댓글 개수
}

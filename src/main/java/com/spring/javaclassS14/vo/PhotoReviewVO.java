package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class PhotoReviewVO {
    private int photoReviewIdx;
    private int userIdx;
    private String part;
    private String title;
    private String content;
    private String thumbnail;
    private String photoNames; 
    private int photoCount;
    private String hostIp;
    private String reviewDate;
    private int readNum;

    // 댓글 관련
    private int photoReplyIdx;
    private String replyMid;
    private int replyPhotoIdx;
    private String prDate;
    private int replyCnt; 

    // 좋아요 관련
    private int likeCnt;      // 좋아요 개수
    private int photoLikesIdx;
    private String likeDate;
    private boolean liked;    // 사용자가 좋아요를 눌렀는지 여부
}
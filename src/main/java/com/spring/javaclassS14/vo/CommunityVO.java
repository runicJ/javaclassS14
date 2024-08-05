package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class CommunityVO {

    private int hospitalCommentIdx;
    private int hospitalIdx;
    private String userId;
    private String hospitalCommentTitle;
    private String hospitalComment;
    private int star; // 별점
    private int waiting_time; // 대기 시간
	
    private String hospitalName;
    private String hospitalCategory;
    private String hospitalRegion;
    
}

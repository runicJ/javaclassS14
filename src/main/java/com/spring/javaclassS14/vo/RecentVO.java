package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class RecentVO {
	
    private int viewIdx;
    private int userIdx;
    private String userId;
    private int productIdx;
    private String viewDate;
	
    private int searchIdx;
    private String searchTerm;
    private String searchDate;
}

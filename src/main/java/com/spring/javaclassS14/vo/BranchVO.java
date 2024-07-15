package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class BranchVO {
	
	private int branchStoreIdx;
	private String branchName;
	private String branchTel;
	private String branchLocation;
	private double latitude;
	private double longitude;
	private String createDate;
	private String qrCode;
	
}

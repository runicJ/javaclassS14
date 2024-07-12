package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class UserVO {

	private int userIdx;
	private String userId;
	private String userPwd;
	private String name;
	private String nickName;
	private String gender;
	private String email;
	private String tel;
	private String userImage;
	private String registerWay;
	private int point;
	private String policyFlag;
	private String createDate;
	private String updateate;
	private double level;
	private String userStatus;
	
	// 회원 접속 로그
	private int logIdx;
	private String loginTime;
	private String hostIp;
	
	// 탈퇴 회원
	private int deleteIdx;
	private String deleteDate;
	private String deleteReason;
	
	private int deleteDiff;
	private String delStatus;
}

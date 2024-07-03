package com.spring.javalclassS14.vo;

import lombok.Data;

@Data
public class UserVO {

	private int user_idx;
	private String user_id;
	private String user_pwd;
	private String name;
	private String nickName;
	private String gender;
	private String email;
	private String tel;
	private String user_image;
	private String register_reason;
	private int point;
	private String policy_flag;
	private String create_date;
	private String update_date;

}

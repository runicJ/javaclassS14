package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class AirVO {
	private String dataTime;  // 오염도측정 연-월-일 시간:분
	private String so2Value;  // 아황산가스 농도(단위: ppm)
	private String coValue;  //	일산화탄소 농도(단위: ppm)
	private String o3Value;  // 오존 농도(단위: ppm)
	private String no2Value;  // 이산화질소 농도(단위: ppm)
	private String pm10Value;  // 미세먼지(PM10) 농도(단위: ug/m3)
	private String pm10Value24;  // 미세먼지(PM10) 24시간 예측이동농도(단위: ug/m3)
	private String pm25Value;  // 초미세먼지(PM2.5) 농도(단위: ug/m3)
	private String pm25Value24;  //	초미세먼지(PM2.5) 24시간 예측이동농도(단위: ug/m3)
	private String khaiValue;  //	통합대기환경수치
	private String khaiGrade;  //	통합대기환경지수
	private String so2Grade;  //	아황산가스 지수
	private String coGrade;  //	 일산화탄소 지수
	private String o3Grade;  //	 오존 지수
	private String no2Grade;  //	이산화질소 지수
	private String pm10Grade;  //	미세먼지(PM10) 24시간 등급자료
	private String pm25Grade;  //	초미세먼지(PM2.5) 24시간 등급자료
	private String pm10Grade1h;  //	미세먼지(PM10) 1시간 등급자료
	private String pm25Grade1h;  //	초미세먼지(PM2.5) 1시간 등급자료
}

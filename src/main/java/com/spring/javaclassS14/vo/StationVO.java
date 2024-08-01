package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class StationVO {
	
	// 측정소 csv
	private int stationIdx; 
	private String stationRegion;
	private String stationName;
	private String stationAddress;
	private String stationAgency;
	private int stationYear; 
	
}

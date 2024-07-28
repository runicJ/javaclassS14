package com.spring.javaclassS14.vo;

import lombok.Data;

@Data
public class AlarmVO {
    private int alarmIdx;
    private int receiverIdx;
    private int senderIdx;
    private String alarmPart;
    private String alarmPartIdx;
    private String alarmDate;
    private String alarmCheckFlag; // 'y' or 'n'
}
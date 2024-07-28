package com.spring.javaclassS14.service;

import java.util.List;

import com.spring.javaclassS14.vo.AlarmVO;

public interface AlarmService {

    public void createAlarm(AlarmVO alarm);
    
    public List<AlarmVO> getAlarms(int receiverIdx);
    
    public void markAlarmAsRead(int alarmIdx);
}

package com.spring.javaclassS14.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaclassS14.dao.AlarmDAO;
import com.spring.javaclassS14.vo.AlarmVO;

@Service
public class AlarmServiceImpl implements AlarmService {

    @Autowired
    private AlarmDAO alarmDAO;

    @Override
    public void createAlarm(AlarmVO alarm) {
        alarmDAO.insertAlarm(alarm);
    }

    @Override
    public List<AlarmVO> getAlarms(int receiverIdx) {
        return alarmDAO.getAlarmsByReceiver(receiverIdx);
    }

    @Override
    public void markAlarmAsRead(int alarmIdx) {
        alarmDAO.updateAlarmCheckFlag(alarmIdx);
    }
}

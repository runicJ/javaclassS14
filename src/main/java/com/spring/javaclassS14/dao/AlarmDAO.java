package com.spring.javaclassS14.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaclassS14.vo.AlarmVO;

public interface AlarmDAO {

	public void insertAlarm(@Param("alarm") AlarmVO alarm);

	public List<AlarmVO> getAlarmsByReceiver(@Param("receiverIdx") int receiverIdx);

	public void updateAlarmCheckFlag(@Param("alarmIdx") int alarmIdx);

}

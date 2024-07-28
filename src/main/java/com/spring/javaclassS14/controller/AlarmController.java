package com.spring.javaclassS14.controller;

import com.spring.javaclassS14.service.AlarmService;
import com.spring.javaclassS14.vo.AlarmVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/alarm")
public class AlarmController {

    @Autowired
    private AlarmService alarmService;

    @PostMapping("/create")
    public void createAlarm(@RequestBody AlarmVO alarm) {
        alarmService.createAlarm(alarm);
    }

    @GetMapping("/list/{receiverIdx}")
    public List<AlarmVO> getAlarms(@PathVariable int receiverIdx) {
        return alarmService.getAlarms(receiverIdx);
    }

    @PutMapping("/read/{alarmIdx}")
    public void markAlarmAsRead(@PathVariable int alarmIdx) {
        alarmService.markAlarmAsRead(alarmIdx);
    }
}
package com.spring.javaclassS14.common;

import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class WebSocketHandler extends TextWebSocketHandler {

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // 연결이 성공적으로 완료되었을 때의 처리
        System.out.println("연결됨: " + session.getId());
    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        // 메시지를 받았을 때의 처리
        System.out.println("메시지 수신: " + message.getPayload());
        session.sendMessage(new TextMessage("알림: " + message.getPayload()));
    }
}

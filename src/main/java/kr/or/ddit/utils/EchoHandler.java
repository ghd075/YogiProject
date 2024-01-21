package kr.or.ddit.utils;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequestMapping("/echo")
public class EchoHandler extends TextWebSocketHandler{

	// 로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	// 클라이언트가 웹 소켓 연결 시
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("Socket 연결됨 => {}", session.getAttributes());
		// 웹 소켓이 생성될 때마다 리스트에 넣어줌
		super.afterConnectionClosed(session, status);
		sessions.add(session);
	}
	
	
}

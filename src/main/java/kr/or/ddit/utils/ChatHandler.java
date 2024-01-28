package kr.or.ddit.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.users.login.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class ChatHandler extends TextWebSocketHandler {

	// 전체 채팅
	private static List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();

	// 1. 클라이언트 연결 이후에 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("## 누군가 접속");
		sessionList.add(session);
		Map<String, Object> sessionMap = session.getAttributes();
		log.info("세션 정보 : " + session.getAttributes());
		MemberVO member = (MemberVO) sessionMap.get("sessionInfo");
		if(member == null) { // 웹소켓 아이디를 가져옴
			log.info("웹소켓 아이디 : " + session.getId());
		}else { // 로그인한 사용자 아이디를 가져옴
			log.info("로그인한 사용자 아이디 : " + member.getMemId());
		}
	}

	// 2. 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		Map<String, Object> mapSession = session.getAttributes();
		MemberVO member = (MemberVO) mapSession.get("sessionInfo");
		// 로그인한 아이디와 클라이언트로부터 서버로 보낸 메시지를 받음
		log.info("{}로 부터 {}받음", member.getMemId(), message.getPayload());
		for(WebSocketSession sess : sessionList) {
			sess.sendMessage(new TextMessage(member.getMemId() + "," + message.getPayload()));
		}
	}

	// 3. 클라이언트의 연결이 끊겼을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		Map<String, Object> mapSession = session.getAttributes();
		MemberVO member = (MemberVO) mapSession.get("sessionInfo");
		String userId = member.getMemId();
		log.info("로그인 한 아이디 : " + userId);
		log.info("{} 연결 끊김", userId);
		log.info("채팅방 퇴장한 사람 : " + userId);
	}
	
}

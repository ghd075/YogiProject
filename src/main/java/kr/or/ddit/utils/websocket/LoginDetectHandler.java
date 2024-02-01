package kr.or.ddit.utils.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.users.login.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class LoginDetectHandler extends TextWebSocketHandler {

	// 전체 로그인한 멤버 리스트, 여러 개의 웹소켓 세션을 담도록 리스트를 생성한다.
	private static List<WebSocketSession> loginSessionList = new ArrayList<WebSocketSession>();
	
	// 1. 클라이언트 연결 이후에 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("##################### 누군가 접속");
		
		loginSessionList.add(session);
		log.info("세션 정보 : {}", session.getAttributes());
		log.info("로그인 이후 연결된 세션 갯수 : {} 개 세션이 연결됨", loginSessionList.size());
		
		Map<String, Object> loginSessionMap = session.getAttributes();
		MemberVO loginMember = (MemberVO) loginSessionMap.get("sessionInfo");
		
		if(loginMember == null) { // 웹소켓 아이디를 가져옴
			log.info("웹소켓 아이디 : {}", session.getId());
		}else { // 로그인한 사용자 아이디를 가져옴
			log.info("로그인한 사용자 아이디 : {}", loginMember.getMemId());
		}
	}
	
	// 로그인 정보 정제
	List<String> loginMembersId = new ArrayList<String>();
	
	// 2. 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		Map<String, Object> loginMapSession = session.getAttributes();
		MemberVO loginMember = (MemberVO) loginMapSession.get("sessionInfo");
		
		// 파싱된 메시지
	    String receivedMessage = message.getPayload();

	    // 로그인 신호 처리
	    if (receivedMessage.contains("loginSignal")) {
	        // 서버에서 로그인 신호를 감지하면 원하는 처리를 수행
	        // 예: 특정 신호를 클라이언트에게 다시 전송하거나, 로그를 출력하는 등의 작업
	        log.info("서버에서 로그인 신호를 감지하였습니다.");
	    }

	    // 로그아웃 신호 처리
	    if (receivedMessage.contains("logoutSignal")) {
	        // 서버에서 로그아웃 신호를 감지하면 원하는 처리를 수행
	        // 예: 특정 신호를 클라이언트에게 다시 전송하거나, 로그를 출력하는 등의 작업
	        log.info("서버에서 로그아웃 신호를 감지하였습니다.");
	    }
		
		// 로그인한 아이디와 클라이언트로부터 서버로 보낸 메시지를 받음
		log.info("아이디 "+loginMember.getMemId()+" 로 부터 이름이 "+loginMember.getMemName()+" 인 사람이 로그인/로그아웃을 시도함.");
		
		// 중복 체크
	    if (!loginMembersId.contains(loginMember.getMemId())) {
	        loginMembersId.add(loginMember.getMemId());
	        log.info("loginMembersId : {}", loginMembersId);

	        ObjectMapper objectMapper = new ObjectMapper();
	        try {
	            String jsonStr = objectMapper.writeValueAsString(loginMembersId);
	            for (WebSocketSession sess : loginSessionList) {
	                sess.sendMessage(new TextMessage(jsonStr));
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    } else {
	        log.info("이미 로그인한 아이디입니다. 중복 처리를 하지 않습니다.");
	    }
		
		
	}
	
	// 3. 클라이언트의 연결이 끊겼을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		Map<String, Object> loginMapSession = session.getAttributes();
	    MemberVO loginMember = (MemberVO) loginMapSession.get("sessionInfo");
	    String userId = loginMember.getMemId();

	    if (loginMembersId.contains(userId)) {
	    	
	        loginMembersId.remove(userId);
	        log.info("로그아웃 후 loginMembersId에서 {} 제거됨", userId);
	        log.info("loginMembersId : {}", loginMembersId);
	        ObjectMapper objectMapper = new ObjectMapper();
	        
	        try {
	        	String jsonStr = objectMapper.writeValueAsString(loginMembersId);
	        	for (WebSocketSession sess : loginSessionList) {
	        		if(sess.isOpen()) {
	        			sess.sendMessage(new TextMessage(jsonStr));
	        		}
	        	}
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
	        
	    } else {
	        log.info("로그아웃한 아이디가 loginMembersId에 없습니다. 처리하지 않습니다.");
	    }

	    loginSessionList.remove(session);
	    log.info("로그아웃 이후 연결된 세션 갯수 : {} 개 세션", loginSessionList.size());

	    log.info("##################### 누군가 로그아웃");
	    log.info("{} 연결 끊김", userId);
	    log.info("로그아웃 한 사람 : {}", userId);
		
	}
	
}

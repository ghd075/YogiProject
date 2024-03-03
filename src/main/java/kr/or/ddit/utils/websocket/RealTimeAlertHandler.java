package kr.or.ddit.utils.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.users.login.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class RealTimeAlertHandler extends TextWebSocketHandler {

	// 전체 로그인한 멤버 리스트
	private static List<WebSocketSession> rtAlertSessionList = new ArrayList<WebSocketSession>();
	
	// 락 걸기
	private static final Lock lock = new ReentrantLock();
	
	// 1. 클라이언트 연결 이후에 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("##################### 누군가 접속");
		
		Map<String, Object> loginSessionMap = session.getAttributes();
	    MemberVO loginMember = (MemberVO) loginSessionMap.get("sessionInfo");
	    
	    if (loginMember == null) {
	        // WebSocket ID is present, do not add to the list
	        log.info("웹소켓 아이디 : {}", session.getId());
	    } else {
	        // Login user is present, add the session to the list
	    	rtAlertSessionList.add(session);
	        log.info("세션 정보 : {}", session.getAttributes());
	        log.info("로그인 이후 연결된 세션 갯수 : {} 개 세션이 연결됨", rtAlertSessionList.size());
	        log.info("로그인한 사용자 아이디 : {}", loginMember.getMemId());
	    }
	}
	
	// 2. 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		Map<String, Object> loginMapSession = session.getAttributes();
		MemberVO loginMember = (MemberVO) loginMapSession.get("sessionInfo");
		
		if (loginMember != null) {
			// 로그인한 아이디와 클라이언트로부터 서버로 보낸 메시지를 받음
			log.info("아이디 "+loginMember.getMemId()+" 로 부터 이름이 "+loginMember.getMemName()+" 인 사람에게 실시간 알림 시작.");
			
			// 공통 변수 선언
			String preRealTimeAlertTxt = message.getPayload();
			log.info("preRealTimeAlertTxt : " + preRealTimeAlertTxt);
			
			// lock 획득
	        lock.lock();
	        try {
	        	// 동시에 실행하면 안되는 코드
	        	for(WebSocketSession sess : rtAlertSessionList) {
	        		sess.sendMessage(new TextMessage(preRealTimeAlertTxt));
	        	}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				// lock 해제
	            lock.unlock();
			}
		}
		
	}
	
	// 3. 클라이언트의 연결이 끊겼을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	    try {
	        rtAlertSessionList.remove(session);
	        log.info("로그아웃 이후 연결된 세션 갯수 : {} 개 세션", rtAlertSessionList.size());

	        Map<String, Object> loginMapSession = session.getAttributes();
	        MemberVO loginMember = (MemberVO) loginMapSession.get("sessionInfo");
	        if (loginMember != null) {
	            String userId = loginMember.getMemId();
	            log.info("##################### 누군가 로그아웃");
	            log.info("{} 연결 끊김", userId);
	            log.info("로그아웃 한 사람 : {}", userId);
	        } else {
	            log.info("##################### 누군가 로그아웃");
	            log.info("로그인하지 않은 사용자 연결 끊김");
	        }
	    } catch (Exception e) {
	        log.error("Error occurred during WebSocket session closing: {}", e.getMessage());
	    }
	}
	
}

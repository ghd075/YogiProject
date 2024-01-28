package kr.or.ddit.utils;

import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.users.login.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class EchoHandler extends TextWebSocketHandler{

	// WebSocketSession : 웹소켓에 연결된 클라이언트의 세션을 가지고 있다.
	// 로그인 한 인원 전체
	// private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	private Map<String, WebSocketSession> sessionMap  = new HashMap<String, WebSocketSession>();	// 웹소켓 세션을 담아둘 맵
	private Map<String, String> userMap = new HashMap<String, String>();							// 사용자
	
	/**
	 * 클라이언트 연결 이후에 실행되는 메소드
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		// List에 session 정보를 담는다.
		// sessions.add(session);
		
		String name = getId(session);
		log.info("접속한 name : " + name);
		
		log.info(name + "님이 입장하셨습니다.");
		
		log.info("{} 연결되었습니다.", session.getId());
		super.afterConnectionEstablished(session);
		sessionMap.put(session.getId(), session);
		
		JSONObject obj = new JSONObject();
		obj.put("type", "getId");
		obj.put("sessionId", session.getId());
        
        //클라이언트에게 메세지 전달
		session.sendMessage(new TextMessage(obj.toJSONString()));
		
	}

	/**
	 * 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행되는 메소드
	 */
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// TextMessage : 웹소켓을 이용해 텍스트로 전달된 메시지가 담겨있는 객체.
		// payload : 전송되는 데이터 
		// message.getPayload() : JSON 객체
		
//		String strMessage = message.getPayload();		// 전송되는 데이터
//		log.info("전송된 메시지 : " + strMessage);
		
		// Jackson 라이브러리 : Java에서 JSON 을 다루기위한 라이브러리
		// Jackson-databind 라이브러리 : 
		
		// 연결된 세션들에게 메시지를 보낼 때
//		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//		String strDate = sdf.format(new Date());
//		strMessage += "|" + strDate;
		
		/*
		 * for(WebSocketSession webSocketSession : sessions) {
		 * webSocketSession.sendMessage(new TextMessage(strMessage)); }
		 */
		String msg = message.getPayload();
		log.info("===============Message=================");
		log.info("{}", msg);
		log.info("===============Message=================");
		
		JSONObject obj = jsonToObjectParser(msg);
		//로그인된 Member (afterConnectionEstablished 메소드에서 session을 저장함)
		for(String key : sessionMap.keySet()) {
			WebSocketSession wss = sessionMap.get(key);
			
			if(userMap.get(wss.getId()) == null) {
				userMap.put(wss.getId(), (String)obj.get("userName"));
			}
			
			//클라이언트에게 메시지 전달
			wss.sendMessage(new TextMessage(obj.toJSONString()));
		}
	}
	
    /**
     * 클라이언트 연결을 끊었을 때 실행되는 메소드
     */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String name = getId(session);
		log.info(name + "님이 퇴장하셨습니다.");
		log.info("{} 연결이 종료되었습니다.", session.getId());
		super.afterConnectionClosed(session, status);
		sessionMap.remove(session.getId());
		
		String userName = userMap.get(session.getId());
		for(String key : sessionMap.keySet()) {
			WebSocketSession wss = sessionMap.get(key);
			
			if(wss == session) continue;

			JSONObject obj = new JSONObject();
			obj.put("type", "close");
			obj.put("userName", userName);
			
			wss.sendMessage(new TextMessage(obj.toJSONString()));
		}
		userMap.remove(session.getId());
	}

	/**
	 * 세션에서 memName 가져오기
	 */
	private String getId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		log.info("세션정보 : => {}", httpSession);
		MemberVO member = (MemberVO) httpSession.get("sessionInfo");
		if(member == null) {
			return session.getId();
		} else {
			return member.getMemName();
		}
	}
	
	/**
	 * JSON 형태의 문자열을 JSONObejct로 파싱
	 */
	private static JSONObject jsonToObjectParser(String jsonStr) throws Exception{
		JSONParser parser = new JSONParser();
		JSONObject obj = null;
		obj = (JSONObject) parser.parse(jsonStr);
		return obj;
	}
}

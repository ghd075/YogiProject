package kr.or.ddit.utils.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.users.login.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class RealTimeAlertHandlerChansVer extends TextWebSocketHandler {

	//로그인 한 인원 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 1:1로 할 경우
	private Map<String, WebSocketSession> userSessionsMap = new HashMap<String, WebSocketSession>();
	
	// 1. 클라이언트 연결 이후에 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
			log.info("Socket 연결");
			sessions.add(session);
			log.info(currentUserName(session));//현재 접속한 사람
			String senderId = currentUserName(session);
			userSessionsMap.put(senderId,session);
	    }
	
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {// 메시지
		// TODO Auto-generated method stub
		log.info("ssesion"+currentUserName(session));
		String msg = message.getPayload();//자바스크립트에서 넘어온 Msg
		log.info("msg="+msg);
		if (StringUtils.isNotEmpty(msg)) {
			log.info("if문 들어옴?");
			for(int i = 0; i < sessions.size(); i++) {
				log.debug("sessionzz + "+i+" : {}", sessions.get(i));
			}
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 9) {
				
//				String cmd = strs[0];
//				String replyWriter = strs[1];
//				String boardWriter = strs[2];
//				String bno = strs[3];
//				String title = strs[4];
//				String bgno = strs[5];
				String realrecIdArr = strs[0];
				String[] realrecIdArrTemp = strs[0].split(";");
				String realsenId = strs[1];
				String realsenName = strs[2];
				String realsenTitle = strs[3];
				String realsenContent = strs[4];
				String realsenType = strs[5];
				String realsenReadyn = strs[6];
				String realsenUrl = strs[7];
				String userImgSrc = strs[8];
				log.info("length 성공?"+realrecIdArr);
				log.debug("realrecIdArrTemp : {}", realrecIdArrTemp);
				log.debug("realrecIdArrTemp : {}", realrecIdArrTemp.length);
				
				if(realrecIdArrTemp.length == 1) {
					WebSocketSession replyWriterSession = userSessionsMap.get(realsenId);
					WebSocketSession boardWriterSession = userSessionsMap.get(realrecIdArr);
					log.info("boardWriterSession="+userSessionsMap.get(realrecIdArr));
					log.info("boardWirterSession"+boardWriterSession);	// 얘한테 알림이 가야하는거임
					
					//댓글
//					if ("test".equals("test") && boardWriterSession != null) {
//						log.info("onmessage되나?");
//						TextMessage tmpMsg = new TextMessage(replyWriter + "님이 "
//								+ "<a href='/board/readView?bno="+ bno +"&bgno="+bgno+"'  style=\"color: black\">"
//								+ title+" 에 댓글을 달았습니다!</a>");
//						boardWriterSession.sendMessage(tmpMsg);
//					}
					
					if ("buyPlan".equals(realsenType) && boardWriterSession != null) {
						log.info("onmessage되나?");
//						TextMessage tmpMsg = new TextMessage(realsenId + "님이" +realrecIdArr+ "인 당신에게" + realsenTitle + " 에서 차감 요청함");
//						boardWriterSession.sendMessage(tmpMsg);
						String preRealTimeAlertTxt = message.getPayload();
						boardWriterSession.sendMessage(new TextMessage(preRealTimeAlertTxt));
					}
					
				} else {
					for(int i = 0; i < realrecIdArrTemp.length; i++) {
						WebSocketSession replyWriterSession = userSessionsMap.get(realsenId);
						WebSocketSession boardWriterSession = userSessionsMap.get(realrecIdArrTemp[i]);
						log.info("boardWriterSession="+userSessionsMap.get(realrecIdArr));
						log.info("boardWirterSession"+boardWriterSession);	// 얘한테 알림이 가야하는거임
						
						if ("buyPlan".equals(realsenType) && boardWriterSession != null) {
							log.info("onmessage되나?");
							String preRealTimeAlertTxt = message.getPayload();
							boardWriterSession.sendMessage(new TextMessage(preRealTimeAlertTxt));
						}
					}
				}
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {//연결 해제
		// TODO Auto-generated method stub
		log.info("Socket 끊음");
		sessions.remove(session);
		userSessionsMap.remove(currentUserName(session),session);
	}

	//세션 아이디 가져와서 리턴해주는 메소드
	private String currentUserName(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		MemberVO loginUser = (MemberVO)httpSession.get("sessionInfo");	// 세션정보 가져오기
		
		if(loginUser == null) {
			String mid = session.getId();
			return mid;
		}
		String mid = loginUser.getMemId();
		log.debug("mid : {}", mid);
		return mid;
		
	}
	
}

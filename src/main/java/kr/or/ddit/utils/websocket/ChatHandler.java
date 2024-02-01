package kr.or.ddit.utils.websocket;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.Condition;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.vo.ChatMembers;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
public class ChatHandler extends TextWebSocketHandler {

	// 전체 채팅
	private static List<WebSocketSession> chatSessionList = new ArrayList<WebSocketSession>();
	
	// 락 걸기
	private static final Lock lock = new ReentrantLock();

	// 1. 클라이언트 연결 이후에 실행되는 메소드
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("## 누군가 접속");
		
		chatSessionList.add(session);
		log.info("세션 정보 : {}", session.getAttributes());
		
		Map<String, Object> chatSessionMap = session.getAttributes();
		MemberVO chatMember = (MemberVO) chatSessionMap.get("sessionInfo");
		
		if(chatMember == null) { // 웹소켓 아이디를 가져옴
			log.info("웹소켓 아이디 : {}", session.getId());
		}else { // 로그인한 사용자 아이디를 가져옴
			log.info("로그인한 사용자 아이디 : {}", chatMember.getMemId());
		}
	}

	boolean flag = false;
	String chatUser = "";
	
	// 2. 클라이언트가 웹소켓 서버로 메시지를 전송했을 때 실행되는 메소드
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		Map<String, Object> chatMapSession = session.getAttributes();
		MemberVO chatMember = (MemberVO) chatMapSession.get("sessionInfo");
		
		// 로그인한 아이디와 클라이언트로부터 서버로 보낸 메시지를 받음
		log.info("아이디 "+chatMember.getMemId()+" 로 부터 이름이 "+chatMember.getMemName()+" 인 사람에게 메세지 '"+message.getPayload()+"' 받음");
		
		// 공통 변수 선언
		String preChatTxt = message.getPayload();
		String[] splitChatTxt = preChatTxt.split(",");
		
		String chatMessage = splitChatTxt[0].trim(); // 채팅 내용
		
		String chatCnt = splitChatTxt[1].trim(); // 채팅 횟수
		int intChatCnt = Integer.parseInt(chatCnt);
		String cntTxt = "<span class='myChatCnt' style='display:none;'>"+chatCnt+"</span>";
		
		log.info("채팅 내용 : {}", chatMessage);
		log.info("채팅한 횟수 : {} 회", chatCnt);
		
		String chatMemid = "";
		String chatMemName = "";
		String chatMemProfileimg = "";
		
		if(intChatCnt == 0) { // 입장/퇴장할 때
			for(WebSocketSession sess : chatSessionList) {
				sess.sendMessage(new TextMessage(chatMessage + "" + cntTxt));
			}
		}
		
		if(intChatCnt >= 1) { // 처음 채팅할 때
			chatMemid = splitChatTxt[2].trim(); // 채팅자 아이디
			if(splitChatTxt[2].equals("empty")) {
				chatMemid = "";
			}
			chatMemName = splitChatTxt[3].trim(); // 채팅자 이름
			if(splitChatTxt[3].equals("empty")) {
				chatMemName = "";
			}
			chatMemProfileimg = splitChatTxt[4].trim(); // 채팅자 프로필 사진 경로
			if(splitChatTxt[4].equals("empty")) {
				chatMemProfileimg = "";
			}
			
			ChatMembers chatmembers = new ChatMembers();
			chatmembers.setChatMemid(chatMemid);
			chatmembers.setChatMemName(chatMemName);
			chatmembers.setChatMessage(chatMessage);
			chatmembers.setChatMemProfileimg(chatMemProfileimg);
			
			// lock 획득
	        lock.lock();
	        try {
	        	// 동시에 실행하면 안되는 코드
	        	for(WebSocketSession sess : chatSessionList) {
	        		StringBuffer result = messageSetting(sess, intChatCnt, chatmembers);
	        		sess.sendMessage(new TextMessage(result));
	        	}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				// lock 해제
	            lock.unlock();
			}
			
			chatUser = chatmembers.getChatMemid();
		}
		
	}
	
	private StringBuffer messageSetting(WebSocketSession sess, int intChatCnt, ChatMembers chatmembers) {
		StringBuffer sb = new StringBuffer();
		
		if(!chatUser.equals(chatmembers.getChatMemid())) {
			flag = true;
			System.out.println("######################## 새로운 채팅 유저가 메세지 남김");
			intChatCnt = 1;
		}
		
		// 초기화된 카운트를 채팅에 담아서 보낸다. DB 저장용.
		String cntTxt = "<span class='myChatCnt' style='display:none;'>"+intChatCnt+"</span>";
		log.info("cntTxt : {}", cntTxt);
		
		String memIdTxt = "<span class='sendMemId' style='display: none;'>"+chatmembers.getChatMemid()+"</span>";
		
		String type = "outer";
		Map<String, Object> chatMembers = sess.getAttributes();
		MemberVO memberVO = (MemberVO) chatMembers.get("sessionInfo");
		if(chatmembers.getChatMemid().equals(memberVO.getMemId())) {
			type = "inner";
		}
		
		sb.append("<div class='"+type+"Talker'>");
		
		if(intChatCnt == 1) {
			sb.append("		<div class='"+type+"startDialogContBox'>");
			sb.append("			<div class='talkerImgBox'>");
			sb.append("				<img src='"+chatmembers.getChatMemProfileimg()+"' alt='상대방 프로필 사진' />");
			sb.append("			</div>");
			sb.append("			<div class='boxLeftRight'>");
			sb.append("				<div class='"+type+"Name'>");
			sb.append("					<span class='chatMemName'>"+chatmembers.getChatMemName()+"</span>");
			sb.append("					<span class='chatMemId' style='display: none;'>"+chatmembers.getChatMemid()+"</span>");
			sb.append("				</div>");
			sb.append("				<div class='"+type+"StartDialog'>");
			sb.append("					<p class='chatMsgTxt' style='display: inline-block; white-space: pre-wrap;'>"+chatmembers.getChatMessage()+"</p>");
			sb.append("					<div class='chatDateInfo'>");
			sb.append("						<div>");
			sb.append("							<span class='yymmdd'>"+getCurrentDate()+"</span>");
			sb.append("							<br />");
			sb.append("							<span class='hhmmss'>"+getCurrentTime()+"</span>");
			sb.append("						</div>");
			sb.append("					</div>");
			sb.append("				</div>");
			sb.append("			</div>");
			sb.append("		</div>");
		}
		if(intChatCnt > 1) {
			sb.append("		<div class='"+type+"LongtakeDialog'>");
			sb.append("			<div>");
			sb.append("				<p class='chatMsgTxt' style='display: inline-block; white-space: pre-wrap;'>"+chatmembers.getChatMessage()+"</p>");
			sb.append("				<div class='chatDateInfo'>");
			sb.append("					<div>");
			sb.append("						<span class='yymmdd'>"+getCurrentDate()+"</span>");
			sb.append("						<br />");
			sb.append("						<span class='hhmmss'>"+getCurrentTime()+"</span>");
			sb.append("					</div>");
			sb.append("				</div>");
			sb.append("			</div>");
			sb.append("		</div>");
		}
		
		sb.append(cntTxt);
		sb.append(memIdTxt);
		
		sb.append("</div>");
		
		return sb;
	}
	
	private String getCurrentDate() {
	    SimpleDateFormat dateFormat = new SimpleDateFormat("yy/MM/dd");

	    Date now = new Date();
	    String dateStr = dateFormat.format(now);

	    return dateStr;
	}
	
	private String getCurrentTime() {
		SimpleDateFormat timeFormat = new SimpleDateFormat("a hh:mm");
		
		Date now = new Date();
		String timeStr = timeFormat.format(now);
		
		return timeStr;
	}

	// 3. 클라이언트의 연결이 끊겼을 때 실행되는 메소드
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		chatSessionList.remove(session);
		
		Map<String, Object> chatMapSession = session.getAttributes();
		MemberVO chatMember = (MemberVO) chatMapSession.get("sessionInfo");
		String userId = chatMember.getMemId();
		
		log.info("## 누군가 퇴장");
		log.info("{} 연결 끊김", userId);
		log.info("채팅방 퇴장한 사람 : {}", userId);
		
	}

}

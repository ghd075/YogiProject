package kr.or.ddit.users.myplan.chatvo;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Chat {
	
	private int chatNo;				// 채팅번호(시퀀스), 기본키
	private int chatroomNo;			// 채팅방번호(시퀀스), 외래키
	private String memId;			// 회원아이디, 외래키
	private String chatContent;		// 채팅내용
	private String chatDate;		// 채팅날짜, sysdate
	private int chatNoreadCount;	// 채팅미확인수
	
	private String chatFiles;		// 임시 파일 이름값들
	
	private MultipartFile[] chatFile;			// 채팅파일
	private List<ChatAttach> chatAttachList;	// 채팅파일리스트
	
	public void setChatFile(MultipartFile[] chatFile) {
		this.chatFile = chatFile;
		if(chatFile != null) {
			List<ChatAttach> chatAttachList = new ArrayList<ChatAttach>();
			for(MultipartFile item : chatFile) {
				if(StringUtils.isBlank(item.getOriginalFilename())) {
					continue;
				}
				
				ChatAttach chatAttach = new ChatAttach(item);
				chatAttachList.add(chatAttach);
			}
			this.chatAttachList = chatAttachList;
		}
	}
	

	
}

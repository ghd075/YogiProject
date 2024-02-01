package kr.or.ddit.users.partner.vo;

import lombok.Data;

@Data
public class ChatroomVO {

	private int roomNo;
	private String roomRegdate;
	private int mgNo;
	
	/* 조인 용도 */
	// ChatVO
	private int chatNo;
	private String memId;
	private String chatFile;
	private String chatContent;
	private String chatYmd;
	private String chatHms;
	private String chatCnt;
	
}

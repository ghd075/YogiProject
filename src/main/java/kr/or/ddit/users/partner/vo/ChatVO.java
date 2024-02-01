package kr.or.ddit.users.partner.vo;

import lombok.Data;

@Data
public class ChatVO {

	private int chatNo;
	private String memId;
	private int roomNo;
	private String chatFile;
	private String chatContent;
	private String chatYmd;
	private String chatHms;
	private String chatCnt;
	
}

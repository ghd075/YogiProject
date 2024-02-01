package kr.or.ddit.users.partner.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class PlanerVO {
 
	private int plNo;
	private String memId;
	private String plRdate;
	private String plTitle;
	private String plMsize;
	private String plPrivate;
	private String plTheme;
	private String plThumburl;
	
	/* 조인 용도 */
	// MemberVO
	private int memNo;
	private String memPw;
	private String memName;
	private String memGender;
	private String memEmail;
	private String memPhone;
	private String memPostcode;
	private String memAddress1;
	private String memAddress2;
	private String gradeCode;
	private String enabled;
	private int memCategory;
	private String memRegdate;
	private String memAgedate;
	
	private MultipartFile imgFile;
	private String memProfileimg;
	
	// mategroupVO
	private int mgNo;
	private String mategroupRecruiter;
	private int mategroupCurrentnum;
	private String mategroupStatus;
	private int mategroupPoint;
	
	// mategroupMemberVO
	private int mategroupNo;
	private String mategroupId;
	private int mategroupAgree;
	private String mategroupApply;
	
	// ChatroomVO
	private int roomNo;
	private String roomRegdate;
	
	// ChatVO
	private int chatNo;
	private String chatFile;
	private String chatContent;
	private String chatYmd;
	private String chatHms;
	private String chatCnt;
	
	// 내플랜 - 그룹장
	// 동행참가 - 참여자
	private String sType;
	
}

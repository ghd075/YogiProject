package kr.or.ddit.users.login.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class MemberVO {

	private int memNo;
	private String memId;
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
	
}

package kr.or.ddit.vo;

import lombok.Data;

@Data
public class RealTimeSenderVO {

	private int realsenNo;
	private String realsenId;
	private String realsenName;
	private String realsenTitle;
	private String realsenContent;
	private String realsenType;
	private String realsenUrl;
	private String realsenPfimg;
	
	private String[] realrecIdArr;
	
	// 참조 테이블
	// realTimeReceiverVO
	private int realrecNo;
	private String realrecId;
	private String realsenReadyn;
	
}

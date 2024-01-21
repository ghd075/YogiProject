package kr.or.ddit.users.myplan.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class JourneyinfoVO {

	private int infoNo;
	private String infoName;
	private String infoEngname;
	private String infoDescription;
	private String infoFlightyn;
	private String infoFlight;
	private String infoFlighttime;
	private String infoVisayn;
	private String infoVisaexp;
	private String infoVisatime;
	private String infoVoltage;
	private String infoTimedifer;
	private String infoRegdate;
	
	private MultipartFile imgFile;
	private String infoPreviewimg;
	
}

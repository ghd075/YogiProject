package kr.or.ddit.users.reserve.air.vo;
import lombok.Data;

/* 항공편 최초 검색 시 담을 정보*/
@Data
public class FlightVO {
	private String flightCode;
	private String airlineCode;
	private String airlineName;
	private String flightDepairport;
	private String flightDepportcode;
	private String flightDeptime = "";
	private String flightArrairport;
	private String flightArrportcode;
	private String flightArrtime = "";
	private String flightDuration;
	private int flightEconomyprice;
	private int flightBusinessprice;
	private int flightFirstclassprice;
	
	//탑승관련
	private int yuaCnt;
	private int soaCnt;
	private int adultCnt;
	private int totalCnt;
	private String seatClass;
	
	//출발편or돌아오는편 구분값
	private String flightType;
	
	//현재 조회 항공편 수
	private int numOfRecord = 4; 
	private int totalRecord; 
	
	
	//출발시간 문자열로 받기
	public void setFlightDeptime(String flightDeptime) {
	  String[] depTimeArr =	flightDeptime.split(" ")[0].split("-");
	  for (String depTime : depTimeArr) {
		this.flightDeptime += depTime;
	  }
	}
	
	//도착시간 문자열로 받기
	public void setFlightArrtime(String flightArrtime) {
		String[] arrTimeArr = flightArrtime.split(" ")[0].split("-");
		for (String arrTime : arrTimeArr) {
			this.flightArrtime += arrTime;
		}
	}
	
	
}








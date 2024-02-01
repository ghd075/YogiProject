package kr.or.ddit.users.reserve.air.vo;
import lombok.Data;

@Data
public class SearchVO {
	
	private String flightCode;
	private String airlineCode;
	private String airlineName;
	private String flightDepairport;
	private String flightDepportcode;
	private String flightDeptime;
	private String flightArrairport;
	private String flightArrportcode;
	private String flightArrtime;
	private String flightDuration;
	private int flightEconomyprice;
	private int flightBusinessprice;
	private int flightFirstclassprice;
	
	private String airlineLogo;  //항공사 로고 경로
	
	//공항 풀네임
	private String depAirportFullname;
	private String arrAirportFullname;
	
	
	
}

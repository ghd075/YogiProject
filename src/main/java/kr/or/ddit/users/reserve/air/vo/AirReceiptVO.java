package kr.or.ddit.users.reserve.air.vo;
import lombok.Data;

/* 항공권 티켓 및 영수증 정보를 담는 VO*/
@Data
public class AirReceiptVO {

	private String airReserveno;
	private String ticketFirstname;
	private String ticketName;
	private String ticketCode;
	private String ticketClass;
	private int ticketTotalprice;
	private int ticketAircharge;
	private int ticketFuelsurcharge;
	private int ticketTax;
	private int ticketCommission;
	private String ticketStatus;
	private String flightCode;
	private String flightDepairport;
	private String flightDepportcode;
	private String flightDeptime;
	private String flightArrairport;
	private String flightArrportcode;
	private String flightArrtime;
	private String airlineCode;
	private String airlineName;
	
}

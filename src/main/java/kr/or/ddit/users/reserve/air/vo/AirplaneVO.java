package kr.or.ddit.users.reserve.air.vo;
import lombok.Data;

/* 항공 좌석정보 */
@Data
public class AirplaneVO {

	private String flightCode;
	private String airlineCode;
	private String airplaneName;
	private int airplaneTotalfirst;
	private int airplaneRemainfirst;
	private int airplaneTotalbusiness;
	private int airplaneRemainbusiness;
	private int airplaneTotaleconomy;
	private int airplaneRemaineconomy;
}

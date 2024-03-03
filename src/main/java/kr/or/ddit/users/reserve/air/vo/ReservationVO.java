package kr.or.ddit.users.reserve.air.vo;
import java.util.List;

import lombok.Data;

/* 항공권 예매 정보 */
@Data
public class ReservationVO {
	
	private String airReserveno;  //RE-0000-항공편4자리
	private String memId;
	private String airReservetel;
	private String airReserveemail;
	private int airTotalprice;
	private String airPayday;
	private int airPersonnum;
	private int plNo;
	
	private List<TicketVO> ticketList;
	
	private String tripType;  //왕복,편도 구분
}

package kr.or.ddit.users.reserve.air.vo;
import lombok.Data;

/* 항공권 정보 */
@Data
public class TicketVO implements Cloneable{

	private String flightCode;
	private String ticketSeatnum;
	private String ticketCode;
	private String ticketType;
	private String ticketClass;
	
	private int ticketTotalprice;
	private int ticketAircharge;
	private int ticketFuelsurcharge;
	private int ticketTax;
	private int ticketCommission;
	private String ticketStatus;
	
	private String ticketFirstname;
	private String ticketName;
	private String ticketPassenage;
	private String ticketPassengender;
	private String ticketDayofbirth;
	private String ticketNationality;
	
	private String airReserveno;
	
	private String ageCnt;
	
	//TicketVO복사 재정의 
	@Override
	protected TicketVO clone() throws CloneNotSupportedException {
		/*
		 clone() 
		  - 현재 객체의 복사본이 생성되어 반환
		  - 객체의 얕은 복사를 수행 -> 객체의 필드 중 기본 타입이거나 불변인 객체타입의 필드정보는 복사된다 
		 */
		TicketVO cloned = (TicketVO) super.clone();
		return cloned;
	}
	
	public TicketVO getClonedTicket() {
		TicketVO ticketVO = null;
		try {
			ticketVO = clone();
		} catch (CloneNotSupportedException e) {
			e.printStackTrace();
		}
		return ticketVO;
	}
}

























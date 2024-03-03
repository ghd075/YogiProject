package kr.or.ddit.users.reserve.stay.vo;
import lombok.Data;


@Data
public class AccommodationVO {

	private String title;
	private String roomName;
	private String totalPrice;
	private int priceNum;
	private int personNum;
	private String checkIn;
	private String checkOut;
	private String type;
	private String period;
	private String picture;
	
	
}

package kr.or.ddit.users.reserve.cart.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

/*장바구니 - 항공편 상품*/
@Data
@ToString
public class CartAirVO {
	
	private String depFlight;
	private String returnFlight;
	private String cartairType;
	private String cartNo;
	private String cartairStatus;
	
	private int cartairTotalprice;
	private int cartairCnt;
	
	public CartAirVO() {}
	
	public CartAirVO(String depFlightCode, String arrFlightCode, String cartNo) {
		this.depFlight = depFlightCode;
		this.returnFlight = arrFlightCode;
		this.cartNo = cartNo;
	}

	public CartAirVO(String depFlight, String returnFlight, 
			            String cartairType, String cartNo,
			            int cartairTotalprice, int cartairCnt) {
		this.depFlight = depFlight;
		this.returnFlight = returnFlight;
		this.cartairType = cartairType;
		this.cartNo = cartNo;
		this.cartairTotalprice = cartairTotalprice;
		this.cartairCnt = cartairCnt;
	}
	
	
	
}

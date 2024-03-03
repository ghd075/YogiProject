package kr.or.ddit.users.reserve.cart.vo;
import java.util.List;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/*장바구니*/
@Data
public class CartVO {
	private String cartNo;
	private String cartType;
	private long plNo;
	private String memId;
	private String cartRegdate;
	
	List<CartAirVO> airList;
}

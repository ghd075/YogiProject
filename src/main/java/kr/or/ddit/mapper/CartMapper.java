package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.cart.vo.CartAirVO;
import kr.or.ddit.users.reserve.cart.vo.CartVO;

public interface CartMapper {

	public String checkCart(long plNo);

	public int insertCart(CartVO cartVO);

	public int insertFlightInCart(CartAirVO cartAirVO);

	public CartAirVO checkFlightInCart(CartAirVO cartAirVO);

	public List<CartAirVO> selectAllAirCart(long plNo);

	public int deleteFlightInCart(Map<String, String> cartMap);

	public int updateCartAirStatus(Map<String, Object> cartMap);

}

package kr.or.ddit.users.reserve.cart.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.utils.ServiceResult;

public interface CartService {

	public String checkAndMakeCart(long plNo, HttpSession session);

	public ServiceResult checkAndInsertAircart(String cartNo, String depFlightCode, String arrFlightCode, int totalPrice, int totalPassenger);

	public List<RoundTripVO> selectAllAirCart(long plNo);

	public ServiceResult deleteFlightInCart(Map<String, String> cartMap);

}

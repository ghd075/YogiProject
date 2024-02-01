package kr.or.ddit.users.reserve.air.service;

import java.util.Map;

import kr.or.ddit.users.reserve.air.vo.AirplaneVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;

public interface AirReserveService {

	public RoundTripVO selectRoundTripFlight(String depFlightCode, String arrFlightCode);

	public Map<String, AirplaneVO> selectAirplane(String depCode, String returnCode);

	public Map<String, String[]> selectSeats(String depCode, String returnCode);

}

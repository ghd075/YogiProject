package kr.or.ddit.mapper;

import kr.or.ddit.users.reserve.air.vo.AirplaneVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;

public interface AirReserveMapper {

	//가는편, 오는편 한개의 항공편 조회
	public SearchVO selectRoundTripFlight(String flightCode);

	//가는편, 오는편 한개의 항공기 좌석현황 조회
	public AirplaneVO selectAirplane(String flightCode);

	//가는편, 오는편 한개의 항공기 좌석상세 조회
	public String[] selectSeats(String flightCode);

}

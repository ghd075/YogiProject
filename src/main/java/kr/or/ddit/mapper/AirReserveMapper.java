package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.users.reserve.air.vo.AirplaneVO;
import kr.or.ddit.users.reserve.air.vo.ReservationVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;
import kr.or.ddit.users.reserve.air.vo.TicketVO;

public interface AirReserveMapper {

	//가는편,오는편 한개의 항공편 조회
	public SearchVO selectRoundTripFlight(String flightCode);

	//가는편,오는편 한개의 항공기 좌석현황 조회
	public AirplaneVO selectAirplane(String flightCode);

	//가는편,오는편 한개의 항공기 좌석상세 조회
	public String[] selectSeats(String flightCode);

	//개인포인트 조회
	public int selectPrivatePoint(String memId);

	//그룹포인트 조회
	public List<PlanerVO> selectGroupPoint(String memId);

	//예약정보 insert
	public int insertAirReservation(ReservationVO reVO);

	//티켓 insert
	public int insertAirTicket(TicketVO ticket);

	//남은좌석 update
	public void updateRemainSeat(TicketVO ticketVO);

	//남은좌석 조회
	public int selectRemainSeat(TicketVO ticket);

	//그룹포인트 업데이트
	public int updateGroupPoint(Map<String, Integer> pointMap);

}

package kr.or.ddit.users.reserve.air.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.reserve.air.vo.AirplaneVO;
import kr.or.ddit.users.reserve.air.vo.ReservationVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;
import kr.or.ddit.users.reserve.air.vo.TicketVO;
import kr.or.ddit.utils.ServiceResult;

public interface AirReserveService {

	public RoundTripVO selectRoundTripFlight(String depFlightCode, String arrFlightCode);

	public Map<String, AirplaneVO> selectAirplane(String depCode, String returnCode);

	public Map<String, String[]> selectSeats(String depCode, String returnCode);

	public ServiceResult setSeat(List<TicketVO> ticketList, String ticketType, String ageCnt, String ticketSeatnum);

	public void setaAirFare(ReservationVO reVO, RoundTripVO roundTripVO, String seatClass);

	public Map<String, Object> selectPoint(String memId);

	public ServiceResult processPayment(ReservationVO reVO, int totalPrice, int finalRemain, int planerNo);

}

package kr.or.ddit.users.reserve.air.service;
import java.util.List;

import javax.servlet.http.HttpSession;

import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SortVO;
import kr.or.ddit.utils.ServiceResult;

public interface AirSearchService {
	
	public SortVO getSortVO();

	public List<RoundTripVO> selectAllRoundTripFlight(FlightVO flightVO, HttpSession session);



}

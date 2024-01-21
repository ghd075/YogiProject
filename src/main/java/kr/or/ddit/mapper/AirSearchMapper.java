package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;
import kr.or.ddit.utils.ServiceResult;

public interface AirSearchMapper {

	public List<SearchVO> selectAllRoundTripFlight(FlightVO flightVO);

}

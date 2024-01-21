package kr.or.ddit.users.reserve.air.service;

import java.util.List;

import kr.or.ddit.users.reserve.air.utils.api.AirApiVO;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.utils.ServiceResult;

public interface AirApiService {

	public boolean checkFlightCode(String flightCode);

	public ServiceResult makeDummy(FlightVO flightVO);

	public ServiceResult insertOne(FlightVO flightVO);
}

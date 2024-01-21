package kr.or.ddit.mapper;

import kr.or.ddit.users.reserve.air.vo.FlightVO;

public interface AirApiMapper {

	public int dummyInsert(FlightVO vo);

	public int checkFlightCode(String flightCode);

	public int insertOne(FlightVO flightVO);

}

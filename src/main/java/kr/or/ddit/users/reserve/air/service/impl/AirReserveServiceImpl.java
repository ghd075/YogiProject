package kr.or.ddit.users.reserve.air.service.impl;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.AirReserveMapper;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import kr.or.ddit.users.reserve.air.utils.api.AirApiVoMapper;
import kr.or.ddit.users.reserve.air.vo.AirplaneVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AirReserveServiceImpl implements AirReserveService{

	@Inject
	private AirReserveMapper reserveMapper;
	
	/* 예약페이지 진입 시 선택한 항공편 정보를 제공하는 기능 */
	@Override
	public RoundTripVO selectRoundTripFlight(String depFlightCode, String arrFlightCode) {
		RoundTripVO roundTripVO;
		
		//1.가는편 조회
		SearchVO depFlight = reserveMapper.selectRoundTripFlight(depFlightCode);
		if(depFlight == null) {
			log.debug("가는편 조회 실패");
			return null;
		}
		//가는편 공항 풀네임설정
		AirApiVoMapper.setDepAirportFullname(depFlight, depFlight.getFlightDepairport()); 
		AirApiVoMapper.setArrAirportFullname(depFlight, depFlight.getFlightArrairport());
		//항공사 로고 설정
		AirApiVoMapper.setAirlineLogoURL(depFlight.getAirlineName(), depFlight);
		
		//2.오는편 조회
		SearchVO returnFlight = reserveMapper.selectRoundTripFlight(arrFlightCode);
		if(returnFlight == null) {
			log.debug("오는편 조회 실패");
			return null;
		}
		//오는편 공항 풀네임설정
		AirApiVoMapper.setDepAirportFullname(returnFlight, returnFlight.getFlightDepairport());
		AirApiVoMapper.setArrAirportFullname(returnFlight, returnFlight.getFlightArrairport());
		//항공사 로고 설정
		AirApiVoMapper.setAirlineLogoURL(returnFlight.getAirlineName(), returnFlight);
		
		roundTripVO = new RoundTripVO();
		roundTripVO.setDeparture(depFlight);
		roundTripVO.setArrival(returnFlight);
		
		return roundTripVO;
	}

    /* 두번째 예약페이지의 항공기 정보 및 좌석전체현황 데이터 조회 */
	@Override
	public Map<String, AirplaneVO> selectAirplane(String depCode, String returnCode) {
		Map<String, AirplaneVO> roundMap = null;
		//가는편
		AirplaneVO depAirplane = reserveMapper.selectAirplane(depCode);
		if(depAirplane == null) {
			log.debug("가는편 좌석정보가 조회되지 않습니다!");
			return null;
		}
		roundMap = new HashMap<String, AirplaneVO>();
		roundMap.put("departure", depAirplane);
		
		//오는편
		AirplaneVO returnAirplane = reserveMapper.selectAirplane(returnCode);
		if(returnAirplane == null) {
			log.debug("오는편 좌석정보가 조회되지 않습니다!");
			return null;
		}
		roundMap.put("return", returnAirplane);
		
		return roundMap;
	}

    /* 두번째 예약페이지의 좌석 상세정보 데이터 조회 */
	@Override
	public Map<String, String[]> selectSeats(String depCode, String returnCode) {
		Map<String, String[]> seatMap = null;
		//가는편
		String[] depSeat = reserveMapper.selectSeats(depCode);
		if(depSeat == null) {
			log.debug("가는편 좌석정보가 조회되지 않습니다!");
			return null;
		}
		seatMap = new HashMap<String, String[]>();
		seatMap.put("depSeat", depSeat);
		
		//오는편
		String[] returnSeat = reserveMapper.selectSeats(returnCode);
		if(returnSeat == null) {
			log.debug("오는편 좌석정보가 조회되지 않습니다!");
			return null;
		}
		seatMap.put("returnSeat", returnSeat);
		
		return seatMap;
	}




	
}
















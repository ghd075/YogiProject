package kr.or.ddit.users.reserve.air.service.impl;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.AirReserveMapper;
import kr.or.ddit.mapper.CartMapper;
import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import kr.or.ddit.users.reserve.air.utils.api.AirApiVoMapper;
import kr.or.ddit.users.reserve.air.vo.AirplaneVO;
import kr.or.ddit.users.reserve.air.vo.ReservationVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;
import kr.or.ddit.users.reserve.air.vo.TicketVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Transactional
@Slf4j
@Service
public class AirReserveServiceImpl implements AirReserveService{

	@Inject
	private AirReserveMapper reserveMapper;
	
	@Inject
	private CartMapper cartMapper;
	
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

	/* 선택한 좌석번호를 설정하는 작업 */
	@Override
	public ServiceResult setSeat(List<TicketVO> ticketList, String ticketType, String ageCnt, String ticketSeatnum) {
		String[] typeArr = ticketType.split(",");
		String[] ageArr = ageCnt.split(",");
		String[] SeatNumArr = ticketSeatnum.split(",");
		int arrSize = typeArr.length;
		
		for(int i = 0; i < ticketList.size(); i++) {
			TicketVO vo = ticketList.get(i);
		  for(int j = 0; j < arrSize; j++) {
			 if(vo.getTicketType().equals(typeArr[j]) && vo.getAgeCnt().equals(ageArr[j])){
				vo.setTicketSeatnum(SeatNumArr[j]); 
				log.debug(i+"번째 ticketList : "+vo);
				break;
			 }
		  }
		}
		return ServiceResult.OK;
	}

	
	/* 상세가격정보를 설정하는 작업 */
	@Override
	public void setaAirFare(ReservationVO reVO, RoundTripVO roundTripVO, String seatClass) {
		List<TicketVO> ticketList = reVO.getTicketList();
		SearchVO depFlight = roundTripVO.getDeparture();
		SearchVO arrFlight = roundTripVO.getArrival();
		
        for (TicketVO ticket : ticketList) {
		  if(ticket.getTicketType().equals("DAPARTURE")) {
			switch(seatClass) {   //1.출발편 총 금액 설정
			  case "economy" : ticket.setTicketTotalprice(depFlight.getFlightEconomyprice()); break;
			  case "business" : ticket.setTicketTotalprice(depFlight.getFlightBusinessprice()); break;
			  case "firstClass" : ticket.setTicketTotalprice(depFlight.getFlightFirstclassprice()); break;
			  default : break;
			}
			//2.출발편 상세금액 비율별 책정
			int total = ticket.getTicketTotalprice();
			int airCharge =  (int) (total * 0.73);
			int fuelSurcharge =  (int) (total * 0.18);
			int tax =  (int) (total * 0.06);
			int commission =  (int) (total * 0.03);
			int tempTotal = airCharge + fuelSurcharge + tax + commission;
			
			ticket.setTicketFuelsurcharge(fuelSurcharge);
			ticket.setTicketTax(tax);
			ticket.setTicketCommission(commission);
			
			//3.금액 책정 시 금액이 넘거나 남을경우 예외처리
			if(total > tempTotal) {
			   int remain = total - tempTotal;
			   ticket.setTicketAircharge(airCharge + remain);
			}else if(total < tempTotal) {
			   int remain = tempTotal - total;
			   ticket.setTicketAircharge(airCharge - remain);
			}else {
			   ticket.setTicketAircharge(airCharge);
			}
		  }
		  if(ticket.getTicketType().equals("RETURN")) {
			switch(seatClass) {   //1.가는편 총 금액 설정
			  case "economy" : ticket.setTicketTotalprice(arrFlight.getFlightEconomyprice()); break;
			  case "business" : ticket.setTicketTotalprice(arrFlight.getFlightBusinessprice()); break;
			  case "firstClass" : ticket.setTicketTotalprice(arrFlight.getFlightFirstclassprice()); break;
			  default : break;
			}
			//2.오는편 상세금액 비율별 책정
			int total = ticket.getTicketTotalprice();
			int airCharge =  (int) (total * 0.73);
			int fuelSurcharge =  (int) (total * 0.18);
			int tax =  (int) (total * 0.06);
			int commission =  (int) (total * 0.03);
			int tempTotal = airCharge + fuelSurcharge + tax + commission;
			
			ticket.setTicketFuelsurcharge(fuelSurcharge);
			ticket.setTicketTax(tax);
			ticket.setTicketCommission(commission);
			
			//3.금액 책정 시 금액이 넘거나 남을경우 예외처리
			if(total > tempTotal) {
			   int remain = total - tempTotal;
			   ticket.setTicketAircharge(airCharge + remain);
			}else if(total < tempTotal) {
			   int remain = tempTotal - total;
			   ticket.setTicketAircharge(airCharge - remain);
			}else {
			   ticket.setTicketAircharge(airCharge);
			}
		  }
		  System.out.println("ticket : "+ticket);
		}
		
	}

	/* 사용 가능한 포인트 정보 조회 */
	@Override
	public Map<String, Object> selectPoint(String memId) {
		Map<String, Object> pointMap = new HashMap<String, Object>();
		List<PlanerVO> planerList = null;
		//1.개인포인트 조회
		int privPoint = reserveMapper.selectPrivatePoint(memId);
		pointMap.put("privPoint", privPoint);
		
		//2.그룹포인트 조회
		planerList = reserveMapper.selectGroupPoint(memId);
		if(planerList == null || planerList.size() == 0) {
			log.debug("조회된 그룹포인트가 없습니다.");
		}
		pointMap.put("groupList", planerList);
		
		return pointMap;
	}
	

	/* 항공 티켓 결제 처리 */
	@Override
	public ServiceResult processPayment(ReservationVO reVO, int totalPrice, int finalRemain, int planerNo) {
		//1.예약 정보 세팅
		reVO.setAirTotalprice(totalPrice);  //총 결제금액 설정
		int ran =	(int) (Math.random() * 99999) + 1;
		String airReserveno = "RE-" + new DecimalFormat("00000").format(ran);  
		reVO.setAirReserveno(airReserveno);  //예약번호 설정
		reVO.setPlNo(planerNo);              //플랜번호 설정
		
		//2.예약정보 insert
		int status = reserveMapper.insertAirReservation(reVO);
		if(status <= 0) {
			log.debug("예약정보 insert실패!");
		}
		
		//3.티켓정보 세팅
		List<TicketVO> ticketList = reVO.getTicketList();
		for (TicketVO ticket : ticketList) {
			int ranNum =	(int) (Math.random() * 9999) + 1;
			String number = new DecimalFormat("0000").format(ranNum);	
			String ticketCode = ticket.getFlightCode().substring(0, 3) + "-" + ticket.getTicketSeatnum() + number;
			ticket.setTicketCode(ticketCode);       //티켓번호
			ticket.setTicketStatus("Y");            //예매상태
			ticket.setAirReserveno(airReserveno);   //티켓의 예약번호
			
			//4.구매한 티켓 insert
			int res = reserveMapper.insertAirTicket(ticket);
			if(res <= 0) {
				log.debug("티켓정보 insert실패!");
			}
		}
		
		//5.남은좌석 확인 후 업데이트 처리
		String depFlightCode = null;
		for (TicketVO ticket : ticketList) {     //가는편 좌석
		  if(ticket.getTicketType().equals("DAPARTURE")) {  
			  depFlightCode = ticket.getFlightCode();
			  int remainNum = reserveMapper.selectRemainSeat(ticket);  //남은좌석 확인
			  System.out.println("가는편 남은좌석  : "+remainNum);
			  if((remainNum - reVO.getAirPersonnum()) < 0) {     //예약하려는 좌석보다 남은좌석이 더 적은 경우
				  log.debug("남은좌석이 없습니다");
				  return ServiceResult.FAILED;
			  }
			  ticket.setPersonNum(reVO.getAirPersonnum());
			  reserveMapper.updateRemainSeat(ticket);  //남은좌석 업데이트
			  break;
		  }
		}
		
		String retFlightCode = null;
		for (TicketVO ticket : ticketList) {      //오는편 좌석
			if(ticket.getTicketType().equals("RETURN")) {  
				retFlightCode = ticket.getFlightCode();
				int remainNum = reserveMapper.selectRemainSeat(ticket);  //남은좌석 확인
			   System.out.println("오는편 남은좌석  : "+remainNum);
			   if((remainNum - reVO.getAirPersonnum()) < 0) {     //예약하려는 좌석보다 남은좌석이 더 적은 경우
				  log.debug("남은좌석이 없습니다");
				  return ServiceResult.FAILED;
			   }
			   ticket.setPersonNum(reVO.getAirPersonnum());
			   reserveMapper.updateRemainSeat(ticket);  //남은좌석 업데이트
			   break;
			}
		}
		
        //6.남은 포인트 업데이트 처리(단위작업)
		Map<String, Integer> pointMap = new HashMap<String, Integer>();
		pointMap.put("planerNo", planerNo);
		pointMap.put("finalRemain", finalRemain);
		int pointStatus = reserveMapper.updateGroupPoint(pointMap);
		if(pointStatus < 0) {
			log.debug("포인트 갱신(update)에 실패하였습니다");
			return ServiceResult.FAILED;
		}
		
		//7.장바구니 번호 검색
		String cartNo = cartMapper.checkCart(planerNo);
		
		//8.항공상품 결제상태 업데이트
		Map<String, Object> cartMap = new HashMap<String, Object>();
		cartMap.put("cartNo", cartNo);
		cartMap.put("depFlightCode", depFlightCode);
		cartMap.put("retFlightCode", retFlightCode);
		int cartStatus = cartMapper.updateCartAirStatus(cartMap);
		if(cartStatus < 0 ) {
			log.debug("장바구니의 항공권 결제상태 업데이트 실패!");
			return ServiceResult.FAILED;
		}
		return ServiceResult.OK;
	}





	
}
















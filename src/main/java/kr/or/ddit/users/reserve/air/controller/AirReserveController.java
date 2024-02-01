package kr.or.ddit.users.reserve.air.controller;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import kr.or.ddit.users.reserve.air.vo.AirplaneVO;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.ReservationVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;
import kr.or.ddit.users.reserve.air.vo.TicketVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve/air/reserve")
public class AirReserveController {

	@Inject
	private AirReserveService reserveService;
	
	/* 예약 첫번째 페이지(탑승객 정보 입력) */
	@RequestMapping(value = "/reserve.do", method = RequestMethod.GET)
	public String reserve(String depFlightCode, String arrFlightCode,
			              HttpSession session, Model model, RedirectAttributes ra) {
		
		//1.항공편 정보 조회
		RoundTripVO roundTripVO = reserveService.selectRoundTripFlight(depFlightCode, arrFlightCode);
		if(roundTripVO == null) {
		  log.debug("항공편이 조회되지 않습니다.");
		  ra.addFlashAttribute("message", "해당항공편이 존재하지 않습니다(서버에러)");
		  return "redirect:/reserve/air/search/form.do";
		}
		model.addAttribute("roundTripVO", roundTripVO);
		session.setAttribute("myRoundTrip", roundTripVO);  //선택한 왕복항공편 정보 기억
		
		//2.여행객 수 가져오기
		FlightVO flightVO = (FlightVO) session.getAttribute("searchInfo");
		if(flightVO == null) {
			log.debug("검색조건이 저장되지 않았습니다.");
			ra.addFlashAttribute("message", "해당 검색조건이 저장되지 않았습니다(서버에러)");
			return "redirect:/reserve/air/search/form.do";
		}
		model.addAttribute("passenger", flightVO);
		
		return "reserve/air/reserve";
	}
	
	/* 예약 두번째 페이지(좌석선택) */
	@RequestMapping(value = "/seat.do", method = RequestMethod.POST)
	public String selectSeat(ReservationVO reVO, HttpSession session, Model model, RedirectAttributes ra) {
		FlightVO flightVO = (FlightVO) session.getAttribute("searchInfo");  //처음 검색정보 가져오기
		RoundTripVO roundTripVO = (RoundTripVO) session.getAttribute("myRoundTrip"); //선택한 왕복항공편정보 가져오기
		
		//1.티켓 기본정보 생성
		List<TicketVO> newTicketList = new ArrayList<TicketVO>();
		if(reVO.getTripType().equals("round-trip")) {  //왕복인 경우
		  for(TicketVO ticket : reVO.getTicketList()) {
			  TicketVO cloned = ticket.getClonedTicket();
			  //1-1.가는편 티켓 정보 설정
			  ticket.setFlightCode(roundTripVO.getDeparture().getFlightCode());  //출발편 코드 설정
			  ticket.setTicketType("DAPARTURE");               //티켓타입:출발편 설정
			  ticket.setTicketClass(flightVO.getSeatClass());  //좌석등급 설정
			  newTicketList.add(ticket);
			  
			  //1-2.오는편 티켓 정보 설정
			  cloned.setFlightCode(roundTripVO.getArrival().getFlightCode());  //오는편 코드 설정
			  cloned.setTicketType("RETURN");               //티켓타입:오는편 설정
			  cloned.setTicketClass(flightVO.getSeatClass());  //좌석등급 설정
			  newTicketList.add(cloned);
		  }
		  reVO.setTicketList(newTicketList);
		}
		
		//2.생성된 티켓정보 기억
		session.setAttribute("myReservation", reVO);
		
		//3.좌석 전체현황 조회
		Map<String, AirplaneVO> roundMap = reserveService.selectAirplane(roundTripVO.getDeparture().getFlightCode(), roundTripVO.getArrival().getFlightCode());
		if(roundMap == null) {
			ra.addFlashAttribute("message", "(서버에러)좌석정보가 조회되지 않습니다!");
			return "redirect:/reserve/air/search/form.do";
		}
		model.addAttribute("departure", roundMap.get("departure"));
		model.addAttribute("airReturn", roundMap.get("return"));
		
		//4.좌석 상세정보 조회
		Map<String, String[]> seatMap = reserveService.selectSeats(roundTripVO.getDeparture().getFlightCode(), roundTripVO.getArrival().getFlightCode());
		if(seatMap == null) {
			ra.addFlashAttribute("message", "(서버에러)상세좌석정보가 조회되지 않습니다!");
			return "redirect:/reserve/air/search/form.do";
		}
		System.out.println("depSeat : "+Arrays.toString(seatMap.get("depSeat")));
		System.out.println("returnSeat : "+Arrays.toString(seatMap.get("returnSeat")));
		model.addAttribute("reservedSeats", seatMap);
		
		return "reserve/air/seat";
	}
	
	
	@RequestMapping(value = "/payment.do", method = RequestMethod.POST)
	public String ticketPayment(ReservationVO reVO) {
		
		
		return "reserve/air/payment";
	}
}



































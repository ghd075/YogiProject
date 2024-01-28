package kr.or.ddit.users.reserve.air.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve/air/reserve")
public class AirReserveController {

	@RequestMapping(value = "/reserve.do", method = RequestMethod.GET)
	public String reserve(String depFlightCode, String arrFlightCode) {
		log.debug("reserve() 진입!");
		log.debug("depFlightCode : "+depFlightCode);
		log.debug("arrFlightCode : "+arrFlightCode);
		return "reserve/air/reserve";
	}
}

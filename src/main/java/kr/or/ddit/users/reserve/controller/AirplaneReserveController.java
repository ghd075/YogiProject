package kr.or.ddit.users.reserve.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve")
public class AirplaneReserveController {

	@RequestMapping(value = "/airplane.do", method = RequestMethod.GET)
	public String airplane() {
		return "reserve/airplane";
	}
	
}

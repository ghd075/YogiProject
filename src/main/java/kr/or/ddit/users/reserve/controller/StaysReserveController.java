package kr.or.ddit.users.reserve.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve")
public class StaysReserveController {

	@RequestMapping(value = "/stays.do", method = RequestMethod.GET)
	public String stays() {
		return "reserve/stays";
	}
	
}

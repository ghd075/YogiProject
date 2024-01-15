package kr.or.ddit.users.partner.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/partner")
public class HistoryPartnerController {

	@RequestMapping(value = "/history.do", method = RequestMethod.GET)
	public String history() {
		return "partner/history";
	}
	
}

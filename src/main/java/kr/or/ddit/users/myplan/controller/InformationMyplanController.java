package kr.or.ddit.users.myplan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myplan")
public class InformationMyplanController {

	@RequestMapping(value = "/info.do", method = RequestMethod.GET)
	public String information() {
		return "myplan/information";
	}
	
}
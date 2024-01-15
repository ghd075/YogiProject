package kr.or.ddit.users.myplan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.utils.DateUtils;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myplan")
public class MakeMyPlanController {

	@RequestMapping(value = "/makeplan.do", method = RequestMethod.GET)
	public String makeplan(Model model) {
		/** 자료수집 및 정의 */ 
		String formattedDate = DateUtils.getCurrentFormattedDate();
		
		/** 서비스 호출 */ 
		
		/** 반환자료 */ 
		
		/** 자료검증 */
		
		/** 자료반환 */ 
		model.addAttribute("formattedDate", formattedDate);
		
		
		return "myplan/makeplan";
	}
	
}

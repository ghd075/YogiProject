package kr.or.ddit.users.myplan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myplan")
public class ChattingTestController {

	@RequestMapping(value = "/chatting.do", method = RequestMethod.GET)
	public String chatting(Model model) {
		
//		log.debug("여기까진 왔냐");
//		
//		List<PlanerVO> bestPlanList = plannerService.getBestPlansList();
//		List<PlanerVO> plansForAreaList = plannerService.getPlansForArea(0);
//
//		log.debug("bestPlanList : {}", bestPlanList.toString());
//		log.debug("plansForAreaList : {}", plansForAreaList.toString());
//		
//		model.addAttribute("bestPlanList", bestPlanList);
//		model.addAttribute("plansForAreaList", plansForAreaList);
//		
		return "myplan/chattingTest";
	}
	
}

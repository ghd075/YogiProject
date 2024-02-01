package kr.or.ddit.users.partner.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.service.PlannerDetailService;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.partner.service.BuyPlanService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/partner")
public class BuyPlanController {
	
	@Inject
	private BuyPlanService buyPlanService;
	
	// 그룹 여행상품 구매계획 페이지 이동
	@GetMapping("/buyPlan.do")
	public String buyPlan(HttpServletRequest req, @RequestParam long plNo, Model model, RedirectAttributes ra) {
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(memberVO == null) {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			return "redirect:/login/signin.do";
		}
		
		log.debug("plNo : {}", plNo);

//		PlannerVO pvo = plannerService.getPlanDetail(plNo);
		
		Map<String, Object> param = buyPlanService.getAllPlans(plNo);
		
		PlannerVO pvo = (PlannerVO)param.get("pvo");
		int dayCnt = (int)param.get("dayCnt");

		model.addAttribute("pvo", pvo);
		model.addAttribute("dayCnt", dayCnt);
		
		for(int i = 0; i < dayCnt; i++) {
			String tempStr = "day" + (i+1);
			List<DetatilPlannerVO> dpvo = (List<DetatilPlannerVO>)param.get("day" + (i+1));
			model.addAttribute(tempStr, dpvo);
		}
		
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = null;
		try {
			jsonString = objectMapper.writeValueAsString(pvo.getDetailList());
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		// n빵을 위한 멤버그룹 현재원 조회
		long curNum = buyPlanService.getCurNum(plNo);
		log.debug("curNum", curNum);
		model.addAttribute("curNum", curNum);
		
		
		model.addAttribute("pvoJson", jsonString);
		log.debug("pvoJson : {}", jsonString);
		
		model.addAttribute("dpList", pvo.getDetailList());
		
		return "partner/buyPlan";
	}
	
}

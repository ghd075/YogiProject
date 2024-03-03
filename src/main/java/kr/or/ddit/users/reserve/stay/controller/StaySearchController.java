package kr.or.ddit.users.reserve.stay.controller;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve/stays/search")
public class StaySearchController {

	@Autowired
	private AirReserveService reserveService;
	
	/* 숙소 검색화면 */
	@RequestMapping("/form.do")
	public String searchForm() {
		
		return "reserve/stay/stays";
	}
	
	
	/* 숙소 검색결과 화면 */
	@RequestMapping("/stayList.do")
	public String stayList(HttpSession session, Model model) {
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		
		//장바구니 검색 및 UI생성
		Map<String, Object> groupMap = reserveService.selectPoint(memberVO.getMemId());
		List<PlannerVO> groupList =  (List<PlannerVO>) groupMap.get("groupList");
		if(groupMap.get("groupList") == null) {
			model.addAttribute("popover", "<span class='popoverSpan'>개인장바구니</span>");	
		}else {
			String html = "<span class='popoverSpan'>개인장바구니</span><hr>";
		    for(int i = 0; i < groupList.size(); i++) {
		    	html += "<span class='popoverSpan' id='"+groupList.get(i).getPlNo()+"'>"+groupList.get(i).getPlTitle()+"</span>";
		    	if(i != (groupList.size() - 1)) {
		    		html += "<hr>";  
				}
		    }	
			model.addAttribute("popover", html);
		}
		return "reserve/stay/list";
	}
}















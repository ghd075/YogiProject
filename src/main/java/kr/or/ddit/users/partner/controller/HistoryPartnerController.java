package kr.or.ddit.users.partner.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.partner.service.HistoryPartnerService;
import kr.or.ddit.users.partner.service.MyTripService;
import kr.or.ddit.users.partner.vo.PlanerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/partner")
public class HistoryPartnerController {
	
	@Inject
	private HistoryPartnerService historyPartnerService;

	@RequestMapping(value = "/history.do", method = RequestMethod.GET)
	public String history(
			HttpSession session,
			Model model
			) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(memberVO != null) {
			String memId = memberVO.getMemId(); // 작성자
			param.put("memId", memId);
		}
		
		/** 서비스 호출 */
		historyPartnerService.historyList(param);
		
		/** 반환 자료 */
		List<PlanerVO> planerList = (List<PlanerVO>) param.get("planerList");
		
		/** 자료 검증 */
		log.info("planerList : " + planerList.toString());
		
		/** 자료 반환 */ 
		model.addAttribute("planerList", planerList);
		return "partner/history";
	}
	
}

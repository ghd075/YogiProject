package kr.or.ddit.users.partner.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.partner.service.MyTripService;
import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/partner")
public class MyGroupPartnerController {

	@Inject
	private MyTripService myTripService;
	
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/mygroup.do", method = RequestMethod.GET)
	public String mygroup(
			HttpSession session,
			Model model
			) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		String memId = memberVO.getMemId(); // 작성자
		param.put("memId", memId);
		
		/** 서비스 호출 */
		myTripService.myTripList(param);
		
		/** 반환 자료 */
		List<PlanerVO> planerList = (List<PlanerVO>) param.get("planerList");
		
		/** 자료 검증 */
		log.info("memId : " + memId);
		log.info("planerList : " + planerList.toString());
		
		/** 자료 반환 */ 
		model.addAttribute("planerList", planerList);
		
		return "partner/mygroup";
	}
	
	// ajax > 실시간 플래너 리스트 검색
	@GetMapping("/ajaxSearch.do")
	@ResponseBody
	public List<PlanerVO> planerList(PlanerVO planerVO) {
		log.info("planerVO : {}" , planerVO);
		return myTripService.searchPlanerList(planerVO);
	}
	
	// 플래너 공개/비공개 처리 메서드
	@Transactional
	@PostMapping("chgStatusPlan.do")
	public String chgStatusPlan(
			PlanerVO planerVO,
			Model model,
			RedirectAttributes ra
			) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memId", planerVO.getMemId());
		param.put("plNo", planerVO.getPlNo());
		param.put("plPrivate", planerVO.getPlPrivate());
		
		/** 서비스 호출 */
		myTripService.chgStatusPlan(param);
		
		/** 반환 자료 */
		ServiceResult result = (ServiceResult) param.get("result");
		String message = (String) param.get("message");
		String goPage = (String) param.get("goPage");
		
		/** 자료 검증 */
		log.info("result : " + result);
		log.info("message : " + message);
		log.info("goPage : " + goPage);
		
		if(result.equals(ServiceResult.OK)) { // 업데이트 성공
			ra.addFlashAttribute("message", message);
		}else { // 업데이트 실패
			model.addAttribute("message", message);
		}
		
		/** 자료 반환 */
		return goPage;
	}
	
}

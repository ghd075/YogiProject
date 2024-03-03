package kr.or.ddit.users.myplan.controller;

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
import kr.or.ddit.users.myplan.service.PlannerMainService;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myplan")
public class PlanDetailController {
	
	@Inject
	private PlannerDetailService plannerDetailService;
	
	/**
	 * 플랜 상세페이지 이동
	 * @param req
	 * @param plNo
	 * @param model
	 * @return
	 */
	@GetMapping("/planDetail.do")
	public String planDetail(HttpServletRequest req, @RequestParam long plNo, Model model) {
		log.debug("/planDetail.do 실행!");
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("req", req);
		
		log.debug("plNo : {}", plNo);
		
		/** 서비스 호출 */
		plannerDetailService.getPlanDetail(plNo, param);
		
		/** 반환 자료 */
		PlannerVO pvo = (PlannerVO)param.get("pvo");	// PlannerVO안에 DetatilPlannerVO(List)안에 tourItemsVO가 있는 구조
		int dayCnt = (int)param.get("dayCnt");
		String jsonString = (String)param.get("pvoJson");
		int isJoined = (int)param.get("isJoined");
		for(int i = 1; i <= dayCnt; i++) {
			String tempStr = "day" + (i);
			List<DetatilPlannerVO> dpvo = (List<DetatilPlannerVO>)param.get("day" + (i));
			model.addAttribute(tempStr, dpvo);
		}
		int mgCurNum = (int)param.get("mgCurNum");
		String joinStatus = (String)param.get("joinStatus");
		String mategroupStep = (String)param.get("mategroupStep");
		
		/** 자료 검증 */
		log.debug("req : {}", req);
		log.debug("plNo : {}", plNo);
		log.debug("pvo : {}", pvo);
		log.debug("dayCnt : {}", dayCnt);
		log.debug("pvoJson : {}", jsonString);
		log.debug("joinStatus : {}", joinStatus);
		log.debug("isJoined : {}", isJoined);
		for(int i = 1; i <= dayCnt; i++) {
			log.debug("day"+i+" : {}", (List<DetatilPlannerVO>)param.get("day" + (i)));
		}
		
		/** 자료 반환 */ 
		model.addAttribute("pvo", pvo);
		model.addAttribute("dayCnt", dayCnt);
		model.addAttribute("isJoined", isJoined);
		model.addAttribute("joinStatus", joinStatus);
		model.addAttribute("pvoJson", jsonString);
//		model.addAttribute("dpList", pvo.getDetailList());
		model.addAttribute("mgCurNum", mgCurNum);
		model.addAttribute("mategroupStep", mategroupStep);
		
		return "myplan/planDetail";
	}
	
	/**
	 * 동행참가 신청
	 * @param req
	 * @param plNo
	 * @param model
	 * @param ra
	 * @return
	 */
	@GetMapping("/groupJoin.do")
	public String groupJoin(HttpServletRequest req, @RequestParam long plNo, Model model, RedirectAttributes ra) {
		log.debug("/planDetail.do 실행!");
		
		/** 로그인 */
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(memberVO == null) {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			ra.addFlashAttribute("msgflag", "in");
			return "redirect:/login/signin.do";
		}
		
		/** 자료 수집 및 정의 */
		String memId = memberVO.getMemId();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("plNo", plNo);
		param.put("memId", memId);
		
		/** 서비스 호출 */
		plannerDetailService.joinGroup(param);
		
		/** 반환 자료 */
		ServiceResult serviceResult =  (ServiceResult)param.get("serviceResult");
		
		/** 자료 검증 */
//		log.debug("plNo : {}" + plNo);
//		log.debug("memId : {}" + memId);
		log.debug("serviceResult : {}" + serviceResult);
		
//		ServiceResult serviceResult = ServiceResult.FAILED;
		/** 자료 반환 */ 
		if(serviceResult == ServiceResult.OK) {
			ra.addFlashAttribute("message", "동행 참가 신청이 완료되었습니다.");
			ra.addFlashAttribute("msgflag", "su");
			return "redirect:/partner/mygroup.do";
		} else {
			ra.addFlashAttribute("message", "동행 참가 신청이 실패하였습니다.");
			ra.addFlashAttribute("msgflag", "fa");
			return "redirect:/myplan/planDetail.do?plNo=" + plNo;
		}
		
	}
}

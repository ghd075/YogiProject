package kr.or.ddit.users.reserve.stay.controller;

import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import kr.or.ddit.users.reserve.stay.service.StayReserveService;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve/stay/reserve")
public class StayReserveController {

	@Inject
	private AirReserveService reserveService;
	
	@Inject
	private StayReserveService stayService;
	
	
	@GetMapping("/stayReserve.do")
	public String stayReserve(HttpSession session, Model model) {
		MemberVO memvo = (MemberVO) session.getAttribute("sessionInfo");
		
		//포인트 정보 조회
        Map<String, Object> pointMap = reserveService.selectPoint(memvo.getMemId());
        model.addAttribute("pointMap", pointMap);
		
		return "reserve/stay/reserve";
	}
	
	@GetMapping("/stayPayment")
	public String stayPayment(int totalPrice, int finalRemain, int planerNo,
            HttpSession session, Model model, RedirectAttributes ra) {
		
		//1.포인트 업데이트
		ServiceResult result = stayService.processPayment(totalPrice, finalRemain, planerNo);
		if(result.equals(ServiceResult.OK)) {
			log.debug("결제처리 성공!");
		}else {
			log.debug("결제처리 실패!");
			ra.addFlashAttribute("message", "서버에러, 결제처리 실패!");
			return "redirect:/reserve/stays/search/form.do";
		}
		
		//2.이동 페이지 결정 
		model.addAttribute("msg", "숙박권 결제가 완료되었습니다!");
		model.addAttribute("plNo", planerNo);
		
		return "reserve/stay/result";
	}
}

















package kr.or.ddit.users.mypage.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.board.vo.QuestionVO;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.mypage.service.MyPageService;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.RealTimeSenderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class MyPageController {

	@Inject
	private MyPageService mypageService;
	
	// 마이페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/myinfo.do", method = RequestMethod.GET)
	public String myinfo(
			HttpSession session,
			Model model
			) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		log.info("memberVO.getMemId() : {}", memberVO.getMemId());
		param.put("memId", memberVO.getMemId());
		
		/** 서비스 호출 */
		// 1. 좋아요 내역 리스트 가져오기
		List<PlannerLikeVO> plList = mypageService.getLikeList(memberVO.getMemId());
		
		// 2. 알림 내역 리스트 가져오기
		mypageService.getRtAlertList(param);
		
		/** 반환 자료 */
		List<RealTimeSenderVO> rtAlertList = (List<RealTimeSenderVO>) param.get("rtAlertList");
		
		/** 자료 검증 */
		log.info("rtAlertList : {}", rtAlertList);
		
		/** 자료 반환 */
		model.addAttribute("rtAlertList", rtAlertList);
		model.addAttribute("likeList", plList);
		
		return "mypage/myInfo";
	}
	
	// 회원정보수정 메서드
	@RequestMapping(value = "/myinfoupd.do", method = RequestMethod.POST)
	public String myinfoUpd(
			HttpSession session,
			HttpServletRequest req,
			MemberVO memberVO,
			Model model,
			RedirectAttributes ra
			) {
		
		String goPage = "";
		
		ServiceResult result = mypageService.myinfoUpd(req, memberVO);
		if(result.equals(ServiceResult.OK)) {
			MemberVO member = mypageService.updCheck(memberVO);
			if(member != null) {
				session.setAttribute("sessionInfo", member);
				int intervalInSeconds = 60 * 60; // 1시간을 초로 계산합니다
				session.setMaxInactiveInterval(intervalInSeconds);
				ra.addFlashAttribute("message", "회원 정보 수정이 완료되었습니다.");
				ra.addFlashAttribute("msgflag", "su");
				goPage = "redirect:/mypage/myinfo.do";
			}else {
				model.addAttribute("message", "서버에러, 다시 시도해 주세요.");
				model.addAttribute("msgflag", "in");
				model.addAttribute("member", memberVO);
				goPage = "login/signin";
			}
		}else {
			model.addAttribute("message", "회원 정보 수정에 실패했습니다.");
			model.addAttribute("msgflag", "fa");
			goPage = "mypage/myInfo";
		}
		
		return goPage;
		
	}
	
	// 회원 탈퇴 메서드
	@RequestMapping(value = "/memDelete.do", method = RequestMethod.GET)
	public String memDelete(
			String memId,
			HttpSession session,
			RedirectAttributes ra,
			Model model
			) {
		
		String goPage = "";
		
		ServiceResult result = mypageService.memDelete(memId);
		if(result.equals(ServiceResult.OK)) { // 회원 삭제 성공
			session.invalidate();
			ra.addFlashAttribute("message", "회원 탈퇴가 되었습니다. 안녕히 가세요.");
			ra.addFlashAttribute("msgflag", "su");
			goPage = "redirect:/login/signin.do";
		}else { // 회원 삭제 실패
			model.addAttribute("message", "서버 에러, 다시 시도해주세요!");
			model.addAttribute("msgflag", "in");
			goPage = "mypage/myInfo";
		}
		
		return goPage;
		
	}
	
	// 실시간 알림 내역 > 내역 삭제 메서드
	@PostMapping("/rtAlertOneDelete.do")
	public String rtAlertOneDelete(
			RealTimeSenderVO rtSenderVO,
			Model model,
			RedirectAttributes ra
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		log.info("rtAlertOneDelete > realrecNo : {}", rtSenderVO.getRealrecNo());
		param.put("realrecNo", rtSenderVO.getRealrecNo());
		
		/** 서비스 호출 */
		mypageService.rtAlertOneDelete(param);
		
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
	        ra.addFlashAttribute("msgflag", "su");
	    }else { // 업데이트 실패
	    	ra.addFlashAttribute("message", message);
	    	ra.addFlashAttribute("msgflag", "fa");
	    }

	    /** 자료 반환 */
	    return goPage;
		
	}
	
	// 실시간 알림 내역 > 내역 삭제 메서드
	@PostMapping("/likeDelete.do")
	public String likeDelete(
			PlannerLikeVO plLikeVO,
			Model model,
			RedirectAttributes ra
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
//		log.info("rtAlertOneDelete > realrecNo : {}", plLikeVO.getPlLikeNo());
		param.put("plLikeNo", plLikeVO.getPlLikeNo());
		
		/** 서비스 호출 */
		mypageService.plLikeDelete(param);
		
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
	        ra.addFlashAttribute("msgflag", "su");
	    }else { // 업데이트 실패
	    	ra.addFlashAttribute("message", message);
	    	ra.addFlashAttribute("msgflag", "fa");
	    }

	    /** 자료 반환 */
	    return goPage;
		
	}
	
	// 게시글 관리 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/boardinfo.do", method = RequestMethod.GET)
	public String boardinfo(
			HttpSession session,
			Model model
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		log.info("memberVO.getMemId() : {}", memberVO.getMemId());
		// 로그인 정보 가져오기
		param.put("memId", memberVO.getMemId());
		
		/** 서비스 호출 */
		// 1. 나의 여행 후기 리스트 가져오기
		
		// 2. 나의 문의 리스트 가져오기
		mypageService.getQnaList(param);
		
		/** 반환 자료 */
		List<QuestionVO> qnaList = (List<QuestionVO>) param.get("qnaList");
		
		/** 자료 검증 */
		log.info("qnaList : {}", qnaList);
		
		/** 자료 반환 */
		model.addAttribute("qnaList", qnaList);
		
		return "mypage/boardInfo";
	}
	
	// 나의 문의 내역 > 내역 삭제 메서드
	@PostMapping("/qnaOneDelete.do")
	public String qnaOneDelete(
			QuestionVO questionVO,
			Model model,
			RedirectAttributes ra
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		log.info("qnaOneDelete > boNo : {}", questionVO.getBoNo());
		param.put("boNo", questionVO.getBoNo());
		
		/** 서비스 호출 */
		mypageService.qnaOneDelete(param);
		
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
	        ra.addFlashAttribute("msgflag", "su");
	    }else { // 업데이트 실패
	    	ra.addFlashAttribute("message", message);
	    	ra.addFlashAttribute("msgflag", "fa");
	    }

	    /** 자료 반환 */
	    return goPage;
		
	}
	
}

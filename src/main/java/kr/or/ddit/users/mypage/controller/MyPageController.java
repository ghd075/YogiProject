package kr.or.ddit.users.mypage.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.login.service.LoginService;
import kr.or.ddit.users.mypage.service.MyPageService;
import kr.or.ddit.users.mypage.vo.MemberVO;
import kr.or.ddit.utils.ServiceResult;
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
	public String myinfo() {
		return "mypage/myInfo";
	}
	
	// 회원정보수정 메서드
	@Transactional
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
				goPage = "redirect:/mypage/myinfo.do";
			}else {
				model.addAttribute("message", "서버에러, 다시 시도해 주세요.");
				model.addAttribute("member", memberVO);
				goPage = "login/signin";
			}
		}else {
			model.addAttribute("message", "회원 정보 수정에 실패했습니다.");
			goPage = "mypage/myInfo";
		}
		
		return goPage;
		
	}
	
	// 회원 탈퇴 메서드
	@Transactional
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
			goPage = "redirect:/login/signin.do";
		}else { // 회원 삭제 실패
			model.addAttribute("message", "서버 에러, 다시 시도해주세요!");
			goPage = "mypage/myInfo";
		}
		
		return goPage;
		
	}
	
	// 게시글 관리 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/boardinfo.do", method = RequestMethod.GET)
	public String boardinfo() {
		return "mypage/boardInfo";
	}
	
	/*
	 * // 결제관리 이동
	 * 
	 * @CrossOrigin(origins = "http://localhost")
	 * 
	 * @RequestMapping(value = "/paymentinfo.do", method = RequestMethod.GET) public
	 * String paymentinfo() { return "mypage/paymentInfo"; }
	 */
	
}

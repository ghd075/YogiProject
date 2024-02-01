package kr.or.ddit.users.login.controller;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.login.service.LoginService;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/login")
public class LoginController {
	
	@Resource(name = "uploadPath")
	private String resourcePath;
	
	@Inject
	private LoginService loginService;

	// 로그인 페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/signin.do", method = RequestMethod.GET)
	public String signin(String message, Model model) {
		if(StringUtils.isNotBlank(message)) {
			// 성공, 실패, 정보
			// 성공 : su
			// 실패 : fa
			// 정보 : in
			model.addAttribute("message", message);
			model.addAttribute("msgflag", "in");
		}
		return "login/signin";
	}
	
	// 회원 가입 페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/signup.do", method = RequestMethod.GET)
	public String signup() {
		return "login/signup";
	}
	
	// Ajax > 아이디 중복체크 메서드
	@RequestMapping(value = "/idCheck.do", method = RequestMethod.POST)
	public ResponseEntity<String> idCheck(@RequestBody Map<String, String> map){
		ServiceResult result = loginService.idCheck(map.get("memId"));
		return new ResponseEntity<String>(result.toString(), HttpStatus.OK);
	}
	
	// Ajax > 이메일 중복체크 메서드
	@RequestMapping(value = "/emailCheck.do", method = RequestMethod.POST)
	public ResponseEntity<String> emailCheck(@RequestBody Map<String, String> map){
		ServiceResult result = loginService.emailCheck(map.get("memEmail"));
		return new ResponseEntity<String>(result.toString(), HttpStatus.OK);
	}
	
	// 회원 가입 메서드
	@RequestMapping(value = "/signup.do", method = RequestMethod.POST)
	public String signup(
			HttpServletRequest req, 
			MemberVO memberVO, 
			Model model, 
			RedirectAttributes ra,
			@RequestParam("imgFile") MultipartFile imgFile
			) {
		
		log.info("imgFile : " + imgFile.getOriginalFilename());
		log.info("memberVO : " + memberVO.toString());
		
		// 이미지 파일이 없는 경우 예외 처리
		if(imgFile.isEmpty()) {
			model.addAttribute("message", "이미지 파일을 업로드해 주세요.");
			model.addAttribute("msgflag", "in");
			return "login/signup";
		}
		
		String goPage = "";
		
		Map<String, String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(memberVO.getMemId())) {
			errors.put("memId", "아이디를 입력해 주세요.");
		}
		if(StringUtils.isBlank(memberVO.getMemPw())) {
			errors.put("memPw", "비밀번호를 입력해 주세요.");
		}
		if(StringUtils.isBlank(memberVO.getMemName())) {
			errors.put("memName", "이름을 입력해 주세요.");
		}
		
		if(errors.size() > 0) { // 에러 정보가 존재
			model.addAttribute("errors", errors);
			model.addAttribute("msgflag", "in");
			model.addAttribute("member", memberVO);
			goPage = "login/signup"; // 회원 가입 페이지로 이동
		}else { // 정상적인 데이터
			ServiceResult result = loginService.signup(req, memberVO);
			if(result.equals(ServiceResult.OK)) { // 가입 성공
				ra.addFlashAttribute("message", "회원가입을 완료하였습니다!");
				ra.addFlashAttribute("msgflag", "su");
				goPage = "redirect:/login/signin.do"; // 로그인 페이지로 이동
			}else { // 가입 실패
				model.addAttribute("message", "서버에러, 다시 시도해 주세요!");
				model.addAttribute("msgflag", "fa");
				model.addAttribute("member", memberVO);
				goPage = "login/signup"; // 회원 가입 페이지로 이동
			}
		}
		
		return goPage;
	}
	
	// 아이디/비밀번호 페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/findIdPw.do", method = RequestMethod.GET)
	public String findIdPw() {
		return "login/findIdPw";
	}
	
	// Ajax > 아이디 찾기 메서드
	@RequestMapping(value = "/findId.do", method = RequestMethod.POST)
	public ResponseEntity<MemberVO> findId(
			@RequestBody Map<String, String> map
			){
		
		MemberVO result = loginService.findId(map);
		return new ResponseEntity<MemberVO>(result, HttpStatus.OK);
		
	}
	
	// Ajax > 비밀번호 찾기 메서드
	@RequestMapping(value = "/findPw.do", method = RequestMethod.POST)
	public ResponseEntity<MemberVO> findPw(
			@RequestBody Map<String, String> map
			){
		
		MemberVO result = loginService.findPw(map);
		return new ResponseEntity<MemberVO>(result, HttpStatus.OK);
		
	}
	
	// 비밀번호 변경 처리 메서드
	@PostMapping("/changePw.do")
	public String changePw(
			MemberVO memberVO,
			Model model,
			RedirectAttributes ra
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memId", memberVO.getMemId());
		param.put("memPw", memberVO.getMemPw());
		
		/** 서비스 호출 */
		loginService.changePw(param);
		
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
	        model.addAttribute("message", message);
	        model.addAttribute("msgflag", "fa");
	    }
		
		/** 자료 반환 */
	    return goPage;
		
	}
	
	// 로그인 처리 메서드
	@RequestMapping(value = "/loginCheck.do", method = RequestMethod.POST)
	public String loginCheck(
			HttpSession session,
			MemberVO memberVO,
			Model model,
			RedirectAttributes ra
			) {
		
		String goPage = "";
		
		Map<String, String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(memberVO.getMemId())) {
			errors.put("memId", "아이디를 입력해 주세요");
		}
		if(StringUtils.isBlank(memberVO.getMemPw())) {
			errors.put("memPw", "비밀번호를 입력해 주세요");
		}
		
		if(errors.size() > 0) { // 에러가 있음
			model.addAttribute("errors", errors);
			model.addAttribute("msgflag", "fa");
			model.addAttribute("member", memberVO);
			goPage = "login/signin";
		}else {
			MemberVO member = loginService.loginCheck(memberVO);
			if(member != null) {
				if(member.getEnabled().equals("0")) { // 탈퇴한 회원
					ra.addFlashAttribute("message", "탈퇴한 회원 계정입니다.");
					ra.addFlashAttribute("msgflag", "in");
					goPage = "redirect:/login/signin.do";
				}else {
					session.setAttribute("sessionInfo", member);
					int intervalInSeconds = 60 * 60; // 1시간을 초로 계산합니다
					session.setMaxInactiveInterval(intervalInSeconds);
					ra.addFlashAttribute("message", member.getMemName() + "님, 환영합니다!");
					ra.addFlashAttribute("msgflag", "su");
					goPage = "redirect:/index.do";
				}
			}else {
				model.addAttribute("message", "존재하지 않는 회원입니다.");
				model.addAttribute("msgflag", "in");
				model.addAttribute("member", memberVO);
				goPage = "login/signin";
			}
		}
		
		return goPage;
		
	}
	
	// 로그아웃 메서드
	@RequestMapping(value = "/logout.do", method = RequestMethod.GET)
	public String logout(
			HttpSession session,
			RedirectAttributes ra
			) {
		
		session.invalidate();
		ra.addFlashAttribute("message", "로그아웃 되었습니다.");
		ra.addFlashAttribute("msgflag", "in");
		return "redirect:/login/signin.do";
		
	}
	
}

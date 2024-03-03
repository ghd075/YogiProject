package kr.or.ddit;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.indexsearch.service.IndexSearchService;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.vo.JourneyinfoVO;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.RealTimeSenderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Inject
	private IndexSearchService indexSearchService;
	
	// 랜딩 페이지
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	
	// 랜딩 페이지 리다이렉트
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/index.do", method = RequestMethod.GET)
	public String index(Model model) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		
		/** 서비스 호출 */
		// 여행 정보 리스트(최신 글 순, 8개) 가져오기
		indexSearchService.informationList8(param);
		
		/** 반환 자료 */
		List<JourneyinfoVO> journeyList8 = (List<JourneyinfoVO>) param.get("journeyList8");
		
		/** 자료 검증 */
		log.info("journeyList8 => {}", journeyList8);
		
		/** 자료 반환 */
		model.addAttribute("journeyList8", journeyList8);
		
		return "user/index";
	}

	// 개인정보처리방침 페이지
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/personalInfo.do", method = RequestMethod.GET)
	public String personalInfo() {
		return "user/personalInfo";
	}
	
	// 영상정보처리기기 운영관리 방침 페이지
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/imageInfo.do", method = RequestMethod.GET)
	public String imageInfo() {
		return "user/imageInfo";
	}
	
	// ajax > 실시간 멤버 아이디 전체 리스트 가져오기
	@GetMapping("/membersIdGet.do")
	@ResponseBody
	public List<MemberVO> ajaxMembersId() {
		return indexSearchService.ajaxMembersId();
	}
	
	// ajax > 실시간 알림 > 내역 저장
	@PostMapping("/allMemberRtAlertSave.do")
	@ResponseBody
	public String ajaxRtAlert(RealTimeSenderVO realVO) {
		log.info("realVO : {}", realVO);
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("realVO", realVO);
		
		/** 서비스 호출 */
		indexSearchService.ajaxRtAlert(param);
		
		/** 반환 자료 */
		ServiceResult result = (ServiceResult) param.get("result");
		String judge = "";
		
		if(result.equals(ServiceResult.OK)) {
			judge = "OK";
		}else {
			judge = "FAIL";
		}
		
		return judge;
	}
	
	// ajax > 실시간 알림 메시지를 전역으로 가져와 뿌리깅
	@GetMapping("/rtAlertGetMsg.do")
	@ResponseBody
	public Map<String, Object> ajaxRtSenderGetMsgFn(
			HttpSession session
			) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		Map<String, Object> resObj = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(memberVO != null) {
			param.put("memId", memberVO.getMemId());
		}
		
		/** 서비스 호출 */
		// 실시간 알림 메시지 가져오기
		indexSearchService.ajaxRtSenderGetMsgFn(param);
		
		/** 반환 자료 */
		RealTimeSenderVO journeySender = (RealTimeSenderVO) param.get("journeySender");
		int journeyCnt = (int) param.get("journeyCnt");
		
		/** 자료 검증 */
		log.info("journeySender : {}", journeySender);
		log.info("journeyCnt : {}", journeyCnt);
		
		/** 자료 반환 */
		resObj.put("journeySender", journeySender);
		resObj.put("journeyCnt", journeyCnt);
		return resObj;
	}
	
	// ajax > 바로 가기 클릭 시 안 본 실시간 알림을 본 것으로 처리
	@PostMapping("/readRtAlert.do")
	@ResponseBody
	public String rtAlertRead(@RequestBody String realrecNo) {
		log.info("realrecNo : {}", realrecNo);
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("realrecNo", realrecNo);
		
		/** 서비스 호출 */
		indexSearchService.ajaxRtAlertRead(param);
		
		/** 반환 자료 */
		ServiceResult result = (ServiceResult) param.get("result");
		String judge = "";
		
		if(result.equals(ServiceResult.OK)) {
			judge = "OK";
		}else {
			judge = "FAIL";
		}
		
		return judge;
	}
	
	// ajax > 실시간 알림 > 동행 참가 요청 > 해당 플래너 찾기
	@GetMapping("/planDetailCreateMemId.do")
	@ResponseBody
	public MemberVO planDetailCreateMemId(String plNo) {
		log.info("plNo : {}", plNo);
		return indexSearchService.planDetailCreateMemId(plNo);
	}
	
	// ajax > 로그인할 멤버 정보 가져오기
	@GetMapping("/loginMemInfoRtAlertSaveInfo.do")
	@ResponseBody
	public MemberVO loginMemInfoRtAlertSaveInfo(
			MemberVO loginMemVO
			) {
		
		log.info("loginMemVO : {}", loginMemVO);
		return indexSearchService.loginMemInfoRtAlertSaveInfo(loginMemVO);
	
	}
	
	// ajax > 로그인 알림 1번 출력 이후 바로 삭제
	@PostMapping("/ajaxLoginRtAlertRemove.do")
	@ResponseBody
	public String ajaxLoginRtAlertRemove(
			HttpSession session
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(memberVO != null) {
			param.put("memId", memberVO.getMemId());
		}
		
		/** 서비스 호출 */
		indexSearchService.ajaxLoginRtAlertRemove(param);
		
		/** 반환 자료 */
		ServiceResult result = (ServiceResult) param.get("result");
		String judge = "";
		
		if(result.equals(ServiceResult.OK)) {
			judge = "OK";
		}else {
			judge = "FAIL";
		}
		
		return judge;
		
	}
	
	// ajax > 딸랑이 클릭하면 모두 읽음 처리
	@GetMapping("/rtAlertClickInit.do")
	@ResponseBody
	public String rtAlertClickInit(String memId) {
		log.info("memId : {}", memId);
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memId", memId);
		
		/** 서비스 호출 */
		indexSearchService.rtAlertClickInit(param);
		
		/** 반환 자료 */
		ServiceResult result = (ServiceResult) param.get("result");
		String judge = "";
		
		if(result.equals(ServiceResult.OK)) {
			judge = "OK";
		}else {
			judge = "FAIL";
		}
		
		return judge;
	}
	
}

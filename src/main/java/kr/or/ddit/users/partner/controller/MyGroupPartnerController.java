package kr.or.ddit.users.partner.controller;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.partner.service.MyTripService;
import kr.or.ddit.users.partner.vo.ChatroomVO;
import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;
 
@Slf4j
@Controller
@RequestMapping("/partner")
public class MyGroupPartnerController {

	@Inject
	private MyTripService myTripService;
	
	// 플래너 리스트 페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/mygroup.do", method = RequestMethod.GET)
	public String mygroup(
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
		myTripService.myTripList(param);
		
		/** 반환 자료 */
		List<PlanerVO> planerList = (List<PlanerVO>) param.get("planerList");
		
		/** 자료 검증 */
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
	@PostMapping("/chgStatusPlan.do")
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
			ra.addFlashAttribute("msgflag", "su");
		}else { // 업데이트 실패
			model.addAttribute("message", message);
			model.addAttribute("msgflag", "fa");
		}
		
		/** 자료 반환 */
		return goPage;
	}
	
	// 플래너 삭제 메서드
	@PostMapping("/deletePlan.do")
	public String deletePlan(
			PlanerVO planerVO,
			Model model,
			RedirectAttributes ra
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("plNo", planerVO.getPlNo());
		
		/** 서비스 호출 */
		myTripService.deletePlan(param);
		
		/** 반환 자료 */
		ServiceResult result = (ServiceResult) param.get("result");
		String message = (String) param.get("message");
		String goPage = (String) param.get("goPage");
		
		/** 자료 검증 */
		log.info("result : " + result);
		log.info("message : " + message);
		log.info("goPage : " + goPage);
		
		if(result.equals(ServiceResult.OK)) { // 삭제 성공
			ra.addFlashAttribute("message", message);
			ra.addFlashAttribute("msgflag", "su");
		}else { // 삭제 실패
			model.addAttribute("message", message);
			model.addAttribute("msgflag", "fa");
		}
		
		/** 자료 반환 */
		return goPage;
		
	}
	
	// 만남의 광장 상세 페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@GetMapping("/meetsquare.do")
	public String meetsquareRoom(
			int plNo,
			Model model
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("plNo", plNo);
		
		/** 서비스 호출 */
		myTripService.meetsquareRoom(param);
		
		/** 반환 자료 */
		PlanerVO recruiter = (PlanerVO) param.get("recruiter");
		List<PlanerVO> mateList = (List<PlanerVO>) param.get("mateList");
		int mateCnt = (int) param.get("mateCnt");
		List<PlanerVO> chatRoomInfo = (List<PlanerVO>) param.get("chatRoomInfo");
		List<PlanerVO> chatInfoList = (List<PlanerVO>) param.get("chatInfoList");
		
		/** 자료 검증 */
		log.info("recruiter : " + recruiter);
		log.info("mateList : " + mateList);
		log.info("mateCnt : " + mateCnt);
		log.info("chatRoomInfo : " + chatRoomInfo);
		log.info("chatInfoList : " + chatInfoList);
		
		model.addAttribute("recruiter", recruiter);
		model.addAttribute("mateList", mateList);
		model.addAttribute("mateCnt", mateCnt);
		model.addAttribute("chatRoomInfo", chatRoomInfo);
		model.addAttribute("chatInfoList", chatInfoList);
		
		return "partner/meetsquareRoom";
		
	}
	
	// ajax > 대기자, 거부/강퇴자 검색
	@GetMapping("/excludeNonUser.do")
	@ResponseBody
	public PlanerVO excludeNonUser(PlanerVO planerVO) {
		log.info("planerVO : {}" , planerVO);
		return myTripService.excludeNonUser(planerVO);
	}
	
	// ajax > 멤버 승인 메서드
	@GetMapping("/acceptMem.do")
	@ResponseBody
	public ResponseEntity<Object> acceptMem(PlanerVO planerVO) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memId", planerVO.getMemId());
		param.put("plNo", planerVO.getPlNo());
		
		Map<String, Object> responseData = new HashMap<String, Object>();
		
		/** 서비스 호출 */
		myTripService.acceptMem(param);
		
		/** 반환 자료 */
		PlanerVO recruiter = (PlanerVO) param.get("recruiter");
		List<PlanerVO> mateList = (List<PlanerVO>) param.get("mateList");
		int mateCnt = (int) param.get("mateCnt");
		
		/** 자료 검증 */
		log.info("recruiter : " + recruiter);
		log.info("mateList : " + mateList);
		log.info("mateCnt : " + mateCnt);
		
		/** 자료 반환 */
		responseData.put("recruiter", recruiter);
		responseData.put("mateList", mateList);
		responseData.put("mateCnt", mateCnt);
		
		return ResponseEntity.ok(responseData);
	}
	
	// ajax > 멤버 거절 메서드
	@GetMapping("/rejectMem.do")
	@ResponseBody
	public ResponseEntity<Object> rejectMem(PlanerVO planerVO) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memId", planerVO.getMemId());
		param.put("plNo", planerVO.getPlNo());
		
		Map<String, Object> responseData = new HashMap<String, Object>();
		
		/** 서비스 호출 */
		myTripService.rejectMem(param);
		
		/** 반환 자료 */
		PlanerVO recruiter = (PlanerVO) param.get("recruiter");
		List<PlanerVO> mateList = (List<PlanerVO>) param.get("mateList");
		int mateCnt = (int) param.get("mateCnt");
		
		/** 자료 검증 */
		log.info("recruiter : " + recruiter);
		log.info("mateList : " + mateList);
		log.info("mateCnt : " + mateCnt);
		
		/** 자료 반환 */
		responseData.put("recruiter", recruiter);
		responseData.put("mateList", mateList);
		responseData.put("mateCnt", mateCnt);
		
		return ResponseEntity.ok(responseData);
	}
	
	// 참여자 > 플래너 취소 기능
	@PostMapping("/chgStatusJoiner.do")
	public String chgStatusJoiner(
			PlanerVO planerVO,
			Model model,
			RedirectAttributes ra
			) {
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("memId", planerVO.getMemId());
		param.put("plNo", planerVO.getPlNo());
		
		/** 서비스 호출 */
		myTripService.chgStatusJoiner(param);
		
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
	
	// ajax > 채팅 내역 저장 메서드
	@PostMapping("/ajaxChatInsert.do")
	@ResponseBody
	public String ajaxChatContSave(ChatroomVO chatroomVO) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("chatroomVO", chatroomVO);
		
		/** 서비스 호출 */
		myTripService.ajaxChatContSave(param);
		
		/** 반환 자료 */
		String result = (String) param.get("result");
		
		/** 자료 검증 */
		log.info("result : {}", result);
		
		/** 자료 반환 */
		return result;
	}
	
	// 모집 마감 처리 메서드
	@PostMapping("/groupRecruitEnded.do")
	public String groupRecruitEnded(
			PlanerVO planerVO,
			Model model,
			RedirectAttributes ra
			) {
		
		/** 자료 수집 및 정의 */
	    Map<String, Object> param = new HashMap<String, Object>();
	    param.put("plNo", planerVO.getPlNo());
	    log.info("plNo : {}", planerVO.getPlNo());
	    
	    /** 서비스 호출 */
	    myTripService.groupRecruitEnded(param);
	    
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
	
	@RequestMapping(value = "/planShare.do", method = RequestMethod.GET)
	public ResponseEntity<Void> planShare(
			HttpServletResponse response,
			HttpServletRequest request, @RequestParam("plNo") int plNo) throws IOException {
		ResponseEntity<byte[]> entity = null;
	    Map<String, Object> param = new HashMap<>();
	    param.put("plNo", plNo);
	    Map<String, Object> result = myTripService.planShare(request, param);
	    
	    String filename = (String) result.get("filename");
	    File saveFile = new File(request.getServletContext().getRealPath("/resources/pdf/"+plNo + "/"+filename));
	    
		response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

		// try with resource
		// () 안에 명시한 객체는 finally로 최종 열린 객체에 대한 close를 처리하지 않아도 자동 close()가 이루어진다.
		try(
				OutputStream os = response.getOutputStream();
		) {
			FileUtils.copyFile(saveFile, os);
		} 
		return new ResponseEntity<Void>(HttpStatus.OK);
	}


	// 채팅내역 다운로드 메소드
	@GetMapping("/chatContTxtDown.do")
	public ResponseEntity<byte[]> chatContTxtDown(@RequestParam int plNo) {
		log.debug("chatContTxtDown() 실행...!");
		
		try {
			
			/** 자료 수집 및 정의 */
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("plNo", plNo);
			
			/** 서비스 호출 */
			myTripService.chatContTxtDown(param);
			
			/** 반환 자료 */
			byte[] contentBytes = (byte[])param.get("contentBytes");
			
			/** 자료 검증 */
			log.debug("plNo : {}", plNo);
			
			
			HttpHeaders headers = new HttpHeaders();
			headers.setContentType(MediaType.parseMediaType("text/plain"));
			/** 자료 반환 */	
			if(contentBytes == null) {
				return ResponseEntity.ok().body(null);
			} else {
				return ResponseEntity.ok()
						.headers(headers)
						.body(contentBytes);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
		
	}
	
	// 오늘 날짜 이전의 채팅을 삭제하는 메소드
	@GetMapping("/chatContDelete.do")
	@ResponseBody
	public ResponseEntity<Object> chatContDelete(@RequestParam int plNo) {
		log.debug("chatContDelete() 실행...!");
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("plNo", plNo);
		
		/** 서비스 호출 */
		myTripService.chatContDelete(param);

		/** 반환 자료 */	
		String delRes = (String)param.get("delRes");
		
		/** 자료 검증 */
		log.debug("plNo은 왔나요 : {}", plNo);
		log.debug("delRes : {}", delRes);
		
		/** 자료 반환 */	
		return ResponseEntity.ok(param);
	}
	
	@GetMapping("/travelTheEndAjax.do")
	@ResponseBody
	public ServiceResult travelTheEndAjax(@RequestParam int plNo) {
		ServiceResult result = myTripService.travelTheEnd(plNo);
		return result;
	}
	
}

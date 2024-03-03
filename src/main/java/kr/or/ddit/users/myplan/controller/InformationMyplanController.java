package kr.or.ddit.users.myplan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.service.JourneyService;
import kr.or.ddit.users.myplan.vo.JourneyinfoVO;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.RealTimeSenderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myplan")
public class InformationMyplanController {

	@Inject
	private JourneyService journeyService;
	
	// 마이 플랜 > 여행 정보 페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/info.do", method = RequestMethod.GET)
	public String information(
			Model model
			) {
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		
		/** 서비스 호출 */
		// 여행정보 리스트 가져오기
		journeyService.informationList(param);
		
		/** 반환 자료 */
		List<JourneyinfoVO> journeyList = (List<JourneyinfoVO>) param.get("journeyList");
		
		/** 자료 검증 */
		log.info("journeyList : {}", journeyList);
		
		/** 자료 반환 */
		model.addAttribute("journeyList", journeyList);
		
		return "myplan/information";
	}
	
	// 여행 정보 등록 페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/inforeg.do", method = RequestMethod.GET)
	public String inforRegForm() {
		return "myplan/infoReg";
	}
	
	// 여행 정보 등록 메소드
	@RequestMapping(value = "/inforeg.do", method = RequestMethod.POST)
	public String inforReg(
			HttpServletRequest req,
			JourneyinfoVO journeyVO,
			Model model,
			RedirectAttributes ra,
			@RequestParam("imgFile") MultipartFile imgFile
			) {
		
		log.info("imgFile : " + imgFile.getOriginalFilename());
		log.info("journeyVO : " + journeyVO.toString());
		
		// 이미지 파일이 없는 경우 예외 처리
		if(imgFile.isEmpty()) {
			model.addAttribute("message", "이미지 파일을 업로드해 주세요.");
			model.addAttribute("msgflag", "in");
			return "myplan/infoReg";
		}
		
		String goPage = "";
		
		Map<String, String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(journeyVO.getInfoName())) {
			errors.put("infoName", "지역명(한글)을 입력해 주세요.");
		}
		if(StringUtils.isBlank(journeyVO.getInfoEngname())) {
			errors.put("infoName", "지역명(영어)를 입력해 주세요.");
		}
		if(StringUtils.isBlank(journeyVO.getInfoDescription())) {
			errors.put("infoName", "지역 설명을 입력해 주세요.");
		}
		if(StringUtils.isBlank(journeyVO.getInfoTimedifer())) {
			errors.put("infoName", "한국 대비 시차 기록을 입력해 주세요.");
		}
		
		if(errors.size() > 0) { // 에러 정보가 존재
			model.addAttribute("errors", errors);
			model.addAttribute("msgflag", "fa");
			model.addAttribute("journey", journeyVO);
			goPage = "myplan/infoReg"; // 여행 정보 등록 페이지로 이동
		}else { // 정상적인 데이터
			ServiceResult result = journeyService.inforReg(req, journeyVO);
			if(result.equals(ServiceResult.OK)) { // 여행 정보 등록 성공
				ra.addFlashAttribute("message", "여행 정보 등록이 성공적으로 완료되었습니다.");
				ra.addFlashAttribute("msgflag", "su");
				goPage = "redirect:/myplan/info.do"; // 여행 정보 페이지 로이동
			}else { // 여행 정보 등록 실패
				model.addAttribute("message", "서버에러, 다시 시도해 주세요.");
				model.addAttribute("msgflag", "in");
				model.addAttribute("journey", journeyVO);
				goPage = "myplan/infoReg"; // 여행 정보 등록 페이지로 이동
			}
		}
		
		return goPage;
		
	}
	
	// 여행 정보 수정 페이지 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/modify.do", method = RequestMethod.GET)
	public String inforModifyForm(int infoNo, Model model) {
		JourneyinfoVO journeyVO = journeyService.selectJourney(infoNo);
		model.addAttribute("journey", journeyVO);
		model.addAttribute("status", "u");
		return "myplan/infoReg";
	}
	
	// 여행 정보 수정 메서드
	@RequestMapping(value = "/modify.do", method = RequestMethod.POST)
	public String inforModify(
			HttpServletRequest req,
			JourneyinfoVO journeyVO,
			Model model,
			RedirectAttributes ra
			) {
		
		String goPage = "";
		
		ServiceResult result = journeyService.inforModify(req, journeyVO);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "여행 정보가 성공적으로 수정되었습니다.");
			ra.addFlashAttribute("msgflag", "su");
			goPage = "redirect:/myplan/info.do";
		}else {
			model.addAttribute("message", "서버 에러, 다시 시도해 주세요.");
			model.addAttribute("msgflag", "in");
			model.addAttribute("journey", journeyVO);
			model.addAttribute("status", "u");
			goPage = "myplan/infoReg";
		}
		
		return goPage;
		
	}
	
	// 여행 정보 삭제 메서드
	@RequestMapping(value = "/delete.do", method = RequestMethod.GET)
	public String inforDelete(
			RedirectAttributes ra,
			int infoNo,
			Model model
			) {
		
		String goPage = "";
		
		ServiceResult result = journeyService.inforDelete(infoNo);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "여행 정보 삭제가 완료되었습니다.");
			ra.addFlashAttribute("msgflag", "su");
			goPage = "redirect:/myplan/info.do";
		}else {
			ra.addFlashAttribute("message", "여행 정보 삭제에 실패했습니다.");
			ra.addFlashAttribute("msgflag", "fa");
			goPage = "redirect:/myplan/info.do";
		}
		
		return goPage;
		
	}
	
	// ajax > 실시간 여행 정보 검색 메서드
	@GetMapping("/ajaxSearch.do")
	@ResponseBody
	public List<JourneyinfoVO> journeyList(JourneyinfoVO journeyVO) {
		log.info("journeyVO : {}" , journeyVO);
		return journeyService.searchJourneyList(journeyVO);
	}
	
}

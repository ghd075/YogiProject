package kr.or.ddit.users.myplan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.filefilter.FalseFileFilter;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.service.MyplanService;
import kr.or.ddit.users.myplan.util.ToAreaCode;
import kr.or.ddit.users.myplan.vo.AreaVO;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerListVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.myplan.vo.SearchCodeVO;
import kr.or.ddit.users.myplan.vo.SearchResultVO;
import kr.or.ddit.users.myplan.vo.SigunguVO;
import kr.or.ddit.users.myplan.vo.TouritemsVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myplan")
public class MakeMyPlanController {

	@Inject
	private MyplanService planService;
	
	// 플랜 작성 페이지로 이동
	@RequestMapping(value = "/makeplan.do", method = RequestMethod.GET)
	public String makeplan(HttpServletRequest req, Model model, RedirectAttributes ra, @RequestParam(required = false, value= "infoName") String infoName) {
		
		/** 자료수집 및 정의 */ 
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(memberVO == null) {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			return "redirect:/login/signin.do";
		}
		
		// 테스트용 (로그인 생략)
		// MemberVO memberVO = new MemberVO();
		// memberVO.setMemId("chantest1");
		
		String memId = memberVO.getMemId();
		String chageToEng = "";
		String planType = "";
		PlannerListVO planList = null;
		PlannerVO plannerVO = new PlannerVO();
		plannerVO.setMemId(memId);
		
		if(infoName != null) {
			try {
				chageToEng = ToAreaCode.englishToTranslation(infoName);
			} catch (Exception e) {
				e.printStackTrace();
			}
			planType = ToAreaCode.checkRegionCodeType(chageToEng);
			
			/** 서비스 호출 */ 
			planList = planService.planList(planType, chageToEng);
		}
		
		/** 서비스 호출 */ 
		planService.newPlanner(plannerVO);
		
		/** 반환자료 */ 
		int plNo = plannerVO.getPlNo();
		
		/** 자료검증 */
		log.info("memberVO 값 => {}", memberVO);
		log.info("memId 값 : " + memId);
		log.info("PlannerVO 값 => {}", memberVO);
		log.info("plNo 값 : " + plNo);
		log.info("넘겨받은 infoName : " + infoName);
		log.info("변환된 infoName : " + chageToEng);
		log.info("지역Type : " + planType);
		log.info("planList =>  {}", planList);
		
		/** 자료반환 */ 
		model.addAttribute("plNo", plNo);
		model.addAttribute("planList", planList);
		
		return "myplan/makeplan";
	}
	
	// 지역 정보 가져오기
	@GetMapping("/selectAreaLIst.json")
	@ResponseBody
	public ArrayList<AreaVO> selectAreaList() {
		ArrayList<AreaVO> areaList = planService.areaList();
		log.info("result { }", areaList.toString());
		return areaList;
	}

	// 시군구 정보 가져오기
	@PostMapping("/selectSigunguList")
	@ResponseBody
	public ArrayList<SigunguVO> selectSigunguList(@RequestBody HashMap<String, Object> map) {
		String areaCode = (String)map.get("areaCode");
		log.info("받아오는 값 : {}", areaCode);
		ArrayList<SigunguVO> sigunguList = planService.sigunguList(areaCode);
		log.info("result { }", sigunguList.toString());
		return sigunguList;
	}
	
	// 검색된 관광지 정보 가져오기
	@PostMapping("/selectTour")
	@ResponseBody
	public SearchResultVO selectTour(@RequestBody SearchCodeVO searchCode) {
		/** 자료검증 */
		log.info("넘겨받은 searchcode { }", searchCode);
		
		/** 서비스 호출 */ 
		SearchResultVO result = planService.searchedList(searchCode);

		/** 결과검증 */
		log.info("result { }", result);
		
		return result;
	}
	
	
	/* 세부플랜 CRUD */
	
	//세부플랜 리스트 조회
	@PostMapping("/dayselect")
	@ResponseBody 
	public List<TouritemsVO> day(@RequestBody DetatilPlannerVO s_planner) {
		List<TouritemsVO> list = planService.selectDayById(s_planner);
		return list;
	}
	
	/**
	 * 하나의 장소를 조회
	 * @param contentId
	 * @return
	 */
	@GetMapping("/getTour")
	@ResponseBody
	public TouritemsVO getTour(@RequestParam String contentId) {
		log.info("contentId : " + contentId);
		TouritemsVO tvo = planService.getTour(contentId);
		return tvo;
	}
	
	/**
	 * 세부플랜 인서트
	 * @param s_planner
	 * @return
	 */
	@PostMapping("/insDp")
	@ResponseBody
	public TouritemsVO insertDetailPlan(@RequestBody DetatilPlannerVO s_planner) {
		log.debug("s_plannerIns : {}", s_planner);
		TouritemsVO tvo = planService.insertDetailPlan(s_planner);
		log.debug("# " + s_planner.getPlNo() + "번 플래너의 DAY " + s_planner.getSpDay() + " 세부 플랜에 " + s_planner.getContentId() + " 추가");
		return tvo;
	}

	/**
	 * 날짜에 해당하는 세부플랜 삭제
	 * @param s_planner
	 * @return
	 */
	@PostMapping("/delAllDp")
	@ResponseBody
	public ResponseEntity<String> deleteAllDetailPlan(@RequestBody DetatilPlannerVO s_planner) {
		log.debug("s_plannerDel : {}", s_planner);
		ServiceResult sres = planService.deleteAllDetailPlan(s_planner);
		log.debug("# " + s_planner.getPlNo() + "번 플래너의 DAY " + s_planner.getSpDay() + " 세부 플랜 전체 삭제");
		return new ResponseEntity<String>(sres.toString(), HttpStatus.OK);
	}
	
	/**
	 * 날짜 상관없이 모든 세부플랜 삭제
	 * @param s_planner
	 * @return
	 */
	@PostMapping("/delAllAllDp")
	@ResponseBody
	public ResponseEntity<String> deleteAllAllDetailPlan(@RequestBody DetatilPlannerVO s_planner) {
		log.debug("s_plannerDel : {}", s_planner);
		ServiceResult sres = planService.deleteAllAllDetailPlan(s_planner.getPlNo());
		return new ResponseEntity<String>(sres.toString(), HttpStatus.OK);
	}
	
	@GetMapping("/delPlan")
	@ResponseBody
	public ResponseEntity<String> delPlan(@RequestParam long plNo) {
		ServiceResult sres = planService.delPlan(plNo);
		return new ResponseEntity<String>(sres.toString(), HttpStatus.OK);
	}
	
	/**
	 * 하나의 세부플랜만 선택하여 삭제
	 * @param s_planner
	 * @return
	 */
	@PostMapping("/delOneDp")
	@ResponseBody
	public ResponseEntity<String> deleteOneDetailPlan(@RequestBody DetatilPlannerVO s_planner) {
		log.debug("s_plannerOneDel : {}", s_planner);
//		ServiceResult sres = planService.deleteOneDetailPlan(s_planner);
		ServiceResult sres = planService.deleteOneDetailPlan(s_planner);
		log.debug("# " + s_planner.getPlNo() + "번 플래너의 DAY " + s_planner.getSpDay()  + s_planner.getSpNo() + " 번 플랜 삭제");
		return new ResponseEntity<String>(sres.toString(), HttpStatus.OK);
	}

	/**
	 * 세부플랜 저장
	 * @param req
	 * @param planVO
	 * @param model
	 * @param ra
	 * @param imgFile
	 * @return
	 */
	@PostMapping("/updatePlan.do")
	public String updatePlan(
			HttpServletRequest req, 
			PlannerVO planVO, 
			Model model, 
			RedirectAttributes ra,
			@RequestParam("fileReal") MultipartFile imgFile,
			@RequestParam String spSday, 
			@RequestParam String spEday) {
		String goPage = "";
		
		/** 자료 수집 및 정의 */
		// 세션 정보에서 아이디를 가져와 업데이트할때 사용하기 위해 planVO에 세팅
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		planVO.setMemId(memberVO.getMemId());
		
		Map<String,Object> param = new HashMap<String, Object>();
		param.put("req", req);
		param.put("planVO", planVO);
		param.put("imgFile", imgFile);
		param.put("spSday", spSday);
		param.put("spEday", spEday);
		
		/** 서비스 호출 */		
		planService.updatePlan(param);
		
		
		/** 자료 검증 */
		log.debug("serviceResult : {}", param.get("serviceResult"));
		if(param.get("serviceResult") == ServiceResult.OK) {
			ra.addFlashAttribute("message", "등록 성공!");
			ra.addFlashAttribute("msgflag", "su");
			goPage = "redirect:/partner/mygroup.do";
		} else {
			ra.addFlashAttribute("message", "등록 실패!");
			ra.addFlashAttribute("msgflag", "fa");
			goPage = "redirect:/myplan/planMain.do";
		}
		
		return goPage;
		
	}
	
	
}

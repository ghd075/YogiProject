package kr.or.ddit.users.myplan.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.filefilter.FalseFileFilter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
//		HttpSession session = req.getSession();
//		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
//		if(memberVO == null) {
//			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
//			return "redirect:/login/signin.do";
//		}
		//테스트용
		MemberVO memberVO = new MemberVO();
		memberVO.setMemId("chantest1");
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
	
	//세부 플랜 추가
	@PostMapping("/insertDetailPlan")
	@ResponseBody
	public  List<TouritemsVO> insertDetailPlan(@RequestBody DetatilPlannerVO s_planner) {
		log.info("detatilPlannerVO 형태 : " + s_planner);
		planService.insertDetailPlan(s_planner);
		log.info("# " + s_planner.getPlNo() + "번 플래너의 DAY " + s_planner.getSpDay() + " 세부 플랜에 " + s_planner.getContentId() + " 추가");
		List<TouritemsVO> list = planService.selectDayById(s_planner);
		return list;
	}
	
	//세부플랜 리스트 조회
	@PostMapping("/dayselect")
	@ResponseBody 
	public List<TouritemsVO> day(@RequestBody DetatilPlannerVO s_planner) {
		List<TouritemsVO> list = planService.selectDayById(s_planner);
		return list;
	}
	
	//세부 플랜 삭제
	@PostMapping("/deleteDetailPlase")
	@ResponseBody
	public List<TouritemsVO> delete_sp(@RequestBody DetatilPlannerVO s_planner) {
		log.info("detatilPlannerVO 형태 : " + s_planner);
		List<TouritemsVO> list = planService.deleteDetailPlase(s_planner);
		log.info("# "+ s_planner.getPlNo() +"번 플래너의  " + s_planner.getSpNo() + " 번 세부 플랜 삭제");
		return list;
	}
	
	@PostMapping("/detailDeleteAll")
	@ResponseBody
	public List<TouritemsVO> detailDeleteAll(@RequestBody DetatilPlannerVO s_planner) {
		log.info("detatilPlannerVO 형태2 : " + s_planner.toString());
		List<TouritemsVO> list = planService.detailDeleteAll(s_planner);
		return list;
	}
	
	@GetMapping("/getTour")
	@ResponseBody
	public TouritemsVO getTour(@RequestParam String contentId) {
		log.info("contentId : " + contentId);
		TouritemsVO tvo = planService.getTour(contentId);
		return tvo;
	}
	
	
}

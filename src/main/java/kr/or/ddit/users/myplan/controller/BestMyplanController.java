package kr.or.ddit.users.myplan.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.users.myplan.service.PlannerMainService;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.myplan.vo.TouritemsVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myplan")
public class BestMyplanController {
	
	@Inject
	private PlannerMainService plannerService;

	/**
	 * 플래너 메인 페이지 진입
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "/planMain.do", method = RequestMethod.GET)
	public String best(Model model) {
		return "myplan/planMain";
	}
	
	/**
	 * 베스트플랜 ajax
	 * @return
	 */
	@ResponseBody
	@GetMapping("/getSortedByLikes.do")
	public List<PlannerVO> getAllPlansByLikes() {
		
		List<PlannerVO> planList = plannerService.getSortedByLikes();
		log.debug("plansForAreaList : {}", planList.toString());
		
		return planList;
		
	}
	
	/**
	 * 지역별 플랜 ajax
	 * @param areaCode
	 * @return
	 */
	@ResponseBody
	@GetMapping("/getSortedByArea.do")
	public List<PlannerVO> plansForAreas(@RequestParam int areaCode) {
		
		log.debug("areaCode : {}", areaCode);
		List<PlannerVO> plansForAreaList = plannerService.getPlansForArea(areaCode);
		log.debug("plansForAreaList : {}", plansForAreaList.toString());
		
		return plansForAreaList;
		
	}
	
	/**
	 * 좋아요 추가
	 * @param plNo
	 * @param memId
	 * @return
	 */
	@ResponseBody
	@GetMapping("/addLike.do")
	public ServiceResult addLike(@RequestParam int plNo, @RequestParam String memId) {
		
		log.debug("plNo", plNo);
		log.debug("memId", memId);
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("plNo", plNo);
		param.put("memId", memId);
		
		ServiceResult res = plannerService.addLike(param);
		
		return res;
	}
	
	/**
	 * 좋아요 삭제	
	 * @param plNo
	 * @param memId
	 * @return
	 */
	@ResponseBody
	@GetMapping("/delLike.do")
	public ServiceResult delLike(@RequestParam int plNo, @RequestParam String memId) {
		
		log.debug("plNo", plNo);
		log.debug("memId", memId);
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("plNo", plNo);
		param.put("memId", memId);
		
		ServiceResult res = plannerService.delLike(param);
		
		return res;
	}
	
	/**
	 * 이미 누른 좋아요 렌더링을 위한 ajax
	 * @param memId
	 * @return
	 */
	@ResponseBody
	@GetMapping("/alreadyActivatedLike.do")
	public List<PlannerLikeVO> alreadyActivatedLike(@RequestParam String memId) {
		
		List<PlannerLikeVO> plList = plannerService.alreadyActivatedLikeList(memId);
		log.debug("plList : ", plList.toString());
		
		
		return plList;
	}
	
}

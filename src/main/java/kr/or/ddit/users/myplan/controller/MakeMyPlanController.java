package kr.or.ddit.users.myplan.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.users.myplan.service.MyplanService;
import kr.or.ddit.users.myplan.vo.AreaVO;
import kr.or.ddit.users.myplan.vo.SigunguVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/myplan")
public class MakeMyPlanController {

	@Inject
	private MyplanService planService;
	
	@RequestMapping(value = "/makeplan.do", method = RequestMethod.GET)
	public String makeplan(Model model) {
		/** 자료수집 및 정의 */ 
		
		/** 서비스 호출 */ 
//		LocalListVO localList = planService.localList();
		
		/** 반환자료 */ 
		
		/** 자료검증 */
//		log.info("지역 목록 => {}", localList);
		
		/** 자료반환 */ 
//		model.addAttribute("localList", localList);
		
		return "myplan/makeplan";
	}
	
	
	@GetMapping("selectAreaLIst.json")
	@ResponseBody
	public ArrayList<AreaVO> selectAreaList() {
		ArrayList<AreaVO> areaList = planService.areaList();
		log.info("result { }", areaList.toString());
		return areaList;
	}

	@PostMapping("selectSigunguList")
	@ResponseBody
	public ArrayList<SigunguVO> selectSigunguList(@RequestBody HashMap<String, Object> map) {
		String areaCode = (String)map.get("areaCode");
		log.info("받아오는 값 : {}", areaCode);
		ArrayList<SigunguVO> sigunguList = planService.sigunguList(areaCode);
		log.info("result { }", sigunguList.toString());
		return sigunguList;
	}
	
}

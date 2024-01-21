package kr.or.ddit;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import kr.or.ddit.indexsearch.service.IndexSearchService;
import kr.or.ddit.users.myplan.vo.JourneyinfoVO;
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
		log.info("journeyList8 : " + journeyList8.toString());
		
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
	
}

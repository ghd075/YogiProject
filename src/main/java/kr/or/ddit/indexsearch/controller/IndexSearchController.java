package kr.or.ddit.indexsearch.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.indexsearch.service.IndexSearchService;
import kr.or.ddit.indexsearch.vo.JourneyinfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/index")
public class IndexSearchController {

	@Inject
	private IndexSearchService indexSearchService;
	
	// 랜딩 페이지 > ajax > 여행 정보(최신글 기준, 최대 8건) 검색 함수
	@GetMapping("/ajaxSearch.do")
	@ResponseBody
	public List<JourneyinfoVO> journeyList8(JourneyinfoVO journeyVO) {
		log.info("journeyVO : {}" , journeyVO);
		return indexSearchService.searchJourneyList8(journeyVO);
	}
	
}

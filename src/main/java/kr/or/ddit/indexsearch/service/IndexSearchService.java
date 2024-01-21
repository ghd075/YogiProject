package kr.or.ddit.indexsearch.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.indexsearch.vo.JourneyinfoVO;

public interface IndexSearchService {

	public void informationList8(Map<String, Object> param);
	public List<JourneyinfoVO> searchJourneyList8(JourneyinfoVO journeyVO);

}

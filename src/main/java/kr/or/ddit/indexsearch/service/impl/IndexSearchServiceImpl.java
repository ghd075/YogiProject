package kr.or.ddit.indexsearch.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.indexsearch.service.IndexSearchService;
import kr.or.ddit.indexsearch.vo.JourneyinfoVO;
import kr.or.ddit.mapper.IndexSearchMapper;

@Service
public class IndexSearchServiceImpl implements IndexSearchService {

	@Inject
	private IndexSearchMapper indexSearchMapper;
	
	@Override
	public void informationList8(Map<String, Object> param) {
		/** 파라미터 조회 */
		/** 파라미터 정의 */
		List<JourneyinfoVO> journeyList8 = new ArrayList<JourneyinfoVO>();
		
		/** 메인로직 처리 */
		journeyList8 = indexSearchMapper.informationList8();
		
		/** 반환자료 저장 */
		param.put("journeyList8", journeyList8);
	}

	@Override
	public List<JourneyinfoVO> searchJourneyList8(JourneyinfoVO journeyVO) {
		return indexSearchMapper.searchJourneyList8(journeyVO);
	}

}

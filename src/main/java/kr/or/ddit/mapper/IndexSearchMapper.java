package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.indexsearch.vo.JourneyinfoVO;

public interface IndexSearchMapper {

	public List<JourneyinfoVO> informationList8();
	public List<JourneyinfoVO> searchJourneyList8(JourneyinfoVO journeyVO);

}

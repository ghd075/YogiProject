package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.myplan.vo.JourneyinfoVO;
import kr.or.ddit.vo.RealTimeSenderVO;

public interface JourneyMapper {

	public int inforReg(JourneyinfoVO journeyVO);
	public List<JourneyinfoVO> informationList();
	public JourneyinfoVO selectJourney(int infoNo);
	public int inforModify(JourneyinfoVO journeyVO);
	public int deleteInfor(int infoNo);
	public List<JourneyinfoVO> searchJourneyList(JourneyinfoVO journeyVO);

}

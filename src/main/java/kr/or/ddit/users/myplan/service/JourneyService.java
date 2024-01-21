package kr.or.ddit.users.myplan.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.users.myplan.vo.JourneyinfoVO;
import kr.or.ddit.utils.ServiceResult;

public interface JourneyService {

	public ServiceResult inforReg(HttpServletRequest req, JourneyinfoVO journeyVO);
	public void informationList(Map<String, Object> param);
	public JourneyinfoVO selectJourney(int infoNo);
	public ServiceResult inforModify(HttpServletRequest req, JourneyinfoVO journeyVO);
	public ServiceResult inforDelete(int infoNo);
	public List<JourneyinfoVO> searchJourneyList(JourneyinfoVO journeyVO);

}

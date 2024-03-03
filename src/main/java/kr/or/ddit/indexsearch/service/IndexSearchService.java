package kr.or.ddit.indexsearch.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.indexsearch.vo.JourneyinfoVO;
import kr.or.ddit.users.login.vo.MemberVO;

public interface IndexSearchService {

	public void informationList8(Map<String, Object> param);
	public List<JourneyinfoVO> searchJourneyList8(JourneyinfoVO journeyVO);
	public List<MemberVO> ajaxMembersId();
	public void ajaxRtAlert(Map<String, Object> param);
	public void ajaxRtSenderGetMsgFn(Map<String, Object> param);
	public void ajaxRtAlertRead(Map<String, Object> param);
	public MemberVO planDetailCreateMemId(String plNo);
	public MemberVO loginMemInfoRtAlertSaveInfo(MemberVO loginMemVO);
	public void ajaxLoginRtAlertRemove(Map<String, Object> param);
	public void rtAlertClickInit(Map<String, Object> param);

}

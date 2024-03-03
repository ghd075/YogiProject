package kr.or.ddit.users.partner.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;


import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.utils.ServiceResult;

public interface MyTripService {
 
	public void myTripList(Map<String, Object> param);
	public List<PlanerVO> searchPlanerList(PlanerVO planerVO);
	public void chgStatusPlan(Map<String, Object> param);
	public void deletePlan(Map<String, Object> param);
	public void meetsquareRoom(Map<String, Object> param);
	public PlanerVO excludeNonUser(PlanerVO planerVO);
	public void acceptMem(Map<String, Object> param);
	public void rejectMem(Map<String, Object> param);
	public void chgStatusJoiner(Map<String, Object> param);
	public void ajaxChatContSave(Map<String, Object> param);
	public void groupRecruitEnded(Map<String, Object> param);
	public void chatContTxtDown(Map<String, Object> param) ;
	public void chatContDelete(Map<String, Object> param);
	public Map<String, Object> planShare(HttpServletRequest request, Map<String, Object> param) throws IOException;
	public ServiceResult travelTheEnd(int plNo);

}

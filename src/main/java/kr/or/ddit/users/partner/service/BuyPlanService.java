package kr.or.ddit.users.partner.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.utils.ServiceResult;

public interface BuyPlanService {

	public void getAllPlans(Map<String, Object> param);
	public long getCurNum(long plNo);
	public void getGroupPoint(Map<String, Object> param);
	public void getDeductStep(Map<String, Object> param2);
	public int getMemPoint(String memId);
	public void chargePoint(Map<String, Object> param);
	public int isAllGmDeducted(long plNo);
	public void updateGmAndG(Map<String, Object> param);
	public String getMateGroupStatus(long plNo);
	public List<PlanerVO> getAllMembers(Map<String, Object> param);
	public void isAllDeducted(Map<String, Object> param);
	public void ajaxRtAlertBp(Map<String, Object> param);

}

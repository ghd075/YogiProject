package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.partner.vo.MategroupVO;
import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.vo.RealTimeSenderVO;

public interface BuyPlanMapper {

	public PlannerVO getAllDpsBuyPlan(long plNo);
	public List<DetatilPlannerVO> getDayDpsBuyPlan(DetatilPlannerVO dpParam);
	public int getCurNum(long plNo);
	public PlanerVO getGroupPoint(long plNo);
	public int getDeductStep(Map<String, Object> param2);
	public int getMemPoint(String memId);
	public int chargePoint(Map<String, Object> param);
	public int changeAgreeStatus(Map<String, Object> param);
	public int getResultPoint(long plNo);
	public int updateGroupPoint(Map<String, Object> param);
	public int isAllGmDeducted(long plNo);
	public int updateGroupMemberStatus(long plNo);
	public int updateGroupStatus(long plNo);
	public String getMateGroupStatus(long plNo);
	public List<PlanerVO> getAllMembers(long plNo);
	public int insertPointLog(Map<String, Object> param);
	public int getCurrentGroupPoint(long plNo);
	public int isAllDeducted(long plNo);
	public int insertSender(RealTimeSenderVO realVO);
	public void insertReceiver(RealTimeSenderVO realVO);

}

package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;

public interface BuyPlanMapper {

	public PlannerVO getAllDpsBuyPlan(long plNo);
	public List<DetatilPlannerVO> getDayDpsBuyPlan(DetatilPlannerVO dpParam);
	public int getCurNum(long plNo);

}

package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;

public interface PlannerDetailMapper {

	public PlannerVO getPlanDetail(long plNo);
	public List<DetatilPlannerVO> getPlanDetailDay(DetatilPlannerVO dpParam);
	public int joinGroup(Map<String, Object> param);
	public long getMg(long plNo);
	public PlannerVO joinCheck(Map<String, Object> param);
	public int getCurNum(long plNo);

}

package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.myplan.vo.TouritemsVO;

public interface PlannerMainMapper {
	
	// 플래너 메인페이지
	public List<PlannerVO> getSortedByLikes();
	public List<PlannerVO> planList();
	public List<PlannerVO> planAreaList();
	public List<PlannerVO> plansForArea(int areaCode);
	public int addLike(Map<String, Object> param);
	public List<PlannerLikeVO> alreadyActivatedLikeList(String memId);
	public int delLike(Map<String, Object> param);
	public PlannerVO getPlanDetail(long plNo);
	public List<DetatilPlannerVO> getPlanDetailDay(DetatilPlannerVO dpParam);
	

}

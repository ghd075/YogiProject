package kr.or.ddit.users.myplan.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.myplan.vo.TouritemsVO;
import kr.or.ddit.utils.ServiceResult;

public interface PlannerMainService {
	public List<PlannerVO> getSortedByLikes();
	public List<PlannerVO> getBestPlansList();
	public List<PlannerVO> getPlansForAreaList();
	public List<PlannerVO> getPlansForArea(int areaCode);
	public ServiceResult addLike(Map<String, Object> param);
	public List<PlannerLikeVO> alreadyActivatedLikeList(String memId);
	public ServiceResult delLike(Map<String, Object> param);
}


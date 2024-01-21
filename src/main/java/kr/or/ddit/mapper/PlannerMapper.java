package kr.or.ddit.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.or.ddit.users.myplan.vo.AreaVO;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.users.myplan.vo.PlannerListVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.myplan.vo.SearchCodeVO;
import kr.or.ddit.users.myplan.vo.SigunguVO;
import kr.or.ddit.users.myplan.vo.TouritemsVO;

public interface PlannerMapper {

	public ArrayList<AreaVO> areaList();

	public ArrayList<SigunguVO> sigunguList(String areaCode);

	public void save(TouritemsVO tourItemsList);

	public List<TouritemsVO> searchResult(SearchCodeVO searchCode);

	public int contentCnt(SearchCodeVO searchCode);

	public int newPlanner(PlannerVO plannerVO);

	public void insertDetailPlan(DetatilPlannerVO s_planner);

	public List<TouritemsVO> selectDayById(DetatilPlannerVO s_planner);

	public void deleteDetailPlase(DetatilPlannerVO s_planner);

	public PlannerListVO selectAreaType(String areaName);

	public PlannerListVO selectSigogunType(String areaName);
	
	public List<PlannerVO> getSortedByLikes();
	public List<PlannerVO> planList();
	public List<PlannerVO> planAreaList();
	public List<PlannerVO> plansForArea(int areaCode);
	public int addLike(Map<String, Object> param);
	public List<PlannerLikeVO> alreadyActivatedLikeList(String memId);
	public int delLike(Map<String, Object> param);

	public TouritemsVO getTour(String contentId);

	public void detailDeleteAll(DetatilPlannerVO s_planner);
	
}

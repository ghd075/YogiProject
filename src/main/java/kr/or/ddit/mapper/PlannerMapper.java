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

	// 기존 코드
	public ArrayList<AreaVO> areaList();
	public ArrayList<SigunguVO> sigunguList(String areaCode);
	public void save(TouritemsVO tourItemsList);
	public List<TouritemsVO> searchResult(SearchCodeVO searchCode);
	public int contentCnt(SearchCodeVO searchCode);
	public int newPlanner(PlannerVO plannerVO);
	public PlannerListVO selectAreaType(String areaName);
	public PlannerListVO selectSigogunType(String areaName);

	// 세부플랜 CRUD
	public List<TouritemsVO> selectDayById(DetatilPlannerVO s_planner);
	public TouritemsVO getTour(String contentId);
	public int insertDetailPlan(DetatilPlannerVO s_planner);
	public void detailDeleteAll(DetatilPlannerVO s_planner);
	public int deleteAllDetailPlan(DetatilPlannerVO s_planner);
	public int deleteOneDetailPlan(DetatilPlannerVO s_planner);
	public TouritemsVO getDetailPlan(DetatilPlannerVO s_planner);
	public int deleteAllAllDetailPlan(long plNo);
	public int updatePlan(PlannerVO plan);
	public List<DetatilPlannerVO> getOneDetailPlan(long plNo);
	public PlannerVO getOnePlan(long plNo);
	public void insertMategroup(PlannerVO plan);
	public void insertMategroupMem(PlannerVO plan);
	
}

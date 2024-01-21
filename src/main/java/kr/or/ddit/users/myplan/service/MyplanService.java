package kr.or.ddit.users.myplan.service;

import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.users.myplan.vo.AreaVO;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerListVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.myplan.vo.SearchCodeVO;
import kr.or.ddit.users.myplan.vo.SearchResultVO;
import kr.or.ddit.users.myplan.vo.SigunguVO;
import kr.or.ddit.users.myplan.vo.TouritemsVO;

public interface MyplanService {

	public ArrayList<AreaVO> areaList();

	public ArrayList<SigunguVO> sigunguList(String areaCode);
	
	public SearchResultVO searchedList(SearchCodeVO searchCode);
	
	public void newPlanner(PlannerVO plannerVO);

	public void insertDetailPlan(DetatilPlannerVO s_planner);

	public List<TouritemsVO> selectDayById(DetatilPlannerVO s_planner);

	public List<TouritemsVO> deleteDetailPlase(DetatilPlannerVO s_planner);

	public PlannerListVO planList(String planType, String chageToEng);

	public TouritemsVO getTour(String contentId);

	public List<TouritemsVO> detailDeleteAll(DetatilPlannerVO s_planner);

}

package kr.or.ddit.users.myplan.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.users.myplan.vo.AreaVO;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerListVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.myplan.vo.SearchCodeVO;
import kr.or.ddit.users.myplan.vo.SearchResultVO;
import kr.or.ddit.users.myplan.vo.SigunguVO;
import kr.or.ddit.users.myplan.vo.TouritemsVO;
import kr.or.ddit.utils.ServiceResult;

public interface MyplanService {

	public ArrayList<AreaVO> areaList();
	public ArrayList<SigunguVO> sigunguList(String areaCode);
	public SearchResultVO searchedList(SearchCodeVO searchCode);
	public void newPlanner(PlannerVO plannerVO);
	public PlannerListVO planList(String planType, String chageToEng);
	
	// 세부플랜 CRUD
	public List<TouritemsVO> selectDayById(DetatilPlannerVO s_planner);
	public TouritemsVO getTour(String contentId);
	public TouritemsVO insertDetailPlan(DetatilPlannerVO s_planner);
	public ServiceResult deleteAllDetailPlan(DetatilPlannerVO s_planner);
	public ServiceResult deleteOneDetailPlan(DetatilPlannerVO s_planner);
	public ServiceResult deleteAllAllDetailPlan(long plNo);
	public void updatePlan(Map<String, Object> param);
	public ServiceResult delPlan(long plNo);

}

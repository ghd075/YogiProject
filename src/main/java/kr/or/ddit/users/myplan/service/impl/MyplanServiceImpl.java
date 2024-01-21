package kr.or.ddit.users.myplan.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.PlannerMapper;
import kr.or.ddit.users.myplan.service.MyplanService;
import kr.or.ddit.users.myplan.vo.*;

@Service
public class MyplanServiceImpl implements MyplanService {

	@Inject
	private PlannerMapper plannerMapper;
	
	@Override
	public ArrayList<AreaVO> areaList() {
		return plannerMapper.areaList();
	}

	@Override
	public ArrayList<SigunguVO> sigunguList(String areaCode) {
		return plannerMapper.sigunguList(areaCode);
	}

	@Override
	public SearchResultVO searchedList(SearchCodeVO searchCode) {
		List<TouritemsVO> tourList = plannerMapper.searchResult(searchCode);
		int tourCnt = plannerMapper.contentCnt(searchCode);
		SearchResultVO result = new SearchResultVO(tourList, tourCnt);
		return result;
	}

	@Override
	public void newPlanner(PlannerVO plannerVO) {
		plannerMapper.newPlanner(plannerVO);
	}

	@Override
	public void insertDetailPlan(DetatilPlannerVO s_planner) {
		plannerMapper.insertDetailPlan(s_planner);
	}

	@Override
	public List<TouritemsVO> selectDayById(DetatilPlannerVO s_planner) {
		return plannerMapper.selectDayById(s_planner);
	}

	@Override
	public List<TouritemsVO> deleteDetailPlase(DetatilPlannerVO s_planner) {
		plannerMapper.deleteDetailPlase(s_planner);
		return plannerMapper.selectDayById(s_planner);
	}

	@Override
	public PlannerListVO planList(String planType, String areaName) {
	    if (planType.equals("areaType")) {
	        return plannerMapper.selectAreaType(areaName);
	    } else if (planType.equals("sigogunType")) {
	        return plannerMapper.selectSigogunType(areaName);
	    } else {
	        throw new IllegalArgumentException("Invalid planType: " + planType);
	    }
	}

	@Override
	public TouritemsVO getTour(String contentId) {
		return plannerMapper.getTour(contentId);
	}

	@Override
	public List<TouritemsVO> detailDeleteAll(DetatilPlannerVO s_planner) {
		plannerMapper.detailDeleteAll(s_planner);
		return plannerMapper.selectDayById(s_planner);
	}

}

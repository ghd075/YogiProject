package kr.or.ddit.users.myplan.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.PlannerMapper;
import kr.or.ddit.users.myplan.service.PlannerMainService;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.utils.ServiceResult;

@Service
public class PlannerMainServiceImpl implements PlannerMainService {

	@Inject
	private PlannerMapper plannerMapper;
	
	@Override
	public List<PlannerVO> getSortedByLikes() {
		return plannerMapper.getSortedByLikes();
	}
	
	@Override
	public List<PlannerVO> getBestPlansList() {
		return plannerMapper.planList();
	}

	@Override
	public List<PlannerVO> getPlansForAreaList() {
		return plannerMapper.planAreaList();
	}

	@Override
	public List<PlannerVO> getPlansForArea(int areaCode) {
		return plannerMapper.plansForArea(areaCode);
	}

	@Override
	public ServiceResult addLike(Map<String, Object> param) {
		ServiceResult sr = null;
		
		int res = plannerMapper.addLike(param);
		
		if(res > 0) {
			sr = ServiceResult.OK;
		} else {
			sr = ServiceResult.FAILED;
		}
		return sr; 
		
	}

	@Override
	public List<PlannerLikeVO> alreadyActivatedLikeList(String memId) {
		return plannerMapper.alreadyActivatedLikeList(memId);
	}

	@Override
	public ServiceResult delLike(Map<String, Object> param) {
		ServiceResult sr = null;
		
		int res = plannerMapper.delLike(param);
		
		if(res > 0) {
			sr = ServiceResult.OK;
		} else {
			sr = ServiceResult.FAILED;
		}
		return sr; 
	}

}

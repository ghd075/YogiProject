package kr.or.ddit.users.myplan.service.impl;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.PlannerMainMapper;
import kr.or.ddit.users.myplan.service.PlannerMainService;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.utils.ServiceResult;

@Service
@Transactional(rollbackFor = Exception.class)
public class PlannerMainServiceImpl implements PlannerMainService {

	@Inject
	private PlannerMainMapper plannerMainMapper;
	
	@Override
	public List<PlannerVO> getSortedByLikes() {
		return plannerMainMapper.getSortedByLikes();
	}
	
	@Override
	public List<PlannerVO> getBestPlansList() {
		return plannerMainMapper.planList();
	}

	@Override
	public List<PlannerVO> getPlansForAreaList() {
		return plannerMainMapper.planAreaList();
	}

	@Override
	public List<PlannerVO> getPlansForArea(int areaCode) {
		return plannerMainMapper.plansForArea(areaCode);
	}

	@Override
	public ServiceResult addLike(Map<String, Object> param) {
		ServiceResult sr = null;
		
		int res = plannerMainMapper.addLike(param);
		
		if(res > 0) {
			sr = ServiceResult.OK;
		} else {
			sr = ServiceResult.FAILED;
		}
		return sr; 
		
	}

	@Override
	public List<PlannerLikeVO> alreadyActivatedLikeList(String memId) {
		return plannerMainMapper.alreadyActivatedLikeList(memId);
	}

	@Override
	public ServiceResult delLike(Map<String, Object> param) {
		ServiceResult sr = null;
		
		int res = plannerMainMapper.delLike(param);
		
		if(res > 0) {
			sr = ServiceResult.OK;
		} else {
			sr = ServiceResult.FAILED;
		}
		return sr; 
	}

}

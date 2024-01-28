package kr.or.ddit.users.myplan.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.PlannerMainMapper;
import kr.or.ddit.mapper.PlannerMapper;
import kr.or.ddit.users.myplan.service.PlannerMainService;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.myplan.vo.TouritemsVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
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

	@Override
	public Map<String, Object> getPlanDetail(long plNo) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		PlannerVO pvo = plannerMainMapper.getPlanDetail(plNo);
		param.put("pvo", pvo);
		log.debug("pvo : {}", pvo);
		
		DetatilPlannerVO dpParam = null; 
		
		int cnt = 0;
				
		for(int i = 0; i < 5; i++) {
			dpParam = new DetatilPlannerVO();
			dpParam.setSpDay(i+1);
			dpParam.setPlNo(plNo);
			List<DetatilPlannerVO> daydpList = plannerMainMapper.getPlanDetailDay(dpParam);
			if(daydpList.size() > 0) {
				param.put("day" + (i+1), daydpList);
				cnt = cnt + 1;
			}
		}
		
		param.put("dayCnt", cnt);
		
		log.debug("param : {}", param.toString());
		
		return param;
	}

}

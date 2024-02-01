package kr.or.ddit.users.partner.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.BuyPlanMapper;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.partner.service.BuyPlanService;

@Service
public class BuyPlanServiceImpl implements BuyPlanService {

	@Inject
	private BuyPlanMapper buyPlanMapper; 
	
	@Override
	public Map<String, Object> getAllPlans(long plNo) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		PlannerVO pvo = buyPlanMapper.getAllDpsBuyPlan(plNo);
		param.put("pvo", pvo);
		
		DetatilPlannerVO dpParam = null; 
		
		int cnt = 0;
				
		for(int i = 0; i < 5; i++) {
			dpParam = new DetatilPlannerVO();
			dpParam.setSpDay(i+1);
			dpParam.setPlNo(plNo);
			List<DetatilPlannerVO> daydpList = buyPlanMapper.getDayDpsBuyPlan(dpParam);
			if(daydpList.size() > 0) {
				param.put("day" + (i+1), daydpList);
				cnt = cnt + 1;
			}
		}
		
		param.put("dayCnt", cnt);
		
		return param;
	}

	@Override
	public long getCurNum(long plNo) {
		return buyPlanMapper.getCurNum(plNo);
	}

}

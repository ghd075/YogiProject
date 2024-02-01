package kr.or.ddit.users.myplan.service;

import java.util.Map;

import kr.or.ddit.users.myplan.vo.PlannerVO;

public interface PlannerDetailService {

	public Map<String, Object> getPlanDetail(long plNo, Map<String, Object> param);
	public void joinGroup(Map<String, Object> param);

}

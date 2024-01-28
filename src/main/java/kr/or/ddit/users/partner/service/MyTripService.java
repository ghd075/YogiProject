package kr.or.ddit.users.partner.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.partner.vo.PlanerVO;

public interface MyTripService {

	public void myTripList(Map<String, Object> param);
	public List<PlanerVO> searchPlanerList(PlanerVO planerVO);
	public void chgStatusPlan(Map<String, Object> param);

}

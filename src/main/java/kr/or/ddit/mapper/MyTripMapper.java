package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.partner.vo.PlanerVO;

public interface MyTripMapper {

	public List<PlanerVO> myTripList(PlanerVO planerVO);
	public List<PlanerVO> searchPlanerList(PlanerVO planerVO);
	public int chgStatusPlan(PlanerVO planerVO);

}

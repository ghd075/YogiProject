package kr.or.ddit.api.service;

import java.util.List;

import kr.or.ddit.api.vo.TouritemsVO;

public interface PlannerService {

	public void save(List<TouritemsVO> tourItemsList);
}

package kr.or.ddit.api.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.api.service.PlannerService;
import kr.or.ddit.api.vo.TouritemsVO;
import kr.or.ddit.mapper.PlannerMapper;

@Service
public class PlannerServiceImpl implements PlannerService {

	@Inject
	private PlannerMapper plannerMapper;

	@Override
	public void save(List<TouritemsVO> tourItemsList) {
		for(TouritemsVO tour : tourItemsList)
			plannerMapper.save(tour);
	}
}

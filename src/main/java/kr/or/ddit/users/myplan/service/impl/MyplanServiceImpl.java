package kr.or.ddit.users.myplan.service.impl;

import java.util.ArrayList;

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
	public LocalListVO localList() {
//		ArrayList<AreaVO> areaList = plannerMapper.areaList();
//		ArrayList<SigunguVO> sigunguList = plannerMapper.sigunguList();
//		LocalListVO localList = new LocalListVO(areaList, sigunguList);
//		if(localList.getAreaList().size() == 0) {
//			return null;
//		}else {
//			return localList;
//		}
		return null;
	}

	@Override
	public ArrayList<AreaVO> areaList() {
		return plannerMapper.areaList();
	}

	@Override
	public ArrayList<SigunguVO> sigunguList(String areaCode) {
		return plannerMapper.sigunguList(areaCode);
	}


}

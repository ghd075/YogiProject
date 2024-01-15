package kr.or.ddit.mapper;

import java.util.ArrayList;

import kr.or.ddit.users.myplan.vo.*;

public interface PlannerMapper {

	public ArrayList<AreaVO> areaList();

	public ArrayList<SigunguVO> sigunguList(String areaCode);

}

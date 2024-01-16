package kr.or.ddit.mapper;

import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.api.vo.TouritemsVO;
import kr.or.ddit.users.myplan.vo.*;

public interface PlannerMapper {

	public ArrayList<AreaVO> areaList();

	public ArrayList<SigunguVO> sigunguList(String areaCode);

	public void save(TouritemsVO tourItemsList);

}

package kr.or.ddit.users.myplan.service;

import java.util.ArrayList;

import kr.or.ddit.users.myplan.vo.AreaVO;
import kr.or.ddit.users.myplan.vo.LocalListVO;
import kr.or.ddit.users.myplan.vo.SigunguVO;

public interface MyplanService {

	public LocalListVO localList();

	public ArrayList<AreaVO> areaList();

	public ArrayList<SigunguVO> sigunguList(String areaCode);
}

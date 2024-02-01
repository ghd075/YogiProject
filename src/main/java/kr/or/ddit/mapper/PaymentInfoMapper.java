package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.mypage.vo.PointVO;

public interface PaymentInfoMapper {

	public int selectPoint(String memId);

	public int updatePoint(PointVO pointVO);

	public void insertPointHistory(PointVO pointVO);

	public List<PointVO> selectUserPointList(Map<String, String> searchParam);

	public int selectUserPointCount(Map<String, String> searchParam);

}

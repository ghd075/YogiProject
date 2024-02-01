package kr.or.ddit.users.mypage.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.mypage.vo.PointVO;

public interface PaymentInfoService {

	public void selectMemPoint(Map<String, Object> param);

	public void updatePoint(PointVO pointVO);

	public List<PointVO> selectUserPointList(Map<String, String> searchParam);

	public int selectUserPointCount(Map<String, String> searchParam);
}

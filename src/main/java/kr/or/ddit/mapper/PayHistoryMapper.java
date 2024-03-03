package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.mypage.vo.PayHistoryVO;
import kr.or.ddit.users.reserve.air.vo.AirReceiptVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface PayHistoryMapper {

	 public int selectHistoryCount(PaginationInfoVO<PayHistoryVO> pageVO);

	public List<PayHistoryVO> selectPayHistoryList(PaginationInfoVO<PayHistoryVO> pageVO);

	public List<AirReceiptVO> selectAirReceipt(Map<String, String> map);

}

package kr.or.ddit.users.mypage.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Workbook;

import kr.or.ddit.users.mypage.vo.PayHistoryVO;
import kr.or.ddit.users.reserve.air.vo.AirReceiptVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface PayHistoryService {

	public int selectHistoryCount(PaginationInfoVO<PayHistoryVO> pageVO);

	public List<PayHistoryVO> selectPayHistoryList(PaginationInfoVO<PayHistoryVO> pageVO);

	public List<AirReceiptVO> selectAirReceipt(String airReserveno, String ticketType);

	public Workbook createPayHistoryExcel(HttpSession session);

}

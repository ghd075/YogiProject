package kr.or.ddit.users.mypage.service.impl;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.PayHistoryMapper;
import kr.or.ddit.users.mypage.service.PayHistoryService;
import kr.or.ddit.users.mypage.vo.PayHistoryVO;
import kr.or.ddit.users.reserve.air.utils.api.AirApiVoMapper;
import kr.or.ddit.users.reserve.air.vo.AirReceiptVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Transactional
@Slf4j
@Service
public class PayHistoryServiceImpl implements PayHistoryService{

	@Inject
	private PayHistoryMapper payHistoryMapper;
	
	/* 항공권 결제리스트 현재 페이지 수 조회 */
	@Override
	public int selectHistoryCount(PaginationInfoVO<PayHistoryVO> pageVO) {
		System.out.println("pageVO : "+pageVO);
		return payHistoryMapper.selectHistoryCount(pageVO);
	}
	

	/* 항공권 결제 리스트 검색 */
	@Override
	public List<PayHistoryVO> selectPayHistoryList(PaginationInfoVO<PayHistoryVO> pageVO) {
		
		List<PayHistoryVO> payHistoryVO = payHistoryMapper.selectPayHistoryList(pageVO);
		if(payHistoryVO == null) {
		  log.debug("결제리스트 조회 실패!");
		  return null;
		}
		//항공사 로고 정보세팅
		for (PayHistoryVO vo : payHistoryVO) {
			AirApiVoMapper.setAirlineLogoURL(vo.getAirlineName(), vo);
		}
		return payHistoryVO;
	}
	

	/* 항공권 확인 버튼 클릭 시 처리 */
	@Override
	public List<AirReceiptVO> selectAirReceipt(String airReserveno, String ticketType) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("airReserveno", airReserveno);
		map.put("ticketType", ticketType);
		return payHistoryMapper.selectAirReceipt(map);
	}
	

	/* 항공권 구매내역을 엑셀파일의 데이터로 세팅 */
	@Override
	public Workbook createPayHistoryExcel(HttpSession session) {
		
		//1.리스트 데이터 가져오기
		PaginationInfoVO<PayHistoryVO> pageInfo 
		         = (PaginationInfoVO<PayHistoryVO>) session.getAttribute("pageVO");
		List<PayHistoryVO> dataList = pageInfo.getDataList();
		DecimalFormat formatter = new DecimalFormat("#,###");
		
	    //2.workbook 생성
		Workbook workbook = new XSSFWorkbook();
		CellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setWrapText(true);
		cellStyle.setBorderLeft(XSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderRight(XSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(XSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderBottom(XSSFCellStyle.BORDER_THIN);
		
		//3.sheet 생성
		Sheet sheet = workbook.createSheet("결제내역");
		sheet.setColumnWidth(1, 4800);
		sheet.setColumnWidth(2, 4800);
		sheet.setColumnWidth(3, 4800);
		sheet.setColumnWidth(4, 4800);
		sheet.setColumnWidth(5, 4800);
		sheet.setColumnWidth(6, 4800);
		sheet.setColumnWidth(7, 4800);
		sheet.setColumnWidth(8, 4800);
		sheet.setColumnWidth(9, 4800);
		sheet.setColumnWidth(10, 4800);
		
		int rowNum = 0;
		Row headrow = sheet.createRow(rowNum++);
		int headcolNum = 0;
		headrow.setHeightInPoints(30);
		headrow.createCell(headcolNum++).setCellValue("NO");
		headrow.createCell(headcolNum++).setCellValue("항공사");
		headrow.createCell(headcolNum++).setCellValue("동행여부");
		headrow.createCell(headcolNum++).setCellValue("여행유형");
		headrow.createCell(headcolNum++).setCellValue("출발(시간)");
		headrow.createCell(headcolNum++).setCellValue("도착(시간)");
		headrow.createCell(headcolNum++).setCellValue("탑승인원");
		headrow.createCell(headcolNum++).setCellValue("1인당 결제금액");
		headrow.createCell(headcolNum++).setCellValue("결제일시");
		headrow.createCell(headcolNum++).setCellValue("결제자");
		
		int rowCount = 1;
		for(PayHistoryVO vo : dataList) {
			//4.row 생성 및 cell데이터 세팅
			Row row = sheet.createRow(rowNum++);
			row.setHeightInPoints(30);
			int colNum = 0;
			
			Cell cell1 = row.createCell(colNum++);
			cell1.setCellStyle(cellStyle);
			cell1.setCellValue(rowCount++);
		
			Cell cell2 = row.createCell(colNum++);
			cell2.setCellStyle(cellStyle);
			cell2.setCellValue(vo.getAirlineName());
			
			Cell cell4 = row.createCell(colNum++);
			cell4.setCellStyle(cellStyle);
			cell4.setCellValue("동행(그룹명 : "+vo.getPlTitle()+")");
			
			if(vo.getTicketType().equals("DAPARTURE")) {
				Cell cell5 = row.createCell(colNum++);
				cell5.setCellStyle(cellStyle);
				cell5.setCellValue("왕복(가는편)");
			}else if(vo.getTicketType().equals("RETURN")) {
				Cell cell5 = row.createCell(colNum++);
				cell5.setCellStyle(cellStyle);
				cell5.setCellValue("왕복(오는편)");
			}
			
			Cell cell6 = row.createCell(colNum++);
			cell6.setCellStyle(cellStyle);
			cell6.setCellValue(vo.getFlightDepairport()+"("+vo.getFlightDeptime()+")");
			
			Cell cell7 = row.createCell(colNum++);
			cell7.setCellStyle(cellStyle);
			cell7.setCellValue(vo.getFlightArrairport()+"("+vo.getFlightArrtime()+")");
			
			Cell cell8 = row.createCell(colNum++);
			cell8.setCellStyle(cellStyle);
			cell8.setCellValue(vo.getAirPersonnum()+"명");
			
			Cell cell9 = row.createCell(colNum++);
			cell9.setCellStyle(cellStyle);
			cell9.setCellValue(formatter.format(vo.getTicketTotalprice())+"원");
			
			Cell cell10 = row.createCell(colNum++);
			cell10.setCellStyle(cellStyle);
			cell10.setCellValue(vo.getAirPayday());
			
			Cell cell11 = row.createCell(colNum++);
			cell11.setCellStyle(cellStyle);
			cell11.setCellValue(vo.getMemId());
		}
		return workbook;
	}

}



























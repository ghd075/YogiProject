package kr.or.ddit.users.mypage.controller;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.mypage.service.PayHistoryService;
import kr.or.ddit.users.mypage.vo.PayHistoryVO;
import kr.or.ddit.users.reserve.air.vo.AirReceiptVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class PayHistoryController {

	@Inject
	private PayHistoryService payHistoryService;
	
	/* 결제내역 조회하기 */
	@ResponseBody
	@RequestMapping(value = "/payHistoryList.do", method = RequestMethod.GET)
	public Map<String, Object> payHistoryList(HttpSession session,
			                    @RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			                    @RequestParam(required = false, defaultValue = "title") String searchType,
			                    @RequestParam(required = false) String searchWord) {
		Map<String, Object> map = new HashMap<String, Object>();
		//id정보 설정
		MemberVO vo = (MemberVO) session.getAttribute("sessionInfo");
		PaginationInfoVO<PayHistoryVO> pageVO = new PaginationInfoVO<PayHistoryVO>(4, 4);
		pageVO.setMemId(vo.getMemId());
		
		//검색여부 검증
		if(StringUtils.isNotBlank(searchWord)) {
			pageVO.setSearchType(searchType);
			pageVO.setSearchWord(searchWord);
			map.put("searchWord", searchWord);
			map.put("searchType", searchType);
		}
		pageVO.setCurrentPage(currentPage);
		
		//현재페이지수 조회
		int totalRecord = payHistoryService.selectHistoryCount(pageVO);
		pageVO.setTotalRecord(totalRecord);
		
		//리스트 검색
		List<PayHistoryVO> dataList = payHistoryService.selectPayHistoryList(pageVO);
		pageVO.setDataList(dataList);
		
		//페이지정보 기억 및 전송
		PaginationInfoVO<PayHistoryVO> pageInfo = (PaginationInfoVO<PayHistoryVO>) session.getAttribute("pageVO");
		if(pageInfo != null) {
			session.removeAttribute("pageVO");
			session.setAttribute("pageVO", pageVO);
		}else {
			session.setAttribute("pageVO", pageVO);
		}
		map.put("pageVO", pageVO);
		
		return map;
	}
	
	
	/* 항공권 확인 버튼 클릭 시 처리 */
	@ResponseBody
	@RequestMapping(value = "/ticketView.do", method = RequestMethod.GET)
	public Map<String, Object> ticketView(String airReserveno, String ticketType) {
		Map<String, Object> map = null;
		List<AirReceiptVO> receiptList = payHistoryService.selectAirReceipt(airReserveno, ticketType);
		if(receiptList == null) {
			map = new HashMap<String, Object>();
			log.debug("조회된 항공티켓이 없습니다!");
			map.put("msg", "FAILED");
			return map;
		}
		map = new HashMap<String, Object>();
		map.put("msg", "SUCCESS");
		map.put("receiptList", receiptList);
		return map;
	}
	
	
	/* 항공권 구매내역을 엑셀파일로 다운로드 요청*/
	@ResponseBody
	@GetMapping("/downloadPayHistoryAsExcel.do")
	public void downloadPayHistoryAsExcel(HttpSession session, HttpServletResponse resp) {
		//1.다운로드 날짜 생성
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd");
		
		//2.엑셀생성 및 데이터 세팅
		Workbook workbook = payHistoryService.createPayHistoryExcel(session);
		if(workbook == null) {
			log.debug("엑셀파일 생성 실패!");
		}
		
		//3.전송데이터 정보 설정
		resp.setContentType("application/octet-stream");
		try {
			resp.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode("항공권_구매내역_"+sdf.format(new Date()), "UTF-8") + ".xlsx");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		}
		
		//4.엑셀파일 전송
		try {
			workbook.write(resp.getOutputStream());
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e.getMessage());
		} finally {
			if(workbook != null) {
				try {
					workbook.close();
				} catch (IOException e) {
					e.printStackTrace();
					throw new RuntimeException(e.getMessage());
				}
			}
		}
	}
	
	/* 숙박결제 내역 */
	@GetMapping("/payHistoryStay.do")
	public String payHistoryStay() {
		
		
		return "mypage/paymentInfo";
	}
	
}































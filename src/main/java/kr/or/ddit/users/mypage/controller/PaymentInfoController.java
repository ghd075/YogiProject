package kr.or.ddit.users.mypage.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.mypage.service.PaymentInfoService;
import kr.or.ddit.users.mypage.service.impl.PayService;
import kr.or.ddit.users.mypage.vo.PointVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class PaymentInfoController {

	@Inject
	private PaymentInfoService paymentInfoService;
	
	@Inject
	private PayService payService;
	
	private IamportClient client = new IamportClient("1106326526400258","gCXZCtHcqDKon8sA4PARVCVc6rFkGo2YRjSBIzk3m4gSBnfWIxzw6BtaR2pE3b1z1rPqyIZYOk2i1wVh");
	
	// 결제관리 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/paymentinfo.do", method = RequestMethod.GET)
	public String paymentinfo(HttpServletRequest req, Model model, @RequestParam(required = false, defaultValue = "0") String plNo) {
		
		/** 자료수집 및 정의 */
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		String memId = memberVO.getMemId();
		Map<String,Object> param = new HashMap<>();
		param.put("memId", memId);
		
		if(!plNo.equals("0")) {
			model.addAttribute("plNo", plNo);
		}
		
		/** 서비스 호출 */
		paymentInfoService.selectMemPoint(param);
		
		/** 반환 자료 */
		int memPoint = (int) param.get("memPoint");
		
		/** 자료검증 */
		log.info("memId : " + memId);
		log.info("memPoint : " + memPoint);
		
		/** 자료반환 */
		model.addAttribute("memPoint", memPoint);
		
		return "mypage/paymentInfo";
	}
	
	// 아임포트 서버로부터 요청
	@ResponseBody
	@RequestMapping(value = "/verify_iamport/{imp_uid}", method = RequestMethod.POST)
	public IamportResponse<Payment> verifyIamportPOST(@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
	    
		log.info("넘어온 imp_uid => 값 : " + imp_uid);
		log.info("client.paymentByImpUid => 값 : " + client.paymentByImpUid(imp_uid));
		
		return client.paymentByImpUid(imp_uid);
	}
	
	
	// 결제 요청 후 DB에 데이터 업데이트 및 추가
	@RequestMapping(value ="/complete", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> paymentComplete(@RequestBody PointVO pointVO) throws Exception {
	    
	    String token = payService.getToken();
	    
	    // 결제 완료된 금액
	    int amount = payService.paymentInfo(pointVO.getImpUid(), token);
	    
	    int res = 1;
	    
	    if (pointVO.getPointAccount() != amount) {
	        res = 0;
	        // 결제 취소
	        payService.payMentCancle(token, pointVO.getImpUid(), amount,"결제 금액 오류");
	        return ResponseEntity.ok(res);
	    }
	    
	    // 포인트 및 사용내역 업데이트
	    paymentInfoService.updatePoint(pointVO);
	    
	    // 응답 데이터 생성
	    Map<String, Object> responseData = new HashMap<>();
	    responseData.put("res", res);
		
	    /** 자료검증 */
	    log.info("넘기는 값들 => {} ", pointVO);
	    log.info("결제 완료된 금액 : " + amount);
	    log.info("아임포트 식별번호 : " + pointVO.getImpUid());

	    // AJAX 응답
	    return ResponseEntity.ok(responseData);
	}

	
	// 결제 요청 후 DB에 데이터 업데이트 및 추가
	@RequestMapping(value ="/payInfo", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> payInfo(@RequestBody Map<String, String> param){
		Map<String, String> searchParam = new HashMap<String, String>();
		searchParam.put("startIndex", param.get("startIndex"));
		searchParam.put("endIndex", param.get("endIndex"));
		searchParam.put("memId", param.get("memId"));
		searchParam.put("filter", param.get("filter"));  // 필터링 옵션 추가
		
		// 포인트 내역 가져오기
		List<PointVO> userPointList = paymentInfoService.selectUserPointList(searchParam);
		
		int totalRecord = paymentInfoService.selectUserPointCount(searchParam); // totalRecord(총 게시글 수)
		
		// 응답 데이터 생성
	    Map<String, Object> responseData1 = new HashMap<>();
	    responseData1.put("userPointList", userPointList);
	    responseData1.put("totalRecord", totalRecord);
	    
	    /** 자료검증 */
	    log.info("넘기는 값들 => {} ", searchParam);
	    log.info("userPointList 리스트 => {} ", userPointList);
	    log.info("totalRecord 값 => " + totalRecord);

	    // AJAX 응답
	    return ResponseEntity.ok(responseData1);
	}
	
}

package kr.or.ddit.users.mypage.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

import kr.or.ddit.users.mypage.service.PaymentInfoService;
import kr.or.ddit.users.mypage.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/mypage")
public class PaymentInfoController {

	@Inject
	private PaymentInfoService paymentInfoService;
	
	private IamportClient client = new IamportClient("1106326526400258","gCXZCtHcqDKon8sA4PARVCVc6rFkGo2YRjSBIzk3m4gSBnfWIxzw6BtaR2pE3b1z1rPqyIZYOk2i1wVh");
	
	// 결제관리 이동
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/paymentinfo.do", method = RequestMethod.GET)
	public String paymentinfo(HttpServletRequest req, Model model) {
		
		/** 자료수집 및 정의 */
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		String memId = memberVO.getMemId();
		Map<String,Object> param = new HashMap<>();
		param.put("memId", memId);
		
		
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
	
	@ResponseBody
	@RequestMapping(value = "/verify_iamport/{imp_uid}", method = RequestMethod.POST)
	public IamportResponse<Payment> verifyIamportPOST(@PathVariable(value = "imp_uid") String imp_uid) throws IamportResponseException, IOException {
	    
		log.info("넘어온 imp_uid => 값 : " + imp_uid);
	   log.info("client.paymentByImpUid => 값 : " + client.paymentByImpUid(imp_uid));
		
		return client.paymentByImpUid(imp_uid);
	}
	
	
}

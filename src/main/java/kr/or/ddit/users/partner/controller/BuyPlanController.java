package kr.or.ddit.users.partner.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.service.PlannerDetailService;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.partner.service.BuyPlanService;
import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.cart.service.CartService;
import kr.or.ddit.users.reserve.stay.vo.AccommodationVO;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.RealTimeSenderVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/partner")
public class BuyPlanController {
	
	@Inject
	private BuyPlanService buyPlanService;
	
	@Inject
	private CartService cartService;  //항공 장바구니 관련 업무
	
	@Inject
	private AirReserveService reserveService;  //항공편 관련 업무
	
	//숙박장바구니 관련
	private boolean stayFlag = false;
	private AccommodationVO acVO = null;
	
	
	// 그룹 여행상품 구매계획 페이지 이동
	@GetMapping("/buyPlan.do")
	public String buyPlan(HttpServletRequest req, @RequestParam long plNo, 
			              String depFlightCode, String arrFlightCode, 
			              @RequestParam(defaultValue = "0") int totalPrice, 
			              @RequestParam(defaultValue = "0") int totalPassenger, 
			              Model model, RedirectAttributes ra,
			              boolean stay) {
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(memberVO == null) {
			ra.addFlashAttribute("message", "로그인 후 사용 가능합니다!");
			return "redirect:/login/signin.do";
		}
		
	   /**1.장바구니 생성 및 항공편 담기*/
	   FlightVO searchVO = (FlightVO) session.getAttribute("searchInfo");
		//1)찜하기 요청 판단
		if(StringUtils.isNotBlank(depFlightCode) && StringUtils.isNotBlank(arrFlightCode)) {
		   
		   //2)찜요청인 경우 기존 장바구니가 있는지 확인, 없을 경우 장바구니 생성하는 작업(그룹당 장바구니 1개)
		   //   장바구니는 담긴 상품이 없어도 delete되지 않는다	   
		   String cartNo = cartService.checkAndMakeCart(plNo, session);
		   if(cartNo == null) {
		   	  log.debug("장바구니 생성 실패");
		      throw new RuntimeException();
		   }else {
		   	  //3)항공편 장바구니에 담기
			  ServiceResult result = cartService.checkAndInsertAircart(cartNo, depFlightCode, arrFlightCode, totalPrice, totalPassenger);
			  if(result.equals(ServiceResult.OK)) {
				
				//4)찜한 항공편 모두 조회(왕복기준)
				List<RoundTripVO> aircartList = cartService.selectAllAirCart(plNo); 
				if(aircartList == null) {
				   log.debug("찜한 항공편이 없습니다.");
				}
				//숙박권 데이터 세팅
				if(stayFlag && acVO != null && stay) {
					model.addAttribute("stayInfo", acVO);
				}
				
				model.addAttribute("aircartList", aircartList);
				model.addAttribute("searchInfo", searchVO);
				model.addAttribute("cartNo", cartNo);
			  }else if(result.equals(ServiceResult.EXIST)){  //장바구니에 항공권 존재 시redirect
				  log.debug("이미 장바구니에 존재하는 상품입니다.");
				  ra.addFlashAttribute("message", "이미 장바구니에 존재하는 상품입니다.");
				  return "redirect:/reserve/air/search/form.do";
			  }
		   }
		}else {
		  //5)찜하기 요청이 아닌경우 기존에 담긴 항공편 조회(왕복기준)
		  String cartNo = cartService.checkAndMakeCart(plNo, session);
		  List<RoundTripVO> aircartList = cartService.selectAllAirCart(plNo); 
		  if(aircartList == null) {
			 log.debug("찜한 항공편이 조회되지 않습니다.");
		  }
		  //6)숙박상품을 담을 경우
		  if(stay){
			  stayFlag = true;
			  acVO = new AccommodationVO();
			  acVO.setTitle("제주신라호텔");
			  acVO.setRoomName("정원 전망 테라스 더블 룸");
			  acVO.setType("블랙 / 5성급 / 호텔");
			  acVO.setPeriod("4박 5일");
			  acVO.setCheckIn("입실시간 14:00");
			  acVO.setCheckOut("퇴실시간 11:00");
			  acVO.setTotalPrice("1,665,888원");
			  acVO.setPicture("/resources/images/stay/list/정원전망테라스더블.PNG");
			  acVO.setPersonNum(4);
			  acVO.setPriceNum(1665888);
              model.addAttribute("stayInfo", acVO);			  
		  }else if(stayFlag && acVO != null) {
			  model.addAttribute("stayInfo", acVO);	
		  }
		  model.addAttribute("aircartList", aircartList);
		  model.addAttribute("searchInfo", searchVO);
		  model.addAttribute("cartNo", cartNo);
		}

		
		/** 그룹플랜 출력*/
		log.debug("plNo : {}", plNo);

		Map<String, Object> param = new HashMap<String, Object>();
		param.put("plNo", plNo);
		
		buyPlanService.getAllPlans(param);
		
		PlannerVO pvo = (PlannerVO)param.get("pvo");
		int dayCnt = (int)param.get("dayCnt");

		
		// 날짜별 데이터 세팅
		for(int i = 0; i < dayCnt; i++) {
			String tempStr = "day" + (i+1);
			List<DetatilPlannerVO> dpvo = (List<DetatilPlannerVO>)param.get("day" + (i+1));
			model.addAttribute(tempStr, dpvo);
		}
		
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = null;
		try {
			jsonString = objectMapper.writeValueAsString(pvo.getDetailList());
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		// n빵을 위한 멤버그룹 현재원 조회
		long curNum = buyPlanService.getCurNum(plNo);
		
		log.debug("curNum : {}", curNum);
		log.debug("pvoJson : {}", jsonString);
		
		model.addAttribute("pvo", pvo);
		model.addAttribute("dayCnt", dayCnt);
		model.addAttribute("curNum", curNum);
		model.addAttribute("pvoJson", jsonString);
		
		
		/** 그룹포인트 관련*/
		String memId = memberVO.getMemId();
		
		// 개인포인트 조회
		int memPoint = buyPlanService.getMemPoint(memId);
		log.debug("memberPoint : {}", memPoint);
		model.addAttribute("memPoint", memPoint);
		
		// 그룹장, 그룹원 판별 및 그룹포인트 조회
		log.debug("memberId : {}", memberVO.getMemId());
		param.put("memId", memId);

		buyPlanService.getGroupPoint(param);
		int groupPoint = (int)param.get("groupPoint");
		String isGroupLeader = (String)param.get("isGroupLeader");
		
		// 차감단계 조회
		Map<String,Object> param2 = new HashMap<String, Object>();
		param2.put("memId", memId);
		param2.put("plNo", plNo);
		buyPlanService.getDeductStep(param2);
		int mategroupAgree = (int)param2.get("mategroupAgree");
		
		/** 로그 */
		log.debug("groupPoint : {}", groupPoint);
		log.debug("isGroupLeader : {}", isGroupLeader);
		log.debug("mategroupAgree : {}", mategroupAgree);
		
		/** 자료 반환 */
		model.addAttribute("groupPoint", groupPoint);
		model.addAttribute("isGroupLeader", isGroupLeader);
		model.addAttribute("mategroupAgree", mategroupAgree);
		
		// 모든 그룹원 포인트 차감 완료 여부
		int isAllGmDeducted = buyPlanService.isAllGmDeducted(plNo);
		log.debug("isAllGmDeducted : {}", isAllGmDeducted);	// agree가 2인 상사람들의 숫자를 현재원과 비교해서 같으면 모든 그룹원이 포인트 차감을 완료했다고 판단함
		model.addAttribute("isAllGmDeducted", isAllGmDeducted);
		
		// 결제확정 여부
		String mategroupStatus = buyPlanService.getMateGroupStatus(plNo);
		log.debug("동행그룹 상태는? : {}", mategroupStatus);	// 2단계면 모집마감, 3단계면 결제확정 상태
		model.addAttribute("confirmPurchasingStep", mategroupStatus);
		
		
		return "partner/buyPlan";
	}
	
	
	/* 장바구니(항공) 삭제 요청 처리 */
	@ResponseBody
	@RequestMapping(value = "/deleteAirCart.do", method = RequestMethod.POST)
	public String deleteAirCart(@RequestBody Map<String, String> cartMap) {
		String resultMsg = null; 
		ServiceResult result = cartService.deleteFlightInCart(cartMap);
		if(result.equals(ServiceResult.OK)) {
			resultMsg = "SUCCESS";
		}else {
			log.debug("장바구니 삭제 실패");
			resultMsg = "FAIL";
		}
		return resultMsg;
	}
	
	
	@ResponseBody
	@PostMapping("/deductPoint.do")
	public Map<String,Object> deductPoint(HttpServletRequest req, @RequestParam int quota, @RequestParam long plNo, @RequestParam int groupPoint) {
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		String memId = memberVO.getMemId();
		
		Map<String, Object> param = new HashMap<String, Object>();
		
		log.debug("quota : {}", quota);
		log.debug("memId : {}", memId);
		
		param.put("quota", quota);
		param.put("memId", memId);
		param.put("plNo", plNo);
		param.put("groupPoint", groupPoint);
		
		buyPlanService.chargePoint(param);
		
		buyPlanService.isAllDeducted(param);
//		int memPoint = buyPlanService.getMemPoint(memId);
//		log.debug("memPoint : {}", memPoint);
		
		
//		Map<String,Object> param = new HashMap<>();
//		param.put("memPoint", memPoint);
		
		
		return param;
	}
	
	@ResponseBody
	@GetMapping("/confirmPurchasing.do")
	public ServiceResult confirmPurchasing(@RequestParam long plNo) {
		Map<String, Object> param = new HashMap<String, Object>();
		
		param.put("plNo", plNo);
		// 업데이 그룹멤버, 업데이트 그룹
		buyPlanService.updateGmAndG(param);
		
		ServiceResult sres = (ServiceResult)param.get("sres");
		
		return sres;
	}
	
	@ResponseBody
	@GetMapping("/getAllMembers.do")
	public List<PlanerVO> getAllMembers(HttpServletRequest req, @RequestParam long plNo) {
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		Map<String, Object> param = new HashMap<String, Object>();

		param.put("memId", memberVO.getMemId());
		param.put("plNo", plNo);
		
		List<PlanerVO> memList = buyPlanService.getAllMembers(param);
		log.debug("memList : {}", memList);
		
		return memList;
	}
	
	@ResponseBody
	@PostMapping("/alertSaveForBuyPlanPage.do")
	public String alertSaveForBuyPlanPage(RealTimeSenderVO realVO) {
		log.info("realVO : {}", realVO);
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("realVO", realVO);
		
		/** 서비스 호출 */
		buyPlanService.ajaxRtAlertBp(param);
		
		/** 반환 자료 */
		ServiceResult result = (ServiceResult) param.get("result");
		String judge = "";
		
		if(result.equals(ServiceResult.OK)) {
			judge = "OK";
		}else {
			judge = "FAIL";
		}
		
		return judge;
	}
	
	

	
}

































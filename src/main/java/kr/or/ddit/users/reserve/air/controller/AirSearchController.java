package kr.or.ddit.users.reserve.air.controller;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import kr.or.ddit.users.reserve.air.service.AirSearchService;
import kr.or.ddit.users.reserve.air.utils.DurationSort;
import kr.or.ddit.users.reserve.air.utils.PriceSort;
import kr.or.ddit.users.reserve.air.utils.api.AirApiVoMapper;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SortVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Controller
@RequestMapping("/reserve/air/search")
public class AirSearchController {

	@Inject
	private AirSearchService searchService;
	
	@Inject
	private AirReserveService reserveService;
	
	private List<RoundTripVO> roundTripList;
	
	@RequestMapping(value = "/form.do", method = RequestMethod.GET)
	public String searchForm(HttpSession session) {
		FlightVO searchVO = (FlightVO) session.getAttribute("searchInfo");
		if(searchVO != null) {
		    session.removeAttribute("searchInfo");
		}
		return "reserve/air/searchForm";
	}
	
	/* 최초 검색화면에서 요청 */
	@RequestMapping(value = "/list.do", method = RequestMethod.POST)
	public String list(FlightVO flightVO, HttpSession session, Model model) {
		log.debug("list() 진입!");
		FlightVO searchVO = (FlightVO) session.getAttribute("searchInfo");
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(searchVO != null) {
		    session.removeAttribute("searchInfo");
		}
		
		//1.최초 기본검색조건 설정
		log.debug("flightVO : "+flightVO);
		flightVO.setTotalCnt(flightVO.getAdultCnt()+flightVO.getYuaCnt()+flightVO.getSoaCnt());
		
		AirApiVoMapper mapper = new AirApiVoMapper();
		mapper.setDepAirportCode(flightVO, flightVO.getFlightDepairport());
		mapper.setArrAirportCode(flightVO, flightVO.getFlightArrairport());
		
		//2.최초 기본검색조건 저장
		session.setAttribute("searchInfo", flightVO);
		
		//3.왕복항공편 검색
		roundTripList = new ArrayList<RoundTripVO>(); 
		roundTripList = searchService.selectAllRoundTripFlight(flightVO, session, "main");
		if(roundTripList == null || roundTripList.size() == 0) {
			model.addAttribute("message", "NO");
		}else {
			SortVO sortVO = searchService.getSortVO();
			session.setAttribute("sortVO", sortVO);

			FlightVO vo = (FlightVO) session.getAttribute("searchInfo");
			List<RoundTripVO> rt = new ArrayList<RoundTripVO>();
			for(int i = 0; i < vo.getNumOfRecord(); i++){
				RoundTripVO r = new RoundTripVO();
				r = roundTripList.get(i);
				rt.add(r);
			}
			//session.setAttribute("roundTripList", roundTripList);  //이미 검색된 값이 존재해도 덮어쓰기
			model.addAttribute("pageList", rt);
			
			//4.찜 기능 구현을 위한 html제작
			Map<String, Object> groupMap = reserveService.selectPoint(memberVO.getMemId());
			List<PlannerVO> groupList =  (List<PlannerVO>) groupMap.get("groupList");
			if(groupMap.get("groupList") == null) {
				model.addAttribute("popover", "<span class='popoverSpan'>개인장바구니</span>");	
			}else {
				String html = "<span class='popoverSpan'>개인장바구니</span><hr>";
			    for(int i = 0; i < groupList.size(); i++) {
			    	html += "<span class='popoverSpan' id='"+groupList.get(i).getPlNo()+"'>"+groupList.get(i).getPlTitle()+"</span>";
			    	if(i != (groupList.size() - 1)) {
			    		html += "<hr>";  
					}
			    }	
				model.addAttribute("popover", html);
			}
		}
	   return "reserve/air/list";
	}
	
	
	/* 더보기 버튼 클릭 시(4개씩 더보여줌) */
	@ResponseBody
	@RequestMapping(value = "/moreList.do", method = RequestMethod.GET)
	public Map<String, Object> moreList(HttpSession session, String type) {
		Map<String, Object> map = new HashMap<String, Object>();
		FlightVO searchVO = (FlightVO) session.getAttribute("searchInfo");
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(searchVO == null) {   
			log.info("세션에 검색정보가 없습니다!");
			map.put("msg", "NO");
			return map;
		}
		
		if(roundTripList == null) {  
			log.info("최초 검색이력이 없습니다!");
			map.put("msg", "NO");
			return map;
		}
		SortVO sortVO = null;
		if(type.equals("price")) {
		  Collections.sort(roundTripList, new PriceSort());  //최저가 정렬
		}else if(type.equals("duration")) {
		  Collections.sort(roundTripList, new DurationSort());  //최단시간 정렬
		}else if(type.equals("recommendation")) {
		  Collections.shuffle(roundTripList);     //추천순 정렬
		  sortVO = new SortVO();
		  sortVO.setRecoDuration(roundTripList.get(0).getAveDuration());
		  sortVO.setRecoPrice(roundTripList.get(0).getRoundTripPrice());
		}else {
			log.debug("정렬type : "+type);
			log.debug("정렬값이 없거나 올바른 정렬값이 아닙니다.");
			map.put("message", "NO");
			return map;
		}
		//출력 레코드 수 증가
	    searchVO.setNumOfRecord(searchVO.getNumOfRecord() + 4);
		
	    //4개만큼 추가로 다시 전송
		List<RoundTripVO> rt = new ArrayList<RoundTripVO>();
		for(int i = 0; i < searchVO.getNumOfRecord(); i++) {
			RoundTripVO r = new RoundTripVO();
			r = roundTripList.get(i);
			rt.add(r);
		}
		map.put("pageList", rt);
		map.put("sortVO", sortVO);
		
		//찜 기능 구현을 위한 html제작
		Map<String, Object> groupMap = reserveService.selectPoint(memberVO.getMemId());
		List<PlannerVO> groupList =  (List<PlannerVO>) groupMap.get("groupList");
		if(groupMap.get("groupList") == null) {
			map.put("popover", "<span class='popoverSpan'>개인장바구니</span>");	
		}else {
			String html = "<span class='popoverSpan'>개인장바구니</span><hr>";
		    for(int i = 0; i < groupList.size(); i++) {
		    	html += "<span class='popoverSpan' id='"+groupList.get(i).getPlNo()+"'>"+groupList.get(i).getPlTitle()+"</span>";
		    	if(i != (groupList.size() - 1)) {
		    		html += "<hr>";  
				}
		    }	
		    map.put("popover", html);
		}
		return map;
	}
	
	
	/* 정렬(최저가,최단시간,추천)탭 버튼 클릭 시 */
	@ResponseBody
	@RequestMapping(value = "/sort.do", method = RequestMethod.GET)
	public Map<String, Object> shortestDurationSort(HttpSession session, String type) {
		Map<String, Object> map = new HashMap<String, Object>();
		FlightVO searchVO = (FlightVO) session.getAttribute("searchInfo");
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		if(searchVO == null) {   
			log.info("세션에 검색정보가 없습니다!");
			map.put("msg", "NO");
			return map;
		}
		
		if(roundTripList == null) {  
			log.info("최초 검색이력이 없습니다!");
			map.put("msg", "NO");
			return map;
		}
		SortVO sortVO = null;
		if(type.equals("price")) {
		  Collections.sort(roundTripList, new PriceSort());  //최저가 정렬
		}else if(type.equals("duration")) {
		  Collections.sort(roundTripList, new DurationSort());  //최단시간 정렬
		}else if(type.equals("recommendation")) {
		  Collections.shuffle(roundTripList);     //추천순 정렬
		  sortVO = new SortVO();
		  sortVO.setRecoDuration(roundTripList.get(0).getAveDuration());
		  sortVO.setRecoPrice(roundTripList.get(0).getRoundTripPrice());
		}else {
			log.debug("정렬type : "+type);
			log.debug("정렬값이 없거나 올바른 정렬값이 아닙니다.");
			map.put("msg", "NO");
			return map;
		}
		//디폴트 레코드 갯수 4
		searchVO.setNumOfRecord(4);
		List<RoundTripVO> rt = new ArrayList<RoundTripVO>();
		for(int i = 0; i < searchVO.getNumOfRecord(); i++) {
			RoundTripVO r = new RoundTripVO();
			r = roundTripList.get(i);
			rt.add(r);
		}
		map.put("pageList", rt);
		map.put("sortVO", sortVO);
		
		//찜 기능 구현을 위한 html제작
		Map<String, Object> groupMap = reserveService.selectPoint(memberVO.getMemId());
		List<PlannerVO> groupList =  (List<PlannerVO>) groupMap.get("groupList");
		if(groupMap.get("groupList") == null) {
			map.put("popover", "<span class='popoverSpan'>개인장바구니</span>");	
		}else {
			String html = "<span class='popoverSpan'>개인장바구니</span><hr>";
		    for(int i = 0; i < groupList.size(); i++) {
		    	html += "<span class='popoverSpan' id='"+groupList.get(i).getPlNo()+"'>"+groupList.get(i).getPlTitle()+"</span>";
		    	if(i != (groupList.size() - 1)) {
		    		html += "<hr>";  
				}
		    }	
		    map.put("popover", html);
		}
		return map;
	}
	
}



























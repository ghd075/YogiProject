package kr.or.ddit.users.reserve.air.controller;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import kr.or.ddit.users.reserve.air.service.AirSearchService;
import kr.or.ddit.users.reserve.air.utils.DurationSort;
import kr.or.ddit.users.reserve.air.utils.PriceSort;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SortVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve/air/subsearch")
public class AirSubSearchController {
	
	@Inject
	private AirSearchService searchService;
	
	@Inject
	private AirReserveService reserveService;
	
	private List<RoundTripVO> roundTripList;

	@ResponseBody
	@RequestMapping(value = "/timeSearch.do", method = RequestMethod.GET)
	public Map<String, Object> timeSearch(HttpSession session, String type, 
			                              String depTime, String arrTime, String durTime) {
	  System.out.println("timeSearch진입!");
	  Map<String, Object> map = new HashMap<String, Object>();
	  FlightVO flightVO = (FlightVO) session.getAttribute("searchInfo");
	  MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
	  
	  //서브 검색조건별로 세팅
	  if(StringUtils.isNotBlank(depTime) && StringUtils.isBlank(arrTime)) {
		  flightVO.setFlightDeptime2(depTime);
		  flightVO.setFlightDuration(durTime);
	  }else if(StringUtils.isBlank(depTime) && StringUtils.isNotBlank(arrTime)) {
		  flightVO.setFlightArrtime2(arrTime);
		  flightVO.setFlightDuration(durTime);
	  }else if(StringUtils.isNotBlank(depTime) && StringUtils.isNotBlank(arrTime)) {
		  flightVO.setFlightDeptime2(depTime);
		  flightVO.setFlightArrtime2(arrTime);
		  flightVO.setFlightDuration(durTime);
	  }else {
		  flightVO.setFlightDuration(durTime);
	  }
	  
	  roundTripList = new ArrayList<RoundTripVO>();
	  roundTripList = searchService.selectAllRoundTripFlight(flightVO, session, "sub");
	  if(roundTripList == null || roundTripList.size() == 0) {
			map.put("msg", "NO");
			return map;
		}else {
			SortVO sortVO = searchService.getSortVO();
			
			if(type.equals("price")) {
				  Collections.sort(roundTripList, new PriceSort());  //최저가 정렬
				}else if(type.equals("duration")) {
				  Collections.sort(roundTripList, new DurationSort());  //최단시간 정렬
				}else if(type.equals("recommendation")) {
				  Collections.shuffle(roundTripList);     //추천순 정렬
				  sortVO.setRecoDuration(roundTripList.get(0).getAveDuration());
				  sortVO.setRecoPrice(roundTripList.get(0).getRoundTripPrice());
				}else {
					log.debug("정렬type : "+type);
					log.debug("정렬값이 없거나 올바른 정렬값이 아닙니다.");
					map.put("msg", "NO");
					return map;
				}
			session.setAttribute("sortVO", sortVO);
			
			flightVO.setNumOfRecord(4);
			List<RoundTripVO> rt = new ArrayList<RoundTripVO>();
			//레코드 사이즈 예외처리
			if(roundTripList.size() < flightVO.getNumOfRecord()) {
				for(int i = 0; i < roundTripList.size(); i++){
					RoundTripVO r = new RoundTripVO();
					r = roundTripList.get(i);
					rt.add(r);
				}
			}else {
				for(int i = 0; i < flightVO.getNumOfRecord(); i++){
					RoundTripVO r = new RoundTripVO();
					r = roundTripList.get(i);
					rt.add(r);
				}
			}
			session.setAttribute("roundTripList", roundTripList);  
			map.put("pageList", rt);
			map.put("sortVO", sortVO);
			map.put("searchInfo", flightVO);
		}
	  
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



















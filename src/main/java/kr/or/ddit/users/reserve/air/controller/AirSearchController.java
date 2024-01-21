package kr.or.ddit.users.reserve.air.controller;
import java.util.ArrayList;
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

import kr.or.ddit.users.reserve.air.service.AirSearchService;
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
		if(searchVO != null) {
		    session.removeAttribute("searchInfo");
		}
		
		//최초 기본검색조건 설정
		log.debug("flightVO : "+flightVO);
		flightVO.setTotalCnt(flightVO.getAdultCnt()+flightVO.getYuaCnt()+flightVO.getSoaCnt());
		
		AirApiVoMapper mapper = new AirApiVoMapper();
		mapper.setDepAirportCode(flightVO, flightVO.getFlightDepairport());
		mapper.setArrAirportCode(flightVO, flightVO.getFlightArrairport());
		
		//최초 기본검색조건 저장
		session.setAttribute("searchInfo", flightVO);
		
		//왕복항공편 검색
		roundTripList = new ArrayList<RoundTripVO>(); 
		roundTripList = searchService.selectAllRoundTripFlight(flightVO, session);
		if(roundTripList == null || roundTripList.size() == 0) {
			model.addAttribute("msg", "NO");
		}else {
			SortVO sortVO = searchService.getSortVO();
			session.setAttribute("sortVO", sortVO);

			FlightVO vo = (FlightVO) session.getAttribute("searchInfo");
			int status = vo.getNumOfRecord();
			List<RoundTripVO> rt = new ArrayList<RoundTripVO>();
			for(int i = status - 4; i < status; i++){
				RoundTripVO r = new RoundTripVO();
				r = roundTripList.get(i);
				rt.add(r);
			}
			session.setAttribute("roundTripList", roundTripList);  //이미 검색된 값이 존재해도 덮어쓰기
			model.addAttribute("pageList", rt);
		}
	   return "reserve/air/list";
	}
	
	/* 더보기 버튼 클릭 시(4개씩 더보여줌) */
	@RequestMapping(value = "/moreList.do", method = RequestMethod.GET)
	public String moreList(HttpServletRequest req, Model model) {
		log.info("moreList() 진입!");
		HttpSession session =  req.getSession();
		FlightVO searchVO = (FlightVO) session.getAttribute("searchInfo");
		if(searchVO == null) {   
			log.info("세션에 검색정보가 없습니다!");
			model.addAttribute("msg", "NO");
			return "reserve/air/list";
		}
		  
		if(roundTripList == null) {  
			log.info("최초 검색이력이 없습니다!");
			model.addAttribute("msg", "NO");
			return "reserve/air/list";
		}
		
		//출력 레코드 수 증가
	    searchVO.setNumOfRecord(searchVO.getNumOfRecord() + 4);
		//4개만큼 얕은복사 후 전송 
		List<RoundTripVO> rt = new ArrayList<RoundTripVO>();
		for(int i = 0; i < searchVO.getNumOfRecord(); i++) {
			RoundTripVO r = new RoundTripVO();
			r = roundTripList.get(i);
			rt.add(r);
		}
		model.addAttribute("pageList", rt);
		return "reserve/air/list";
	}
}

















package kr.or.ddit.users.reserve.air.service.impl;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Service;
import kr.or.ddit.mapper.AirSearchMapper;
import kr.or.ddit.users.reserve.air.service.AirSearchService;
import kr.or.ddit.users.reserve.air.utils.DurationSort;
import kr.or.ddit.users.reserve.air.utils.PriceSort;
import kr.or.ddit.users.reserve.air.utils.TimeGenerator;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;
import kr.or.ddit.users.reserve.air.vo.SortVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AirSearchServiceImpl implements AirSearchService{
	
	@Inject
	private AirSearchMapper searchMapper;
	private SortVO sortVO;
	
	@Override
	public SortVO getSortVO() {
		return this.sortVO;
	}

	/*[왕복 항공편 검색]*/
	@Override
	public List<RoundTripVO> selectAllRoundTripFlight(FlightVO flightVO, HttpSession session) {
		List<RoundTripVO> roundTripList = new ArrayList<RoundTripVO>();
		int cnt = 0;
		//1.출발편 검색
		flightVO.setFlightType("departure");
		List<SearchVO> depList = searchMapper.selectAllRoundTripFlight(flightVO);
		
		if(depList != null && depList.size() > 0) {
		  //2.돌아오는편 검색
		  flightVO.setFlightType("arrival");
	      List<SearchVO> arrList = searchMapper.selectAllRoundTripFlight(flightVO);
	     
		   if(arrList == null || arrList.size() <= 0) {
		    	 return null;
		   }
		  FlightVO searchVO = (FlightVO) session.getAttribute("searchInfo"); //최초검색조건 참조
		  
		  //3.왕복항공편 생성(출국편 x 귀국편) => ex) 출발편(20) x 귀국편(30) = 600개 
	      for(int i = 0; i < depList.size(); i++) {
	        for(int j = 0; j < arrList.size(); j++) {
	          cnt++;
	          RoundTripVO roundVO = new RoundTripVO();
	          SearchVO depVO = depList.get(i);
	          SearchVO arrVO = arrList.get(j);
	          //4.로고이미지 설정
	          setAirlineLogoURL(depVO.getAirlineName(), depVO);
	          setAirlineLogoURL(arrVO.getAirlineName(), arrVO);
	          
	          //5.출발편, 돌아오는편 세팅
	    	  roundVO.setDeparture(depVO);
	    	  roundVO.setArrival(arrVO);
	    	  
	    	  //6.왕복가격 설정
	    	  switch(searchVO.getSeatClass()) {
	    	   case "economy" :  
	    		 roundVO.setRoundTripPrice(depVO.getFlightEconomyprice(), arrVO.getFlightEconomyprice());
	    		 break;
	    	   case "business" : 
	    		 roundVO.setRoundTripPrice(depVO.getFlightBusinessprice(), arrVO.getFlightBusinessprice());
	    		 break;
	    	   case "firstClass" : 
	    		 roundVO.setRoundTripPrice(depVO.getFlightFirstclassprice(), arrVO.getFlightFirstclassprice());  
	    		 break;
               default : break;	    	   
	    	  }
	    	  //7.총가격 설정
	    	  roundVO.setTotalPrice(searchVO.getTotalCnt() * roundVO.getRoundTripPrice());
	    	  
	    	  //8.총운항시간 및 평균운항시간 계산
	    	  long aveDurationMilli = TimeGenerator.getAveDurationMilli(depVO.getFlightDuration(), arrVO.getFlightDuration());
	    	  roundVO.setAveDurationMill(aveDurationMilli);  //평균운항시간(밀리초) 설정
	    	  roundVO.setAveDuration(TimeGenerator.getAveDuration(aveDurationMilli));   //평균운항시간 설정
	    	  roundVO.setTotalDuration(TimeGenerator.getAveDuration(aveDurationMilli * 2));  //총 운항시간 설정
	    	  roundTripList.add(roundVO);
	    	}
	      }
	      searchVO.setTotalRecord(cnt); //총 왕복편 갯수 설정	      
	      //9.항공편 정렬
	      //1)최단운항시간 정렬
	      sortVO = new SortVO();
	      Collections.sort(roundTripList, new DurationSort());
	      sortVO.setShortestDuration(roundTripList.get(0).getAveDuration());  //최단여행시간 설정
	      sortVO.setShortestPrice(roundTripList.get(0).getRoundTripPrice());  //최단여행 시 가격 설정
	      sortVO.setRecoDuration(roundTripList.get(0).getAveDuration());      //추천 여행시간(테스트중)
	      //2)최저가 정렬(최초 검색 시 디폴트 정렬)
	      Collections.sort(roundTripList, new PriceSort());
	      sortVO.setLowestDuration(roundTripList.get(0).getAveDuration());   //최저가여행 시 운항시간
	      sortVO.setLowestPrice(roundTripList.get(0).getRoundTripPrice());   //최저가 설정
	      sortVO.setRecoPrice(roundTripList.get(0).getRoundTripPrice());     //추천 가격(테스트중)
		}
		return roundTripList;
	}
	
	
	
	
	//항공사 로고 경로 설정을 위한 메서드
	private void setAirlineLogoURL(String airlineName, SearchVO searchVO) {
		 switch(airlineName) {
		    case "아시아나항공" : searchVO.setAirlineLogo("/resources/images/air/list/아시아나항공.PNG"); break;
		    case "에어부산" : searchVO.setAirlineLogo("/resources/images/air/list/에어부산.PNG"); break;
		    case "에어서울" : searchVO.setAirlineLogo("/resources/images/air/list/에어서울.PNG"); break;
		    case "이스타항공" : searchVO.setAirlineLogo("/resources/images/air/list/이스타항공.PNG"); break;
		    case "플라이강원" : searchVO.setAirlineLogo("/resources/images/air/list/플라이강원.PNG"); break;
		    case "하이에어" : searchVO.setAirlineLogo("/resources/images/air/list/하이에어.PNG"); break;
		    case "제주항공" : searchVO.setAirlineLogo("/resources/images/air/list/제주항공.PNG"); break;
		    case "진에어" : searchVO.setAirlineLogo("/resources/images/air/list/진에어.PNG"); break;
		    case "대한항공" : searchVO.setAirlineLogo("/resources/images/air/list/대한항공.PNG"); break;
		    case "티웨이항공" : searchVO.setAirlineLogo("/resources/images/air/list/티웨이항공.PNG"); break;
		    case "에어로케이" : searchVO.setAirlineLogo("/resources/images/air/list/에어로케이.PNG"); break;
		    default : break;
		  }
	}




	
	
	
    
	

}

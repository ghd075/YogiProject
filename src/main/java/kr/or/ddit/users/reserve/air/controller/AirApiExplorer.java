package kr.or.ddit.users.reserve.air.controller;
import java.net.URLEncoder;
import java.util.List;
import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;
import kr.or.ddit.users.reserve.air.service.AirApiService;
import kr.or.ddit.users.reserve.air.utils.api.AirApiAdapter;
import kr.or.ddit.users.reserve.air.utils.api.AirApiVO;
import kr.or.ddit.users.reserve.air.utils.api.AirApiVoMapper;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/reserve/air/api")
public class AirApiExplorer {

	@Inject
	private AirApiService airService;
	
	@ResponseBody
	@RequestMapping("/explorer.do")
	public String explorer(HttpServletResponse resp) {
	  resp.setCharacterEncoding("UTF-8");	
		
	  /* 1.json데이터 가져오기 */
	  String jsonResult = AirApiAdapter.getFlights();  
	  
	  if(jsonResult == null) {
		  log.debug("해당 항공편이 존재하지 않습니다!!");
		  return "FAIL : 해당 항공편이 존재하지 않습니다!";
	  }
	  
	  /* 2.json -> 자바객체(AirApiVO)로 데이터 받기 */
	  Gson gson = new Gson();
	  AirApiVO aVO = gson.fromJson(jsonResult, AirApiVO.class);  
	  
	  /* 3.AirApiVO -> FligthVO(DB저장용)로 매핑 */
	  List<FlightVO> fVOList = AirApiVoMapper.voMapping(aVO);     
	
	  /* 4.FligthVO기반 dummy생성  */
	  int cnt = 0;
      for(int i = 0; i < fVOList.size(); i++) {
    	log.debug("fVOList["+i+"] : "+fVOList.get(i));
    	
    	if(airService.checkFlightCode(fVOList.get(i).getFlightCode())) {  //기준항공편 코드가 DB에 존재하면 dummy생성(x)
    		log.debug("해당 항공편코드가 존재합니다 dummy생성 불가");
    		continue;
    	}
    	ServiceResult result = airService.makeDummy(fVOList.get(i));
  	    if(!(result.equals(ServiceResult.OK))) {
  		  return "FAIL : Dummy insert실패..";
  	    }
  	    cnt++;
      }
	  return "작업완료, inert dummy : "+cnt+"개";
	}
	

}















package kr.or.ddit.users.reserve.air.service.impl;
import java.text.DecimalFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import kr.or.ddit.mapper.AirApiMapper;
import kr.or.ddit.users.reserve.air.service.AirApiService;
import kr.or.ddit.users.reserve.air.utils.TimeGenerator;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class AirApiServiceImpl implements AirApiService{

	@Inject
	private AirApiMapper airMapper;

	/*기준항공편 데이터가 존재하는지 확인*/
	@Override
	public boolean checkFlightCode(String flightCode) {
        boolean result;
         
		int status = airMapper.checkFlightCode(flightCode);
        if(status > 0) {
        	result = true;
        }else {
        	result = false;
        }
		return result;
	}
	
	/*항공편 insert*/
	@Override
	public ServiceResult insertOne(FlightVO flightVO) {
		ServiceResult result = ServiceResult.OK;
		int status = airMapper.insertOne(flightVO);
		if(!(status > 0)) {
			 log.debug("원본 insert실패!");
			 return result = ServiceResult.FAILED;
		}
		return result;
	}
	
	/*Dummy생성기*/
	@Transactional
	@Override
	public ServiceResult makeDummy(FlightVO flightVO) {
	  log.info("makeDummy() 진입완료!!");
	  ServiceResult result = null;
	  
	  //1.첫번째 항공편 insert(기준 항공편 코드)
	  insertOne(flightVO);  
	  for(int i = 1; i < 16; i++) {  //기준 항공편당 생성 더미수 
		 FlightVO vo = new FlightVO();
		//2.고정데이터 세팅
		vo.setFlightDepairport(flightVO.getFlightDepairport());  //출발공항이름
		vo.setFlightDepportcode(flightVO.getFlightDepportcode());//출발공항코드
		vo.setFlightArrairport(flightVO.getFlightArrairport());  //도착공항이름
		vo.setFlightArrportcode(flightVO.getFlightArrportcode()); //도착공항코드
		vo.setFlightDeptime(flightVO.getFlightDeptime());         //출발날짜
		 
		//3.변경데이터 세팅
		//1)항공편코드 생성
		String flightCode = flightVO.getFlightCode()+"-";
		int ran = (int) (Math.random() * 999999);
		flightCode += new DecimalFormat("000000").format(ran);
		vo.setFlightCode(flightCode);
		
		//2)항공사 이름,코드 생성
		String[] airlines = {
		  "아시아나항공", "대한한공", "제주항공", "진에어", 
		  "티웨이항공", "에어부산", "에어서울"
		};
		
		Map<String, String> airMap = new HashMap<String, String>();
		airMap.put(airlines[0], "AAR");
		airMap.put(airlines[1], "KAL");
		airMap.put(airlines[2], "JJA");
		airMap.put(airlines[3], "JNA");
		airMap.put(airlines[4], "TWB");
		airMap.put(airlines[5], "ABL");
		airMap.put(airlines[6], "ASV");
		
		while(true) {
		  int index = (int) (Math.random() * 7) + 1;
		  if(airlines[index-1].equals(flightVO.getAirlineName())) { //기준데이터와 항공사가 같으면x
			  continue;
		  }else {
			 vo.setAirlineName(airlines[index-1]);
			 vo.setAirlineCode(airMap.get(airlines[index-1]));
             break;			 
		  }
		}
		
		//4.출발시간 생성하기(TimeGenerator활용) => 날짜고정, 시분만 생성
		String depTime = flightVO.getFlightDeptime().substring(0, 8);  
		
		long seed = System.currentTimeMillis();
		Random random = new Random(seed);
		Date ranTime = TimeGenerator.generateRandomTime(random);
		String formattedTime = TimeGenerator.formatTime(ranTime);
		depTime += formattedTime;
		
		vo.setFlightDeptime(depTime);
		
		//5.운항시간 생성하기(TimeGenerator활용)
		vo.setFlightDuration(TimeGenerator.generateDuration(flightVO.getFlightDuration()));
		
		//6.도착시간 생성하기(TimeGenerator활용)
		vo.setFlightArrtime(TimeGenerator.getArriveTime(vo.getFlightDuration(), vo.getFlightDeptime()));
		
	    //7.운항비 생성하기
        double range = 98500 - 64500;  //가격 발생범위  
	    int ecoPrice = (int) (Math.random() * range + 64500);
	    
	    vo.setFlightEconomyprice(ecoPrice); 
	    vo.setFlightBusinessprice((int) Math.ceil(ecoPrice * 2.4)); 
	    vo.setFlightFirstclassprice((int) Math.ceil(ecoPrice * 5.2));
		
		//8.생성된dummy insert
	    log.info("생성된 더미vo : "+vo);
		if(insertOne(vo).equals(ServiceResult.OK)) {
			log.info(flightVO.getFlightCode()+"항공편의"+i+"번째 dummy 추가 완료!");
			result = ServiceResult.OK;
		}else {
			log.info(flightVO.getFlightCode()+"항공편의"+i+"번째 dummy 추가 실패..");
			return ServiceResult.FAILED;
		}
		
	  }
	  return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}


















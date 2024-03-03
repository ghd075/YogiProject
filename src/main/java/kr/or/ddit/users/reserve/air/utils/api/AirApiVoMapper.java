package kr.or.ddit.users.reserve.air.utils.api;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import kr.or.ddit.users.mypage.vo.PayHistoryVO;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.SearchVO;

/*[DB에 저장하기 위해 AirApiVO -> FlightVO로 매핑]*/
public class AirApiVoMapper {
	
  public static List<FlightVO> voMapping(AirApiVO apiVO) {
	 List<FlightVO> fVOList = new ArrayList<FlightVO>();
	 List<Data> flights = apiVO.getResponse().getBody().getItems().getItem();
  	 //로깅용
	 int st = 0;
	 System.out.println("flights사이즈 : "+ flights.size());  
	 
	 for (Data flight : flights) {
	  //로깅용
	  st += 1;
	  System.out.println("flight : "+flight);
	  
	  FlightVO fVO = new FlightVO();
      
      fVO.setFlightCode(flight.getVihicleId());   //항공편코드 설정	  
      fVO.setAirlineName(flight.getAirlineNm());  //항공사이름 설정
      setAirline(fVO, flight.getAirlineNm());     //항공사코드 설정
      fVO.setFlightArrairport(flight.getArrAirportNm());               //도착공항이름 설정
      setArrAirportCode(fVO, flight.getArrAirportNm());                //도착공항코드 설정
      fVO.setFlightArrtime(setCurrentYear(flight.getArrPlandTime()));  //도착시간 설정
      
      //운임비설정(가격 데이터가 존재하지 않을 경우 생성)
      //이코노미 -> 비즈니스 -> 일등석 순
      int ecoPrice = flight.getEconomyCharge();
      if(ecoPrice == 0) {   //이코노미석 데이터가 없을 때 
    	 double range = 98500 - 64500;   //가격 발생범위 : 64500 ~ 98500
    	 ecoPrice = (int) (Math.random() * range + 64500); 
      }
      fVO.setFlightEconomyprice(ecoPrice); 
      
      int busiPrice = flight.getPrestigeCharge();
      if(busiPrice == 0) {   //비즈니석 데이터가 없을 때
    	  busiPrice =  (int) Math.ceil(ecoPrice * 2.4);
      }
      fVO.setFlightBusinessprice(busiPrice);  
      fVO.setFlightFirstclassprice((int) Math.ceil(ecoPrice * 5.2)); 
      
      fVO.setFlightDepairport(flight.getDepAirportNm());              //출발공항이름 설정
      setDepAirportCode(fVO, flight.getDepAirportNm());               //출발공항코드 설정
      fVO.setFlightDeptime(setCurrentYear(flight.getDepPlandTime())); //출발시간 설정
      
      fVO.setFlightDuration(setDuration(flight));  //운항시간 계산하기 
      
      fVOList.add(fVO);
	 }
	   return fVOList;
	}


	/* 운항시간 계산 (도착시간 - 출발시간) */
    private static String setDuration(Data flight) {
      long hours = 0;
      long minutes = 0;
      
      String depTime = flight.getDepPlandTime();
	  String arrTime = flight.getArrPlandTime();
	  
	  SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmm");
	  try {
	  //문자열 형태의 시간을 Date타입으로 파싱
	  Date depDate = format.parse(depTime);
	  Date arrDate = format.parse(arrTime);
	  long differenceInMillis = arrDate.getTime() - depDate.getTime(); //밀리초 단위로 계산
	  
	  minutes = differenceInMillis / (60 * 1000); 
	  hours = minutes / 60;        //시 계산
	  minutes = minutes % 60;     //분 계산
	} catch (ParseException e) {
		e.printStackTrace();
	}
	  return hours+"시간 "+minutes+"분";
    }
    
	/* 년도세팅 */
    private static String setCurrentYear(String time) {
    	String result = "2024";
    	String afterWord = time.substring(4);
    	result += afterWord;
    	return result;
    }
    
    
	/* 항공사코드 설정 */
	public static void setAirline(FlightVO fVO, String airlineNm){
	  switch(airlineNm) {
	    case "아시아나항공" : fVO.setAirlineCode("AAR"); break;
	    case "에어부산" : fVO.setAirlineCode("ABL"); break;
	    case "에어서울" : fVO.setAirlineCode("ASV"); break;
	    case "이스타항공" : fVO.setAirlineCode("ESR"); break;
	    case "플라이강원" : fVO.setAirlineCode("FGW"); break;
	    case "하이에어" : fVO.setAirlineCode("HGG"); break;
	    case "제주항공" : fVO.setAirlineCode("JJA"); break;
	    case "진에어" : fVO.setAirlineCode("JNA"); break;
	    case "대한항공" : fVO.setAirlineCode("KAL"); break;
	    case "티웨이항공" : fVO.setAirlineCode("TWB"); break;
	    case "에어로케이" : fVO.setAirlineCode("ALK"); break;
	    default : break;
	  }
	}
    
    /* 출발공항코드 설정 */
	public static void setDepAirportCode(FlightVO fVO, String depAirportNm) {
  	  switch(depAirportNm) {
	    case "무안" : fVO.setFlightDepportcode("NAARKJB"); break;
	    case "광주" : fVO.setFlightDepportcode("NAARKJJ"); break;
	    case "군산" : fVO.setFlightDepportcode("NAARKJK"); break;
	    case "여수" : fVO.setFlightDepportcode("NAARKJY"); break;
	    case "원주" : fVO.setFlightDepportcode("NAARKNW"); break;
	    case "양양" : fVO.setFlightDepportcode("NAARKNY"); break;
	    case "제주" : fVO.setFlightDepportcode("NAARKPC"); break;
	    case "김해" : fVO.setFlightDepportcode("NAARKPK"); break;
	    case "사천" : fVO.setFlightDepportcode("NAARKPS"); break;
	    case "울산" : fVO.setFlightDepportcode("NAARKPU"); break;
	    case "인천" : fVO.setFlightDepportcode("NAARKSI"); break;
	    case "김포" : fVO.setFlightDepportcode("NAARKSS"); break;
	    case "포항" : fVO.setFlightDepportcode("NAARKTH"); break;
	    case "대구" : fVO.setFlightDepportcode("NAARKTN"); break;
	    case "청주" : fVO.setFlightDepportcode("NAARKTU"); break;
	    default : break;
	  }
    }

	/* 도착공항코드 설정 */
	public static void setArrAirportCode(FlightVO fVO, String arrAirportNm) {
	  switch(arrAirportNm) {
	    case "무안" : fVO.setFlightArrportcode("NAARKJB"); break;
	    case "광주" : fVO.setFlightArrportcode("NAARKJJ"); break;
	    case "군산" : fVO.setFlightArrportcode("NAARKJK"); break;
	    case "여수" : fVO.setFlightArrportcode("NAARKJY"); break;
	    case "원주" : fVO.setFlightArrportcode("NAARKNW"); break;
	    case "양양" : fVO.setFlightArrportcode("NAARKNY"); break;
	    case "제주" : fVO.setFlightArrportcode("NAARKPC"); break;
	    case "김해" : fVO.setFlightArrportcode("NAARKPK"); break;
	    case "사천" : fVO.setFlightArrportcode("NAARKPS"); break;
	    case "울산" : fVO.setFlightArrportcode("NAARKPU"); break;
	    case "인천" : fVO.setFlightArrportcode("NAARKSI"); break;
	    case "김포" : fVO.setFlightArrportcode("NAARKSS"); break;
	    case "포항" : fVO.setFlightArrportcode("NAARKTH"); break;
	    case "대구" : fVO.setFlightArrportcode("NAARKTN"); break;
	    case "청주" : fVO.setFlightArrportcode("NAARKTU"); break;
	    default : break;
	  }
    }
	
	
	/* 출발공항풀네임 설정 */
	public static void setDepAirportFullname(SearchVO searchVO, String airportName) {
		switch(airportName) {
		  case "무안" : searchVO.setDepAirportFullname("무안국제공항"); break;
		  case "광주" : searchVO.setDepAirportFullname("광주공항"); break;
		  case "군산" : searchVO.setDepAirportFullname("군산공항"); break;
		  case "여수" : searchVO.setDepAirportFullname("여수공항"); break;
		  case "원주" : searchVO.setDepAirportFullname("원주공항"); break;
		  case "양양" : searchVO.setDepAirportFullname("양양국제공항"); break;
		  case "제주" : searchVO.setDepAirportFullname("제주국제공항"); break;
		  case "김해" : searchVO.setDepAirportFullname("김해국제공항"); break;
		  case "사천" : searchVO.setDepAirportFullname("사천공항"); break;
		  case "울산" : searchVO.setDepAirportFullname("울산공항"); break;
		  case "인천" : searchVO.setDepAirportFullname("인천국제공항"); break;
		  case "김포" : searchVO.setDepAirportFullname("김포국제공항"); break;
		  case "포항" : searchVO.setDepAirportFullname("포항경주공항"); break;
		  case "대구" : searchVO.setDepAirportFullname("대구국제공항"); break;
		  case "청주" : searchVO.setDepAirportFullname("청주국제공항"); break;
		default : break;
		}
	}
	
	/* 도착공항풀네임 설정 */
	public static void setArrAirportFullname(SearchVO searchVO, String airportName) {
		switch(airportName) {
		case "무안" : searchVO.setArrAirportFullname("무안국제공항"); break;
		case "광주" : searchVO.setArrAirportFullname("광주공항"); break;
		case "군산" : searchVO.setArrAirportFullname("군산공항"); break;
		case "여수" : searchVO.setArrAirportFullname("여수공항"); break;
		case "원주" : searchVO.setArrAirportFullname("원주공항"); break;
		case "양양" : searchVO.setArrAirportFullname("양양국제공항"); break;
		case "제주" : searchVO.setArrAirportFullname("제주국제공항"); break;
		case "김해" : searchVO.setArrAirportFullname("김해국제공항"); break;
		case "사천" : searchVO.setArrAirportFullname("사천공항"); break;
		case "울산" : searchVO.setArrAirportFullname("울산공항"); break;
		case "인천" : searchVO.setArrAirportFullname("인천국제공항"); break;
		case "김포" : searchVO.setArrAirportFullname("김포국제공항"); break;
		case "포항" : searchVO.setArrAirportFullname("포항경주공항"); break;
		case "대구" : searchVO.setArrAirportFullname("대구국제공항"); break;
		case "청주" : searchVO.setArrAirportFullname("청주국제공항"); break;
		default : break;
		}
	}
	
	//항공사 로고 경로 설정을 위한 메서드1(overload)
	public static void setAirlineLogoURL(String airlineName, SearchVO searchVO) {
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
	
	//항공사 로고 경로 설정을 위한 메서드2(overload)
	public static void setAirlineLogoURL(String airlineName, PayHistoryVO payVO) {
		switch(airlineName) {
		case "아시아나항공" : payVO.setAirlineLogo("/resources/images/air/list/아시아나항공.PNG"); break;
		case "에어부산" : payVO.setAirlineLogo("/resources/images/air/list/에어부산.PNG"); break;
		case "에어서울" : payVO.setAirlineLogo("/resources/images/air/list/에어서울.PNG"); break;
		case "이스타항공" : payVO.setAirlineLogo("/resources/images/air/list/이스타항공.PNG"); break;
		case "플라이강원" : payVO.setAirlineLogo("/resources/images/air/list/플라이강원.PNG"); break;
		case "하이에어" : payVO.setAirlineLogo("/resources/images/air/list/하이에어.PNG"); break;
		case "제주항공" : payVO.setAirlineLogo("/resources/images/air/list/제주항공.PNG"); break;
		case "진에어" : payVO.setAirlineLogo("/resources/images/air/list/진에어.PNG"); break;
		case "대한항공" : payVO.setAirlineLogo("/resources/images/air/list/대한항공.PNG"); break;
		case "티웨이항공" : payVO.setAirlineLogo("/resources/images/air/list/티웨이항공.PNG"); break;
		case "에어로케이" : payVO.setAirlineLogo("/resources/images/air/list/에어로케이.PNG"); break;
		default : break;
		}
	}


}














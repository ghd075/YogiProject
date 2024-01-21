package kr.or.ddit.users.reserve.air.utils.api;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;

import lombok.extern.slf4j.Slf4j;

/* 국토교통부 국내항공운항정보를 가져오는 모듈*/
@Slf4j
public class AirApiAdapter {

  public static String getFlights() {
	//1.기본 요청URL세팅
	StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/DmstcFlightNvgInfoService/getFlightOpratInfoList");
	
	//2.요청을 위한 날짜생성
	String depTime = "202303";
	int day = (int) (Math.random() * 31) + 1;
	//String depTime = "202302";
	//int range = 29 - 19;
	//int day = (int) (Math.random() * range) + 1 + 19;
	depTime += new DecimalFormat("00").format(day);
	System.out.println("생성된 날짜 : "+depTime);
	
	//3.요청을 위한 출발&도착공항코드 생성
	String depAirport;
	String arrAirport = "NAARK"
			+ "PC";
	
	String[] airportCode = {
	  "NAARKJB", "NAARKJJ", "NAARKJK", "NAARKJY", 
	  "NAARKNW", "NAARKNY", "NAARKPC", "NAARKPK", 
	  "NAARKPS", "NAARKPU", "NAARKSI", "NAARKSS", 
	  "NAARKTH", "NAARKTN", "NAARKTU"
	};  
	
	while(true) {
	  int index = (int) (Math.random() * 14) + 1;
	  if(airportCode[index].equals(arrAirport)) { //출발공항 = 도착공항 (x)
		  continue;
	  }
      depAirport = airportCode[index];
	  
//	  if(airportCode[index].equals(depAirport)) {
//		  continue;
//	  }
//	  arrAirport = airportCode[index];
	  break;
	}
	System.out.println("생성된 출발공항 : "+depAirport);
	System.out.println("생성된 도착공항 : "+arrAirport);
	
	//4. 요청URL 생성
	try {
	  urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=mQ%2BFsygFZfNuzghf0kwtMS3SAOfLRVPjhfehMvryUpsrzixHjk1YnTMhyxZ5R3WAr%2BtcGvSe8CJat3GFYwjCdg%3D%3D"); /*Service Key*/ 
	  urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	  urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("10", "UTF-8")); /*한 페이지 결과 수*/
	  urlBuilder.append("&" + URLEncoder.encode("_type","UTF-8") + "=" + URLEncoder.encode("json", "UTF-8")); /*데이터 타입(xml, json)*/
      urlBuilder.append("&" + URLEncoder.encode("depAirportId","UTF-8") + "=" + URLEncoder.encode(depAirport, "UTF-8")); /*출발공항ID*/
	  urlBuilder.append("&" + URLEncoder.encode("arrAirportId","UTF-8") + "=" + URLEncoder.encode(arrAirport, "UTF-8")); /*도착공항ID*/
	  urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(depTime, "UTF-8")); /*출발일(YYYYMMDD)*/
	  //urlBuilder.append("&" + URLEncoder.encode("airlineId","UTF-8") + "=" + URLEncoder.encode("AAR", "UTF-8")); /*항공사ID는 검색조건 제외*/
	} catch (UnsupportedEncodingException e) {
	  log.debug("URLEncoder에서 지원하지 않는 인코딩 타입입니다!");
	  e.printStackTrace();
	} 
	/* [URL] 
      - 자바에서 url을 나타내는 클래스
      - 네트워크 상의 자원을 가리키는데 사용되며, 주로 웹에서 리소스에 접근하는 데 활용
      
       [HttpURLConnection]  
      - URLConnection 클래스의 하위 클래스로, HTTP 프로토콜을 사용하여 서버와 통신하기 위한 기능을 제공
      - HTTP 메서드를 지원하며, 요청 헤더 및 응답 헤더의 설정과 읽기, 
                쿠키 관리, 리다이렉션 처리, 캐시 제어 등 다양한 HTTP 관련 기능을 제공              */
	    URL url = null;
	    HttpURLConnection conn = null;
	    BufferedReader br = null;
	    StringBuilder sb = null;
	    
	    try {
	     //5.Http url연결 및 요청 전송
		 url = new URL(urlBuilder.toString());
		 conn = (HttpURLConnection) url.openConnection();
		 conn.setRequestMethod("GET");
		 conn.setRequestProperty("Content-type", "application/json");
		 System.out.println("Response Code : "+conn.getResponseCode());
		 
	      if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	    	//응답 body의 'json/xml문자열'데이터를 메모리로 가져오기
	    	br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	      }else {
	    	//응답 body?의 에러메세지를 메모리로 가져오기
	    	br = new BufferedReader(new InputStreamReader(conn.getErrorStream()));  
	      }
	      
	      /*6.응답메세지(body)의 데이터를 메모리로 가져오기
	       
	       BufferedReader.readLine() 
	        - 텍스트 데이터를 한 줄씩 읽어어와 문자열로 반환
	        - 파일의 끝에 도달하면 null을 반환*/
	      sb = new StringBuilder();
	      String line;
	      while((line = br.readLine()) != null) {
	    	  sb.append(line);
	      }
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if(br != null) { try { br.close(); } catch (IOException e) {e.printStackTrace();} }
			if(conn != null) { conn.disconnect(); }
		}
	        System.out.println("가져온json값 : "+sb.toString());
	        if(sb.toString().contains("\"totalCount\":0")) {  //가져온 항공편 데이터가 없을 경우
	        	return null;
	        }
			return sb.toString();
		}
	}






















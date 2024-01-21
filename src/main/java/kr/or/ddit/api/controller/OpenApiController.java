package kr.or.ddit.api.controller;

import static kr.or.ddit.utils.RestResponse.success;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.inject.Inject;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import kr.or.ddit.api.OpenApiManager;
import kr.or.ddit.api.exception.OpenApiException;
import kr.or.ddit.api.service.PlannerService;
import kr.or.ddit.api.vo.AreaCode;
import kr.or.ddit.api.vo.ContentCode;
import kr.or.ddit.users.myplan.vo.TouritemsVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/locations")
@RequiredArgsConstructor
@Slf4j
public class OpenApiController {

	private final OpenApiManager openApiManager;
	
	@Inject
	private PlannerService service;
	
	@GetMapping("/api/{pageNo}/{areaCode}")
	 public ResponseEntity<?> loadJsonFromApi(@PathVariable("areaCode") int areaCode, @PathVariable("pageNo") int pageNo) {
		 String addr = openApiManager.fetchByAreaCode(areaCode, pageNo);
		   	log.info("url 주소 => {}", addr);
	    	String result = "";
//	    	List<TouritemsVO> list = new ArrayList<TouritemsVO>();
	    	try {
	    		URL url = new URL(addr);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("GET");
	            conn.setRequestProperty("Content-type", "applicaton/json");
	            
	            BufferedReader br = new BufferedReader(
	                    new InputStreamReader(conn.getInputStream(), "utf-8"));
	            
	            result = br.readLine();
	            
	            JSONParser jsonParser = new JSONParser();
	            JSONObject jsonObject = (JSONObject) jsonParser.parse(result);
	            // 가장 큰 JSON 객체 response 가져오기
	            JSONObject jsonResponse = (JSONObject) jsonObject.get("response");
	            log.info("response 파싱 완료 = {}", jsonResponse);

	            // 그 다음 body 부분 파싱
	            JSONObject jsonBody = (JSONObject) jsonResponse.get("body");
	            log.info("response->body 파싱 완료 = {}", jsonBody);

	            // 그 다음 위치 정보를 배열로 담은 items 파싱
	            JSONObject jsonItems = (JSONObject) jsonBody.get("items");
	            log.info("response->body->items 파싱 완료 = {}", jsonItems);

	            // items 는 JSON 임, 이제 그걸 또 배열로 가져온다
	            JSONArray jsonItemList = (JSONArray) jsonItems.get("item");
	            log.info("response->body->items->item 파싱 완료 = {}", jsonItemList);
	            
	            List<TouritemsVO> tourItemsList = new ArrayList<TouritemsVO>();
	            
	            String tourId = "";			// 관광지 고유 번호
	            String cityName = "";		// 지역명
	            String address = "";		// 주소
	            String areaCd = "";			// 지역코드
	            String sigunguCd = "";		// 시군구코드
	            String tourCate = "";		// 관광지 분류(자연, 인문, 레포츠, 쇼핑, 음식, 숙박, 교통, 추천)
	            String contentTypeId = "";	// 관광지 타입(관광지, 문화시설, 축제공연행사, 여행코스, 레포츠, 숙박, 쇼핑, 음식점)
	            String thumbnail = "";		// 썸네일 이미지
	            String title = "";			// 관광지명
	            String phone = "";			// 전화번호
	            String zipcode = "";		// 우편번호
	            String latitude = "";		// 위도
	            String longitude = "";		// 경도
	            
	            for(int i = 0; i < jsonItemList.size(); i++) {
	            	JSONObject item = (JSONObject) jsonItemList.get(i);
	            	log.info("값 출력 : {}" + i, item);
	            	
	            	tourId = (String) item.get("contentid");
	            	String addr1 = (String) item.get("addr1");
	            	String addr2 = (String) item.get("addr2");
		            sigunguCd = (String) item.get("sigungucode");			// 시군구코드
		            tourCate = (String) item.get("cat1");					// 관광지 분류(자연, 인문, 레포츠, 쇼핑, 음식, 숙박, 교통, 추천)
		            contentTypeId = (String) item.get("contenttypeid");		// 관광지 타입(관광지, 문화시설, 축제공연행사, 여행코스, 레포츠, 숙박, 쇼핑, 음식점)
		            thumbnail = (String) item.get("firstimage");			// 썸네일 이미지
		            title = (String) item.get("title");						// 관광지명
		            phone = ((String) item.get("tel")).equals("") ? generateRandomNumber() : (String) item.get("tel");	// 전화번호
		            zipcode = (String) item.get("zipcode");					// 우편번호
		            latitude = (String) item.get("mapy");					// 위도
		            longitude = (String) item.get("mapx");					// 경도
	            	tourId = (String) item.get("contentid");				// 관광지 고유 번호
	            	areaCd = (String) item.get("areacode");					// 지역코드
		            cityName = AreaCode.getAreaName(Long.valueOf(areaCd));	// 지역명
		            
		            if (contentTypeId.equals("15") || contentTypeId.equals("25")) {
		                continue;
		            }
		            
		            if(addr2.equals("")) {
	            		address = addr1 + ' ' + (String) item.get("addr2");			// 주소
	            	}
		            
		            if (zipcode.equals("")) {
		                zipcode = generateRandomPostalCode();
		            }
		            
		            String contenttypeName = ContentCode.getContentName(Long.valueOf(contentTypeId)); 

	                log.info("=================================================");
	                log.info(i + "=> 콘텐츠Id = {}", tourId);
	                log.info(i + "=> 관광지명 = {}", title);
	                log.info(i + "=> 대분류코드 = {}", tourCate);
	                log.info(i + "=> 콘텐츠타입Id = {}", contentTypeId);
	                log.info(i + "=> 콘텐츠타입명 = {}", contenttypeName);
	                log.info(i + "=> 지역코드 : {}", areaCd);
	                log.info(i + "=> 시군구코드 : {}", sigunguCd);
	                log.info(i + "=> 지역명 = {}", cityName);
	            	log.info(i + "=> 주소 출력 : {}", address);
	            	log.info(i + "=> 경도 = {}", longitude);
	            	log.info(i + "=> 위도 = {}", latitude);
	            	log.info(i + "=> 우편번호 = {}", zipcode);
	            	log.info(i + "=> 전화번호 = {}", phone);
	            	log.info(i + "=> 이미지 = {}", thumbnail);
	            	log.info("=================================================");
	            	
	            	TouritemsVO touritemsVO = new TouritemsVO(tourId, areaCd, sigunguCd, tourCate, contentTypeId, thumbnail, latitude, longitude, address, phone, title, zipcode);
	            	
	            	tourItemsList.add(touritemsVO);
	            	
	            	log.info(i + " => touritemsVO 값 : {}", touritemsVO);
	            	// service.save(touritemsVO);
	            }
	            //log.info(" => tourItemsList 값 : {}", tourItemsList);
	            service.save(tourItemsList);
	            
	    	} catch(Exception e) {
	    		 throw new OpenApiException("오픈 API 예외 = fetch 로 가져온 데이터가 비어있음 (데이터 요청 방식 오류)");
	    	}
	    	return success("성공");
	 }
	 
	// 전화번호를 랜덤으로 생성하는 메서드
	private static String generateRandomNumber() {
	    // 랜덤한 숫자 8자리 생성
	    Random random = new Random();
	    // Generate 4 digits for the first part
	    int firstPart = 1000 + random.nextInt(9000);
	    
	    // Generate 4 digits for the second part
	    int secondPart = 1000 + random.nextInt(9000);
	    
	    return "010-" + firstPart + "-" + secondPart;
	}
	
	// 랜덤한 우편번호 생성
	private static String generateRandomPostalCode() {
	    // 랜덤하게 6자리 우편번호 생성
	    Random random = new Random();
	    int randomCode = 100000 + random.nextInt(900000);
	    return String.valueOf(randomCode);
	}
}

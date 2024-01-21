package kr.or.ddit.api;

import org.springframework.stereotype.Component;

import kr.or.ddit.api.vo.OpenApiCode;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class OpenApiManager {

    // 지역 기반 조회 테스트(해당 지역 50건의 데이터 가져오기)
    public String fetchByAreaCode(int areaCode, int pageNo) {
    	String areaUrl = makeAreaUrl(areaCode, 3000, pageNo);
    	return areaUrl;
    }
	
	// 기본 URL
    private String makeUrl(String apiUriType) {
        return OpenApiCode.ENDPOINT + apiUriType + OpenApiCode.SERVICE_KEY + OpenApiCode.DEFAULT_QUERY_PARAMS;
    }
    
    // 지역 기반 URL
    private String makeAreaUrl(int areaCode, int numOfRows, int pageNo) {
    	return makeUrl("/areaBasedList1") + setPageNo(pageNo) + setNumOfRows(numOfRows) + setAreaCode(areaCode); 
    }
    
    // 지역 코드 입력
    private String setPageNo(int code) {
    	return "&pageNo=" + code;
    }

    // 지역 코드 입력
    private String setAreaCode(int code) {
        return "&areaCode=" + code;
    }
    
    // 가져올 데이터 수 정하기
    private String setNumOfRows(int n) {
        if (n < 0 || n > 10000) {
            // 범위를 넘어가면 디폴트값 내리기
            return "&numOfRows=10";
        }
        return "&numOfRows=" + n;
    }
    
    
}

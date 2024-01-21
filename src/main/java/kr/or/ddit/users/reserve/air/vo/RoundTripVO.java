package kr.or.ddit.users.reserve.air.vo;

import lombok.Data;

/*
  [검색된 왕복 항공편의 정보를 담고있는 VO]
 */
@Data
public class RoundTripVO {

	//1.검색된 정보
	private SearchVO departure;  //출발항공편
	private SearchVO arrival;     //도착항공편
	
	
	//2.최저가,최단거리,추천 정렬을 위한 기준정보
	private int roundTripPrice;      //인당 왕복가격
	private int totalPrice;          //총 가격
	private String aveDuration;      //평균 운항시간
	private long aveDurationMill;    //평균 운항시간(비교기준)
	private String totalDuration;    //총 운항시간
	
	public void setRoundTripPrice(int depPrice, int arrPrice) {
		this.roundTripPrice = depPrice + arrPrice;
	}
	
}














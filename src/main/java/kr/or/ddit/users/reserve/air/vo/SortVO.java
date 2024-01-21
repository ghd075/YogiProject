package kr.or.ddit.users.reserve.air.vo;
import lombok.Data;

@Data
public class SortVO {

	private int lowestPrice;       //최저가
	private String lowestDuration; //최저가의 운항시간
	
	private int shortestPrice;        //최단시간의 가격
	private String shortestDuration;  //최단시간
	
	private int recoPrice;        //추천 가격
	private String recoDuration;  //추천 시간
	
	
	public void setRecoPrice(int lowestPrice) {
		this.recoPrice = lowestPrice + 15000;
	}
	public void setRecoDuration(String shortestDuration) {
		this.recoDuration = shortestDuration;
	}
	
	
}

package kr.or.ddit.users.reserve.air.utils;
import java.util.Comparator;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;

/* 
  [최저가 정렬]
   - 인당 왕복가격 기준으로 오름차순
   - 기준 : 0(값이같음, 순서안바뀜), 1(양수, 순서바뀜), -1(순서안바뀜)
*/
public class PriceSort implements Comparator<RoundTripVO>{

	@Override
	public int compare(RoundTripVO r1, RoundTripVO r2) {
		
		//Integer.compare() : 첫번째 매개변수가 두번째 매개변수보다 더 크면 양수반환
		return Integer.compare(r1.getRoundTripPrice(), r2.getRoundTripPrice());
	}

}

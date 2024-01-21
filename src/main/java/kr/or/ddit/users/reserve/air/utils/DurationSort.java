package kr.or.ddit.users.reserve.air.utils;
import java.util.Comparator;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
/*
  [최단거리 정렬]
  - 평균시간으로 오름차순
 */
public class DurationSort implements Comparator<RoundTripVO>{

	@Override
	public int compare(RoundTripVO r1, RoundTripVO r2) {
		
		//Long.compare() : 첫번째 매개변수가 두번째 매개변수보다 더 크면 양수반환
		return Long.compare(r1.getAveDurationMill(), r2.getAveDurationMill());
	}

}

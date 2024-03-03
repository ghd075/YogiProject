package kr.or.ddit.users.reserve.stay.service.impl;
import java.util.HashMap;
import java.util.Map;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import kr.or.ddit.mapper.AirReserveMapper;
import kr.or.ddit.users.reserve.stay.service.StayReserveService;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class StayReserveServiceImpl implements StayReserveService{
	
	@Inject
	private AirReserveMapper reserveMapper;
	
	@Override
	public ServiceResult processPayment(int totalPrice, int finalRemain, int planerNo) {
		
		Map<String, Integer> pointMap = new HashMap<String, Integer>();
		pointMap.put("planerNo", planerNo);
		pointMap.put("finalRemain", finalRemain);
		int pointStatus = reserveMapper.updateGroupPoint(pointMap);
		if(pointStatus < 0) {
			log.debug("포인트 갱신(update)에 실패하였습니다");
			return ServiceResult.FAILED;
		}
		return ServiceResult.OK;
	}

	
}

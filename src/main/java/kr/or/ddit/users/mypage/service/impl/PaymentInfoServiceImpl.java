package kr.or.ddit.users.mypage.service.impl;

import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.PaymentInfoMapper;
import kr.or.ddit.users.mypage.service.PaymentInfoService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class PaymentInfoServiceImpl implements PaymentInfoService {

	@Inject
	private PaymentInfoMapper paymentInfoMapper;
	
	@Override
	public void selectMemPoint(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		
		/** 파라미터 정의 */
		int memPoint = 0;
		
		/** 메인로직 처리 */
		memPoint = paymentInfoMapper.selectPoint(memId);
		
		/** 자료 검증 */ 
		log.info("넘어온 memId : " + memId);
		log.info("가져온 포인트 : " + memPoint);
		
		/** 반환자료 저장 */
		param.put("memPoint", memPoint);
	}

}

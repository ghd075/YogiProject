package kr.or.ddit.users.partner.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.HistoryPartnerMapper;
import kr.or.ddit.users.partner.service.HistoryPartnerService;
import kr.or.ddit.users.partner.vo.PlanerVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class HistoryPartnerServiceImpl implements HistoryPartnerService {
	
	@Inject
	private HistoryPartnerMapper historyPartnerMapper;

	@Override
	public void historyList(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		
		/** 파라미터 정의 */
		List<PlanerVO> planerList = new ArrayList<PlanerVO>();
		
		/** 메인로직 처리 */
		// 플래너 리스트 가져오기
		PlanerVO planerVO = new PlanerVO();
		planerVO.setMemId(memId);
		planerList = historyPartnerMapper.historyList(planerVO);
		
		// 그룹장 이름 가져오기위해 다시 셀렉트
		for(PlanerVO plans : planerList) {
			String recruiterId = plans.getMategroupRecruiter();
			log.debug("recruiterId : {}", recruiterId);
			
			String recruiterName = historyPartnerMapper.getRecruiterName(recruiterId);
			plans.setMemName(recruiterName);
			log.debug("recruiterName : {}", recruiterName);
			
		}
		
		/** 반환자료 저장 */
		param.put("planerList", planerList);
	}

}

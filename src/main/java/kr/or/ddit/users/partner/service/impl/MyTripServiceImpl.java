package kr.or.ddit.users.partner.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.MyTripMapper;
import kr.or.ddit.users.partner.service.MyTripService;
import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MyTripServiceImpl implements MyTripService {

	@Inject
	private MyTripMapper myTripMapper;
	
	@Override
	public void myTripList(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		
		/** 파라미터 정의 */
		List<PlanerVO> planerList = new ArrayList<PlanerVO>();
		
		/** 메인로직 처리 */
		// 플래너 리스트 가져오기
		PlanerVO planerVO = new PlanerVO();
		planerVO.setMemId(memId);
		planerList = myTripMapper.myTripList(planerVO);
		
		/** 반환자료 저장 */
		param.put("planerList", planerList);
	}

	@Override
	public List<PlanerVO> searchPlanerList(PlanerVO planerVO) {
		return myTripMapper.searchPlanerList(planerVO);
	}

	@Override
	public void chgStatusPlan(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		int plNo = (int) param.get("plNo");
		String plPrivate = (String) param.get("plPrivate");
		
		/** 파라미터 정의 */
		PlanerVO planerVO = new PlanerVO();
		int status = 0;
		ServiceResult result = null;
		String message = "";
		String goPage = "";
		
		/** 메인로직 처리 */
		// 해당 플래너를 공개/비공개 처리 하기
		planerVO.setMemId(memId);
		planerVO.setPlNo(plNo);
		
		if(plPrivate.equals("Y")) { // 비공개 처리
			planerVO.setPlPrivate("N");
		}else if(plPrivate.equals("N")) { // 공개 처리
			planerVO.setPlPrivate("Y");
		}
		
		status = myTripMapper.chgStatusPlan(planerVO);
		
		if(status > 0) { // 업데이트 성공
			result = ServiceResult.OK;
			if(plPrivate.equals("Y")) { // 비공개 처리
				message = "해당 플래너를 비공개 처리하였습니다.";
			}else if(plPrivate.equals("N")) { // 공개 처리
				message = "해당 플래너를 공개 처리하였습니다.";
			}
			goPage = "redirect:/partner/mygroup.do";
		}else { // 업데이트 실패
			result = ServiceResult.FAILED;
			message = "해당 플래너를 갱신하는데 실패했습니다.";
			goPage = "partner/mygroup";
		}
		
		/** 반환자료 저장 */
		param.put("result", result);
		param.put("message", message);
		param.put("goPage", goPage);
	}

}

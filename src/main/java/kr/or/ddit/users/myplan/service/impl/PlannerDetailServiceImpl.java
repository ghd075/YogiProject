package kr.or.ddit.users.myplan.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.mapper.PlannerDetailMapper;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.service.PlannerDetailService;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional(rollbackFor = Exception.class)
public class PlannerDetailServiceImpl implements PlannerDetailService{

	@Inject
	PlannerDetailMapper plannerDetailMapper;
	
	@Override
	public Map<String, Object> getPlanDetail(long plNo, Map<String, Object> param) {
		/** 파라미터 조회 */
		HttpServletRequest req = (HttpServletRequest)param.get("req");
		
		HttpSession session = req.getSession();
		String memId = null;
		if(session != null) {
			MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
			if(memberVO != null) {
				memId = memberVO.getMemId();
			}
		}
		
		/** 파라미터 정의 */
		Map<String,Object> param2 = new HashMap<String, Object>();
		int isJoined = 0;
		String joinStatus = "";
		
		/** 메인로직 처리 */
		PlannerVO pvo = plannerDetailMapper.getPlanDetail(plNo);
		
		// 날짜별 세부플랜을 조회하여 각 날짜에 해당하는 플랜들을 분류
		DetatilPlannerVO dpParam = null; 
		int cnt = 0;
		for(int i = 0; i < 5; i++) {
			dpParam = new DetatilPlannerVO();
			dpParam.setSpDay(i+1);
			dpParam.setPlNo(plNo);
			List<DetatilPlannerVO> daydpList = plannerDetailMapper.getPlanDetailDay(dpParam);
			if(daydpList.size() > 0) {
				param.put("day" + (i+1), daydpList);
				cnt = cnt + 1;
			}
		}
		
		// 자바객체 json문자열화
		ObjectMapper objectMapper = new ObjectMapper();
		String jsonString = null;
		
		try {
			jsonString = objectMapper.writeValueAsString(pvo.getDetailList());
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		
		// 동행참가를 누른 회원이 해당 플랜에 참가중인지를 판별
		param2.put("plNo", plNo);
		param2.put("memId", memId);
	
//		joinStatus
		PlannerVO tempPvo = plannerDetailMapper.joinCheck(param2);
		if(tempPvo != null) {
			isJoined = 1;
			joinStatus = tempPvo.getMategroupApply();
		}
		
//		joinStatus = "Y";
		
		// 현재원 겟
		int mgCurNum = plannerDetailMapper.getCurNum(plNo); 
		
		/** 반환자료 저장 */
		param.put("pvo", pvo);
		param.put("dayCnt", cnt);
		param.put("pvoJson", jsonString);
		param.put("isJoined", isJoined);
		param.put("joinStatus", joinStatus);
		param.put("mgCurNum", mgCurNum);
		
		return param;
	}

	@Override
	public void joinGroup(Map<String, Object> param) {
		
		/** 파라미터 조회 */
		long plNo = (long)param.get("plNo");
		long mgNo = plannerDetailMapper.getMg(plNo);
		
		/** 파라미터 정의 */
		ServiceResult result = null;
		
		/** 메인로직 처리 */
		param.put("mgNo", mgNo);
		int status = plannerDetailMapper.joinGroup(param);

		if(status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		/** 반환자료 저장 */
		param.put("serviceResult", result);
		
	}

}

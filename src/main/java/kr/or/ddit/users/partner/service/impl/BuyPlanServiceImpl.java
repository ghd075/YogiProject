package kr.or.ddit.users.partner.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.BuyPlanMapper;
import kr.or.ddit.users.myplan.vo.DetatilPlannerVO;
import kr.or.ddit.users.myplan.vo.PlannerVO;
import kr.or.ddit.users.partner.service.BuyPlanService;
import kr.or.ddit.users.partner.vo.MategroupVO;
import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.RealTimeSenderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class BuyPlanServiceImpl implements BuyPlanService {

	@Inject
	private BuyPlanMapper buyPlanMapper; 
	
	@Override
	public void getAllPlans(Map<String, Object> param) {
		
		long plNo = (long)param.get("plNo");
		
		PlannerVO pvo = buyPlanMapper.getAllDpsBuyPlan(plNo);
		param.put("pvo", pvo);
		
		DetatilPlannerVO dpParam = null; 
		
		int cnt = 0;
				
		for(int i = 0; i < 5; i++) {
			dpParam = new DetatilPlannerVO();
			dpParam.setSpDay(i+1);
			dpParam.setPlNo(plNo);
			List<DetatilPlannerVO> daydpList = buyPlanMapper.getDayDpsBuyPlan(dpParam);
			if(daydpList.size() > 0) {
				param.put("day" + (i+1), daydpList);
				cnt = cnt + 1;
			}
		}
		
		param.put("dayCnt", cnt);
		
	}

	@Override
	public long getCurNum(long plNo) {
		return buyPlanMapper.getCurNum(plNo);
	}

	@Override
	public void getGroupPoint(Map<String, Object> param) {
		
		long plNo = (long)param.get("plNo");
		String memId = (String)param.get("memId");
		
		// 서비스 호출
		PlanerVO mgvo = buyPlanMapper.getGroupPoint(plNo);
		log.debug("mgvo : {}", mgvo);
		
		// 그룹포인트 세팅
		int groupPoint = mgvo.getMategroupPoint();
		param.put("groupPoint", groupPoint);
		
		
		// 그룹장인가?
		log.debug("mategroup_recruiter : {}", mgvo.getMategroupRecruiter());
		if(memId.equals(mgvo.getMategroupRecruiter())) {
			param.put("isGroupLeader", "Y");
		} else {
			param.put("isGroupLeader", "N");
		}
		
		
	}

	@Override
	public void getDeductStep(Map<String, Object> param2) {
		
//		String memId = (String)param2.get("memId");
//		long plNo = (long)param2.get("plNo");
		
		// 차감 단계 세팅
		int mategroupAgree = buyPlanMapper.getDeductStep(param2);
		param2.put("mategroupAgree", mategroupAgree);
		
	}

	@Override
	public int getMemPoint(String memId) {
		return buyPlanMapper.getMemPoint(memId);
	}

	@Override
	public void chargePoint(Map<String, Object> param) {
		ServiceResult sres = null;
		
		int quota = (int)param.get("quota");
		String memId = (String)param.get("memId");
		long plNo = (long)param.get("plNo");
		int groupPoint = (int)param.get("groupPoint");
		
		int memberPoint = buyPlanMapper.getMemPoint(memId);
		int chargePoint = memberPoint - quota;
		//int resultGroupPoint = groupPoint + quota;
		
		int realGroupPoint = buyPlanMapper.getCurrentGroupPoint(plNo);
		
		int resultGroupPoint = realGroupPoint + quota;
		
		param.put("chargePoint", chargePoint);
		
		Map<String,Object> param2 = new HashMap<String, Object>();
		param2.put("memId", memId);
		param2.put("pointContent", memId + "님이 " + quota + "포인트를 차감하였습니다.");
		param2.put("pointAccount", quota);
		
		int status = buyPlanMapper.chargePoint(param);
		if(status > 0) {
			int status2 = buyPlanMapper.insertPointLog(param2);
			if(status2 > 0) {
				param.put("resultGroupPoint", resultGroupPoint);
				int status3 = buyPlanMapper.updateGroupPoint(param);
				if(status3 > 0) {
					int status4 = buyPlanMapper.changeAgreeStatus(param);
					if(status4 > 0) {
						sres = ServiceResult.OK;
						int resultPoint = buyPlanMapper.getResultPoint(plNo);
						param.put("resultPoint", resultPoint);
					} else {
						sres = ServiceResult.FAILED;
					}
				} else {
					sres = ServiceResult.FAILED;
				}
			} else {
				sres = ServiceResult.FAILED;
			}
		} else {
			sres = ServiceResult.FAILED;
		}
		
		param.put("serviceResult", sres);
		
	}

	@Override
	public int isAllGmDeducted(long plNo) {
		return buyPlanMapper.isAllGmDeducted(plNo);
	}

	@Override
	public void updateGmAndG(Map<String, Object> param) {
		ServiceResult sres = null;
		
		long plNo = (long)param.get("plNo");
		
		int resultCnt = 0;
		
		// 그룹 멤버의 상태를 2으로 일괄 변경
		int status = buyPlanMapper.updateGroupMemberStatus(plNo);
		
		if(status>0) {
			// 그룹의 상태를 3단계로 변경
			resultCnt += 1;
			int status2 =  buyPlanMapper.updateGroupStatus(plNo);
			if(status2 > 0) {
				resultCnt += 1;
			}
		}
		
		if(resultCnt == 2) {
			sres = ServiceResult.OK;
		} else {
			sres = ServiceResult.FAILED;
		}
		
		param.put("sres", sres);
		
	}

	@Override
	public String getMateGroupStatus(long plNo) {
		return buyPlanMapper.getMateGroupStatus(plNo);
	}

	@Override
	public List<PlanerVO> getAllMembers(Map<String, Object> param) {
		
		long plNo = (long)param.get("plNo");
		String memId = (String)param.get("memId");
		List<PlanerVO> tempList = buyPlanMapper.getAllMembers(plNo);
		List<PlanerVO> memListExceptMe = new ArrayList<PlanerVO>();
		log.debug("tempList : {}", tempList);
		log.debug("memListExceptMe : {}", memListExceptMe);
		for(PlanerVO plan : tempList) {
			if(!plan.getMategroupId().equals(memId)) {
				memListExceptMe.add(plan);
			}
		}
		return memListExceptMe;
	}

	@Override
	public void isAllDeducted(Map<String, Object> param) {
		long plNo = (long)param.get("plNo");
		int result = buyPlanMapper.isAllDeducted(plNo);
		if(result == 0) {
			param.put("allCompleted", "Y");
		} else {
			param.put("allCompleted", "N");
		}
		
	}

	@Override
	public void ajaxRtAlertBp(Map<String, Object> param) {
		/** 파라미터 조회 */
		RealTimeSenderVO realVO = (RealTimeSenderVO) param.get("realVO");
		
		/** 파라미터 정의 */
		ServiceResult result = null;
		int status = 0;
		
		String[] realrecIdArr = null;
		
		/** 메인로직 처리 */
		// ajax > 실시간 알림 > 로그인 내역 저장
		// 1. 가져온 로그 데이터를 발신자 테이블에 1번만 insert 해보아요
		status = buyPlanMapper.insertSender(realVO);
		
		if(status > 0) { // 마더 값이 들어감
			// 2. 수신자 테이블에 수신자 멤버 수 만큼 insert 해 보아요
			realrecIdArr = realVO.getRealrecIdArr();
			for(String recId : realrecIdArr) {
				realVO.setRealrecId(recId);
				buyPlanMapper.insertReceiver(realVO);
			}
			result = ServiceResult.OK;
		}else { // 실패
			result = ServiceResult.FAILED;
		}
		
		/** 반환자료 저장 */
		param.put("result", result);
		
	}

}

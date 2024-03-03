package kr.or.ddit.indexsearch.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.indexsearch.service.IndexSearchService;
import kr.or.ddit.indexsearch.vo.JourneyinfoVO;
import kr.or.ddit.mapper.IndexSearchMapper;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.RealTimeSenderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class IndexSearchServiceImpl implements IndexSearchService {

	@Inject
	private IndexSearchMapper indexSearchMapper;
	
	@Override
	public void informationList8(Map<String, Object> param) {
		/** 파라미터 조회 */
		/** 파라미터 정의 */
		List<JourneyinfoVO> journeyList8 = new ArrayList<JourneyinfoVO>();
		
		/** 메인로직 처리 */
		journeyList8 = indexSearchMapper.informationList8();
		
		/** 반환자료 저장 */
		param.put("journeyList8", journeyList8);
	}

	@Override
	public List<JourneyinfoVO> searchJourneyList8(JourneyinfoVO journeyVO) {
		return indexSearchMapper.searchJourneyList8(journeyVO);
	}

	@Override
	public List<MemberVO> ajaxMembersId() {
		return indexSearchMapper.ajaxMembersId();
	}

	@Override
	public void ajaxRtAlert(Map<String, Object> param) {
		/** 파라미터 조회 */
		RealTimeSenderVO realVO = (RealTimeSenderVO) param.get("realVO");
		
		/** 파라미터 정의 */
		ServiceResult result = null;
		int status = 0;
		
		String[] realrecIdArr = null;
		
		/** 메인로직 처리 */
		// ajax > 실시간 알림 > 로그인 내역 저장
		// 1. 가져온 로그 데이터를 발신자 테이블에 1번만 insert 해보아요
		status = indexSearchMapper.insertSender(realVO);
		
		if(status > 0) { // 마더 값이 들어감
			// 2. 수신자 테이블에 수신자 멤버 수 만큼 insert 해 보아요
			realrecIdArr = realVO.getRealrecIdArr();
			for(String recId : realrecIdArr) {
				realVO.setRealrecId(recId);
				indexSearchMapper.insertReceiver(realVO);
			}
			result = ServiceResult.OK;
		}else { // 실패
			result = ServiceResult.FAILED;
		}
		
		/** 반환자료 저장 */
		param.put("result", result);
	}

	@Override
	public void ajaxRtSenderGetMsgFn(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		
		/** 파라미터 정의 */
		RealTimeSenderVO journeySender = new RealTimeSenderVO();
		int journeyCnt = 0;
		
		/** 메인로직 처리 */
		// 실시간 알림 정보를 가져오기(로그인한 세션 기준)
		journeySender = indexSearchMapper.sender(memId);
		// 실시간 알림 정보 갯수 가져오기(로그인한 세션 기준)
		journeyCnt = indexSearchMapper.senderCnt(memId);
		
		/** 반환자료 저장 */
		param.put("journeySender", journeySender);
		param.put("journeyCnt", journeyCnt);
	}

	@Override
	public void ajaxRtAlertRead(Map<String, Object> param) {
		/** 파라미터 조회 */
		int realrecNo = Integer.parseInt((String) param.get("realrecNo"));
		log.info("ajaxRtAlertRead > realrecNo : {}", realrecNo);
		
		/** 파라미터 정의 */
		int status = 0;
		ServiceResult result = null;
		
		/** 메인로직 처리 */
		// 바로 가기 클릭 시 안 본 실시간 알림을 본 것으로 처리해 보아요. 업데이트여요.
		status = indexSearchMapper.ajaxRtAlertRead(realrecNo);
		log.info("ajaxRtAlertRead > status : {}", status);
		
		if(status > 0) {
			result = ServiceResult.OK;
		}else { // 실패
			result = ServiceResult.FAILED;
		}
		
		/** 반환자료 저장 */
		param.put("result", result);
	}

	@Override
	public MemberVO planDetailCreateMemId(String plNo) {
		int intPlNo = Integer.parseInt(plNo);
		return indexSearchMapper.planDetailCreateMemId(intPlNo);
	}

	@Override
	public MemberVO loginMemInfoRtAlertSaveInfo(MemberVO loginMemVO) {
		return indexSearchMapper.loginMemInfoRtAlertSaveInfo(loginMemVO);
	}

	@Override
	public void ajaxLoginRtAlertRemove(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		
		/** 파라미터 정의 */
		Map<String, Object> paramMap = new HashMap<String, Object>();
		ServiceResult result = null;
		
		int cnt = 0;
		RealTimeSenderVO rtSender = new RealTimeSenderVO();
		int realsenNo = 0;
		int status = 0;
		int status2 = 0;
		
		/** 메인로직 처리 */
		// 0. 일단 로그인 쌓인게 몇 건인지 가져와 봐요
		cnt = indexSearchMapper.removeRealSenNoCnt();
		log.info("cnt : {}", cnt);
		
		if(cnt > 0) { // 1건 이상 있다는 말이므로 cnt 만큼 반복문을 돌려서 삭제해요
			
			for(int i = 0; i < cnt; i++) {
				
				// 1. 로그인한 알림의 realsenNo 값을 가져와요
				rtSender = indexSearchMapper.removeSelectRealSenNo(memId);
				
				// 1-1. 예외 처리: removeSelectRealSenNo가 null을 반환하는 경우
				if (rtSender == null) {
				    log.warn("removeSelectRealSenNo returned null. Handle this case accordingly.");
				    // 처리할 내용을 여기에 추가하세요.
				    // 예를 들어, 오류 응답을 클라이언트로 반환하거나 기본값으로 초기화할 수 있습니다.
				    realsenNo = 0; // 기본값으로 초기화 예시
				}else {
					realsenNo = rtSender.getRealsenNo();
				}

				log.info("realsenNo : {}", realsenNo);
				
				// 2. 조회한 realsenNo 값으로 발신자 테이블을 삭제해요
				status = indexSearchMapper.removeRealtimereceiverTbl(realsenNo);
				log.info("status : {}", status);
				
				if(status > 0) {
					// 3. 조회한 realsenNo 값으로 수신자 테이블을 삭제해요
					status2 = indexSearchMapper.removeRealtimesenderTbl(realsenNo);
					log.info("status2 : {}", status2);
					if(status2 > 0) {
						result = ServiceResult.OK;
					}else {
						result = ServiceResult.FAILED;
					}
				}else { // 실패
					result = ServiceResult.FAILED;
				}
				
			}
			
		}else { // 돌릴게 없으므로 그냥 ok 사인을 던져요
			result = ServiceResult.OK;
		}
		
		/** 반환자료 저장 */
		param.put("result", result);
	}

	@Override
	public void rtAlertClickInit(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		
		/** 파라미터 정의 */
		ServiceResult result = null;
		int status = 0;
		
		/** 메인로직 처리 */
		status = indexSearchMapper.rtAlertClickInit(memId);
		
		if(status > 0) { // 실시간 알림 초기화 완료
			result = ServiceResult.OK;
		}else { // 실시간 알림 초기화 실패
			result = ServiceResult.FAILED;
		}
		
		/** 반환자료 저장 */
		param.put("result", result);
	}

}

package kr.or.ddit.users.partner.service.impl;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.MyTripMapper;
import kr.or.ddit.mapper.PdfUploadMapper;
import kr.or.ddit.users.partner.service.MyTripService;
import kr.or.ddit.users.partner.vo.ChatroomVO;
import kr.or.ddit.users.partner.vo.PlanerVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

import java.nio.file.Files;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class MyTripServiceImpl implements MyTripService {

	@Inject
	private MyTripMapper myTripMapper;
	
	@Inject
	private PdfUploadMapper pdfUploadMapper;
	
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

	@Override
	public void deletePlan(Map<String, Object> param) {
		/** 파라미터 조회 */
		int plNo = (int) param.get("plNo");
		
		/** 파라미터 정의 */
		int status = 0;
		ServiceResult result = null;
		String message = "";
		String goPage = "";
		
		/** 메인로직 처리 */
		// 항공편 삭제
		myTripMapper.deleteCartAir(plNo);
		myTripMapper.deleteCart(plNo);
		
		// 플래너 삭제하기
		// 1. 세부플랜(s_planer) 삭제 - plNo 이용
		myTripMapper.deleteSPlaner(plNo);
		
		// 2. 좋아요 삭제(planer_like) - plNo 이용
		myTripMapper.deletePlanerLike(plNo);
		
		// 3. 동행 그룹 멤버(mategroup_member)삭제 후 동행그룹(mategroup)삭제
		// plNo에 해당하는 동행그룹을 하나 조회하여 그 그룹번호(mg_no)가 외래키로 들어간 동행그룹멤버 테이블의 레코드를 전부 삭제
		myTripMapper.deleteMategrpMem(plNo);
		// + 채팅방도 삭제
		myTripMapper.deleteChatAll(plNo);
		myTripMapper.deleteChatRoom(plNo);
		myTripMapper.deleteMategrp(plNo);
		
		
		
		// 4. 플랜(planer) 삭제 - plNo 이용
		status = myTripMapper.deletePlan(plNo);
		
		if(status > 0) { // 삭제 성공
			result = ServiceResult.OK;
			message = "해당 플래너를 삭제하였습니다.";
			goPage = "redirect:/partner/mygroup.do";
		}else { // 삭제 실패
			result = ServiceResult.FAILED;
			message = "해당 플래너 삭제에 실패했습니다.";
			goPage = "partner/mygroup";
		}
		
		/** 반환자료 저장 */
		param.put("result", result);
		param.put("message", message);
		param.put("goPage", goPage);
	}

	@Override
	public void meetsquareRoom(Map<String, Object> param) {
		/** 파라미터 조회 */
		int plNo = (int) param.get("plNo");
		
		/** 파라미터 정의 */
		PlanerVO recruiter = new PlanerVO();
		List<PlanerVO> mateList = new ArrayList<PlanerVO>();
		int mateCnt = 0;
		List<PlanerVO> chatRoomInfo = new ArrayList<PlanerVO>();
		List<PlanerVO> chatInfoList = new ArrayList<PlanerVO>();
		
		/** 메인로직 처리 */
		// 해당 플래너 참여자 목록 들고 오기
		// 1. 모집자 목록 들고오기
		recruiter = myTripMapper.meetsquareRoomOne(plNo);
		// 2. 참여자 목록 들고오기
		mateList = myTripMapper.meetsquareRoomList(plNo);
		// 3. 현재멤버 수 들고오기
		mateCnt = myTripMapper.mateCnt(plNo);
		// 4. 채팅방 정보 들고오기
		chatRoomInfo = myTripMapper.chatRoomInfo(plNo);
		// 5. 채팅내역 들고오기
		chatInfoList = myTripMapper.chatInfoList(plNo);
		
		/** 반환자료 저장 */
		param.put("recruiter", recruiter);
		param.put("mateList", mateList);
		param.put("mateCnt", mateCnt);
		param.put("chatRoomInfo", chatRoomInfo);
		param.put("chatInfoList", chatInfoList);
	}

	@Override
	public PlanerVO excludeNonUser(PlanerVO planerVO) {
		return myTripMapper.excludeNonUser(planerVO);
	}

	@Override
	public void acceptMem(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		int plNo = (int) param.get("plNo");
		
		/** 파라미터 정의 */
		PlanerVO planerVO = new PlanerVO();
		int status = 0;
		int status2 = 0;
		PlanerVO recruiter = new PlanerVO();
		List<PlanerVO> mateList = new ArrayList<PlanerVO>();
		int mateCnt = 0;
		
		/** 메인로직 처리 */
		// 1. 멤버 상태를 승인으로 업데이트
		planerVO.setMemId(memId);
		planerVO.setPlNo(plNo);
		status = myTripMapper.acceptMemUpd(planerVO);
		
		// 2. 만들어진 채팅방에 승인된 멤버를 인서트해야 함
		// mategroup테이블의 mategroup_currentnum(현재원)를 가입 신청 상태가 'Y'인 승인된 회원들의 수로 업데이트 
		status2 = myTripMapper.updateCurMemCnt(plNo);	
		
		if(status > 0) { // 멤버 상태 승인
			if(status2 > 0) {
				// 2. 갱신된 리스트 들고 오기
				recruiter = myTripMapper.meetsquareRoomOne(plNo);
				mateList = myTripMapper.meetsquareRoomList(plNo);
			}
		}
		
		// 3. 갱신된 채팅방 참여자 수 가져오기
		mateCnt = myTripMapper.mateCnt(plNo);
		
		/** 반환자료 저장 */
		param.put("recruiter", recruiter);
		param.put("mateList", mateList);
		param.put("mateCnt", mateCnt);
	}

	@Override
	public void rejectMem(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		int plNo = (int) param.get("plNo");
		
		/** 파라미터 정의 */
		PlanerVO planerVO = new PlanerVO();
		int status = 0;
		int status2 = 0;
		PlanerVO recruiter = new PlanerVO();
		List<PlanerVO> mateList = new ArrayList<PlanerVO>();
		int mateCnt = 0;
		
		/** 메인로직 처리 */
		// 1. 멤버 상태를 승인으로 업데이트
		planerVO.setMemId(memId);
		planerVO.setPlNo(plNo);
		status = myTripMapper.rejectMemUpd(planerVO);
		
		// 현재원을 업데이트
		status2 = myTripMapper.updateCurMemCnt(plNo);
		
		if(status > 0) { // 멤버 상태 승인
			// 2. 갱신된 리스트 들고 오기
			if (status2 > 0) {
				recruiter = myTripMapper.meetsquareRoomOne(plNo);
				mateList = myTripMapper.meetsquareRoomList(plNo);
			}
		}
		
		// 3. 갱신된 채팅방 참여자 수 가져오기
		mateCnt = myTripMapper.mateCnt(plNo);
		
		/** 반환자료 저장 */
		param.put("recruiter", recruiter);
		param.put("mateList", mateList);
		param.put("mateCnt", mateCnt);
	}

	@Override
	public void chgStatusJoiner(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		int plNo = (int) param.get("plNo");
		
		/** 파라미터 정의 */
		PlanerVO planerVO = new PlanerVO();
		int status = 0;
		int status2 = 0;
		ServiceResult result = null;
		String message = "";
		String goPage = "";
		
		/** 메인로직 처리 */
		// 해당 플래너 취소 처리 하기
		planerVO.setMemId(memId);
		planerVO.setPlNo(plNo);
		
		status = myTripMapper.chgStatusJoiner(planerVO);
		
		// 현재 인원을 업데이트
		status2 = myTripMapper.updateCurMemCnt(plNo);
		
		if(status > 0) { // 업데이트 성공
			if(status2 > 0) {
				result = ServiceResult.OK;
				message = "해당 플래너를 취소하였습니다. 재참여는 불가합니다.";
				goPage = "redirect:/partner/mygroup.do";
			} else {
				result = ServiceResult.FAILED;
				message = "현재 인원을 업데이트 하는데 실패했습니다. 다시 시도해 주세요.";
				goPage = "partner/mygroup";
			}
		}else { // 업데이트 실패
			result = ServiceResult.FAILED;
			message = "해당 플래너를 취소하는데 실패했습니다. 다시 시도해 주세요.";
			goPage = "partner/mygroup";
		}
		
		/** 반환자료 저장 */
	    param.put("result", result);
	    param.put("message", message);
	    param.put("goPage", goPage);
	}

	@Override
	public void ajaxChatContSave(Map<String, Object> param) {
		/** 파라미터 조회 */
		ChatroomVO chatroomVO = (ChatroomVO) param.get("chatroomVO");
		
		/** 파라미터 정의 */
		String result = "";
		int status = 0;
		
		/** 메인로직 처리 */
		// 1. 채팅 내역 저장하기
		status = myTripMapper.ajaxChatContSave(chatroomVO);
		if(status > 0) { // 채팅 내역 저장 성공
			result = "OK";
		}else { // 채팅 내역 저장 실패
			result = "FAILED";
		}
		
		/** 반환자료 저장 */
		param.put("result", result);
	}

	@Override
	public void groupRecruitEnded(Map<String, Object> param) {
		/** 파라미터 조회 */
	    int plNo = (int) param.get("plNo");
	    
	    /** 파라미터 정의 */
	    int cnt1 = 0;
	    int cnt2 = 0;
	    int status = 0;
	    int status2 = 0;
	    ServiceResult result = null;
	    String message = "";
	    String goPage = "";
	    
	    /** 메인로직 처리 */
	    // 0. 혼자가는 여행일 경우, mategroup_apply = 'Y'이게 나 혼자니까 무조건 cnt2 = 1;
	    cnt1 = myTripMapper.soloTrip(plNo);
	    log.debug("cnt1 : {}", cnt1);
	    
//	    if(cnt1 == 1) { // 신청 멤버는 모르겠고 나혼자 무조건 ㄱ
//	    	// 1. 현재 플래너에 대기 중인 나 자신을 모집 마감 상태로 바꾸기
//    		status = myTripMapper.mategroupApplyCancel(plNo);
//    		if(status > 0) {
//    			// 2. 현재 플래너의 상태를 1단계에서 2단계로 바꾸기
//			    status2 = myTripMapper.mategroupStatusSecondStage(plNo);
//		    	if(status2 > 0) { // 2단계로 바꾸기 성공
//		    		result = ServiceResult.OK;
//			        message = "현재 플래너에 참여 모집을 마감하였습니다. 다음 단계를 진행해 주세요.";
//			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
//		    	}else { // 2단계로 바꾸기 실패
//		    		result = ServiceResult.FAILED;
//			        message = "2단계로 바꾸기 실패했습니다.";
//			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
//		    	}
//    		}
//	    }else if(cnt1 > 0) { // 신청 멤버는 모르겠는데 일단 동행 모집할 거임
//
//	    }
	    // 경우의수 
	    // 1. 나 자신은 당연히 'Y'겠지
	    // 나 혼자인 경우
	    // 1. 아무도 안 받고 나만 있는 상태에서 모집마감
	    // 2. 아무도 안 받고 신청한 사람('W')이 있는 상태에서 모집마감
	    // 3. 아무도 안 받고 신청한 사람('W')이 있는 상태에서 모집마감
	    // 동행 모집한경우
	    // 1. 나 외에 한명 이상을 승인한 상황에서 대기자('W')가 존재하는 경우
	    // 2. 나 외에 한명 이상을 승인한 상황에서 거절자나 취소자('C', 'N')가 존재하는 경우
	    // 3. 나 외에 한명 이상을 승인한 상황에서 대기자나 거절자, 취소자가 존재하지 않는 경우
	    
	    cnt1 = myTripMapper.soloTrip(plNo);
	    
	    // cnt1 == 1이면 혼자가는거여
	    if(cnt1 == 1) {
	    	// 신청멤버를 센다
	    	cnt2 = myTripMapper.waitMemCnt(plNo);
	    	log.debug("cnt2 : {}", cnt2);
	    	if(cnt2 == 0) {	// 신청멤버가 없어. 또는 취소자나 거절자만 있어
	    		// 모집마감 가능
	    		status2 = myTripMapper.mategroupStatusSecondStage(plNo);
	    		if(status2 > 0) {
	    			result = ServiceResult.OK;
			        message = "현재 플래너에 참여 모집을 마감하였습니다. 다음 단계를 진행해 주세요.";
			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    		} else {
	    			result = ServiceResult.FAILED;
			        message = "2단계로 바꾸기 실패했습니다.";
			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    		}
	    		
	    	} else if(cnt2 >= 1) {	// 신청멤버가 한명 이상이여
	    		// 일단 대기자들을 E(모집마감)상태로 바꾸고 모집마감해
	    		status = myTripMapper.mategroupApplyCancel(plNo);
	    		if(status > 0) {
	    			status2 = myTripMapper.mategroupStatusSecondStage(plNo);
	    			if(status2 > 0) {
	    				result = ServiceResult.OK;
				        message = "현재 플래너에 참여 모집을 마감하였습니다. 다음 단계를 진행해 주세요.";
				        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    			} else {
	    				result = ServiceResult.FAILED;
				        message = "2단계로 바꾸기 실패했습니다.";
				        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    			}
	    		} else {
	    			result = ServiceResult.FAILED;
			        message = "모집 마감 상태 변경 실패했습니다.";
			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    		}
	    		
	    	}
	    	
	    } else if(cnt1 > 1) {	// cnt1 2이상이면 같이가는 거겠지
	    	// 신청멤버를 센다
	    	cnt2 = myTripMapper.waitMemCnt(plNo);
	    	log.debug("cnt2 : {}", cnt2);
	    	if(cnt2 == 0) {	// 신청멤버가 없어. 또는 취소자나 거절자만 있어
	    		// 모집마감 가능
	    		status2 = myTripMapper.mategroupStatusSecondStage(plNo);
	    		if(status2 > 0) {
	    			result = ServiceResult.OK;
			        message = "현재 플래너에 참여 모집을 마감하였습니다. 다음 단계를 진행해 주세요.";
			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    		} else {
	    			result = ServiceResult.FAILED;
			        message = "2단계로 바꾸기 실패했습니다.";
			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    		}
	    		
	    	} else if(cnt2 >= 1) {	// 신청멤버가 한명 이상이여
	    		// 일단 대기자들을 E(모집마감)상태로 바꾸고 모집마감해
	    		status = myTripMapper.mategroupApplyCancel(plNo);
	    		if(status > 0) {
	    			status2 = myTripMapper.mategroupStatusSecondStage(plNo);
	    			if(status2 > 0) {
	    				result = ServiceResult.OK;
				        message = "현재 플래너에 참여 모집을 마감하였습니다. 다음 단계를 진행해 주세요.";
				        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    			} else {
	    				result = ServiceResult.FAILED;
				        message = "2단계로 바꾸기 실패했습니다.";
				        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    			}
	    		} else {
	    			result = ServiceResult.FAILED;
			        message = "모집 마감 상태 변경 실패했습니다.";
			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
	    		}
	    		
	    	}
	    	
	    }
	    
	    
    	// 0. 신청멤버 카운트를 센다
//    	cnt2 = myTripMapper.waitMemCnt(plNo);
//    	log.debug("cnt2 : {}", cnt2);
//    	if(cnt2 == 0) { // 신청 멤버가 없는 경우
//    		result = ServiceResult.FAILED;
//            message = "신청 멤버가 없습니다.";
//            goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
//    	}else if(cnt2 >= 1) { // 동행 참가인 경우
//    		// 1. 현재 플래너에 대기 중인 멤버를 모집 마감 상태로 바꾸기
//		    status = myTripMapper.mategroupApplyCancel(plNo);
//		    
//		    if(status > 0) { // 모집 마감 상태 변경 성공
//		    	// 2. 현재 플래너의 상태를 1단계에서 2단계로 바꾸기
//			    status2 = myTripMapper.mategroupStatusSecondStage(plNo);
//		    	if(status2 > 0) { // 2단계로 바꾸기 성공
//		    		result = ServiceResult.OK;
//			        message = "현재 플래너에 참여 모집을 마감하였습니다. 다음 단계를 진행해 주세요.";
//			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
//		    	}else { // 2단계로 바꾸기 실패
//		    		result = ServiceResult.FAILED;
//			        message = "2단계로 바꾸기 실패했습니다.";
//			        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
//		    	}
//		    }else { // 모집 마감 상태 변경 실패
//		    	result = ServiceResult.FAILED;
//		        message = "모집 마감 상태 변경 실패했습니다.";
//		        goPage = "redirect:/partner/meetsquare.do?plNo=" + plNo;
//		    }
//    	}
	    
	    /** 반환자료 저장 */
	    param.put("result", result);
	    param.put("message", message);
	    param.put("goPage", goPage);
	}

	@Override
	public void chatContTxtDown(Map<String, Object> param) {
		
		/** 파라미터 조회 */
		int plNo = (int)param.get("plNo");
		
		/** 파라미터 정의*/
		List<PlanerVO> allChatList = new ArrayList<PlanerVO>();
		
		/** 메인로직 처리 */
		allChatList = myTripMapper.chatContTxtDown(plNo);
		
		// 로그 내용 만들기
		StringBuilder content = new StringBuilder();
        for (PlanerVO message : allChatList) {
        	String line = String.format("[%s][%s][%s]: %s", 
			message.getChatYmd(), message.getChatHms(), message.getMemName(), message.getChatContent());
            content.append(line).append("\n");
        }
        
        String allContent = content.toString();
        log.debug("allContent : {}", allContent);
        
        byte[] contentBytes = allContent.getBytes();
        
        /** 반환자료 저장 */
        param.put("contentBytes", contentBytes);
		
	}

	@Override
	public void chatContDelete(Map<String, Object> param) {
		/** 파라미터 조회 */
		int plNo = (int)param.get("plNo");
		
		/** 파라미터 정의*/
		int status =  0;
		String delRes = "";
		
		/** 메인로직 처리 */
		status = myTripMapper.chatContDelete(plNo);
		
		if(status > 0) {
			delRes = "success"; 
		} else {
			delRes = "failed"; 
		}
		
		/** 반환자료 저장 */
		param.put("delRes", delRes);
		
	}

	// 일정공유
	@Override
	public Map<String, Object> planShare(HttpServletRequest request, Map<String, Object> param) throws IOException {
	    // 파라미터 조회
	    int plNo = (int)param.get("plNo");
	    String pdfUrl = pdfUploadMapper.getPdfUrl(plNo);
	    
	    log.info("pdfUrl : " + pdfUrl);
	    log.info("plNo : " + plNo);

	    Map<String, Object> result = new HashMap<String, Object>();

	    // pdfUrl이 null이 아닌 경우에만 처리합니다.
	    if (pdfUrl != null) {
	        // PDF 파일이 저장된 경로를 찾습니다.
	        String realPath = request.getServletContext().getRealPath(pdfUrl);
	        File pdfFile = new File(realPath);

	        log.info("realPath : " + realPath);
	        log.info("pdfFile : " + pdfFile.getName());
	      

	        // PDF 파일이 존재하는 경우, 파일의 바이트 배열과 파일 이름을 반환합니다.
	        if(pdfFile.exists()) {
	            byte[] fileBytes = Files.readAllBytes(pdfFile.toPath());
	            String filename = pdfFile.getName();

	            result.put("fileBytes", fileBytes);
	            result.put("filename", filename);
	        } 
	    }

	    return result;
	}

	@Override
	public ServiceResult travelTheEnd(int plNo) {
		ServiceResult sres = null;
		int res = myTripMapper.travelTheEnd(plNo);
		
		if(res > 0) {
			sres = ServiceResult.OK;
		} else {
			sres = ServiceResult.FAILED;
		}
		
		return sres;
	}

}

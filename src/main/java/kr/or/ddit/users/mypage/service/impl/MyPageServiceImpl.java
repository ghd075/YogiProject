package kr.or.ddit.users.mypage.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.MyPageMapper;
import kr.or.ddit.users.board.vo.QuestionVO;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.mypage.service.MyPageService;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.RealTimeSenderVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class MyPageServiceImpl implements MyPageService {

	@Inject
	private MyPageMapper mypageMapper;
	
	@Override
	public ServiceResult myinfoUpd(HttpServletRequest req, MemberVO memberVO) {
		ServiceResult result = null;
		
		// 회원 정보 수정 시, 프로필 이미지로 파일 업로드 할 서버 경로 지정
		String uploadPath = req.getServletContext().getRealPath("/resources/profile");
		File file = new File(uploadPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		
		String profileImg = ""; // 회원정보에 추가될 프로필 이미지 경로
		try {
			
			// 넘겨받은 회원정보에서 파일 데이터 가져오기
			MultipartFile profileImgFile = memberVO.getImgFile();
			
			// 넘겨받은 파일 데이터가 존재할 때
			if(profileImgFile.getOriginalFilename() != null && !profileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 생성
				fileName += "_" + profileImgFile.getOriginalFilename(); // UUID_원본파일명으로 생성
				uploadPath += "/" + fileName; // /resources/profile/UUID_원본파일명
				
				profileImgFile.transferTo(new File(uploadPath)); // 해당 위치에 파일 복사
				profileImg = "/resources/profile/" + fileName; // 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
			}
			
			memberVO.setMemProfileimg(profileImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int status = mypageMapper.myinfoUpd(memberVO);
		if(status > 0) { // 수정 성공
			result = ServiceResult.OK;
		}else { // 수정 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public MemberVO updCheck(MemberVO memberVO) {
		return mypageMapper.updCheck(memberVO);
	}

	@Override
	public ServiceResult memDelete(String memId) {
		ServiceResult result = null;
		
		int status = mypageMapper.memDelete(memId);
		if(status > 0) { // 회원 탈퇴 성공
			result = ServiceResult.OK;
		}else { // 회원 탈퇴 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public void getRtAlertList(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		log.info("memId : {}", memId);
		
		/** 파라미터 정의 */
		List<RealTimeSenderVO> rtAlertList = new ArrayList<RealTimeSenderVO>();
		
		/** 메인로직 처리 */
		// 알림 내역 리스트 가져오기
		rtAlertList = mypageMapper.getRtAlertList(memId);
		log.info("rtAlertList : {}", rtAlertList);
		
		/** 예외처리 - rtAlertList가 null인 경우 */
	    if (rtAlertList == null) {
	        System.out.println("Warning: rtAlertList is null");
	        return;
	    }

	    /** 반환자료 저장 */
	    param.put("rtAlertList", rtAlertList);
	}

	@Override
	public void rtAlertOneDelete(Map<String, Object> param) {
		/** 파라미터 조회 */
		int realrecNo = (int) param.get("realrecNo");
		
		/** 파라미터 정의 */
		int status = 0;
		ServiceResult result = null;
	    String message = "";
	    String goPage = "";
	    
	    /** 메인로직 처리 */
	    // 수신자 번호에 해당하는 실시간 알림 1건 삭제하기
	    status = mypageMapper.rtAlertOneDelete(realrecNo);
	    
	    if(status > 0) { // 삭제 완료
	    	result = ServiceResult.OK;
	    	message = "실시간 알림 내역 삭제에 성공했습니다.";
	    	goPage = "redirect:/mypage/myinfo.do?submenu=2";
	    }else { // 삭제 실패
	    	result = ServiceResult.FAILED;
	    	message = "실시간 알림 내역 삭제에 실패했습니다.";
	    	goPage = "redirect:/mypage/myinfo.do?submenu=2";
	    }
	    
	    /** 반환자료 저장 */
	    param.put("result", result);
	    param.put("message", message);
	    param.put("goPage", goPage);
	}

	@Override
	public void getQnaList(Map<String, Object> param) {
		/** 파라미터 조회 */
		String memId = (String) param.get("memId");
		log.info("memId : {}", memId);
		
		/** 파라미터 정의 */
		List<QuestionVO> qnaList = new ArrayList<QuestionVO>();
		
		/** 메인로직 처리 */
		// 문의 내역 리스트 가져오기
		qnaList = mypageMapper.getQnaList(memId);
		log.info("qnaList : {}", qnaList);
		
		/** 예외처리 - rtAlertList가 null인 경우 */
	    if (qnaList == null) {
	    	log.info("Warning: rtAlertList is null");
	        return;
	    }

	    /** 반환자료 저장 */
	    param.put("qnaList", qnaList);
		
	}

	@Override
	public void qnaOneDelete(Map<String, Object> param) {
		/** 파라미터 조회 */
		int boNo = (int) param.get("boNo");
		
		/** 파라미터 정의 */
		int status = 0;
		ServiceResult result = null;
	    String message = "";
	    String goPage = "";
	    
	    /** 메인로직 처리 */
	    // 수신자 번호에 해당하는 실시간 알림 1건 삭제하기
	    status = mypageMapper.qnaOneDelete(boNo);
	    
	    if(status > 0) { // 삭제 완료
	    	result = ServiceResult.OK;
	    	message = "실시간 알림 내역 삭제에 성공했습니다.";
	    	goPage = "redirect:/mypage/boardinfo.do?submenu=1";
	    }else { // 삭제 실패
	    	result = ServiceResult.FAILED;
	    	message = "실시간 알림 내역 삭제에 실패했습니다.";
	    	goPage = "redirect:/mypage/boardinfo.do?submenu=1";
	    }
	    
	    /** 반환자료 저장 */
	    param.put("result", result);
	    param.put("message", message);
	    param.put("goPage", goPage);
		
	}

	@Override
	public List<PlannerLikeVO> getLikeList(String memId) {
		return mypageMapper.getLikeList(memId);
	}

	@Override
	public void plLikeDelete(Map<String, Object> param) {
		/** 파라미터 조회 */
		int plLikeNo = (int) param.get("plLikeNo");
		
		/** 파라미터 정의 */
		int status = 0;
		ServiceResult result = null;
	    String message = "";
	    String goPage = "";
	    
	    /** 메인로직 처리 */
	    // 수신자 번호에 해당하는 실시간 알림 1건 삭제하기
	    status = mypageMapper.plLikeDelete(plLikeNo);
	    
	    if(status > 0) { // 삭제 완료
	    	result = ServiceResult.OK;
	    	message = "좋아요 취소에 성공했습니다.";
	    	goPage = "redirect:/mypage/myinfo.do?submenu=1";
	    }else { // 삭제 실패
	    	result = ServiceResult.FAILED;
	    	message = "좋아요 취소에 실패했습니다.";
	    	goPage = "redirect:/mypage/myinfo.do?submenu=1";
	    }
	    
	    /** 반환자료 저장 */
	    param.put("result", result);
	    param.put("message", message);
	    param.put("goPage", goPage);
		
	}
	
}

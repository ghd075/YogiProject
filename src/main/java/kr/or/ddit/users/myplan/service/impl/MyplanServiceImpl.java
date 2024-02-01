package kr.or.ddit.users.myplan.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.PlannerMapper;
import kr.or.ddit.users.myplan.service.MyplanService;
import kr.or.ddit.users.myplan.vo.*;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@Transactional(rollbackFor = Exception.class)
public class MyplanServiceImpl implements MyplanService {

	@Inject
	private PlannerMapper plannerMapper;
	
	@Override
	public ArrayList<AreaVO> areaList() {
		return plannerMapper.areaList();
	}

	@Override
	public ArrayList<SigunguVO> sigunguList(String areaCode) {
		return plannerMapper.sigunguList(areaCode);
	}

	@Override
	public SearchResultVO searchedList(SearchCodeVO searchCode) {
		List<TouritemsVO> tourList = plannerMapper.searchResult(searchCode);
		int tourCnt = plannerMapper.contentCnt(searchCode);
		SearchResultVO result = new SearchResultVO(tourList, tourCnt);
		return result;
	}

	@Override
	public void newPlanner(PlannerVO plannerVO) {
		plannerMapper.newPlanner(plannerVO);
	}

	@Override
	public PlannerListVO planList(String planType, String areaName) {
	    if (planType.equals("areaType")) {
	        return plannerMapper.selectAreaType(areaName);
	    } else if (planType.equals("sigogunType")) {
	        return plannerMapper.selectSigogunType(areaName);
	    } else {
	        throw new IllegalArgumentException("Invalid planType: " + planType);
	    }
	}

	
	/* 세부플랜 CRUD */
	
	/**
	 * 날짜에 해당하는 세부플랜들 조회
	 */
	@Override
	public List<TouritemsVO> selectDayById(DetatilPlannerVO s_planner) {
		return plannerMapper.selectDayById(s_planner);
	}
	
	/**
	 * 하나의 장소를 조회
	 */
	@Override
	public TouritemsVO getTour(String contentId) {
		return plannerMapper.getTour(contentId);
	}
	
	/**
	 * 세부플랜 인서트 후 조회
	 */
	@Override
	public TouritemsVO insertDetailPlan(DetatilPlannerVO s_planner) {
		TouritemsVO tvo = null;
		
		int cnt = plannerMapper.insertDetailPlan(s_planner);
		
		if(cnt > 0) {
			tvo = plannerMapper.getDetailPlan(s_planner);
		} 
		
		return tvo; 
	}

	/**
	 * 날짜에 해당하는 세부플랜 전체삭제
	 */
	@Override
	public ServiceResult deleteAllDetailPlan(DetatilPlannerVO s_planner) {
		ServiceResult res = null;
		
		int cnt = plannerMapper.deleteAllDetailPlan(s_planner);
		if(cnt > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res; 
	}

	/**
	 * 하나의 세부플랜 개별 삭제
	 */
	@Transactional
	@Override
	public ServiceResult deleteOneDetailPlan(DetatilPlannerVO s_planner) {
		ServiceResult res = null;
//		
//		log.debug("왜 안오냐", s_planner.getSpNo());
//		int cnt = plannerMapper.deleteOneDetailPlan(s_planner);
//		if(cnt > 0) {
//			res = ServiceResult.OK;
//		} else {
//			res = ServiceResult.FAILED;
//		}
//		
//		return res; 
		
		// 전체
		List<TouritemsVO> tList = plannerMapper.selectDayById(s_planner);
		// 삭제할 개별플랜 조회
		TouritemsVO tvo = plannerMapper.getDetailPlan(s_planner);
		
		if(tvo == null) {
			return ServiceResult.FAILED;
		}
		// 전체 삭제
		int cnt = plannerMapper.deleteAllDetailPlan(s_planner);
		int idxCnt = 1;
		
		// 삭제할 개별플랜 제외하고 인서트
//		for(TouritemsVO tOne : tList) {
		for(int i = 0; i < tList.size(); i++) {
			TouritemsVO tOne = tList.get(i);
			DetatilPlannerVO dvo = null; 
			
			if(tOne.getSpNo() != tvo.getSpNo()) {
				dvo = new DetatilPlannerVO();
				dvo.setPlNo(tOne.getPlNo());
				dvo.setContentId(tOne.getContentId());
				dvo.setSpDay(tOne.getSpDay());
				dvo.setSpDistance(tOne.getSpDistance());
				dvo.setSpEday(tOne.getSpEday());
				dvo.setSpSday(tOne.getSpSday());
//				dvo.setSpNo(tOne.getSpNo());
				dvo.setSpOrder(idxCnt);
				log.debug("dvo.toString() : {}", dvo.toString());
				plannerMapper.insertDetailPlan(dvo);
				idxCnt += 1;
			} 
		}
		
		
		return res = ServiceResult.OK;
		
	}

	/**
	 * 모든 세부플랜 삭제
	 */
	@Override
	public ServiceResult deleteAllAllDetailPlan(long plNo) {
		ServiceResult res = null;
		
		int cnt = plannerMapper.deleteAllAllDetailPlan(plNo);
		if(cnt > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
		
		return res; 
	}
	
	@Override
	public ServiceResult delPlan(long plNo) {
		ServiceResult res = null;
		
		// 세부플랜 부터 삭제
		int cnt = plannerMapper.deleteAllAllDetailPlan(plNo);
		int cnt2 = plannerMapper.delPlan(plNo);
		if(cnt2 > 0) {
			res = ServiceResult.OK;
		} else {
			res = ServiceResult.FAILED;
		}
	
		return res;
	}

	/**
	 * 세부플랜 저장
	 */
	@Transactional
	@Override
	public void updatePlan(Map<String, Object> param) {
		/** 파라미터 조회 */
		HttpServletRequest req = (HttpServletRequest) param.get("req");
		PlannerVO plan = (PlannerVO) param.get("planVO");
		MultipartFile imgFile = (MultipartFile) param.get("imgFile");
		String spSday = (String) param.get("spSday");
		String spEday = (String) param.get("spEday");
		
		
		/** 파라미터 정의 */
		ServiceResult result = null;
		Map<String,Object> param2 = new HashMap<String, Object>();	// updateSEdays()를 위한 파라미터
		param2.put("spSday", spSday);
		param2.put("spEday", spEday);
		param2.put("plNo", plan.getPlNo());
		
		/** 메인로직 처리 */
		// 파일 업로드 할 서버 경로 지정
		String uploadPath = req.getServletContext().getRealPath("/resources/images/planner/" + plan.getPlNo());
		File file = new File(uploadPath);
		if (!file.exists()) {
			file.mkdirs();
		}
		
		String addedImg = ""; // 추가될 이미지 경로
		try {
			// 넘겨받은 회원정보에서 파일 데이터 가져오기
			MultipartFile addedImgFile = imgFile;
			
			// 넘겨받은 파일 데이터가 존재할 때
			if(addedImgFile.getOriginalFilename() != null && !addedImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 생성
				fileName += "_" + addedImgFile.getOriginalFilename(); // UUID_원본파일명으로 생성
				uploadPath += "/" + fileName; // /resources/profile/UUID_원본파일명
				
				addedImgFile.transferTo(new File(uploadPath)); // 해당 위치에 파일 복사
				addedImg = "/resources/images/planner/" + plan.getPlNo() + "/" + fileName; // 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
			}
			
			plan.setPlThumburl(addedImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 서비스 실행
		int successCnt = 0;
		
		int status = plannerMapper.updatePlan(plan);
		
		
		if(status > 0) { // 등록 성공
			successCnt += 1;
			int status2 = plannerMapper.updateSEdays(param2);
			if(status2 > 0) {
				successCnt += 1;
				int status3 = plannerMapper.insertMategroup(plan);
				if(status3 > 0) {
					successCnt += 1;
					int status4 = plannerMapper.insertMategroupMem(plan);
					if(status4 > 0) {
						successCnt += 1;
						log.debug("mgno : {}", plan.getMgNo());
						int status5 = plannerMapper.insertChatRoom(plan);
						if(status5 > 0) {
							successCnt += 1;
						}
					}
				}
			}
		}
		
		if(successCnt == 5) {
			result = ServiceResult.OK;
		} else {
			result =  ServiceResult.FAILED;
		}
		
		/** 반환자료 저장 */
		param.put("serviceResult", result);
		
	}

}

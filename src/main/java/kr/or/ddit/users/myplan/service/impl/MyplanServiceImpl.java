package kr.or.ddit.users.myplan.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
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
	 * 특정 날짜에 해당하는 세부플랜 전체 삭제
	 */
	@Override
	public List<TouritemsVO> detailDeleteAll(DetatilPlannerVO s_planner) {
		plannerMapper.detailDeleteAll(s_planner);
		return plannerMapper.selectDayById(s_planner);
	}
	
	/**
	 * 날짜에 상관없이 모든 세부플랜 삭제
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

	/**
	 * 세부플랜 저장
	 */
	@Transactional
	@Override
	public ServiceResult updatePlan(HttpServletRequest req, PlannerVO plan, MultipartFile imgFile) {
		ServiceResult result = null;
		
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
		
		int status = plannerMapper.updatePlan(plan);
		
		if(status > 0) { // 등록 성공
			plannerMapper.insertMategroup(plan);
			plannerMapper.insertMategroupMem(plan);
			result = ServiceResult.OK;
		}else { // 등록 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

}

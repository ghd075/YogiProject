package kr.or.ddit.users.myplan.service.impl;

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

import kr.or.ddit.mapper.JourneyMapper;
import kr.or.ddit.users.myplan.service.JourneyService;
import kr.or.ddit.users.myplan.vo.JourneyinfoVO;
import kr.or.ddit.utils.ServiceResult;

@Service
@Transactional(rollbackFor = Exception.class)
public class JourneyServiceImpl implements JourneyService {

	@Inject
	private JourneyMapper journeyMapper;
	
	@Override
	public ServiceResult inforReg(HttpServletRequest req, JourneyinfoVO journeyVO) {
		ServiceResult result = null;
		
		// 여행 정보 등록 시, 미리보기 이미지로 파일 업로드할 서버 경로를 지정
		String uploadPath = req.getServletContext().getRealPath("/resources/journeyinfo");
		File file = new File(uploadPath);
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String previewImg = ""; // 여행 정보에 추가될 미리보기 이미지 경로
		try {
			// 넘겨받은 여행정보에서 파일 데이터 가져오기
			MultipartFile previewImgFile = journeyVO.getImgFile();
			
			// 넘겨받은 파일 데이터가 존재할 때
			if(previewImgFile.getOriginalFilename() != null && !previewImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 생성
				fileName += "_" + previewImgFile.getOriginalFilename(); // UUID_원본파일명으로 생성
				uploadPath += "/"  + fileName; // /resources/journeyinfo/UUID_원본파일명
				
				previewImgFile.transferTo(new File(uploadPath)); // 해당 위치에 파일 복사
				previewImg = "/resources/journeyinfo/" + fileName; // 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
			}
			
			journeyVO.setInfoPreviewimg(previewImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int status = journeyMapper.inforReg(journeyVO);
		
		if(status > 0) { // 등록 성공
			result = ServiceResult.OK;
		}else { // 등록 실패
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public void informationList(Map<String, Object> param) {
		/** 파라미터 조회 */
		/** 파라미터 정의 */
		List<JourneyinfoVO> journeyList = new ArrayList<JourneyinfoVO>();
		
		/** 메인로직 처리 */
		// 여행 정보를 리스트로 받아오기
		journeyList = journeyMapper.informationList();
		
		/** 반환자료 저장 */
		param.put("journeyList", journeyList);
	}

	@Override
	public JourneyinfoVO selectJourney(int infoNo) {
		return journeyMapper.selectJourney(infoNo);
	}

	@Override
	public ServiceResult inforModify(HttpServletRequest req, JourneyinfoVO journeyVO) {
		ServiceResult result = null;
		
		// 여행 정보 수정 시, 미리보기 이미지로 파일 업로드할 서버 경로 지정
		String uploadPath = req.getServletContext().getRealPath("/resources/journeyinfo");
		File file = new File(uploadPath);
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String previewImg = ""; // 여행 정보에 추가될 미리보기 이미지 경로
		try {
			// 넘겨받은 여행정보에서 파일 데이터 가져오기
			MultipartFile previewImgFile = journeyVO.getImgFile();
			
			// 넘겨받은 파일 데이터가 존재할 때
			if(previewImgFile.getOriginalFilename() != null && !previewImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 생성
				fileName += "_" + previewImgFile.getOriginalFilename(); // UUID_원본파일명으로 생성
				uploadPath += "/" + fileName; // /resources/journeyinfo/UUID_원본파일명
				
				previewImgFile.transferTo(new File(uploadPath)); // 해당 위치에 파일 복사
				previewImg = "/resources/journeyinfo/" + fileName; // 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
			}
			
			journeyVO.setInfoPreviewimg(previewImg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int status = journeyMapper.inforModify(journeyVO);
		if(status > 0) { // 수정 성공
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult inforDelete(int infoNo) {
		ServiceResult result = null;
		
		// 여행 정보를 삭제하장
		int status = journeyMapper.deleteInfor(infoNo);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public List<JourneyinfoVO> searchJourneyList(JourneyinfoVO journeyVO) {
		return journeyMapper.searchJourneyList(journeyVO);
	}

}

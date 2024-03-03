package kr.or.ddit.users.myplan.service.impl;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.mapper.PdfUploadMapper;
import kr.or.ddit.users.myplan.service.PdfUploadService;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class PdfUploadServiceImpl implements PdfUploadService {

	@Inject
	private PdfUploadMapper pdfUploadMapper;
	
	@Override
	public ServiceResult updatePdfUrl(Map<String, Object> param) {
		
		/** 파라미터 조회 */
		HttpServletRequest req = (HttpServletRequest) param.get("req");
		MultipartFile pdfFile = (MultipartFile) param.get("pdfFile");
		long plNo = (long) param.get("plNo");
		ServiceResult serviceResult = null;
		String savePath = "/resources/pdf/";
		
		String pdfUrl = pdfUploadMapper.getPdfUrl(plNo);
		
		/** 메인로직 처리 */
		// 파일 업로드 할 서버 경로 지정
		String uploadPath = req.getServletContext().getRealPath(savePath + plNo);
		File file = new File(uploadPath);
		if (!file.exists()) {
			file.mkdirs();
		}

		String addedImg = ""; // 추가될 이미지 경로
		try {
			// 넘겨받은 파일 데이터가 존재할 때
			if(pdfFile.getOriginalFilename() != null && !pdfFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString(); // UUID 파일명 생성
				fileName += "_" + pdfFile.getOriginalFilename(); // UUID_원본파일명으로 생성
				uploadPath += "/" + fileName; // /resources/profile/UUID_원본파일명
				File existingFile = null;
				existingFile = new File(uploadPath);
				
				log.info("pdfUrl 값 : " + pdfUrl);
				if(!StringUtils.isBlank(pdfUrl)) {
					// 해당 디렉토리의 모든 파일 삭제
                    File[] files = file.listFiles();
                    log.info("files 리스트 => {}", files);
                    for(File f : files) {
                    	if(f.isDirectory()) {
                    		log.info("{} >>> 파일은 디렉토리입니다. 하위 파일을 확인하겠습니다.", f);
                    	}
                    	f.delete();
                        log.info("{} >>> 파일이 삭제되었습니다.", f);
                    }
	            } else {
	                log.info("pdfUrl 값이 비어있습니다.");
	            }
				
				log.info("pdf 업로드 경로 : " + uploadPath);
				
				if (existingFile != null) {
	                pdfFile.transferTo(existingFile); // 해당 위치에 파일 복사
	            }
				
				addedImg = savePath + plNo + "/" + fileName; // 파일 복사가 일어난 파일의 위치로 접근하기 위한 URI 설정
				
				// Map 생성 후 값 추가
	            Map<String, Object> map = new HashMap<String, Object>();
	            map.put("plNo", plNo);
	            map.put("plPdfurl", addedImg);
	            
	            // 마이바티스 메서드 호출
	            int result = pdfUploadMapper.updatePdfUrl(map);
	            
	            // 결과에 따라서 처리
	            if(result > 0) {
	                log.info("PDF URL 업데이트 성공");
	                serviceResult = ServiceResult.OK;
	            } else {
	                log.error("PDF URL 업데이트 실패");
	                serviceResult = ServiceResult.FAILED;
	            }
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/** 자료 검증 */
		log.info("넘겨받은 pdfFile 값 : " + pdfFile);
		log.info("넘겨받은 plNo 값 : " + plNo);
		
		return serviceResult;
	}

}

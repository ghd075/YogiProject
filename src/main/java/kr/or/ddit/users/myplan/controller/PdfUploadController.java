package kr.or.ddit.users.myplan.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.users.myplan.service.PdfUploadService;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class PdfUploadController {
	
	@Inject
	private PdfUploadService pdfUploadService;
	
	@ResponseBody
	@RequestMapping(value = "/pdfUpload.do", method = RequestMethod.POST)
	public ResponseEntity<String> excelUploadAjax(HttpServletRequest req, @RequestParam("file") MultipartFile pdfFile, long plNo) throws Exception{
		
		/** 자료 수집 및 정의 */
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("req", req);
		param.put("pdfFile", pdfFile);
		param.put("plNo", plNo);
		
		/** 서비스 호출 */
		ServiceResult res = pdfUploadService.updatePdfUrl(param);
		
		/** 자료 검증 */
		log.info("넘어온 pdfFile값 : " + pdfFile.getOriginalFilename());
		log.info("넘어온 plNo값 : " + plNo);
		
		String result = "failed";
        if(res.equals(ServiceResult.OK)) {
            result = "success";
        }
	    return new ResponseEntity<String>(result, HttpStatus.OK);
	}
}	

package kr.or.ddit.users.board.service.impl;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.mapper.QnaBoardMapper;
import kr.or.ddit.users.board.service.QnaBoardService;
import kr.or.ddit.users.board.utils.ExcelRead;
import kr.or.ddit.users.board.utils.ExcelReadOption;
import kr.or.ddit.users.board.vo.QnaVO;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class QnaBoardServiceImpl implements QnaBoardService {

	@Autowired
    private QnaBoardMapper qnaBoardMapper;
	
	// qna 리스트 조회
	@Override
	public List<QnaVO> qnaList() {
		return qnaBoardMapper.qnaList();
	}
	
	// qna 카테고리 조회
	@Override
	public List<String> getMenuList() {
		return qnaBoardMapper.getMenuList();
	}
	
	// 엑셀파일 DB에 저장
	@Transactional
	@Override
	public ServiceResult insertQna(File destFile, MultipartHttpServletRequest request) {
		// 등록된 FQA 한번 비우고 엑셀에서 업로드된 데이터 기반으로 insert
		qnaBoardMapper.deleteQna();
		
		ServiceResult res = ServiceResult.FAILED;
		int resCnt = 0;
		
		HttpSession session = request.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		
		ExcelReadOption excelReadOption = new ExcelReadOption();
		excelReadOption.setFilePath(destFile.getAbsolutePath());		// 파일경로 추가
		excelReadOption.setOutputColumns("A", "B", "C");				// 추출할 컬럼명 추가
		excelReadOption.setStartRow(5); 								// 시작행
		
		List<Map<String, String>> excelContent = ExcelRead.read(excelReadOption);
		
		for(Map<String, String> article : excelContent) {
			
			article.put("boWriter", memberVO.getMemId());
			
			log.info("article 값들 => {}", article);
			resCnt = qnaBoardMapper.insertQna(article);	
		}
		
		log.info("excelContent 값들 => {}", excelContent);
		
		
		if(resCnt > 0) {
        	res = ServiceResult.OK;
        }        
		return res;
	}
	
	// 엑셀 업로드
	@Override
	public ServiceResult excelUpload(MultipartHttpServletRequest request) {
		
        ServiceResult res = ServiceResult.FAILED;
        MultipartFile excelFile = request.getFile("excelFile");

        log.info("request값들 => {}", request);
        log.info("excelFile 파일 잘 들어왔니?? : " + excelFile.getOriginalFilename());

        String uploadPath = request.getServletContext().getRealPath("/resources/excel");
        File file = new File(uploadPath); // 파일위치 지정 

        if(!file.exists()) {
            file.mkdirs();
        }

        if(excelFile != null && !excelFile.isEmpty()) {
            try {
                File destFile = new File(uploadPath + "/" + excelFile.getOriginalFilename()); 	// 파일위치 지정
                excelFile.transferTo(destFile); 												// 엑셀파일 생성
                res = insertQna(destFile, request); 														// 데이터 추가
                destFile.delete(); 																// 업로드된 엑셀파일 삭제
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        log.info("res 값 : " + res);
        
        return res;
    }

	// 카테고리별 QNA 조회
	@Override
	public List<QnaVO> getQnaMenuList(String menuName) {
		return qnaBoardMapper.getQnaMenuList(menuName);
	}
}

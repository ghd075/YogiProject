package kr.or.ddit.users.board.service;

import java.io.File;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.or.ddit.users.board.vo.QnaVO;
import kr.or.ddit.utils.ServiceResult;

public interface QnaBoardService {

	// qna 리스트 조회
	public List<QnaVO> qnaList();

	// 엑셀파일 DB에 저장
	public ServiceResult insertQna(File destFile, MultipartHttpServletRequest request);

	// 엑셀 업로드
	public ServiceResult excelUpload(MultipartHttpServletRequest request);

	// 카테고리 메뉴 조회
	public List<String> getMenuList();
	
	// 카테고리별 QNA 조회
	public List<QnaVO> getQnaMenuList(String menuName);

}

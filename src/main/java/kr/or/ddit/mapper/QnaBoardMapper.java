package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.users.board.vo.QnaVO;

public interface QnaBoardMapper {

	// qna 리스트 조회
	public List<QnaVO> qnaList();
	
	// qna 등록
	public int insertQna(Map<String, String> article);

	// qna 전체 삭제
	public void deleteQna();

	// qna 카테고리 조회
	public List<String> getMenuList();

	// 카테고리별 QNA 조회
	public List<QnaVO> getQnaMenuList(String menuName);
}

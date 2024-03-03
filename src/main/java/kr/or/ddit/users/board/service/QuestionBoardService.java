package kr.or.ddit.users.board.service;

import java.util.List;

import kr.or.ddit.users.board.vo.QuestionVO;

public interface QuestionBoardService {

	public int questionInput(QuestionVO vo);

	public List<QuestionVO> getQuestionList(String memId);

	public List<QuestionVO> getAllQuestionList();

	public QuestionVO getquestionInfo(int idx);

	public int questionAnswer(QuestionVO vo);

}

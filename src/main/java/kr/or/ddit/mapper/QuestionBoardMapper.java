package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.board.vo.QuestionVO;

public interface QuestionBoardMapper {

	public int questionInput(QuestionVO vo);

	public List<QuestionVO> getQuestionList(String memId);

	public List<QuestionVO> getAllQuestionList();

	public QuestionVO getquestionInfo(int boNo);

	public int questionAnswer(QuestionVO vo);

}

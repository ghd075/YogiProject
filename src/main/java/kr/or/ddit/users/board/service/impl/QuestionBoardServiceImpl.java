package kr.or.ddit.users.board.service.impl;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.QuestionBoardMapper;
import kr.or.ddit.users.board.service.QuestionBoardService;
import kr.or.ddit.users.board.vo.QuestionVO;

@Service
public class QuestionBoardServiceImpl implements QuestionBoardService {

	@Inject
	private QuestionBoardMapper questionBoardMapper;
	
	@Override
	@Transactional
	public int questionInput(QuestionVO vo) {
		return questionBoardMapper.questionInput(vo);
	}

	public List<QuestionVO> getQuestionList(String memId) {
		return questionBoardMapper.getQuestionList(memId);
	}

	@Override
	public List<QuestionVO> getAllQuestionList() {
		return questionBoardMapper.getAllQuestionList();
	}

	@Override
	public QuestionVO getquestionInfo(int idx) {
		return questionBoardMapper.getquestionInfo(idx);
	}

	@Override
	public int questionAnswer(QuestionVO vo) {
		return questionBoardMapper.questionAnswer(vo);
	}

}

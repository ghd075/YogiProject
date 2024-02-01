package kr.or.ddit.users.board.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.QnaBoardMapper;
import kr.or.ddit.users.board.service.QnaBoardService;
import kr.or.ddit.users.board.vo.QnaMenuVO;

@Service
public class QnaBoardServiceImpl implements QnaBoardService {

	@Autowired
    private QnaBoardMapper qnaBoardMapper;
	
	@Override
	public List<QnaMenuVO> getTopMenus() {
		return qnaBoardMapper.getTopMenus();
	}

}

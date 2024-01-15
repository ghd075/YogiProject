package kr.or.ddit.users.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/qna")
public class QnaBoardController {

	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String qnaList() {
		return "board/qnaBoardList";
	}
	
}

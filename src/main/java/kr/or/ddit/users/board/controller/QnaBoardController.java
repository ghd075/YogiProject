package kr.or.ddit.users.board.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.users.board.service.QnaBoardService;
import kr.or.ddit.users.board.vo.QnaMenuVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/qna")
public class QnaBoardController {

	@Inject
	private QnaBoardService qnaBoardService;
	
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String qnaList() {
		return "board/qnaBoardList";
	}
	
    @RequestMapping(value = "/getTopMenus", method = RequestMethod.GET)
    @ResponseBody
    public List<QnaMenuVO> getTopMenus() {
    	
    	List<QnaMenuVO> topMenuList = qnaBoardService.getTopMenus();
    	
    	log.info("값 잘 넘어오니 => {}", topMenuList);
    	
        return topMenuList;
    }
	
}

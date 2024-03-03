package kr.or.ddit.users.board.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.ddit.users.board.service.QuestionBoardService;
import kr.or.ddit.users.board.vo.QuestionVO;
import kr.or.ddit.users.login.vo.MemberVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/question")
public class QuestionBoardController {

	@Inject
	private QuestionBoardService questionBoardService;
	
	
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String questionList(HttpSession session, Model model) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		
		String memId = memberVO.getMemId();
		
		// 회원별 문의사항 리스트 조회
		List<QuestionVO> queList = questionBoardService.getQuestionList(memId);
		
		// 모든 문의사항 리스트 조회
		List<QuestionVO> getAllQueList = questionBoardService.getAllQuestionList();
		
		model.addAttribute("queList", queList);
		model.addAttribute("getAllQueList", getAllQueList);
		
		log.info("넘어온 memId 값 : " + memId);
		log.info("queList => {} ", queList);
		log.info("getAllQueList => {} ", getAllQueList);
		
		return "board/questionBoardList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/questionInputPost.do", method = RequestMethod.POST)
	public String questionInputPost(HttpSession session, QuestionVO vo) {
		
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		
		String memId = memberVO.getMemId();
		
		vo.setBoWriter(memId);
		
		int res = questionBoardService.questionInput(vo);
		
		log.info("넘어온 memId 값 : " + memId);
		log.info("넘어온 vo 값 : {}", vo);
		
		return res+"";
	}
	
	@ResponseBody
	@RequestMapping(value = "/questionInfoPost.do", method = RequestMethod.POST)
	public QuestionVO questionInfoPost(int idx) {
		QuestionVO vo = questionBoardService.getquestionInfo(idx);
		
		log.info("넘어온 idx 값 : => " + idx);
		log.info("vo 값 : => {}", vo);
		
		return vo;
		
	}

	@ResponseBody
	@RequestMapping(value = "/questionAnswer.do", method = RequestMethod.POST)
	public String questionAnswerPost(QuestionVO vo) {
		
		log.info("넘어온 vo 값 : => {}", vo);
		
		int res = questionBoardService.questionAnswer(vo);
		
		log.info("성공 res : " + res);
		
		return res+"";
		
	}
	
}

package kr.or.ddit.users.board.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.View;

import kr.or.ddit.users.board.service.QnaBoardService;
import kr.or.ddit.users.board.utils.ExcelView;
import kr.or.ddit.users.board.vo.QnaVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/qna")
public class QnaBoardController {

	@Inject
	private QnaBoardService qnaBoardService;
	
	// Qna 게시판으로 이동
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String qnaList(Model model) {
		
		List<String> menuList = qnaBoardService.getMenuList();
		
		model.addAttribute("menuList", menuList);
		
		return "board/qnaBoardList";
	}
	
	// 엑셀 다운로드
    @RequestMapping(value = "/downloadExcel.do", method = RequestMethod.GET)
	public View downloadExcel1(Model model) throws Exception {
    	
    	List<QnaVO> qnaList = null;
    	
		try {
			// 다운로드 일시
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");

			qnaList = qnaBoardService.qnaList();
			
			model.addAttribute("qnaList", qnaList);
			model.addAttribute("DownloadDate", sdf.format(new Date()));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ExcelView();
	}
    
    // 엑셀 업로드
	@ResponseBody
	@RequestMapping(value = "/excelUpload.do", method = RequestMethod.POST)
	public ResponseEntity<String> excelUploadAjax(MultipartHttpServletRequest request) throws Exception{
		String result = "failed";
	    
	    try {
	    	ServiceResult res = qnaBoardService.excelUpload(request); // service단 호출
            if(res.equals(ServiceResult.OK)) {
                result = "success";
            }
	    }catch(Exception e) {
	        e.printStackTrace();
	    } 

	    return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	// QNA 카테고리 가져오기
	@ResponseBody
	@RequestMapping(value = "/getQnaMenuList.do", method = RequestMethod.GET) 
	public List<QnaVO> getQnaMenuList(String menuName) {
		List<QnaVO> list = qnaBoardService.getQnaMenuList(menuName);
		log.info("넘어왔니?? menuName : " + menuName);
		log.info("list 잘 조회되니 => {}", list);
		return list;
	}
}

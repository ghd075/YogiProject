package kr.or.ddit.users.board.controller;

import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.users.board.service.NoticeService;
import kr.or.ddit.users.board.vo.NoticeFileVO;
import kr.or.ddit.users.board.vo.NoticeVO;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.utils.MediaUtils;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeBoardController {
	
	@Inject
	private NoticeService noticeService;

	// 공지사항 리스트 출력
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/list.do", method = RequestMethod.GET)
	public String noticeList(
			@RequestParam(name = "page", required = false, defaultValue = "1") int currentPage,
			@RequestParam(required = false, defaultValue = "title") String searchType,
			@RequestParam(required = false) String searchWord,
			Model model
			) {
		
		/** 자료 수집 및 정의 */
		Map<String,Object> param = new HashMap<>();
		param.put("currentPage", currentPage);
		param.put("searchType", searchType);
		param.put("searchWord", searchWord);
		
		/** 서비스 호출 */
		// 공지사항 게시판 리스트 가져오기
		noticeService.noticeList(param);
		
		/** 반환 자료 */
		PaginationInfoVO<NoticeVO> pagingVO = (PaginationInfoVO<NoticeVO>) param.get("pagingVO");
		List<NoticeVO> importantNoticeList = (List<NoticeVO>) param.get("importantNoticeList");
		List<NoticeVO> fileExistNoticeList = (List<NoticeVO>) param.get("fileExistNoticeList");
		
		/** 자료 검증 */ 
		log.info("pagingVO : " + pagingVO.toString());
		log.info("importantNoticeList : " + importantNoticeList.toString());
		log.info("importantNoticeList : " + importantNoticeList.toString());
		log.info("fileExistNoticeList : " + fileExistNoticeList.toString());
		
		/** 자료 반환 */ 
		model.addAttribute("searchType", searchType);
		model.addAttribute("searchWord", searchWord);
		model.addAttribute("pagingVO", pagingVO);
		model.addAttribute("importantNoticeList", importantNoticeList);
		model.addAttribute("fileExistNoticeList", fileExistNoticeList);
		
		return "board/noticeBoardList";
		
	}
	
	// 공지사항 파일 다운로드
	@RequestMapping(value = "/user/download.do", method = RequestMethod.GET)
	public ResponseEntity<byte[]> fileDownload(int fileNo) throws Exception {
		
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		String fileName = null;
		NoticeFileVO fileVO = noticeService.selectFileInfo(fileNo);
		if(fileVO != null) {
			try {
				fileName = fileVO.getFileName();
				
				String formatName = fileName.substring(fileName.lastIndexOf(".") + 1);
				MediaType mType = MediaUtils.getMediaType(formatName);
				HttpHeaders headers = new HttpHeaders();
				in = new FileInputStream(fileVO.getFileSavepath());
				
				fileName = fileName.substring(fileName.indexOf("_") + 1);
				headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
				headers.add("Content-Disposition", "attachment; filename=\""+ new String(fileName.getBytes("UTF-8"), "ISO-8859-1") +"\"");
				
				entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in), headers, HttpStatus.CREATED);
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				in.close();
			}
		}else {
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	// 공지사항 상세보기
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/user/detail.do")
	public String noticeDetail(int boNo, Model model) {
		
		/** 자료수집 및 정의 */
		Map<String,Object> param = new HashMap<>();
		param.put("boNo", boNo);
		
		/** 서비스 호출 */
		noticeService.noticeDetail(param);
		
		/** 반환 자료 */
		NoticeVO noticeVO = (NoticeVO) param.get("noticeVO");
		List<NoticeVO> prevNextList = (List<NoticeVO>) param.get("prevNextList");
		
		/** 자료검증 */
		log.info("noticeVO : " + noticeVO);
		log.info("prevNextList : " + prevNextList);
		
		/** 자료반환 */
		model.addAttribute("noticeDetail", noticeVO);
		model.addAttribute("prevNextInfo", prevNextList);
		
		return "board/noticeBoardDetail";
		
	}
	
	///////////////////////////////////////////////////////////////////////////
	
	// 공지사항 등록
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/admin/register.do", method = RequestMethod.GET)
	public String noticeRegisterForm() {
		return "board/noticeBoardForm";
	}
	
	@Transactional
	@RequestMapping(value = "/admin/register.do", method = RequestMethod.POST)
	public String noticeRegister(
			HttpServletRequest req,
			NoticeVO noticeVO, 
			RedirectAttributes ra,
			Model model
			) throws Exception {
		
		String goPage = "";
		
		Map<String, String> errors = new HashMap<String, String>();
		if(StringUtils.isBlank(noticeVO.getBoTitle())) {
			errors.put("boTitle", "제목을 입력해 주세요");
		}
		if(StringUtils.isBlank(noticeVO.getBoContent())) {
			errors.put("boContent", "내용을 입력해 주세요");
		}
		
		if(errors.size() > 0) {
			model.addAttribute("errors", errors);
			model.addAttribute("noticeVO", noticeVO);
			goPage = "board/noticeBoardForm";
		}else {
			HttpSession session = req.getSession();
			MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
			noticeVO.setBoWriter(memberVO.getMemName()); // 로그인 한 사용자의 이름으로 작성자 넣기
			ServiceResult result = noticeService.insertNotice(req, noticeVO);
			
			if(result.equals(ServiceResult.OK)) {
				ra.addFlashAttribute("message", "공지사항 게시글이 성공적으로 등록되었습니다!");
				goPage = "redirect:/notice/list.do";
			}else {
				model.addAttribute("message", "서버 에러, 다시 시도해주세요!");
				model.addAttribute("noticeVO", noticeVO);
				goPage = "board/noticeBoardForm";
			}
		}
		
		return goPage;
		
	}
	
	// 공지사항 삭제
	@Transactional
	@RequestMapping(value = "/admin/delete.do", method = RequestMethod.POST)
	public String noticeDelete(
			RedirectAttributes ra,
			int boNo,
			Model model
			) {
		
		String goPage = "";
		
		ServiceResult result = noticeService.deleteNotice(boNo);
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "공지사항 삭제가 완료되었습니다");
			goPage = "redirect:/notice/list.do";
		}else {
			ra.addFlashAttribute("message", "공지사항 삭제에 실패했습니다");
			goPage = "redirect:/notice/user/detail.do?boNo=" + boNo;
		}
		
		return goPage;
		
	}
	
	// 공지사항 수정
	@CrossOrigin(origins = "http://localhost")
	@RequestMapping(value = "/admin/modify.do", method = RequestMethod.GET)
	public String noticeModifyForm(int boNo, Model model) {
		NoticeVO noticeVO = noticeService.selectNotice(boNo);
		model.addAttribute("notice", noticeVO);
		model.addAttribute("status", "u");
		return "board/noticeBoardForm";
	}
	
	@Transactional
	@RequestMapping(value = "/admin/modify.do", method = RequestMethod.POST)
	public String noticeModify(
			HttpServletRequest req,
			NoticeVO noticeVO,
			Model model,
			RedirectAttributes ra
			) {
		
		String goPage = "";
		
		HttpSession session = req.getSession();
		MemberVO memberVO = (MemberVO) session.getAttribute("sessionInfo");
		noticeVO.setBoWriter(memberVO.getMemName()); // 로그인 한 사용자의 이름으로 작성자 넣기
		ServiceResult result = noticeService.modifyNotice(req, noticeVO);
		
		if(result.equals(ServiceResult.OK)) {
			ra.addFlashAttribute("message", "공지사항 수정이 완료되었습니다.");
			goPage = "redirect:/notice/user/detail.do?boNo=" + noticeVO.getBoNo();
		}else {
			model.addAttribute("notice", noticeVO);
			model.addAttribute("message", "공지사항 수정이 실패했습니다!");
			model.addAttribute("status", "u");
			goPage = "board/noticeBoardForm";
		}
		
		return goPage;
		
	}
	
}

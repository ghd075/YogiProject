package kr.or.ddit.users.board.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.users.board.vo.NoticeFileVO;
import kr.or.ddit.users.board.vo.NoticeVO;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;

public interface NoticeService {

	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);
	public List<NoticeVO> importantNoticeList();
	public ServiceResult insertNotice(HttpServletRequest req, NoticeVO noticeVO) throws Exception;
	public NoticeFileVO selectFileInfo(int fileNo);
	public NoticeVO selectNotice(int boNo);
	public List<NoticeVO> prevNextInfo(int boNo);
	public ServiceResult deleteNotice(int boNo);
	public ServiceResult modifyNotice(HttpServletRequest req, NoticeVO noticeVO);
	
}

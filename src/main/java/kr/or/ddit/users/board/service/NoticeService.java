package kr.or.ddit.users.board.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.users.board.vo.NoticeFileVO;
import kr.or.ddit.users.board.vo.NoticeVO;
import kr.or.ddit.utils.ServiceResult;

public interface NoticeService {

	public void noticeList(Map<String, Object> param);
	public void noticeDetail(Map<String, Object> param);
	
	public ServiceResult insertNotice(HttpServletRequest req, NoticeVO noticeVO) throws Exception;
	public NoticeFileVO selectFileInfo(int fileNo);
	public NoticeVO selectNotice(int boNo);
	public ServiceResult deleteNotice(int boNo);
	public ServiceResult modifyNotice(HttpServletRequest req, NoticeVO noticeVO);

}

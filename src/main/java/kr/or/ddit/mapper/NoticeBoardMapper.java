package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.board.vo.NoticeFileVO;
import kr.or.ddit.users.board.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;

public interface NoticeBoardMapper {

	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO);
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO);
	public List<NoticeVO> importantNoticeList();
	public List<NoticeVO> fileExistNoticeList();
	
	public int insertNotice(NoticeVO noticeVO);
	public void insertNoticeBoardFile(NoticeFileVO noticeFileVO);
	public NoticeFileVO selectFileInfo(int fileNo);
	public void incrementHit(int boNo);
	public NoticeVO selectNotice(int boNo);
	public List<NoticeVO> prevNextInfo(int boNo);
	public void deleteNoticeFile(int boNo);
	public int deleteNotice(int boNo);
	
	public int modifyNotice(NoticeVO noticeVO);
	public NoticeFileVO selectNoticeFile(Integer integer);
	public void deleteNoticeFileList(Integer[] delNoticeNo);

}

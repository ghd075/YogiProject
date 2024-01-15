package kr.or.ddit.users.board.service.impl;

import java.io.File;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.or.ddit.mapper.NoticeBoardMapper;
import kr.or.ddit.users.board.service.NoticeService;
import kr.or.ddit.users.board.vo.NoticeFileVO;
import kr.or.ddit.users.board.vo.NoticeVO;
import kr.or.ddit.utils.FileUploadUtils;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Inject
	private NoticeBoardMapper noticeMapper;
	
	@Override
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO) {
		return noticeMapper.selectNoticeCount(pagingVO);
	}

	@Override
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO) {
		return noticeMapper.selectNoticeList(pagingVO);
	}

	@Override
	public List<NoticeVO> importantNoticeList() {
		return noticeMapper.importantNoticeList();
	}

	@Override
	public ServiceResult insertNotice(HttpServletRequest req, NoticeVO noticeVO) throws Exception {
		ServiceResult result = null;
		
		int status = noticeMapper.insertNotice(noticeVO);
		if(status > 0) {
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			FileUploadUtils.noticeBoardFileUpload(noticeFileList, noticeVO.getBoNo(), req, noticeMapper);
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public NoticeFileVO selectFileInfo(int fileNo) {
		return noticeMapper.selectFileInfo(fileNo);
	}

	@Override
	public NoticeVO selectNotice(int boNo) {
		noticeMapper.incrementHit(boNo); // 조회수 증가
		return noticeMapper.selectNotice(boNo);
	}

	@Override
	public List<NoticeVO> prevNextInfo(int boNo) {
		return noticeMapper.prevNextInfo(boNo);
	}

	@Override
	public ServiceResult deleteNotice(int boNo) {
		ServiceResult result = null;
		
		// 먼저 파일부터 삭제한다.
		noticeMapper.deleteNoticeFile(boNo);
		
		// 그 다음에 게시글을 삭제한다.
		int status = noticeMapper.deleteNotice(boNo);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult modifyNotice(HttpServletRequest req, NoticeVO noticeVO) {
		ServiceResult result = null;
		
		int status = noticeMapper.modifyNotice(noticeVO); // 공지사항 수정
		if(status > 0) { // 공지사항 수정 완료
			// 게시글 정보에서 파일 목록을 가져오기
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			
			try {
				// 공지사항 업로드 진행
				FileUploadUtils.noticeBoardFileUpload(noticeFileList, noticeVO.getBoNo(), req, noticeMapper);
				
				// 기존에 등록되어 있는 파일 목록들 중, 수정하기 위해 delete 버튼을 눌러 삭제 처리로 넘겨준 파일 번호들
				Integer[] delNoticeNo = noticeVO.getDelNoticeNo();
				
				if(delNoticeNo != null) {
					for(int i = 0; i > delNoticeNo.length; i++) {
						System.out.println("delNoticeNo["+i+"] : " + delNoticeNo[i]);
						// 삭제할 파일 번호 중, 파일 번호에 해당하는 게시판 파일 정보를 가져와 물리적인 삭제를 진행
						NoticeFileVO noticeFileVO = noticeMapper.selectNoticeFile(delNoticeNo[i]);
						File file = new File(noticeFileVO.getFileSavepath());
						file.delete(); // 기존 파일이 업로드된 경로에 파일 삭제
					}
					noticeMapper.deleteNoticeFileList(delNoticeNo); // 파일번호에 해당하는 파일 데이터를 DB에서 삭제
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

}

package kr.or.ddit.users.board.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import kr.or.ddit.mapper.NoticeBoardMapper;
import kr.or.ddit.users.board.service.NoticeService;
import kr.or.ddit.users.board.vo.NoticeFileVO;
import kr.or.ddit.users.board.vo.NoticeVO;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.utils.FileUploadUtils;
import kr.or.ddit.utils.ServiceResult;
import kr.or.ddit.vo.PaginationInfoVO;

@Service
public class NoticeServiceImpl implements NoticeService {

	@Inject
	private NoticeBoardMapper noticeMapper;
	
	@Override
	public void noticeList(Map<String, Object> param) {
		
		/** 파라미터 조회 */
		int currentPage = (int) param.get("currentPage");
		String searchType = (String) param.get("searchType");
		String searchWord = (String) param.get("searchWord");
		
		/** 파라미터 정의 */
		PaginationInfoVO<NoticeVO> pagingVO = new PaginationInfoVO<NoticeVO>();
		List<NoticeVO> importantNoticeList = new ArrayList<NoticeVO>();
		List<NoticeVO> fileExistNoticeList = new ArrayList<NoticeVO>();
		
		/** 메인로직 처리 */
		// 검색 기능
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchType(searchType);
			pagingVO.setSearchWord(searchWord);
		}
		pagingVO.setCurrentPage(currentPage);
		
		// 총 게시글 수 가져오기
		int totalRecord = noticeMapper.selectNoticeCount(pagingVO);
		pagingVO.setTotalRecord(totalRecord);
		
		// 총 게시글을 리스트로 받아오기
		List<NoticeVO> dataList = noticeMapper.selectNoticeList(pagingVO);
		pagingVO.setDataList(dataList);
		
		// 중요공지 리스트 가져오기
		importantNoticeList = noticeMapper.importantNoticeList();
		
		// 파일이 들어있는 게시글 리스트 가져오기
		fileExistNoticeList = noticeMapper.fileExistNoticeList();
		
		/** 반환자료 저장 */
		param.put("pagingVO", pagingVO);
		param.put("importantNoticeList", importantNoticeList);
		param.put("fileExistNoticeList", fileExistNoticeList);
		
	}
	
	@Override
	public void noticeDetail(Map<String, Object> param) {

		/** 파라미터 조회 */
		int boNo = (int) param.get("boNo");
		
		/** 파라미터 정의 */
		NoticeVO noticeVO = new NoticeVO();
		List<NoticeVO> prevNextList = new ArrayList<NoticeVO>();
		
		/** 메인로직 처리 */
		// 조회수 증가
		noticeMapper.incrementHit(boNo);
		
		// 게시판 상세 정보 가져오기
		noticeVO = noticeMapper.selectNotice(boNo);
		
		// 이전글/이후글 정보 가져오기
		prevNextList = noticeMapper.prevNextInfo(boNo);
		
		/** 반환자료 저장 */
		param.put("noticeVO", noticeVO);
		param.put("prevNextList", prevNextList);
		
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

package kr.or.ddit.utils;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.mapper.NoticeBoardMapper;
import kr.or.ddit.users.board.vo.NoticeFileVO;

public class FileUploadUtils {

	public static void noticeBoardFileUpload(List<NoticeFileVO> noticeFileList, int boNo, HttpServletRequest req,
			NoticeBoardMapper noticeMapper) throws Exception {

		String savePath = "/resources/notice/";
		
		if(noticeFileList != null && noticeFileList.size() > 0) {
			for(NoticeFileVO noticeFileVO : noticeFileList) {
				String saveName = UUID.randomUUID().toString();
				saveName = saveName + "_" + noticeFileVO.getFileName().replaceAll(" ", "_");
				
				// 업로드 서버 경로 + /resources/notice/10
				String saveLocate = req.getServletContext().getRealPath(savePath + boNo);
				File file = new File(saveLocate);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				// saveLocate + "/"  + UUID_원본파일명
				saveLocate += "/" + saveName;
				noticeFileVO.setBoNo(boNo); // 게시글 번호 설정
				noticeFileVO.setFileSavepath(saveLocate); // 파일 업로드 경로 설정
				noticeMapper.insertNoticeBoardFile(noticeFileVO); // 공지시항 게시글 파일 데이터 추가
				
				File saveFile = new File(saveLocate);
				noticeFileVO.getItem().transferTo(saveFile); // 파일 복사
			}
		}
		
	}
	
}
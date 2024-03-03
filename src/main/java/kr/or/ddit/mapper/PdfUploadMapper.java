package kr.or.ddit.mapper;

import java.util.Map;

public interface PdfUploadMapper {

	// 해당 플랜에 대한 pdf경로 조회
	public String getPdfUrl(long plNo);

	// 해당 플랜에 대한 pdf경로 업데이트
	public int updatePdfUrl(Map<String, Object> map);

}

package kr.or.ddit.users.board.vo;

import org.apache.commons.io.FileUtils;
import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class NoticeFileVO {

	private MultipartFile item;
	private Integer boNo;
	private Integer fileNo;
	private String fileName;
	private Long fileSize;
	private String fileFancysize;
	private String fileMime;
	private String fileSavepath;
	private Integer fileDowncount;
	
	public NoticeFileVO() {}
	public NoticeFileVO(MultipartFile item) {
		this.item = item;
		this.fileName = item.getOriginalFilename();
		this.fileSize = item.getSize();
		this.fileMime = item.getContentType();
		this.fileFancysize = FileUtils.byteCountToDisplaySize(fileSize); 
	}
	
	private String fileNos;
	private String fileNames;
	private String fileSizes;
	private String fileFancysizes;
	private String fileMimes;
	private String fileSavepaths;
	private String fileDowncounts;
	
}

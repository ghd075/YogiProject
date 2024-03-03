package kr.or.ddit.users.myplan.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class PlannerVO {
	private int plNo;			// 플랜 고유 번호
	private String memId;		// 작성자 아이디
	private String plRdate;		// 플랜 작성일
	private String plTitle;		// 플랜 제목
	private int plMsize;		// 플랜 모집인원수
	private String plPrivate;	// 플랜 공개여부
	private String plTheme;		// 플랜 테마(혼자, 동행)
	private String plThumburl;	// 썸네일 이미지
	private String plPdfurl;	// pdf url 경로
	
	private int likeCount;
	private MultipartFile fileReal;
	
	private List<DetatilPlannerVO> detailList;
	private long mgNo;
	private long mgCurNum;
	private String mategroupApply;
	
	private int mategroupPoint;
	
	
}

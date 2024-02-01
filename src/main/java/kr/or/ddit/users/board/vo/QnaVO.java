package kr.or.ddit.users.board.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaVO {
	
	private int boNo;					// qnaID
	private String boTitle;				// qna제목
	private String boContent;			// qna내용
	private String boWriter;			// qna작성자
	private String boDate;				// qna등록일
	private String menuName;			// 메뉴 명
}

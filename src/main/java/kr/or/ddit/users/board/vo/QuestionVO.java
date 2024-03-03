package kr.or.ddit.users.board.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class QuestionVO {
	private int boNo;
	private String boTitle;
	private String boContent;
	private String cont;
	private String answer;
	private String boWriter;
	private Date boDate;
	private Date boAnswerDay;
}

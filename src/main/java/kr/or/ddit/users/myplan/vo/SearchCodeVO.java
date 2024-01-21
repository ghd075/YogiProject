package kr.or.ddit.users.myplan.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SearchCodeVO {
	private String searchOption;
	private String keyword;
	private String areaCode;
	private String sigunguCode;
}

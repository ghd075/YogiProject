package kr.or.ddit.users.myplan.vo;

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
public class DetatilPlannerVO {
	private long spNo;
	private long spDay;
	private String spSday;
	private String spEday;
	private String contentId;
	private long plNo;
	private long spOrder;
	private long spDistance;
}

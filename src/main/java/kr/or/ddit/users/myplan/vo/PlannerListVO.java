package kr.or.ddit.users.myplan.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PlannerListVO {
	private String areaCode;
	private String areaName;
	private String sigunguCode;
	private String sigunguName;
	private double latitude;
	private double longitude;
}

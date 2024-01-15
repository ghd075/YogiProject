package kr.or.ddit.users.myplan.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AreaVO {
	private String areaCode;
	private String areaName;
	private double latitude;
	private double longitude;
}

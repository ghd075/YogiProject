package kr.or.ddit.users.myplan.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SigunguVO {
	private int sigunguId;
	private String sigunguName;
	private String sigunguCode;
	private String areaCode;
	private double latitude;
	private double longitude;
}

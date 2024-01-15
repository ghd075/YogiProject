package kr.or.ddit.users.myplan.vo;

import java.util.ArrayList;

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
public class LocalListVO {
	private ArrayList<AreaVO> areaList;
	private ArrayList<SigunguVO> sigunguList;
}

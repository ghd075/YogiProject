package kr.or.ddit.users.board.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class QnaMenuVO {

	private String menuId;				// 메뉴ID
	private String menuLower;			// 상위 메뉴 ID
	private int menuOrder;				// 메뉴 순서
	private String menuName;			// 메뉴 명
	private String menuDescription;		// 메뉴 설명
	private String menuYn;				// 사용 여부
}

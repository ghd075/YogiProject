package kr.or.ddit.users.partner.vo;

import kr.or.ddit.users.login.vo.MemberVO;
import lombok.Data;

@Data
public class PlanerVO {

	private int plNo;
	private String memId;
	private String plRdate;
	private String plTitle;
	private String plMsize;
	private String plPrivate;
	private String plTheme;
	private String plThumburl;
	
	/* 조인 용도 */
//	private MemberVO memberVO;
//	private MategroupVO mategroupVO;
//	private MategroupMemberVO mategroupMemberVO;

	private String memName;
	
	private int mgNo;
	private String mategroupRecruiter;
	private int mategroupCurrentnum;
	private String mategroupStatus;
	private int mategroupPoint;
	
	private int mategroupNo;
	private String mategroupId;
	private int mategroupAgree;
	private String mategroupApply;
	
	private String sType;
	
}

package kr.or.ddit.mapper;

import kr.or.ddit.users.mypage.vo.MemberVO;

public interface MyPageMapper {

	public int myinfoUpd(MemberVO memberVO);
	public MemberVO updCheck(MemberVO memberVO);
	public int memDelete(String memId);

}

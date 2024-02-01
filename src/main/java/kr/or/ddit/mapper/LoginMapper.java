package kr.or.ddit.mapper;

import java.util.Map;

import kr.or.ddit.users.login.vo.MemberVO;

public interface LoginMapper {

	public MemberVO idCheck(String memId);
	public MemberVO emailCheck(String memEmail);
	public int signup(MemberVO memberVO);
	public MemberVO findId(Map<String, String> map);
	public MemberVO findPw(Map<String, String> map);
	public MemberVO loginCheck(MemberVO memberVO);
	public int changePw(MemberVO memberVO);

}

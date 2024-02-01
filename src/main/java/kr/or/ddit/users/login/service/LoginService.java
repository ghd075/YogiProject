package kr.or.ddit.users.login.service;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.utils.ServiceResult;

public interface LoginService {

	public ServiceResult idCheck(String memId);
	public ServiceResult emailCheck(String memEmail);
	public ServiceResult signup(HttpServletRequest req, MemberVO memberVO);
	public MemberVO findId(Map<String, String> map);
	public MemberVO findPw(Map<String, String> map);
	public MemberVO loginCheck(MemberVO memberVO);
	public void changePw(Map<String, Object> param);

}

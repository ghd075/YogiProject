package kr.or.ddit.users.mypage.service;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.utils.ServiceResult;

public interface MyPageService {

	public ServiceResult myinfoUpd(HttpServletRequest req, MemberVO memberVO);
	public MemberVO updCheck(MemberVO memberVO);
	public ServiceResult memDelete(String memId);

}

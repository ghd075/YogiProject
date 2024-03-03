package kr.or.ddit.users.mypage.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.utils.ServiceResult;

public interface MyPageService {

	public ServiceResult myinfoUpd(HttpServletRequest req, MemberVO memberVO);
	public MemberVO updCheck(MemberVO memberVO);
	public ServiceResult memDelete(String memId);
	public void getRtAlertList(Map<String, Object> param);
	public void rtAlertOneDelete(Map<String, Object> param);
	public void getQnaList(Map<String, Object> param);
	public void qnaOneDelete(Map<String, Object> param);
	public List<PlannerLikeVO> getLikeList(String string);
	public void plLikeDelete(Map<String, Object> param);

}

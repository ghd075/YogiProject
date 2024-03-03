package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.board.vo.QuestionVO;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.myplan.vo.PlannerLikeVO;
import kr.or.ddit.vo.RealTimeSenderVO;

public interface MyPageMapper {

	public int myinfoUpd(MemberVO memberVO);
	public MemberVO updCheck(MemberVO memberVO);
	public int memDelete(String memId);
	public List<RealTimeSenderVO> getRtAlertList(String memId);
	public int rtAlertOneDelete(int realrecNo);
	public List<QuestionVO> getQnaList(String memId);
	public int qnaOneDelete(int boNo);
	public List<PlannerLikeVO> getLikeList(String memId);
	public int plLikeDelete(int plLikeNo);

}

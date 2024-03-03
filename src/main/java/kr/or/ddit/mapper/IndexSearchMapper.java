package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.indexsearch.vo.JourneyinfoVO;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.vo.RealTimeSenderVO;

public interface IndexSearchMapper {

	public List<JourneyinfoVO> informationList8();
	public List<JourneyinfoVO> searchJourneyList8(JourneyinfoVO journeyVO);
	public List<MemberVO> ajaxMembersId();
	public int insertSender(RealTimeSenderVO realVO);
	public void insertReceiver(RealTimeSenderVO rtAlertVO);
	public RealTimeSenderVO sender(String memId);
	public int senderCnt(String memId);
	public int ajaxRtAlertRead(int intRealrecNo);
	public MemberVO planDetailCreateMemId(int intPlNo);
	public MemberVO loginMemInfoRtAlertSaveInfo(MemberVO loginMemVO);
	
	public int removeRealSenNoCnt();
	public RealTimeSenderVO removeSelectRealSenNo(String memId);
	public int removeRealtimesenderTbl(int realsenNo);
	public int removeRealtimereceiverTbl(int realsenNo);
	
	public int rtAlertClickInit(String memId);

}

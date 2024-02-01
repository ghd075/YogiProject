package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.partner.vo.ChatroomVO;
import kr.or.ddit.users.partner.vo.PlanerVO;

public interface MyTripMapper {
 
	public List<PlanerVO> myTripList(PlanerVO planerVO);
	public List<PlanerVO> searchPlanerList(PlanerVO planerVO);
	public int chgStatusPlan(PlanerVO planerVO);
	public void deleteSPlaner(int plNo);
	public void deletePlanerLike(int plNo);
	public void deleteMategrpMem(int plNo);
	public void deleteMategrp(int plNo);
	public int deletePlan(int plNo);
	public PlanerVO meetsquareRoomOne(int plNo);
	public List<PlanerVO> meetsquareRoomList(int plNo);
	public PlanerVO excludeNonUser(PlanerVO planerVO);
	public int mateCnt(int plNo);
	public int acceptMemUpd(PlanerVO planerVO);
	public int rejectMemUpd(PlanerVO planerVO);
	public int chgStatusJoiner(PlanerVO planerVO);
	public void deleteChatRoom(int plNo);
	public int updateCurMemCnt(int plNo);
	public List<PlanerVO> chatInfoList(int plNo);
	public int ajaxChatContSave(ChatroomVO chatroomVO);
	public List<PlanerVO> chatRoomInfo(int plNo);
	public int mategroupApplyCancel(int plNo);
	public int mategroupStatusSecondStage(int plNo);
	public List<PlanerVO> chatContTxtDown(int plNo);
	public void deleteChatAll(int plNo);
	public int chatContDelete(int plNo);

}

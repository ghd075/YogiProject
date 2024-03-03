package kr.or.ddit.mapper;

import java.util.List;

import kr.or.ddit.users.partner.vo.PlanerVO;

public interface HistoryPartnerMapper {

	public List<PlanerVO> historyList(PlanerVO planerVO);

	public String getRecruiterName(String recruiterId);

}

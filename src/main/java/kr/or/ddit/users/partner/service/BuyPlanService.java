package kr.or.ddit.users.partner.service;

import java.util.Map;

public interface BuyPlanService {

	public Map<String, Object> getAllPlans(long plNo);
	public long getCurNum(long plNo);

}

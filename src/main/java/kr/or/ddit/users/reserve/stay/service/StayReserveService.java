package kr.or.ddit.users.reserve.stay.service;

import kr.or.ddit.utils.ServiceResult;

public interface StayReserveService {

	public ServiceResult processPayment(int totalPrice, int finalRemain, int planerNo);

}

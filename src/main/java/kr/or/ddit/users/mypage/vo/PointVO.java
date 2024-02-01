package kr.or.ddit.users.mypage.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PointVO {

	private String memId;				// 회원 아이디
	private String memName;				// 회원명
	private String impUid;				// 아임포트 고유번호
	private int memPoint;				// 회원 총 포인트
	
	private int pointNo;				// 포인트 결제번호
	private int pointAccount;			// 포인트 결제금액
	private String pointDate;			// 포인트 날짜
	private String pointType;			// 포인트 결제 타임
	private String pointContent;		// 포인트 결제 내용
	private int remainingPoint;			// 잔여 포인트
	private int totalCnt;				// 총 포인트 내역 수
	private String startIndex;				// 첫페이지
	private String endIndex;				// 마지막페이지
}

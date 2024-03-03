package kr.or.ddit.users.reserve.cart.service.impl;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.CartMapper;
import kr.or.ddit.users.login.vo.MemberVO;
import kr.or.ddit.users.reserve.air.service.AirReserveService;
import kr.or.ddit.users.reserve.air.vo.FlightVO;
import kr.or.ddit.users.reserve.air.vo.RoundTripVO;
import kr.or.ddit.users.reserve.cart.service.CartService;
import kr.or.ddit.users.reserve.cart.vo.CartAirVO;
import kr.or.ddit.users.reserve.cart.vo.CartVO;
import kr.or.ddit.utils.ServiceResult;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper cartMapper;
	
	@Autowired
	private AirReserveService reserveService;
	
	private final String code = "CART-";
	
	/*장바구니 확인 및 생성*/
	@Override
	public String checkAndMakeCart(long plNo, HttpSession session) {
		
		//1.기존 장바구니 확인
		String cartNo = cartMapper.checkCart(plNo);
		System.out.println("기존 장바구니 확인결과 cartNo : "+cartNo);
		if(cartNo == null) {  //2.없으면 장바구니 생성
			log.debug("기존 장바구니가 존재하지 않습니다.");
			CartVO cartVO = new CartVO();
			//3.장바구니 코드 생성 및 정보 세팅 
			String cartCode = code + plNo + "-";
			int ran = (int) (Math.random() * 99999) + 1;
			cartCode += new DecimalFormat("00000").format(ran);
			cartVO.setCartNo(cartCode);
			cartVO.setPlNo(plNo);
			cartVO.setCartType("GROUP");
			MemberVO memVO = (MemberVO) session.getAttribute("sessionInfo");
			cartVO.setMemId(memVO.getMemId());
			//4.장바구니 insert
			int status = cartMapper.insertCart(cartVO);
			if(status <= 0) {
				log.debug("장바구니insert실패!");
				return null;
			}
			System.out.println("장바구니 insert결과 CartNo : "+cartVO.getCartNo());
			return cartVO.getCartNo();
		}
		return cartNo;
	}
	
	/* 담겨있는 항공편 확인 후 insert*/
	@Override
	public ServiceResult checkAndInsertAircart(String cartNo, String depFlightCode, String arrFlightCode, int totalPrice, int totalPassenger) {
		System.out.println("checkAndInsertAircart() 진입!");
		//1.기존에 담겨있는 항공편확인
		CartAirVO cartAirVO = cartMapper.checkFlightInCart(new CartAirVO(depFlightCode, arrFlightCode, cartNo));
		log.debug("cartAirVO : "+cartAirVO);
		if(cartAirVO == null) {
		  //2.항공상품 담기(insert)
		  int status = cartMapper.insertFlightInCart(new CartAirVO(depFlightCode, arrFlightCode, "ROUND-TRIP", cartNo, totalPrice, totalPassenger));
		  if(status <= 0) {
			 log.debug("항공권 장바구니 insert실패!");
			 throw new RuntimeException();
		  }
		  return ServiceResult.OK;
		}
		//3.담겨있으면 EXIST리턴
		return ServiceResult.EXIST;
	}

	/* 기존의 항공편 장바구니 리스트 가져오기 */
	@Override
	public List<RoundTripVO> selectAllAirCart(long plNo) {
        List<RoundTripVO> roundTripList = null;
		
		//1.장바구니에 담긴 항공권 조회
		List<CartAirVO> cartAirList = cartMapper.selectAllAirCart(plNo);
		if(cartAirList == null) {
			return null;
		}
		//2.담긴 항공권이 있을 경우 처리
		roundTripList = new ArrayList<RoundTripVO>();
		for (CartAirVO cartAir : cartAirList) {
			RoundTripVO roundTripVO = reserveService.selectRoundTripFlight(cartAir.getDepFlight(), cartAir.getReturnFlight());
			roundTripVO.setTotalPrice(cartAir.getCartairTotalprice());
			roundTripVO.setTotalCnt(cartAir.getCartairCnt());
			roundTripVO.setCartairStatus(cartAir.getCartairStatus());
			roundTripList.add(roundTripVO);
		}
		return roundTripList;
	}

	/* 장바구니(항공) 삭제 작업*/
	@Override
	public ServiceResult deleteFlightInCart(Map<String, String> cartMap) {
		ServiceResult result = null;
		int status = cartMapper.deleteFlightInCart(cartMap);
		if(status > 0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		return result;
	}

}

















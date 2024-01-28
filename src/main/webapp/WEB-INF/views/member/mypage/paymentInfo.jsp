<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- 마이 페이지 css -->
<link href="${contextPath }/resources/css/mypage.css" rel="stylesheet" />
<style>
  .header {
      padding: 10px 0;
      text-align: center;
  }
</style>

<!-- 마이 페이지 화면 영역 -->
<section class="myInfoContainer emptySpace cen">
    <aside class="myPageLnbContents">
        <nav class="myPageLnbCont">
            <ul>
                <li><a href="/mypage/myinfo.do">마이페이지</a></li>
                <li><a href="/mypage/boardinfo.do">게시글관리</a></li>
                <li><a href="/mypage/paymentinfo.do">결제관리</a></li>
            </ul>
        </nav>
    </aside>
    <article class="mypageContainer">
        <div class="myPageTabbtnGroup">
            <div class="tabbtn tactive">
				포인트 충전 및 사용내역
            </div>
            <div class="tabbtn">
				장바구니
            </div>
            <div class="tabbtn">
				항공권 구매내역
            </div>
            <div class="tabbtn">
				숙소 예약내역
            </div>
        </div>
        <div class="myPageTabcontBox">
            <div class="tabcont">
                <!-- 포인트 충전 및 사용내역 -->
                <div class="header">
				    <h3>포인트 충전</h3>
                </div>
                <div>
                	현재 보유 금액은 <span id="memPointSpan">${memPoint}</span>원입니다.
                </div>
				<div class="btn-group">
				    <form name="updatePoint">
				    	<input type="hidden" name="point_charge" value=""/>
						<input type="hidden" name="pay_code" value=""/>
				        <input type="hidden" name="memName" id="memName" value="${sessionInfo.memName}">
				        <input type="hidden" name="pointType" id="pointType" value="포인트 충전">
				
						<table style="margin-left: auto; margin-right: auto; ">
							<tr >
								<th colspan="2">충전금액</th>					
							</tr>
							<tr>
								<td>
									<input type="radio" name="pay" value="1000" style="width:20px;height:20px">
								</td>
								<td>1천원</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="pay" value="5000" style="width:20px;height:20px">
								</td>
								<td>5천원</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="pay" value="10000" style="width:20px;height:20px">
								</td>
								<td>1만원</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="pay" value="30000" style="width:20px;height:20px">
								</td>
								<td>3만원</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="pay" value="50000" style="width:20px;height:20px">
								</td>
								<td>5만원</td>
							</tr>
							<tr>
								<td>
									<input type="radio" name="pay" value="100000" style="width:20px;height:20px">
								</td>
								<td>10만원</td>
							</tr>
						</table>
				
				        <input class="btn btn-outline-danger" type="button" onclick="payment()" value="포인트 충전">
				    </form>
				</div>
				<div>
					<h3>사용내역</h3>
					<table class="table">
					  <thead>
					    <tr>
					      <th scope="col">날짜</th>
					      <th scope="col">입/출금</th>
					      <th scope="col">출금액</th>
					      <th scope="col">입금액</th>
					      <th scope="col">잔여금액</th>
					    </tr>
					  </thead>
					  <tbody>
					    <tr>
					      <th>2022-04-12</th>
					      <th>입금</th>
					      <td></td>
					      <td>100000</td>
					      <td>100000</td>
					    </tr>
					  </tbody>
					</table>
				</div>

            </div>
            <div class="tabcont">
                <!-- 장바구니 -->
				장바구니
            </div>
            <div class="tabcont">
                <!-- 항공권 구매내역 -->
				항공권 구매내역
            </div>
            <div class="tabcont">
                <!-- 숙소 예약내역 -->
				숙소 예약내역
            </div>
        </div>
    </article>
</section>

<!-- 마이 페이지 js -->
<script src="${contextPath }/resources/js/mypage.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
	$(function(){
	    $.lnbHequalContHFn();
	    $.myPageTabbtnFn();
	    
	    var memPointSpan = $("#memPointSpan").text();
	    var formattedMemPoint = addComma(memPointSpan);
	    console.log("memPoint 값 : " + memPointSpan);
	    console.log("formattedMemPoint 값 : " + formattedMemPoint);
	 	// span을 포맷된 값으로 업데이트
	    $("#memPointSpan").text(formattedMemPoint);
	});
	
	IMP.init('imp83255565'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	
	//결제api사용시 넘어가는 값 2개를 매개변수로 받아 저장후 컨트롤러로 넘김
	function payresult(param1,param2){
			$('input[name="pay_code"]').val(param1);
			$('input[name="point_charge"]').val(param2);
			
			
			console.log(param1," ",param2);
			console.log($('input[name="pay_code"]').val());
			$("#payresult").submit();
		}
	
	function payment() {
		//라디오버튼 체크 value변수	
		var radioVal = $('input[name="pay"]:checked').val();
		var memName = $('#memName').val();
		
		console.log("값 : " + radioVal);
		console.log("이름 값 : " + memName);
		
		//결제 api
		IMP.request_pay({
			pg: "kakaopay", 			// 	pg사
            amount: radioVal,  			//	가격 
            name : '주문명:결제테스트',
            buyer_name: memName,		// 	구매자 이름
		}, function(rsp) {
			if (rsp.success) {			// 	결제 성공
				uid = rsp.imp_uid;
				console.log('uid 값 : ' + uid);
				$.ajax({
					url : '/mypage/verify_iamport' + uid,
					type : 'post'
				}).done(function(data){
					console.log('넘겨왔던 값 : ', data);
				});
				var msg = '결제가 완료되었습니다.';
				// chargePoint(parseInt(radioVal)); // 충전 함수 호출
				// payresult(rsp.imp_uid, rsp.paid_amount);
			} else {					// 	결제 실패
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
			}
			alert(radioVal + "원 " + msg);
		});
	};

	//천단위 콤마처리 함수
	function addComma(value){
		value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return value; 
	}
	
	// 충전 시 memPointSpan 값 변경 함수
	function chargePoint(amount) {
	  var memPointSpan = $("#memPointSpan");
	  var currentPoint = parseInt(memPointSpan.text().replace(/[^0-9]/g, ''));
	  var updatedPoint = currentPoint + amount;
	  var formattedPoint = addComma(updatedPoint);
	  
	  console.log("amount 값 : " + amount);
	  console.log("currentPoint 값 : " + currentPoint);
	  console.log("updatedPoint 값 : " + updatedPoint);
	  console.log("formattedPoint 값 : " + formattedPoint);
	
	  memPointSpan.text(formattedPoint);
	}
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 마이 트립 css -->
<link href="${contextPath }/resources/css/myTrip.css" rel="stylesheet" />
<link href="${contextPath }/resources/css/buyPlan.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<section class="buyPlanContainer emptySpace">
	<article class="myTripHeadStyle">
        <div class="myTripImgBox">
            <img src="${contextPath }/resources/images/myTripBgImg.jpg" alt="마이 트립 배경 이미지" />
        </div>
        <div>
            <h3>마이 트립</h3>
            <span>MY TRIP</span>
        </div>
    </article>
    <div class="buyPlanBox cen">
    	<div class="btnWrap">
    		<button id="goToGroupPageBtn">그룹 페이지로 이동</button>
    	</div>
	    <article class="groupPlanContents">
	    	<h3>그룹 플랜</h3>
	    	<div class="groupPlanCont">
					<div class="mainContentsBox row mt-3">
						<div class="mainContentsBoxCenter col-md-12">
							<ul class="list-group">
								<li class="list-group-item border-0 tab">
									<c:forEach begin="0" end="${dayCnt}" varStatus="status0">
										<c:if test="${status0.index == 0 }">
											<span class="customBadge active" data-selday="${status0.index}">전체</span>
										</c:if>
										<c:if test="${status0.index > 0 }">
											<span class="customBadge" data-selday="${status0.index}">${status0.index}일차</span>
										</c:if>
									</c:forEach>
								</li>
								<!-- 전체탭(기본 show) -->
								<c:forEach begin="1" end="${dayCnt}" varStatus="status">
									<c:set value="day${status.index}" var="dayKey"></c:set>
									<li class="list-group-item border-0 dayHeader dayAll">
										<h4>DAY${status.index}</h4>
									</li>
									<c:forEach items="${requestScope[dayKey]}" var="dpForDay" varStatus="status2">
										<li class="list-group-item border-top-0 border-start-0 border-end-0 dayContents dayAll">
											<div class="row my-2">
												<div class="col-md-1">${dpForDay.spOrder}</div>
												<div class="col-md-2">
													<img class="thumbImg" src="${dpForDay.tourVO.firstImage}" alt="">
												</div>
												<div class="col-md-7">
													<div class="row">
														<div class="col-md-12 textDrop">${dpForDay.tourVO.title}</div>
													</div>
													<div class="row">
														<div class="col-md-12 textAdress">${dpForDay.tourVO.address}</div>
													</div>
												</div>
											</div>
										</li>
									</c:forEach>
								</c:forEach>
								<!-- 일차 선택탭(기본 hide) -->
								<c:forEach begin="1" end="${dayCnt}" varStatus="status3">
									<c:set value="day${status3.index}" var="dayKey2"></c:set>
									<li class="list-group-item border-0 dayHeader ${dayKey2}" style="display:none;">
										<h4>DAY${status3.index}</h4>
									</li>
									<c:forEach items="${requestScope[dayKey2]}" var="dpForDay2" varStatus="status4">
										<li class="list-group-item border-top-0 border-start-0 border-end-0 dayContents ${dayKey2}" style="display:none;">
											<div class="row my-2">
												<div class="col-md-1">${dpForDay2.spOrder}</div>
												<div class="col-md-2">
													<img class="thumbImg" src="${dpForDay2.tourVO.firstImage}" alt="">
												</div>
												<div class="col-md-7">
													<div class="row">
														<div class="col-md-12 textDrop">${dpForDay2.tourVO.title}</div>
													</div>
													<div class="row">
														<div class="col-md-12 textAdress">${dpForDay2.tourVO.address}</div>
													</div>
												</div>
											</div>
										</li>
									</c:forEach>
								</c:forEach>
							</ul>
						</div>
					</div>
	    	</div>
	    </article>
	    <style>
	    	.cart__list__detail:nth-child(odd) > td {
	    		border-bottom: none;
	    	}
	    </style>
	    <article class="buyPlanContents">
	    	<h3>그룹 여행상품 구매계획</h3>
	    	<div class="buyPlanCont">
	    		<!-- <form action=""> -->
		    		<table class="table cart__list">
	    				<thead>
						    <tr>
						      <td scope="col" colspan="2">상품정보</td>
						      <td scope="col">옵션</td>
						      <td scope="col">상품금액</td>
						      <td scope="col"></td>
						    </tr>	    					
	    				</thead>
	    				<tbody>
	    				  <c:choose>
	    				    <c:when test="${empty aircartList}">
	    				      <tr><input type="hidden" class="noItems" value="true"><td colspan="5">찜한 항공권이 존재하지 않습니다.</td></tr>
	    				    </c:when>
	    				    <c:otherwise>
	    				      <c:forEach items="${aircartList}" var="airProduct">
	    				          <!-- 가는편 -->
		    				      <tr class="cart__list__detail">
			                        <td>
			                          <img class="cartImg" src="${airProduct.departure.airlineLogo}" alt="magic keyboard">
			                          <span style="margin-left: 50px; font-weight: bolder;">${airProduct.departure.airlineName}</span>
			                        </td>
			                        <td>
			                        	<a href="#">${airProduct.departure.flightDepairport}(${airProduct.departure.flightDepportcode})</a>
			                            <p style="margin-left: 30px; margin-top: 10px;"><span class="material-symbols-outlined">arrow_downward</span></p>
			                            <span class="price">${airProduct.departure.flightArrairport}(${airProduct.departure.flightArrportcode})</span>
			                        </td>
			                        <td class="cart__list__option">
			                            <p>인원 : ${airProduct.totalCnt}</p>
			                            <p style="width: 100px;">
			                              <fmt:parseDate value="${airProduct.departure.flightDeptime}" pattern="yyyyMMddHHmm" var="depTime1"/>
			                              <fmt:formatDate value="${depTime1}" pattern="a h:mm"/> 출발
			                            </p>
			                        </td>
			                        <td><br><br>
			                        	&nbsp;&nbsp;&nbsp;
			                        	<span class="price">
			                        	 <input type="hidden" value="${airProduct.totalPrice}" class="airTotalPrice">
			                        	 <fmt:formatNumber value="${airProduct.totalPrice}" pattern="#,###"/>원
			                        	</span><br><br><br>
										<c:if test="${isGroupLeader ne 'N' }">
											<!-- 구매여부 -->
											<c:if test="${airProduct.cartairStatus eq 'N'}">
											  <button class="btn btn-success buyAir" style="width: 80px;" type="button"><span style="font-size: 12px;">구매하기</span></button>
											</c:if>
											<c:if test="${airProduct.cartairStatus eq 'Y'}">
											  <button class="btn btn-secondary" style="width: 80px;" type="button"><span style="font-size: 12px;">구매하기</span></button>
											</c:if>
										</c:if> 
			                        </td>
			                        <td>
			                          <br><br><br><br><br>
									  	<c:if test="${isGroupLeader ne 'N' }">
											  <!-- 구매여부 -->
											<c:if test="${airProduct.cartairStatus eq 'N'}">
											   <span class="material-symbols-outlined deleteAirBtn">cancel</span>   
											</c:if>
											<c:if test="${airProduct.cartairStatus eq 'Y'}">
											  <p style="font-size: 16px; color: red; font-weight: bolder;">결제완료</p>  
											</c:if>
										</c:if> 
									  	<c:if test="${isGroupLeader eq 'N' }">
											<c:if test="${airProduct.cartairStatus eq 'Y'}">
											  <p style="font-size: 16px; color: red; font-weight: bolder;">결제완료</p>  
											</c:if>
										</c:if> 
			                          <input type="hidden" name="depFlightCode" value="${airProduct.departure.flightCode}">
	    				              <input type="hidden" name="retFlightCode" value="${airProduct.arrival.flightCode}">
	    				              <input type="hidden" name="cartNo" value="${cartNo}">
			                        </td>
			                      </tr>
			                      
			                      <!-- 오는편 -->
		    				      <tr class="cart__list__detail">
			                        <td>
			                          <img class="cartImg" src="${airProduct.arrival.airlineLogo}" alt="magic keyboard">
			                          <span style="margin-left: 50px; font-weight: bolder;">${airProduct.arrival.airlineName}</span>
			                        </td>
			                        <td>
			                        	<a href="#">${airProduct.arrival.flightDepairport}(${airProduct.arrival.flightDepportcode})</a>
			                            <p style="margin-left: 30px;"><span class="material-symbols-outlined">arrow_downward</span></p>
			                            <span class="price">${airProduct.arrival.flightArrairport}(${airProduct.arrival.flightArrportcode})</span>
			                            <span style="text-decoration: line-through; color: lightgray;">왕복</span>
			                        </td>
			                        <td class="cart__list__option">
			                            <p>인원 : ${airProduct.totalCnt}</p>
			                            <p style="width: 100px;">
		                                  <fmt:parseDate value="${airProduct.arrival.flightDeptime}" pattern="yyyyMMddHHmm" var="arrTime1"/>
		                                  <fmt:formatDate value="${arrTime1}" pattern="a h:mm"/> 출발
			                            </p>
			                        </td>
			                        <td></td> 
			                        <td></td> 
			                      </tr>
	    				      </c:forEach>

	    				      <!-- 숙박 -->
	    				      <c:if test="${not empty stayInfo}">
		    				     <tr class="cart__list__detail">
			                        <td>
			                          <img class="cartImg" src="${stayInfo.picture}" style="margin-top: 20px;">
			                          <span style="margin-left: 50px; font-weight: bolder;">${stayInfo.title}</span>
			                        </td>
			                        <td style="padding-top: 10px;">
			                            <span>숙소타입 :<br> ${stayInfo.type}</span><hr>
			                        	<a href="#"><span style="font-weight: bold;">객실 :<br> ${stayInfo.roomName}</span></a><hr>
			                        </td>
			                        <td class="cart__list__option">
			                            <p>인원 : ${stayInfo.personNum}</p>
			                            <p style="width: 100px;">
			                               ${stayInfo.checkIn}
			                            </p>
			                            <p style="width: 100px;">
			                               ${stayInfo.checkOut}
			                            </p>
			                        </td>
			                        <td><br><br>
			                        	&nbsp;&nbsp;&nbsp;
			                        	<span class="price">
			                        	  <input type="hidden" value="${stayInfo.priceNum}" class="airTotalPrice">
			                        	  ${stayInfo.totalPrice}
			                        	</span><br><br><br>
										<c:if test="${isGroupLeader ne 'N' }">
											<!-- 구매여부 -->
											  <button class="btn btn-success" style="width: 80px;" type="button"  onclick="stayReserve()"><span style="font-size: 12px;">구매하기</span></button>
										</c:if> 
			                        </td>
			                        <td>
			                          <br><br><br><br><br>
									  	<c:if test="${isGroupLeader ne 'N' }">
											<!-- 구매여부 -->
											   <span class="material-symbols-outlined deleteAirBtn">cancel</span>   
										</c:if> 
									  	<c:if test="${isGroupLeader eq 'N' }">
											  <p style="font-size: 16px; color: red; font-weight: bolder;">결제완료</p>  
										</c:if> 
			                        </td>
			                      </tr>
	    				      </c:if>
	    				      
	    				    </c:otherwise>
	    				  </c:choose>
	    				</tbody>		
		    		</table>
		    		
					<div>
					  <input type="hidden" value="${groupPoint}" class="groupPointHidden"/>
					  <input type="hidden" value="${mategroupAgree }" class="mategroupAgreeHidden"/>
					  <input type="hidden" value="${memPoint }" class="memPointHidden"/>
					  <input type="hidden" value="${isAllGmDeducted }" class="isAllGmDeductedHidden"/>
					  <input type="hidden" value="${confirmPurchasingStep }" class="confirmPurchasingStepHidden"/>
					  <input type="hidden" value="${isGroupLeader }" class="isGroupLeaderHidden"/>
					  <%-- <span class="totalPointCost" style="font-size: 15px;">
					  	<span style="font-weight: bolder;">1인당 분할 결제 포인트 : </span>
					  	<span class="quotaPoint"></span><span>P /</span>
					    <span style="font-weight: bolder;">상품 총액 : </span>
					    <span class="totalPrice">0</span><span>원(P)</span>
					    <hr> 
					    <span style="font-weight: bolder;">필요한 포인트 : </span>
					    <span class="needPoint">0</span><span>P / </span>
					    <span style="font-weight: bolder;">현재 그룹포인트 잔액 : </span>
					    <span class="groupPoint">0</span><span>P</span>
					  </span>
					  <hr>
					  <span style="font-weight: bolder;">
					  	<span class="material-symbols-outlined">groups</span>
					  	<span>총 그룹원 : </span>
					  	<span class="curNum">${curNum}</span>
					  </span> --%>
					  <div class="totalPointCost">
					    <div class="point-details">
					        <span class="point-label">상품 총액 :</span>
					        <span class="totalPrice">0</span><span class="point-unit">원(P)</span>
					    </div>
					    <hr>
					    <div class="point-details" <c:if test="${confirmPurchasingStep eq '1단계' or confirmPurchasingStep eq '3단계'}">style="display:none;"</c:if>>
					        <span class="point-label">현재 그룹포인트 :</span>
					        <span class="groupPoint">0</span><span class="point-unit">P</span>
					    </div>
					    <div class="point-details" <c:if test="${confirmPurchasingStep eq '1단계' or confirmPurchasingStep eq '3단계'}">style="display:none;"</c:if>>
					        <span class="point-label">1인당 차감 할당량 :</span>
					        <span class="quotaPoint"></span><span class="point-unit">P /</span>
					        <span class="point-label">필요 그룹포인트 :</span>
					        <span class="needPoint">0</span><span class="point-unit">P</span>
					    </div>
						<div>
							<c:if test="${confirmPurchasingStep eq '1단계'}">* 모집마감 전에는 상품을 담으실 수만 있습니다. <br/> 포인트 차감 기능을 사용하려면 모집을 마감해주시기 바랍니다.</c:if>
						</div>
					</div>
					<hr <c:if test="${confirmPurchasingStep eq '3단계'}">style="display:none;"</c:if>>
					<div class="group-details">
					    <span class="material-symbols-outlined">groups</span>
					    <span class="group-label">그룹 총원 : <span class="curNum">${curNum}</span></span>
					    
					</div>
					</div>
					<!-- -->
    		        <div class="cart__mainbtns forGl" <c:if test="${isGroupLeader eq 'N' }">style="display:none;"</c:if>>
			            <!-- <span class="material-symbols-outlined">event_available</span> -->
			            <!-- <button class="cart__bigorderbtn left deductBtn">요청 마감일 설정</button> -->
						<c:if test="${confirmPurchasingStep eq '2단계' && isAllGmDeducted ne curNum}">
							<button class="cart__bigorderbtn left deductBtn">차감요청</button>
							<button class="cart__bigorderbtn left deductBtnForGm">포인트 차감</button>
						</c:if>
						<c:if test="${confirmPurchasingStep eq '2단계' && isAllGmDeducted eq curNum || confirmPurchasingStep eq '3단계' }">
							<button class="cart__bigorderbtn right purchaseConfirmedBtn">결제확정</button>
						</c:if>
			        </div>
			        <c:if test="${confirmPurchasingStep eq '2단계' }">
    		        <div class="cart__mainbtns forGm" <c:if test="${isGroupLeader eq 'Y' }">style="display:none;"</c:if>>
			            <button class="cart__bigorderbtn left deductBtnForGm forGmStyle">포인트 차감</button>
			        </div>
			        </c:if>
	    		<!-- </form> -->
	    	</div>
	    </article>
    </div>
</section>

<section class="deductProcessingModalContents">
	<div class="deductProcessingModalBox cen">
		<div class="deductProcessingModalClose">
			<div></div>
			<div></div>
		</div>
		<article class="deductProcessingModalCenter">
			<div>
				<div class="row modalContWrap deductPointModal">
					<h3>포인트 차감</h3>
					<div class="col-md-12 mt-3 modalContBox">
						<ul class="list-group">
							<li class="list-group-item border-0">
							</li>
							<li class="list-group-item border-0">
								<div class="row">
									<div class="col-md-6 modalLabel">상품 총액</div><div class="col-md-5"><span class="totalPrice"></span>P</div>
								</div>
							</li>
							<li class="list-group-item border-0">
								<div class="row">
									<div class="col-md-6 modalLabel">현재 내 포인트</div><div class="col-md-5"><span class="myCurP"></span>P</div>
								</div>
							</li>
							<li class="list-group-item border-0">
								<div class="row">
									<div class="col-md-6 modalLabel">차감 할당량</div><div class="col-md-5"><span class="myDedP"></span>P</div>
								</div>
							</li>
							<li class="list-group-item border-0">
								<div class="row">
									<div class="col-md-6 modalLabel">차감 후 내 포인트</div><div class="col-md-5"><span class="myPointAfterDeduct"></span>P<span style="color:red;" class="isPointEnough"></span></div>
								</div>
							</li>
							<li class="list-group-item border-0">
								<div class="row">
									<div class="col-md-6 modalLabel">차감 후 그룹 포인트</div><div class="col-md-5"><span class="groupPointAfterDeduct"></span>P</div>
								</div>
							</li>
							<li class="list-group-item border-0" id="totalResult">
								<div class="row">
									<div class="col-md-12 resultSummary">총 <span class="myDedP"></span>포인트를 차감합니다.</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
				<div class="row modalContWrap requestDeductingModal">
					<h3>차감요청</h3>
					<div class="col-md-12 mt-3 modalContBox">
						<ul class="list-group requestDeductListHere">
							<!-- 동적으로 생성됨 -->
						</ul>
					</div>
				</div>
				<div class="row modalBtnsWrap">
					<div class="col-md-12 mt-5">
						<button class="btn btn btn-dark btn-lg modalBtn requestDeductingToAllMemsBtn">일괄 차감요청</button>
						<button class="btn btn btn-dark btn-lg modalBtn deductPointBtn">포인트 차감</button>
					</div>
				</div>
			</div>
		</article>
	</div>
</section>

<!-- 마이 트립 js -->
<script src="${contextPath }/resources/js/myTrip.js"></script>
<script src="${contextPath }/resources/js/buyPlan.js"></script>
<script>

	let plNo = ${pvo.plNo};
	let pTitle = "${pvo.plTitle}";
	let pMem = "${pvo.memId}";	// 작성자
	console.log("pMem", pMem);
	let memId = "${sessionInfo.memId}";
	let memName = "${sessionInfo.memName}";
	let memProfileimg = "${sessionInfo.memProfileimg }";
	let memObj = {
		"memId" : memId,
		"memName" : memName,
		"memProfileimg" : memProfileimg
	};
	// console.log("objobjob", memObj);
	let allMem = "${memList}";
	console.log("allMem", allMem);
	// var ws;
	/*
"${sessionInfo.memName}"; // 발신자 이름
  var realsenTitle = "여행 정보 등록"; // 실시간 알림 제목
  var realsenContent = +"("+realsenId+")님이 새로운 여행 정보("+infoName.val()+", "+infoEngname.val()+")를 등록하였습니다."; // 실시간 알림 내용
  var realsenType = "buyPlan"; // 그룹 장바구니 타입 알림
  var realsenReadyn = "N"; // 안 읽음
  var realsenUrl = "/partner/buyPlan.do?plNo=" + plNo; // 그룹 장바구니 페이지로 이동
  
  var dbSaveFlag = false; // db에 저장
  var userImgSrc = "${sessionInfo.memProfileimg }"; // 유저 프로파일 이미지 정보
  var realrecNo = "empty";
	*/

	$(function(){
		// $.rtAlertChansFn(memId);
		$.getAllMemAjaxFn();
		$.isConfirmedPurchasingFn();
		$.deductPointFn();
		$.isAllGmdeductedFn();
		$.dedeuctModalFn();
		
		var myTripImgBox = $(".myTripImgBox");
        var myTripImg = $(".myTripImgBox img");
        $.ratioBoxH(myTripImgBox, myTripImg);
        
	});
	
	function stayReserve(){
		  Swal.fire({
			    title: '숙소예매를 진행하시겠습니까?',
			    showDenyButton: true,
			    showCancelButton: false,
			    confirmButtonText: "예",
			    denyButtonText: "아니오"
			  }).then((result) => {
			    if (result.isConfirmed) {
			    	location.href='/reserve/stay/reserve/stayReserve.do';
			    } else if (result.isDenied) {
			      return;
			    }
			  });
	}

</script>



























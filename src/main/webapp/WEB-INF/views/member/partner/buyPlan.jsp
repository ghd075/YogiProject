<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 마이 트립 css -->
<link href="${contextPath }/resources/css/myTrip.css" rel="stylesheet" />
<link href="${contextPath }/resources/css/buyPlan.css" rel="stylesheet" />

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
    		<button id="returnBtn">그룹 페이지로 이동</button>
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
	    <article class="buyPlanContents">
	    	<h3>그룹 여행상품 구매계획</h3>
	    	<div class="buyPlanCont">
	    		<form action="">
		    		<table class="table cart__list">
	    				<thead>
						    <tr>
						      <td scope="col"><input type="checkbox" /></td>
						      <td scope="col" colspan="2">상품정보</td>
						      <td scope="col">옵션</td>
						      <td scope="col">상품금액</td>
						      <td scope="col"></td>
						    </tr>	    					
	    				</thead>
	    				<tbody>
		                    <tr class="cart__list__detail">
		                        <td><input type="checkbox"></td>
		                        <td><img class="cartImg" src="https://www.hotelscombined.co.kr/rimg/himg/8e/ae/86/revato-15105-13688630-805323.jpg?width=968&height=607&crop=true" alt="magic keyboard"></td>
		                        <td>
		                        	<a href="#">롯데시티호텔 대전</a>
		                            <p>하룻밤 일반룸 101호</p>
		                            <sapn class="price">100,000원</sapn>
		                            <span style="text-decoration: line-through; color: lightgray;">90,000</span>
		                        </td>
		                        <td class="cart__list__option">
		                            <p>인원 : 5</p>
		                            <button class="cart__list__optionbtn">구매조건 추가/변경</button>
		                        </td>
		                        <td>
		                        	<span class="price">450,000원</span><br>
		                            <button class="cart__list__orderbtn">구매하기</button>
		                        </td>
		                        <td><button type="button" class="btn_delete_a" name="btn_delete" value="${n.cno}">&#8855;</button></td>
		                    </tr>
		                    <tr class="cart__list__detail">
		                        <td><input type="checkbox"></td>
		                        <td><img class="cartImg" src="https://www.hotelscombined.co.kr/rimg/himg/8e/ae/86/revato-15105-13688630-805323.jpg?width=968&height=607&crop=true" alt="magic keyboard"></td>
		                        <td>
		                        	<a href="#">롯데시티호텔 대전</a>
		                            <p>하룻밤 일반룸 101호</p>
		                            <sapn class="price">100,000원</sapn>
		                            <span style="text-decoration: line-through; color: lightgray;">90,000</span>
		                        </td>
		                        <td class="cart__list__option">
		                            <p>인원 : 5</p>
		                            <button class="cart__list__optionbtn">구매조건 추가/변경</button>
		                        </td>
		                        <td>
		                        	<span class="price">450,000원</span><br>
		                            <button class="cart__list__orderbtn">구매하기</button>
		                        </td>
		                        <td><button type="button" class="btn_delete_a" name="btn_delete" value="${n.cno}">&#8855;</button></td>
		                    </tr>
	    				</tbody>		
		    		</table>
					<div><span class="totalPointCost">현재원 : ${curNum} / 개인 포인트 차감 할당량 : 10,000 포인트 / 상품 총액 : 50,000 포인트</span></div>
					<!-- -->
    		        <div class="cart__mainbtns">
			            <!-- <button class="cart__bigorderbtn left">쇼핑 계속하기</button>
			            <button class="cart__bigorderbtn right">구매확정</button> -->
			            <button class="cart__bigorderbtn left deductBtn">차감요청</button>
			            <button class="cart__bigorderbtn right confirmPurchase">구매확정</button>
			            <!-- <button id="deductBtn">차감요청</button> -->
			        </div>
	    		</form>
	    	</div>
	    </article>
    </div>
</section>

<!-- 마이 트립 js -->
<script src="${contextPath }/resources/js/myTrip.js"></script>
<script src="${contextPath }/resources/js/buyPlan.js"></script>
<script>

	let plNo = ${pvo.plNo};
	
	$(function(){
		var myTripImgBox = $(".myTripImgBox");
        var myTripImg = $(".myTripImgBox img");
        $.ratioBoxH(myTripImgBox, myTripImg);
	});

</script>
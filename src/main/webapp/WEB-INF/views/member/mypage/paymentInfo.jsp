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
  .btn-block {
  	width: 100%
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
				<div class="container">
				    <div class="row">
				        <!-- 포인트 충전 영역 -->
				        <div class="col-md-12 mb-4">
				            <div class="card">
				                <div class="card-header">
				                    <h3>포인트 충전</h3>
				                </div>
				                <div class="card-body">
				                    <p>현재 포인트는 <span id="memPointSpan">${memPoint}</span>입니다.</p>
				                    <form name="updatePoint">
				                        <input type="hidden" name="memName" id="memName" value="${sessionInfo.memName}">
				                        <input type="hidden" name="memId" id="memId" value="${sessionInfo.memId}">
				                        <div class="row">
				                            <div class="col-md-3 mb-3">
				                                <div class="form-group">
				                                    <input type="radio" name="pay" value="10000" id="pay1" class="btn-check" autocomplete="off">
				                                    <label class="btn btn-outline-secondary btn-block" for="pay1">1만원</label>
				                                </div>
				                            </div>
				                            <div class="col-md-3 mb-3">
				                                <div class="form-group">
				                                    <input type="radio" name="pay" value="30000" id="pay2" class="btn-check" autocomplete="off">
				                                    <label class="btn btn-outline-secondary btn-block" for="pay2">3만원</label>
				                                </div>
				                            </div>
				                            <div class="col-md-3 mb-3">
				                                <div class="form-group">
				                                    <input type="radio" name="pay" value="50000" id="pay3" class="btn-check" autocomplete="off">
				                                    <label class="btn btn-outline-secondary btn-block" for="pay3">5만원</label>
				                                </div>
				                            </div>
				                            <div class="col-md-3 mb-3">
				                                <div class="form-group">
				                                    <input type="radio" name="pay" value="100000" id="pay4" class="btn-check" autocomplete="off">
				                                    <label class="btn btn-outline-secondary btn-block" for="pay4">10만원</label>
				                                </div>
				                            </div>
				                            <div class="col-md-3 mb-3">
				                                <div class="form-group">
				                                    <input type="radio" name="pay" value="300000" id="pay5" class="btn-check" autocomplete="off">
				                                    <label class="btn btn-outline-secondary btn-block" for="pay5">30만원</label>
				                                </div>
				                            </div>
				                            <div class="col-md-3 mb-3">
				                                <div class="form-group">
				                                    <input type="radio" name="pay" value="500000" id="pay6" class="btn-check" autocomplete="off">
				                                    <label class="btn btn-outline-secondary btn-block" for="pay6">50만원</label>
				                                </div>
				                            </div>
				                            <div class="col-md-3 mb-3">
				                                <div class="form-group">
				                                    <input type="radio" name="pay" value="1000000" id="pay7" class="btn-check" autocomplete="off">
				                                    <label class="btn btn-outline-secondary btn-block" for="pay7">100만원</label>
				                                </div>
				                            </div>
				                        </div>
				                        <div class="form-group text-md-end">
				                            <input class="btn btn-outline-danger" type="button" id="pointPaymentBtn" value="포인트 충전">
				                        </div>
				                    </form>
				                </div>
				            </div>
				        </div>
				
				        <!-- 사용내역 영역 -->
				        <div class="col-md-12 paymentResTbl">
				            <div class="card">
			                    <div class="card-header">
								    <div class="row">
								        <div class="col-md-9">
								            <h3>포인트 내역</h3>
								        </div>
								        <div class="col-md-3">
								            <select id="selectSort" class="form-select" onchange="filterResults(this.value)">
								                <option	value="all">전체</option>
								                <option value="priceSelect">충전</option>
												<option value="recoSelect">차감</option>
								            </select>
								        </div>
								    </div> 
			                	</div>
			                     <div class="card-body">
                    				<table class="table">
									  <thead>
									    <tr>
									      <th scope="col">번호</th>
									      <th scope="col">날짜</th>
									      <th scope="col">유형</th>
									      <th scope="col">입/출금액</th>
									      <th scope="col">잔여금액</th>
									    </tr>
									  </thead>
									  <tbody>
									  </tbody>
									</table>
							        <!-- 더보기 버튼 -->
					                <button id="searchMorePointBtn" class="btn btn-outline-primary btn-block col-sm-10 mx-auto">더 보기</button>
			                    </div>
				            </div>
				        </div>
				    </div>
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

<!-- 결제 js -->
<script src="${contextPath }/resources/js/myPayment.js"></script>
<!-- 아임포트 js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script>
	$(function(){
		// 조회 인덱스
		var startIndex = 1;	// 인덱스 초기값
		var searchStep = 5;	// 5개씩 로딩
	    $.lnbHequalContHFn();
	    $.myPageTabbtnFn();
	    $.readOldPointInfo(startIndex);
	    
	 	// 더보기 함수(전역)
	 	$.searchMoreClickFn(startIndex, searchStep);
	 	
	    $.myPaymentPointChgFn(startIndex);
	});

</script>
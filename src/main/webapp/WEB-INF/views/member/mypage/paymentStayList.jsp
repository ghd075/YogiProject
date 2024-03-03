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
				나의 장바구니
            </div>
            <div class="tabbtn" id="product">
				여행상품 구매내역
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
				                    <input type="hidden" class="plNo" value="${plNo }"/>
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
				                            <c:if test="${plNo > 0 }">
					                            <input class="btn btn-outline-danger" type="button" onclick="location.href='/partner/buyPlan.do?plNo=${plNo}'" value="그룹 페이지로 돌아가기">
				                            </c:if>
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
            
             <!-- 여행상품 구매내역 -->
            <div class="tabcont"><br>
                <!-- 상단 검색영역 -->
                <div class="row">
				  <div class="col-sm-4">
					<div class="form-check" style="display: inline-block; margin-right: 50px;">
					  <input type="radio" class="form-check-input" id="radio1" name="optradio" value="option1">항공상품
					  <label class="form-check-label" for="radio1"></label>
					</div>
					<div class="form-check" style="display: inline-block;">
					  <input type="radio" class="form-check-input" id="radio2" name="optradio" value="option2" onclick="location.href='/mypage/payHistoryStay.do'" checked>숙박상품
					  <label class="form-check-label" for="radio2"></label>
					</div>
				  </div>
				  <div class="col-sm-8">
				  <select class="form-select" id="sel1" name="sellist1" style="width : 130px; margin-left: 140px; display: inline-block;">
				      <option>전체</option>
				      <option>여행유형</option>
				      <option>항공사</option>
				      <option>출발지</option>
				      <option>도착지</option>
				      <option>결제자</option>
				    </select>
				    <input type="text" class="form-control" placeholder="검색어를 입력해주세요." style="display: inline-block; width: 240px; margin-left: 10px;">
				    <button class="btn btn-primary" style="margin-left: 10px;">검색하기</button>
				  </div>
				</div>
               <hr>
			  <!-- 상품 리스트 -->
			  <table class="table taleair">
			    <thead class="table-dark">
			      <tr>
			        <th>NO</th>
			        <th>동행여부</th>
			        <th>숙박업소</th>
			        <th>객실</th>
			        <th>분류</th>
			        <th>사용기간</th>
			        <th>사용인원</th>
			        <th>1인당<br>결제금액</th>
			        <th>결제일시</th>
			        <th>결제자</th>
			        <th>결제취소</th>
			      </tr>
			    </thead>
			    <tbody>
			     <tr style="height: 80px;">
	               <td>1</td>
	               <td>동행</td>
	               <td>
	                  <span>제주신라호텔</span><br>
	                  <img src="/resources/images/stay/list/제주신라편의시설2.PNG" style="width: 100px; height: 80px;">
	               </td>
	               <td>정원 전망 테라스 더블 룸</td>
	               <td>블랙 / 5성급 / 호텔</td>
	               <td>03.25(월) 14:00 ~ 03.30(토) 11:00</td>
	               <td>4명</td>
	               <td>416,472원</td>
	               <td>2024-02-16</td>
	               <td>${sessionInfo.memId}</td>
	               <td>
	                 <button class="btn btn-primary ticketBtn" style="margin-left: 10px; width: 80px;">취소하기</button>
	               </td>
                 </tr>
			    </tbody>
			  </table>
			  <!-- 페이징 영역 -->
			  <div class="row" id="paging">
			    <div class="col-sm-4"></div>
			    <div class="col-sm-4" id="pagingArea"></div>
			    <div class="col-sm-4"></div>
			  </div>
			  <div class="row">
			    <div class="col-sm-12">
			       <button class="btn btn-success" onclick="location.href='/mypage/downloadPayHistoryAsExcel.do'">엑셀 출력하기</button> 
			    </div>
			  </div>
			  
			    <!--항공편 티켓 미리보기 모달 -->
				<div class="modal" id="myModal">
				  <div class="modal-dialog modal-dialog-centered">
				    <div class="modal-content">
				
				      <!-- Modal Header -->
				      <div class="modal-header">
				        <button type="button" class="btn btn-danger" id="PDFDownload">PDF다운로드</button>
				        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body">
				        <div class="row headerModal">
				          <div class="col-sm-1">
				            <img src="/resources/images/logo.png" width="80px;" height="80px;" style="padding-top: 13px;">
				          </div>
				          <div class="col-sm-2">
				             &nbsp;&nbsp;<h4 style="padding-top: 10px; padding-left: 10px;">여기갈래</h4>
				          </div>
				          <div class="col-sm-5">
				             <h4 style="padding-top: 30px;">e-Ticket Intinerary & Receipt</h4>
				          </div>
				          <div class="col-sm-4" style="padding-top: 35px;">
				          </div>
				        </div>
				      </div>  <!-- modal body -->
				    
				  </div>
				</div>
            </div>  <!-- model end -->
        </div>
    </article>
</section>

<!-- 마이 페이지 js -->
<script src="${contextPath }/resources/js/mypage.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!-- 아임포트 js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<!-- html2canvas 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/1.4.1/html2canvas.min.js"></script>
<!-- jspdf 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>

<script>
	$(function(){
		// 조회 인덱스
		var startIndex = 1;	// 인덱스 초기값
		var searchStep = 5;	// 5개씩 로딩
	    
	 	// 더보기 함수(전역)
	 	$.searchMoreClickFn(startIndex, searchStep);
	 	
	    $.myPaymentPointChgFn(startIndex);
</script>


































<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- 마이 페이지 css -->
<link href="${contextPath }/resources/css/mypage.css" rel="stylesheet" />
<style>
    .travelReviewTbl th {
        text-align: center;
    }
    .travelReviewTbl td {
        text-align: center;
        padding: 10px; /* td 간격 조절 */
       	line-height: 100px; /* 세로 가운데 정렬 */
    }
	.reviewBoardImgBox {
	    position: relative;
	    width: 100px; 
	    height: 100px;
	    border-radius: 10%;
	    overflow: hidden;
	    margin-right: 10px; /* 이미지와 텍스트 사이의 간격 조정 */
	    display: inline-block; /* 이미지를 인라인 요소로 설정 */
	    vertical-align: middle; /* 세로 중앙 정렬 */
	}
	
	.reviewBoardImgBox img {
	    position: absolute;
	    top: 50%;
	    left: 50%;
	    transform: translate(-50%, -50%);
	    width: 100%; 
	    height: auto;
	}
	
	.travelReviewTbl td:first-of-type {
	    text-align: left; /* 텍스트를 왼쪽 정렬 */
	    line-height: 100px; /* 세로 중앙 정렬 */
	}
	
	.travelReviewTbl td:first-of-type>span {
	    display: inline-block; /* 텍스트를 인라인 요소로 설정 */
	    vertical-align: middle; /* 세로 중앙 정렬 */
	}
	
	.rtQnaTbl th {
		text-align: center;
	}
	
	.rtQnaTbl th:first-of-type {
		width: 120px;
	}
	
	.rtQnaTbl th:nth-of-type(3) {
		width: 100px;
	}
	
	.rtQnaTbl th:last-of-type {
		width: 90px;
	}
	
	.rtQnaTbl td:first-of-type, .rtQnaTbl td:nth-of-type(3), .rtQnaTbl td:last-of-type
		{
		text-align: center;
	}
	
	.rtQnaTbl td:first-of-type {
		overflow: auto;
	}
	
	.rtQnaTbl td:first-of-type>div, .rtQnaTbl td:first-of-type>span {
		float: left;
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
				나의 여행 후기
            </div>
            <div class="tabbtn">
				나의 문의
            </div>
        </div>
        <div class="myPageTabcontBox">
            <div class="tabcont">
                <!-- 나의 여행 후기 -->
				<table class="table table-striped table-hover travelReviewTbl">
				    <thead>
				        <tr>
				            <th>여행지</th>
				            <th>제목</th>
				            <th>여행기간</th>
				            <th>작성일</th>
				            <th>내역 삭제</th>
				        </tr>
				    </thead>
				    <tbody>
				        <!-- 첫 번째 여행 후기 -->
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
					            	<img src="${contextPath }/resources/images/review/reviewBg01.jpg" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>제주도</span>
				            </td>
				            <td>제주도 여행코스</td>
				            <td>4박 5일</td>
				            <td>2023.12.29</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				        <!-- 두 번째 여행 후기 -->
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
				            		<img src="${contextPath }/resources/images/air/search/airBg04.jpg" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>경기도 용인시</span>
				            </td>
				            <td>용인 1박2일 코스</td>
				            <td>1박 2일</td>
				            <td>2023.12.29</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				        <!-- 세 번째 여행 후기 -->
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
					            	<img src="${contextPath }/resources/images/review/reviewBg11.JPG" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>대전광역시</span>
			            	</td>
			            	<td>대전 1박2일 여행</td>
				            <td>1박 2일</td>
				            <td>2023.12.29</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				        <!-- 네 번째 여행 후기 -->
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
						            <img src="${contextPath }/resources/images/review/reviewBg10.jpg" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>대구광역시</span>
				            </td>
				            <td>대구 1박2일 여행</td>
				            <td>1박 2일</td>
				            <td>2023.12.29</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
						            <img src="${contextPath }/resources/images/air/search/airBg04.jpg" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>경기도 시흥시</span>
				            </td>
				            <td>시흥 여행코스</td>
				            <td>1박 2일</td>
				            <td>2023.12.29</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
						            <img src="${contextPath }/resources/images/review/reviewBg08.jpg" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>전라북도 남원시</span>
				            </td>
				            <td>남원 1박2일</td>
				            <td>1박 2일</td>
				            <td>2024.01.29</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
						            <img src="${contextPath }/resources/images/review/reviewBg07.JPG" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>전라남도 구례군</span>
				            </td>
				            <td>전남 구례군 여행코스</td>
				            <td>3박 4일</td>
				            <td>2024.02.13</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
						            <img src="${contextPath }/resources/images/review/reviewBg05.jpg" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>강원특별자치도 평창군</span>
				            </td>
				            <td>강원 평창군 여행코스</td>
				            <td>4박 5일</td>
				            <td>2023.12.29</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				        <tr>
				            <td>
				            	<div class="reviewBoardImgBox">
						            <img src="${contextPath }/resources/images/review/reviewBg06.jpg" alt="여행 후기 썸네일 이미지" />
				            	</div>
				            	<span>충청북도 단양군</span>
				            </td>
				            <td>충북 단양군 여행코스</td>
				            <td>3박 4일</td>
				            <td>2023.12.29</td>
				            <td><button class="btn btn-danger btn-sm" type="button">삭제</button></td>
				        </tr>
				    </tbody>
				</table>
            </div>
            <div class="tabcont">
                <!-- 나의 문의 -->

                <table class="table table-striped table-hover rtQnaTbl">
                	<thead>
                		<tr>
                			<th>순번</th>
                			<th>문의 제목</th>
                			<th>답변</th>
                			<th>내역 삭제</th>
                		</tr>
                	</thead>
                	<tbody>
                		<c:choose>
                			<c:when test="${not empty qnaList }">
                				<c:forEach items="${qnaList }" var="qna">
	                				<tr>
	                					<td>
	                						${qna.boNo }		
	                					</td>
	                					<td>
	                						${qna.boTitle }		
	                					</td>
	                					<td>
	                						<c:choose>
	                							<c:when test="${qna.cont eq 'off' }">
			                						<button class="btn btn-warning btn-sm disabled" type="button">대기중</button>		
	                							</c:when>
	                							<c:otherwise>
			                						<button class="btn btn-warning btn-sm" type="button" onclick="modalOn(${qna.boNo});" >답변 보기</button>		
	                							</c:otherwise>
	                						</c:choose>
	                					</td>
	                					<td>
	                						<form class="qnaOneDeleteForm" action="/mypage/qnaOneDelete.do" method="post">
	                							<input class="boNo" name="boNo" type="hidden" value="${qna.boNo }" />
	                						</form>
	                						<button class="btn btn-danger btn-sm qnaRemoveBtn" type="button">삭제</button>		
	                					</td>
	                				</tr>
                				</c:forEach>
                			</c:when>
                			<c:otherwise>
		                		<tr>
		            				<td colspan="4">문의 내역이 존재하지 않습니다.</td>
		            			</tr>
                			</c:otherwise>
                		</c:choose>
                	</tbody>
            	</table>
            </div>
        </div>
    </article>
</section>


<!-- 모달창(문의사항 답변) -->
<section class="questionAnswerModalContents">
	<div class="questionAnswerModalBox cen">
		<div class="questionAnswerModalClose">
            <div></div>
            <div></div>
        </div>
        <article>
        	<div>
				<div class="p-4 ml-auto mr-auto" style="font-size: 1.1em; width: 100%;">
					<div class="mb-2">
						<div>
							<span class="ml-2 mb-2">문의 제목</span>
							<input id="title" type="text" class="form-control mb-2" disabled/>
							<span class="ml-2 mb-2">문의 내용</span>
							<textarea id="content" class="form-control mb-2" disabled></textarea>
							<span class="ml-2 mb-2">답변 내용</span>
							<textarea id="answer" class="form-control mb-2"></textarea>
						</div>
					</div>
				</div>
        	</div>
        </article>
	</div>
</section>

<!-- 마이 페이지 js -->
<script src="${contextPath }/resources/js/mypage.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(function(){
    $.lnbHequalContHFn();
    $.myPageTabbtnFn();
    $.questionModalFn();
    
    // 종횡비 함수
    var reviewImgBox = $(".reviewBoardImgBox");
    var reviewImg = $(".reviewBoardImgBox img");
    $.ratioBoxH(reviewImgBox, reviewImg);
    
    // 나의 문의 > 내역 삭제
    var qnaRemoveBtn = $(".qnaRemoveBtn");
    qnaRemoveBtn.click(function(){
    	var thisIs = $(this);
    	console.log("thisIs : ", thisIs);
    	var qnaOneDeleteForm = thisIs.prev();
    	console.log("qnaOneDeleteForm : ", qnaOneDeleteForm);
    	Swal.fire({
    	  icon: "question",
   		  title: "나의 문의 내역 > 삭제",
   		  text : "해당 문의 내역을 삭제하시겠습니까?",
   		  showDenyButton: true,
   		  confirmButtonText: "삭제",
   		  denyButtonText: "취소"
   		}).then((result) => {
   		  if (result.isConfirmed) {
   			qnaOneDeleteForm.submit();
   		  } else if (result.isDenied) {
   			Swal.fire({
   			  icon: "error",
   			  title: "삭제 취소",
   			  text: "해당 문의 내역의 삭제가 취소되었습니다."
   			});
   		  }
   		});
    });
});
</script>
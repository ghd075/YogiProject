<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- 마이 페이지 css -->
<link href="${contextPath }/resources/css/mypage.css" rel="stylesheet" />

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
				포인트 충전 및 사용내역
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

<script>
$(function(){
    $.lnbHequalContHFn();
    $.myPageTabbtnFn();
});
</script>
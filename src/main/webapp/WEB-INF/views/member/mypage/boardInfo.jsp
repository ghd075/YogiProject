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
				나의 여행 후기
            </div>
            <div class="tabbtn">
				나의 문의
            </div>
            <div class="tabbtn">
				나의 숙소 후기
            </div>
        </div>
        <div class="myPageTabcontBox">
            <div class="tabcont">
                <!-- 나의 여행 후기 -->
				나의 여행 후기
            </div>
            <div class="tabcont">
                <!-- 나의 문의 -->
				나의 문의
            </div>
            <div class="tabcont">
                <!-- 나의 숙소 후기 -->
				나의 숙소 후기
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
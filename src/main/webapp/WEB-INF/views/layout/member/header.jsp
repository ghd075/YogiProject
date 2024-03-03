<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
    <h1>
        <a href="/index.do">
            <img src="${contextPath }/resources/images/logo.png" alt="로고 이미지" />
            <span class="logoTxt">
				여기갈래
                <br />
                <span>
                    Travel Integration
                    <br />
                    Platform System
                </span>
            </span>
        </a>
    </h1>
    <div>
        <nav class="pcgnb">
            <div>
                <div>
                	<c:if test="${not empty sessionInfo }">
	                    <div class="mainProfileImgCont">
	                        <img src="${sessionInfo.memProfileimg }" alt="프로필 이미지" />
	                    </div>
	                    <div class="loginHello">
	                        <span>
	                            [${sessionInfo.memName }]님 환영합니다.
	                        </span>
	                    </div>
                	</c:if>
                	<c:if test="${empty sessionInfo }">
                		<div class="loginHello">
	                        <span>
								로그인하시면 더 많은 혜택을 누릴 수 있습니다.
	                        </span>
	                    </div>
                	</c:if>
                    <div class="gnbBtnGroup">
                    	<c:if test="${not empty sessionInfo }">
	                        <a class="mypageIcon" href="/mypage/myinfo.do">
	                            <i class="fas fa-address-book"></i>
	                        </a>
	                        <a class="alarmIcon" href="javascript:void(0)">
	                            <i class="fas fa-bell" style="transition: color 0.5s;"></i>
	                            <span>0</span>
	                        </a>
	                        <a class="loginOutIcon" href="/login/logout.do">
	                            <i class="fas fa-sign-out-alt"></i>
	                        </a>
                    	</c:if>
                    	<c:if test="${empty sessionInfo }">
                    		<a class="loginOutIcon" href="/login/signin.do">
	                            <i class="fas fa-sign-in-alt"></i>
	                        </a>
                    	</c:if>
                    </div>
                </div>
            </div>
        </nav>
        <nav class="pclnb">
            <ul>
                <li class="main">
                    <a href="javascript:void(0);">마이 플랜</a>
                    <ul class="sub">
                        <li><a href="/myplan/info.do">여행 정보</a></li>
                        <li><a href="/myplan/planMain.do">플래너</a></li>
                        <%-- <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/myplan/makeplan.do">플래너</a></li> --%>
                    </ul>
                </li>
                <li class="main">
                    <a href="javascript:void(0);">마이 트립</a>
                    <ul class="sub">
	                    <!-- 
	                    	1. 만남의 광장 > 0) 플래너 작성 > 1) 여행 목록 리스트 > 2) 만남의 광장 그룹 채팅 > 3) 그룹 플랜 화면으로 진입? 4) 장바구니까지 표현하시겠다?
	                    	2. 여행 경비 계산 > 1) 지출 내역을 가계부 형식으로 기록 관리만 하는 것이다.
	                    	3. 마이 플랜 이력 > 1) 여행 목록 리스트 > 2) 해당 여행에 대한 플랜이 제시 되고, 그 여행에 걸린 여행상품 구매 내역을 목록으로 출력
	                    -->
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/mygroup.do">만남의 광장</a></li>
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/history.do">마이 플랜 이력</a></li>
                    </ul>
                </li>
                <li class="main">
                    <a href="javascript:void(0);">예약 관리</a>
                    <ul class="sub">
                      <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/reserve/air/search/form.do">항공 예약</a></li>
                      <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/reserve/stays/search/form.do">숙박 예약</a></li>
                    </ul>
                </li>
                <li class="main">
                    <a href="javascript:void(0);">게시판</a>
                    <ul class="sub">
                        <li><a href="/notice/list.do">공지사항</a></li>
                        <li><a href="/qna/list.do">Q&amp;A</a></li>
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/question/list.do">문의게시판</a></li>
                        <li><a href="/review/list.do">여행후기</a></li>
                    </ul>
                </li>
                <li class="main">
                    <a class="mLnbBtn" href="javascript:void(0)">
                        <div></div>
                        <div></div>
                        <div></div>
                    </a>
                </li>
            </ul>
        </nav>
    </div>
    <nav class="mlnb scroll">
        <div class="cen">
            <nav class="mgnb">
                <div>
                    <div>
                    	<c:if test="${not empty sessionInfo }">
	                        <div class="mainProfileImgCont">
	                            <img src="${sessionInfo.memProfileimg }" alt="프로필 이미지" />
	                        </div>
	                        <div class="loginHello">
	                            <span>
	                                [${sessionInfo.memName }]님 환영합니다.
	                            </span>
	                        </div>
                    	</c:if>
                    	<c:if test="${empty sessionInfo }">
	                		<div class="loginHello">
		                        <span>
									로그인하시면 더 많은 혜택을 누릴 수 있습니다.
		                        </span>
		                    </div>
	                	</c:if>
                        <div class="gnbBtnGroup">
                        	<c:if test="${not empty sessionInfo }">
		                        <a class="mypageIcon" href="/mypage/myinfo.do">
		                            <i class="fas fa-address-book"></i>
		                        </a>
		                        <a class="alarmIcon" href="javascript:void(0)">
		                            <i class="fas fa-bell"></i>
		                            <span>0</span>
		                        </a>
		                        <a class="loginOutIcon" href="/login/logout.do">
		                            <i class="fas fa-sign-out-alt"></i>
		                        </a>
	                    	</c:if>
	                    	<c:if test="${empty sessionInfo }">
	                    		<a class="loginOutIcon" href="/login/signin.do">
		                            <i class="fas fa-sign-in-alt"></i>
		                        </a>
	                    	</c:if>
                        </div>
                    </div>
                </div>
            </nav>
            <div class="mlnbCloseBtn">
                <div></div>
                <div></div>
            </div>
            <h2>
                <a href="/index.do">
                    <img src="${contextPath }/resources/images/logo.png" alt="로고 이미지" />
                    <span class="logoTxt">
						여기갈래
                        <br />
                        <span>
                            Travel Integration
                            <br />
                            Platform System
                        </span>
                    </span>
                </a>
            </h2>
            <ul>
                <li class="emptyList"></li>
                <li class="mmain">
                    <a href="javascript:void(0);">마이 플랜</a>
                    <ul class="msub">
                        <li><a href="/myplan/info.do">여행 정보</a></li>
                        <li><a href="/myplan/planMain.do">플래너</a></li>
                    </ul>
                </li>
                <li class="mmain">
                    <a href="javascript:void(0);">마이 트립</a>
                    <!--  
                    	1. 만남의 광장 > 0) 플래너 작성 > 1) 여행 목록 리스트 > 2) 만남의 광장 그룹 채팅 > 3) 그룹 플랜 화면으로 진입? 4) 장바구니까지 표현하시겠다?
                    	2. 여행 경비 계산 > 1) 지출 내역을 가계부 형식으로 기록 관리만 하는 것이다.
                    	3. 마이 플랜 이력 > 1) 여행 목록 리스트 > 2) 해당 여행에 대한 플랜이 제시 되고, 그 여행에 걸린 여행상품 구매 내역을 목록으로 출력
                    -->
                    <ul class="msub">
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/mygroup.do">만남의 광장</a></li>
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/history.do">마이 플랜 이력</a></li>
                    </ul>
                </li>
                <li class="mmain">
                    <a href="javascript:void(0);">예약 관리</a>
                    <ul class="msub">
                      <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/reserve/air/search/form.do">항공 예약</a></li>
                      <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/reserve/stays/search/form.do">숙박 예약</a></li>
                    </ul>
                </li>
                <li class="mmain">
                    <a href="javascript:void(0);">게시판</a>
                    <ul class="msub">
                        <li><a href="/notice/list.do">공지사항</a></li>
                        <li><a href="/qna/list.do">Q&amp;A</a></li>
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/question/list.do">문의게시판</a></li>
                        <li><a href="/review/list.do">여행후기</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </nav>
    <div class="card rtAlertBox">
    	<i class="far fa-window-close rtCloseBtn"></i>
        <div class="rtImgBox">
            <img src="${contextPath }/resources/images/default_profile.png" alt="실시간 알림 프로필 이미지" />
        </div>
        <div class="card-body">
            <h4 class="card-title">알림</h4>
            <p class="card-text">
				블라블라블라
            </p>
        </div>
    </div>
</header>
<script>

var ws;
var sessionMemIdChan = "${sessionInfo.memId}"
$.rtAlertChansFn = function(sessionMemIdChan) {
    if(sessionMemIdChan != null) {
        console.log("일단 연결해")
        connectWs();
    }
    
    function connectWs(){
        console.log("tttttt")
        ws = new SockJS("/alertForChan");
    
           ws.onopen = function() {
            console.log('open');
            //testAjax();
            };
    
           ws.onmessage = function(event) {
            console.log("onmessage"+event.data);
            //    let $socketAlert = $('div#socketAlert');
            //    $socketAlert.html(event.data)
            //    $socketAlert.css('display', 'block');
                
            //    setTimeout(function(){
            //        $socketAlert.css('display','none');
                    
            //    }, 5000);
            realTimeAlertMessageChan(event);
        };
    
           ws.onclose = function() {
                console.log('close');
         };
       };
}

$.rtAlertChansFn(sessionMemIdChan);

function realTimeAlertMessageChan(event){
		var realTimeAlertData = event.data;
		console.log("realTimeAlertData : ", realTimeAlertData);

        // 웹 소켓에서 브로드캐스팅된 text를 정제
        var rtArr = realTimeAlertData.split(",");
        console.log("rtArr : ", rtArr);

        var rtAlertBox = $(".rtAlertBox");

        // 구분자가 없는 경우 배열의 길이가 1이상이어야 함
        if(rtArr.length > 1) {
            var realrecIdArr = rtArr[0].trim();
            var realsenId = rtArr[1].trim();
            var realsenName = rtArr[2].trim();
            var realsenTitle = rtArr[3].trim();
            var realsenContent = rtArr[4].trim();
            var realsenType = rtArr[5].trim();
            var realsenReadyn = rtArr[6].trim();
            var realsenUrl = rtArr[7].trim();
            var realsenPfImg = rtArr[8].trim();
            // var realrecNo = rtArr[8].trim();
            // console.log("realsenUrl",realsenUrl);

            var rtAlertBox = $(".rtAlertBox");
            rtAlertBox.find(".rtImgBox img").attr("src", realsenPfImg);
            rtAlertBox.find(".card-title").html(realsenTitle);
            rtAlertBox.find(".card-text").html(realsenContent);

            // console.log("realsenUrl : ", realsenUrl);
            // console.log("realsenUrl > empty ", realsenUrl !== "empty");

            // console.log("realrecNo : ", realrecNo);
            // console.log("realrecNo > empty : ", realrecNo !== "empty");

            if(realsenUrl !== "empty") {
                rtAlertBox.find(".rtAlertFadeBtn").remove();

                // if(realrecNo !== "empty") {
                //     rtAlertBox.find(".card-body").append(`
                //         <div class="rtAlertFadeBtn" style="text-align: right;">
                //             <a href="${realsenUrl}" class="btn btn-primary" data="${realrecNo}">바로가기</a>
                //         </div>
                //     `);
                // }else {
                    let tempHtml = '<div class="rtAlertFadeBtn" style="text-align: right;"><a href="'+realsenUrl+'" class="btn btn-primary">바로가기</a></div>';
                    rtAlertBox.find(".card-body").append(tempHtml);
                // }
            }

            rtAlertBox.fadeIn(1000, function() {
                setTimeout(function() {
                    rtAlertBox.fadeOut(1000);
                }, 4000);
            });
        }
        
	}
</script>
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
	                            <i class="fas fa-bell"></i>
	                            <span>99</span>
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
                        <li><a href="/myplan/chatting.do">채팅 테스트</a></li>
                    </ul>
                </li>
                <li class="main">
                    <a href="javascript:void(0);">마이 트립</a>
                    <ul class="sub">
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/mygroup.do">마이 그룹</a></li>
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/calculate.do">여행 경비 계산</a></li>
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/basket.do">그룹 장바구니</a></li>
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
		                            <span>99</span>
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
                    <ul class="msub">
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/mygroup.do">마이 그룹</a></li>
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/calculate.do">여행 경비 계산</a></li>
                        <li class="<c:if test="${empty sessionInfo }">noUserBlock</c:if>"><a href="/partner/basket.do">그룹 장바구니</a></li>
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
</header>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pageContext.request.contextPath }" var="contextPath" />
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="author" content="부루마불" />
        <meta name="description" content="대덕인재개발원 7월반 4조 부루마불의 여기갈래 프로젝트입니다." />
        <meta name="keywords" content="부루마불, 여기갈래, 여행, 통합, 플랫폼" />
        <meta name="copyright" content="대덕인재개발원" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>여기갈래 &gt; 로그인</title>
        <link href="${contextPath }/resources/images/favicon.ico" rel="shoutcut icon" />
        <!-- 공통 css -->
        <link href="${contextPath }/resources/css/login.css" rel="stylesheet" />
        <!-- 제이쿼리 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- 공통 js -->
        <script defer src="${contextPath }/resources/js/util.js"></script>
        <script defer src="${contextPath }/resources/js/login.js"></script>
        <!-- 부트스트랩 모듈 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- 스위트 얼럿 모듈 -->
    	<link href="${contextPath }/resources/css/sweetalert2.min.css" rel="stylesheet" />
    	<script defer src="${contextPath }/resources/js/sweetalert2.all.min.js"></script>

        <c:if test="${not empty message }">
		    <script>
	        	//alert("${message}");
		        $(function(){
		        	// 성공시
		        	<c:if test="${msgflag eq 'su'}">
		        		Swal.fire({
		                    title: "성공",
		                    text: "${message}",
		                    icon: "success"
		                });
		        	</c:if>
		        	// 실패시
		        	<c:if test="${msgflag eq 'fa'}">
			        	Swal.fire({
		                    title: "실패",
		                    text: "${message}",
		                    icon: "error"
		                });
		        	</c:if>
		        	// 정보성 메시지
		        	<c:if test="${msgflag eq 'in'}">
			        	Swal.fire({
		                    title: "안내",
		                    text: "${message}",
		                    icon: "info"
		                });
		        	</c:if>
		        });
		        <c:remove var="message" scope="request" />
		        <c:remove var="message" scope="session" />
		    </script>
		</c:if>
		
		<c:if test="${not empty errors && msgflag eq 'in'}">
		    <script>
		        // alert("${errors}"); 
			    $(function(){
		        	Swal.fire({
	                    title: "서버오류",
	                    text: "${errors}",
	                    icon: "error"
	                });
			    });
		    	<c:remove var="errors" scope="request" />
		    	<c:remove var="errors" scope="session" />
		    </script>
		</c:if>

    </head>

    <body class="scroll">
        <section id="loginContainer">
            <article>
                <h1>
                    <a href="/index.do">
                        <img src="${contextPath }/resources/images/logo.png" alt="메인 로고" />
                    </a>
                </h1>
                <div class="loginBox">
                    <h2>여기갈래</h2>
                    <p>Travel Integration Platform System</p>
                    <form action="/login/loginCheck.do" id="loginForm" name="loginForm" method="post">
                        <input class="form-control" type="text" id="memId" name="memId" placeholder="아이디" autocomplete="off" value="${member.memId }" />
                        <input class="form-control" type="password" id="memPw" name="memPw" placeholder="비밀번호" autocomplete="off" value="${member.memPw }" />
                        <div>
                            <a href="/login/signup.do">회원가입</a>
                            <a href="/login/findIdPw.do">ID/비밀번호 찾기</a>
                        </div>
                        <button class="btn btn-success" type="button" id="loginBtn">로그인</button>
                    </form>
                    <p class="testBtnShow">
                        Copyright &copy; 2023. Burumabool. All right reserved.
                        <br />
                        YOgIGaLE v.2.1
                    </p>
                </div>
                <div class="testBtnGroup">
                 	<div>
	                	<button class="btn btn-primary" type="button" id="adminAccount">관리자 계정</button>
	                	<button class="btn btn-secondary" type="button" id="lgjAccount">테스트 계정</button>
                 	</div>
                 	<div>
                 		<button class="btn btn-success" type="button" id="iuAccount">아이유 계정</button>
                 		<button class="btn btn-info" type="button" id="wonAccount">장원영 계정</button>
                 	</div>
                 	<div>
                 		<button class="btn btn-warning" type="button" id="haAccount">하루토 계정</button>
                 		<button class="btn btn-danger" type="button" id="kiAccount">키이오 계정</button>
                 	</div>
                </div>
            </article>
            <div class="stylecomp_firstbar"></div>
            <div class="stylecomp_secondbar"></div>
            <div class="bg_video">
                <div class="donttouch"></div>
                <iframe src="https://www.youtube.com/embed/jX2t-FPDQ2g?autoplay=1&mute=1&controls=0&loop=1&playlist=jX2t-FPDQ2g" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
            </div>
        </section>
        <script>
            $(function(){

                var memId = $("#memId");
                var memPw = $("#memPw");
                var loginBtn = $("#loginBtn");
                var loginForm = $("#loginForm");

                $.loginMouseOverEvent();
                $.loginMouseOutEvent();
                $.enterKeyUpEvent();
                
                // 테스트 계정 함수
                $.testAccountFn();

                loginBtn.on("click", function(){
                    var idFlag = $.falsyCheckFn(memId, "아이디");
                    if(!idFlag) return;
                    var pwFlag = $.falsyCheckFn(memPw, "비밀번호");
                    if(!pwFlag) return;
                    loginForm.submit();
                });

            });
        </script>
    </body>
</html>
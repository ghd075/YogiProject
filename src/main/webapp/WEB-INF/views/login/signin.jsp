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

        <c:if test="${not empty message }">
		    <script>
		        alert("${message}"); 
		        <c:remove var="message" scope="request" />
		        <c:remove var="message" scope="session" />
		    </script>
		</c:if>
		
		<c:if test="${not empty errors }">
		    <script>
		        alert("${errors}"); 
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
                <div>
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
                    <p>
                        Copyright &copy; 2023. Burumabool. All right reserved.
                        <br />
                        YOgIGaLE v.2.1
                    </p>
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
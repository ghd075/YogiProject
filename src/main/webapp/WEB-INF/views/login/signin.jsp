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
    	<!-- sockjs -->
		<script src="${contextPath }/resources/js/sockjs.min.js"></script>

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
                    
                 	// 실시간 알림 - 로그인 내용 저장 시작
           	        var realrecIdArr; // 모든 유저를 대상으로 알림
           	        $.ajaxMembersIdListGetFn(function(result){
           	        	
           	        	var loginMemVO = {
           	        		memId : memId.val(),
           	        		memPw : memPw.val()
           	        	};
           	        	console.log("loginMemVO : ", loginMemVO);
           	        	
           	        	$.ajax({
           	        		 type : "get",
	           	             url : "/loginMemInfoRtAlertSaveInfo.do",
	           	             data : loginMemVO,
	           	             dataType : "json",
	           	             success : function(res){
	           	                console.log("res : ", res);
	           	                
		           	        	realrecIdArr = result;
		           		        console.log("realrecIdArr : ", realrecIdArr);
		           		        
		           		        var realsenId = res.memId; // 발신자 아이디
		           		        var realsenName = res.memName; // 발신자 이름
		           		        var realsenTitle = "로그인"; // 실시간 알림 제목
		           		        var realsenContent = realsenName+"("+realsenId+")님이 로그인하였습니다."; // 실시간 알림 내용
		           		        var realsenType = "logininfo"; // 정보
		           		        var realsenReadyn = "N"; // 안 읽음
		           		        var realsenUrl = "empty"; // 갈데 없음
		           		        
		           		  		// db에 저장하고 1번만 읽고 바로 realsenReadyn = N을 realsenReadyn = Y로 처리한다.
		           		        // 로그아웃 시 해당 정보를 삭제해야 한다.
		           		        
		           		        var dbSaveFlag = true; // db에 저장
		    			        var userImgSrc = res.memProfileimg; // 유저 프로파일 이미지 정보
		    			        var realrecNo = "empty";
		           		        
		    			        var rtAlert = {
		       			        	"realrecIdArr": realrecIdArr,
		       			        	"realsenId": realsenId,
		       			        	"realsenName": realsenName,
		       			        	"realsenTitle": realsenTitle,
		       			        	"realsenContent": realsenContent,
		       			        	"realsenType": realsenType,
		       			        	"realsenReadyn": realsenReadyn,
		       			        	"realsenUrl": realsenUrl,
		       			        	"realsenPfimg": userImgSrc
		       			        };
		           		        console.log("login > rtAlert : ", rtAlert);
		           		        
		           		        $.realTimeAlertWebSocketFn(rtAlert, dbSaveFlag, userImgSrc, realrecNo);
		           		        
	           	             }
           	        	});
           	        	
           		        
           	        });
           	  		// 실시간 알림 - 로그인 내용 저장 끝
           	  		
           	  		// 로그인 처리
           	  		setTimeout(()=>{
                        loginForm.submit();           	  			
           	  		}, 2000);
                });

            });
        </script>
    </body>
</html>
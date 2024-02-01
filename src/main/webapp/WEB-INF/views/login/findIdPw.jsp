<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pageContext.request.contextPath }" var="contextPath" />
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8">
        <meta name="author" content="부루마불" />
        <meta name="description" content="대덕인재개발원 7월반 4조 부루마불의 여기갈래 프로젝트입니다." />
        <meta name="keywords" content="부루마불, 여기갈래, 여행, 통합, 플랫폼" />
        <meta name="copyright" content="대덕인재개발원" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>여기갈래 &gt; 아이디/비밀번호 찾기</title>
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
    	
        <style>
            #chgPwModal .modal-body>div {
                overflow: auto;
            }
            
            #chgPwModal .modal-body>div p,
            #chgPwModal .modal-body>div .chgPwChkBadge {
                float: left;
            }
            
            #chgPwModal .modal-body>div .chgPwChkBadge {
                margin-left: 20px;
            }
            
            #chgPwForm>div {
                overflow: auto;
                margin-bottom: 20px;
            }
            
            #chgPwForm label {
                float: left;
                width: 150px;
                padding-top: 5px;
            }
            
            #chgPwForm input {
                float: left;
                width: calc(100% - 150px);
            }
            
            .chgPwChkBadge {
                margin-bottom: 20px;
            }
        </style>
        
    </head>
    
    <body class="scroll">
        <section id="idPwFindContainer">
            <article>
                <h1>
                    <a href="/index.do">
                        <img src="${contextPath }/resources/images/logo.png" alt="메인 로고" />
                    </a>
                </h1>
                <div class="findContents">
                    <h2>아이디 찾기</h2>
                    <p>아이디 찾기는 이메일, 이름을 입력하여 찾을 수 있습니다.</p>
                    <form action="" id="idFind" name="idFind">
                        <input class="form-control" type="text" id="memEmail" name="memEmail" placeholder="회원 이메일 입력" autocomplete="off" />
                        <input class="form-control" type="text" id="memName" name="memName" placeholder="회원 이름 입력" autocomplete="off" />
                        <p class="findIdTxt">
							<span class="badge bg-warning">아이디 찾기 버튼을 눌러 주세요.</span>
                        </p>
                        <button class="btn btn-primary" type="button" id="idFindBtn">아이디 찾기</button>
                        <button class="btn btn-success loginPageGoBtn" type="button">로그인 페이지</button>
                    </form>
                </div>
                <div class="findContents">
                    <h2>비밀번호 재설정</h2>
                    <p>비밀번호 재설정은 아이디, 이메일, 이름을 입력하여 변경할 수 있습니다.</p>
                    <form action="" id="pwFind" name="pwFind">
                        <input class="form-control" type="text" id="memId" name="memId" placeholder="회원 아이디 입력" autocomplete="off" />
                        <input class="form-control" type="text" id="memEmail2" name="memEmail" placeholder="회원 이메일 입력" autocomplete="off" />
                        <input class="form-control" type="text" id="memName2" name="memName" placeholder="회원 이름 입력" autocomplete="off" />
                        <p class="findPwTxt">
							<span class="badge bg-warning">비밀번호 재설정 버튼을 눌러 주세요.</span>
                        </p>
                        <button class="btn btn-primary" type="button" id="pwFindBtn">비밀번호 재설정</button>
                        <button class="btn btn-success loginPageGoBtn" type="button">로그인 페이지</button>
                    </form>
                </div>
            </article>
            <div class="bg_video">
                <div class="donttouch"></div>
                <iframe src="https://www.youtube.com/embed/PMBa2F44jxU?autoplay=1&mute=1&controls=0&loop=1&playlist=PMBa2F44jxU" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
            </div>
        </section>
        <script>
            $(function(){
				// 공통 변수
                var idFindBtn = $("#idFindBtn");
                var pwFindBtn = $("#pwFindBtn");

                var memEmail = $("#memEmail");
                var memName = $("#memName");

                var memId = $("#memId");
                var memEmail2 = $("#memEmail2");
                var memName2 = $("#memName2");

                var findCont = $("#idPwFindContainer>article");

                // 공통 함수
                $.loginPageGoFn();
                $.findMouseOverEvent(findCont);
                $.findMouseOutEvent(findCont);

                idFindBtn.click(function(){
                	
                    var emailFlag = $.falsyCheckFn(memEmail, "회원 이메일");
                    if(!emailFlag) return;
                    var nameFlag = $.falsyCheckFn(memName, "회원 이름");
                    if(!nameFlag) return;
                    
                    var findIdObj = {
                    	memEmail: memEmail.val(),
                    	memName: memName.val()
                    };
                    var idObj = {
                    	url: "/login/findId.do",
                    	msgEl: ".findIdTxt",
                    	msg: "아이디"
                    };
                    $.findChkFn(findIdObj, idObj);
                    
                });

                pwFindBtn.click(function(){
                	
                    var idFlag = $.falsyCheckFn(memId, "회원 아이디");
                    if(!idFlag) return;
                    var emailFlag = $.falsyCheckFn(memEmail2, "회원 이메일");
                    if(!emailFlag) return;
                    var nameFlag = $.falsyCheckFn(memName2, "회원 이름");
                    if(!nameFlag) return;
                    
                    var findPwObj = {
                    	memId: memId.val(),
                    	memEmail: memEmail2.val(),
                    	memName: memName2.val()
                    };
                    var pwObj = {
                       	url: "/login/findPw.do",
                       	msgEl: ".findPwTxt",
                       	msg: "비밀번호"
                    };
                    $.findChkFn(findPwObj, pwObj);
                    
                });

            });
        </script>
    </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pageContext.request.contextPath }" var="contextPath" />
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="author" content="부루마불" />
        <meta name="description" content="대덕인재개발원 7월반 4조 부루마불의 여기갈래 프로젝트입니다." />
        <meta name="keywords" content="부루마불, 여기갈래, 여행, 통합, 플랫폼" />
        <meta name="copyright" content="대덕인재개발원" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>여기갈래 &gt; 회원가입</title>
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
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!-- flatpickr css -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
        <!-- flatpickr JS -->
        <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
        <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
        
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
        <section id="signContainer">
            <article>
                <div class="profileContents">
                    <div>
                        <img id="profileImg" src="${contextPath }/resources/images/default_profile.png" alt="프로필 이미지 미리보기" />
                    </div>
                </div>
                <div class="profileIcon">
                    <i class="fas fa-camera"></i>
                </div>
                <div class="signContents">
                    <form action="/login/signup.do" id="signForm" name="signForm" method="post" enctype="multipart/form-data">
                        <div class="inputCont">
                            <label for="imgFile">프로필 사진</label>
                            <input class="form-control" type="file" id="imgFile" name="imgFile" />
                        </div>
                        <div class="inputCont">
                            <label for="memId">
								아이디
                                <span class="idChkMsg">
                                    <span class="badge bg-danger">아이디 사용불가</span>
                                </span>
                            </label>
                            <input class="form-control" type="text" id="memId" name="memId" autocomplete="off" value="${member.memId }" />
                        </div>
                        <div class="inputCont">
                            <label for="memPw">비밀번호</label>
                            <input class="form-control" type="password" id="memPw" name="memPw" autocomplete="off" value="${member.memPw }" />
                            <label for="memPwChk">
								비밀번호 확인
                                <span class="pwChkMsg">
                                    <span class="badge bg-danger">비밀번호 불일치</span>
                                </span>
                            </label>
                            <input class="form-control" type="password" id="memPwChk" name="memPwChk" autocomplete="off" value="${member.memPw }" />
                        </div>
                        <div class="inputCont">
                            <label for="memName">이름</label>
                            <input class="form-control" type="text" id="memName" name="memName" autocomplete="off" value="${member.memName }" />
                        </div>
                        <div class="inputCont inputNone">
                            <span class="genderTxt">성별</span>
                            <input type="radio" id="memGender1" name="memGender" value="M" checked <c:if test="${member.memGender eq 'M' }">checked</c:if> />
                            <label for="memGender1">남성</label>
                            <input type="radio" id="memGender2" name="memGender" value="F" <c:if test="${member.memGender eq 'F' }">checked</c:if> />
                            <label for="memGender2">여성</label>
                        </div>
                        <div class="inputCont">
                            <label for="memAgedate">생년월일</label>
                            <input class="form-control" type="date" id="memAgedate" name="memAgedate" autocomplete="off" value="${member.memAgedate }" />
                        </div>
                        <div class="inputCont">
                            <label for="memEmail">
								이메일
								<span class="emailChkMsg">
                                    <span class="badge bg-danger">이메일 사용불가</span>
                                </span>
                            </label>
                            <input class="form-control" type="text" id="memEmail" name="memEmail" autocomplete="off" value="${member.memEmail }" />
                        </div>
                        <div class="inputCont">
                            <label for="memPhone">핸드폰번호</label>
                            <input class="form-control" type="text" id="memPhone" name="memPhone" autocomplete="off" value="${member.memPhone }" />
                        </div>
                        <div class="inputCont">
                        	<label for="memPostcode">
								우편번호
                                <span class="badge bg-secondary postcodeBtn" style="cursor: pointer;" onclick="DaumPostcode()">우편번호 찾기</span>
                            </label>
                            <input class="form-control" type="text" id="memPostcode" name="memPostcode" autocomplete="off" value="${member.memPostcode }" />
                        </div>
                        <div class="inputCont">
                            <label for="memAddress1">기본주소</label>
                            <input class="form-control" type="text" id="memAddress1" name="memAddress1" autocomplete="off" value="${member.memAddress1 }" />
                        </div>
                        <div class="inputCont">
                            <label for="memAddress2">상세주소</label>
                            <input class="form-control" type="text" id="memAddress2" name="memAddress2" autocomplete="off" value="${member.memAddress2 }" />
                        </div>
                        <div class="inputCont inputNone">
                            <input type="checkbox" id="memAgree" name="memAgree" value="Y" />
                            <label for="memAgree">개인정보처리동의</label>
                        </div>
                        <div class="inputCont">
                            <button class="btn btn-primary" type="button" id="signBtn">회원가입</button>
                            <button class="btn btn-success loginPageGoBtn" type="button">로그인 페이지</button>
                        </div>
                    </form>
                </div>
            </article>
            <div class="bg_video">
                <div class="donttouch"></div>
                <iframe src="https://www.youtube.com/embed/3TD8hlH6iR8?autoplay=1&mute=1&controls=0&loop=1&playlist=3TD8hlH6iR8" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
            </div>
        </section>
        <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
        <script>

            $(function() {
                // 전역 변수
                var signCont = $("#signContainer>article");

                var memId = $("#memId");
                var memPw = $("#memPw");
                var memName = $("#memName");
                var memAgedate = $("#memAgedate");
                var memEmail = $("#memEmail");
                var memPhone = $("#memPhone");
                var memPostcode = $("#memPostcode");
                var memAddress1 = $("#memAddress1");
                var memAddress2 = $("#memAddress2");
                var signBtn = $("#signBtn");
                var signForm = $("#signForm");

                var postcodeBtn = $(".postcodeBtn");

                var imgFile = $("#imgFile");
                var profileImg = $("#profileImg");
                
                var memPwChk = $("#memPwChk");

                // 전역 함수
                $.loginPageGoFn();
                $.fileChangeEvent();
                $.findMouseOverEvent(signCont);
                $.findMouseOutEvent(signCont);

                // 이미지 미리보기 함수
                $.imgPreviewFn(imgFile, profileImg);
                
                // KISS - Keep it small and simple
                // 아이디중복체크여부
                var idChkFlag = false;
                var idObj = {
                	el: memId,
                	msgEl: ".idChkMsg",
                	msg: "아이디",
                	col: "memId",
                	url: "/login/idCheck.do"
                };
                $.matchKeyupEvent(idObj, function(result){
                	idChkFlag = result;
                });
                
             	// 비밀번호중복체크여부
                var pwChkFlag = false;
             	var pwObj = {
             		el1: memPw,
             		el2: memPwChk,
             		msgEl: ".pwChkMsg",
             		msg: "비밀번호"
             	};
             	$.inputValMismatchChkFn(pwObj, function(result){
                	pwChkFlag = result;
             	});
                
             	// 이메일중복체크여부
                var emailChkFlag = false;
                var emailObj = {
                   	el: memEmail,
                   	msgEl: ".emailChkMsg",
                   	msg: "이메일",
                   	col: "memEmail",
                   	url: "/login/emailCheck.do"
                };
                $.matchKeyupEvent(emailObj, function(result){
                	emailChkFlag = result;
                });

                // 정합성 체크 및 submit 함수
                signBtn.on("click", function(){

                    var agreeFlag = false; // 개인정보처리동의여부

                    var idFlag = $.falsyCheckFn(memId, "아이디");
                    if(!idFlag) return;
                    var pwFlag = $.falsyCheckFn(memPw, "비밀번호");
                    if(!pwFlag) return;
                    var nameFlag = $.falsyCheckFn(memName, "이름");
                    if(!nameFlag) return;
                    var ageDateFlag = $.falsyCheckFn(memAgedate, "생년월일");
                    if(!ageDateFlag) return;
                    var emailFlag = $.falsyCheckFn(memEmail, "이메일");
                    if(!emailFlag) return;
                    var phoneFlag = $.falsyCheckFn(memPhone, "핸드폰번호");
                    if(!phoneFlag) return;
                    var postcodeFlag = $.falsyCheckFn(memPostcode, "우편번호");
                    if(!postcodeFlag) return;
                    var add1Flag = $.falsyCheckFn(memAddress1, "주소");
                    if(!add1Flag) return;
                    var add2Flag = $.falsyCheckFn(memAddress2, "상세주소");
                    if(!add2Flag) return;

                    // 개인정보처리동의
                    var memAgree = $("#memAgree:checked").val();
                    if(memAgree == "Y") {
                        agreeFlag = true;
                    }
                    
                    console.log("아이디 중복 여부", idChkFlag);
                    console.log("비밀번호 중복 여부", pwChkFlag);
                    console.log("이메일 중복 여부", emailChkFlag);

                    if(agreeFlag) {
                        if(idChkFlag) {
                            if(pwChkFlag) {
                            	if(emailChkFlag) {
	                                signForm.submit();
                            	}else {
                            		alert("이메일 중복체크를 해주세요.");
                            	}
                            }else {
                                alert("비밀번호 중복체크를 해주세요.");
                            }
                        }else {
                            alert("아이디 중복체크를 해주세요.");
                        }
                    }else {
                        alert("개인정보 동의를 체크해 주세요.");
                    }

                });

                // 종횡비 함수
                var profileBox = $(".profileContents>div");
                var profileImg = $(".profileContents img")
                $.ratioBoxH(profileBox, profileImg);
            });

        </script>
    </body>
</html>
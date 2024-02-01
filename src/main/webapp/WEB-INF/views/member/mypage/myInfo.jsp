<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
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
				내 정보
            </div>
            <div class="tabbtn">
				신고내역
            </div>
            <div class="tabbtn">
				좋아요내역
            </div>
            <div class="tabbtn">
				알림내역
            </div>
            <c:if test="${sessionInfo.memCategory ne '03' }">
	            <div class="tabbtn">
					회원탈퇴
	            </div>
            </c:if>
        </div>
        <div class="myPageTabcontBox">
            <div class="tabcont">
               <!-- 내 정보 -->
                <div class="myInfoContents">
                    <div class="myInfoContLefts">
                        <div class="myInfoImgBox">
                            <img src="${sessionInfo.memProfileimg }" alt="프로필 이미지" />
                        </div>
                        <label>
                            <span>아이디</span>
                            <input class="form-control memId" type="text" readonly value="${sessionInfo.memId }" />
                        </label>
                        <label>
                            <span>이름</span>
                            <input class="form-control memName" type="text" readonly value="${sessionInfo.memName }" />
                        </label>
                        <label>
                            <span>성별</span>
                            <c:if test="${sessionInfo.memGender eq 'M' }">
	                            <input class="form-control memGender" type="text" readonly value="남자" />
                            </c:if>
                            <c:if test="${sessionInfo.memGender eq 'F' }">
	                            <input class="form-control memGender" type="text" readonly value="여자" />
                            </c:if>
                        </label>
                        <label>
                            <span>생년월일</span>
                            <fmt:parseDate var="parseData" value="${sessionInfo.memAgedate }" pattern="yyyy-MM-dd" />
                            <input class="form-control memAgedate" type="text" readonly value="<fmt:formatDate value="${parseData }" pattern="yyyy년 MM월 dd일"/>" />
                        </label>
                        <label>
                            <span>이메일</span>
                            <input class="form-control memEmail" type="text" readonly value="${sessionInfo.memEmail }" />
                        </label>
                        <label>
                            <span>핸드폰번호</span>
                            <input class="form-control memPhone" type="text" readonly value="${sessionInfo.memPhone }" />
                        </label>
                        <label>
                            <span>우편번호</span>
                            <input class="form-control memPostcode" type="text" readonly value="${sessionInfo.memPostcode }" />
                        </label>
                        <label>
                            <span>기본주소</span>
                            <input class="form-control memAddress1" type="text" readonly value="${sessionInfo.memAddress1 }" />
                        </label>
                        <label>
                            <span>상세주소</span>
                            <input class="form-control memAddress2" type="text" readonly value="${sessionInfo.memAddress2 }" />
                        </label>
                    </div>
                    <div class="myInfoContRights">
                        <div class="updBlockLayer">
                            <button id="updBlockBtn" type="button" class="btn btn-warning">회원정보수정 활성화</button>
                        </div>
                        <form id="myinfoupdForm" name="myinfoupdForm" action="/mypage/myinfoupd.do" method="post" enctype="multipart/form-data">
                            <div style="position: relative;">
                                <div class="myInfoImgBox">
                                    <img id="profileImg" src="${contextPath }/resources/images/default_profile.png" alt="프로필 이미지" />
                                </div>
                                <div class="profileIcon">
                                    <i class="fas fa-camera"></i>
                                </div>
                            </div>
                            <label style="display: none;">
                                <span>프로필 사진</span>
                                <input class="form-control" type="file" id="imgFile" name="imgFile" />
                            </label>
                            <label>
                                <span>아이디</span>
                                <input class="form-control" type="text" id="memId" name="memId" value="${sessionInfo.memId }" readonly />
                            </label>
                            <label>
                                <span>비밀번호</span>
                                <input class="form-control" type="password" id="memPw" name="memPw" value="" autocomplete="off" />
                            </label>
                            <label>
                                <span>이름</span>
                                <input class="form-control" type="text" id="memName" name="memName" value="${sessionInfo.memName }" autocomplete="off" />
                            </label>
                            <label>
                                <span class="nonBlock">성별</span>
                                <input type="radio" id="memGender1" name="memGender" value="M" <c:if test="${sessionInfo.memGender eq 'M' }">checked</c:if> />
                                <label for="memGender1">남성</label>
                                <input type="radio" id="memGender2" name="memGender" value="F" <c:if test="${sessionInfo.memGender eq 'F' }">checked</c:if> />
                                <label for="memGender2">여성</label>
                            </label>
                            <label>
                                <span>생년월일</span>
                                <input class="form-control" type="date" id="memAgedate" name="memAgedate" value="${sessionInfo.memAgedate }" autocomplete="off" />
                            </label>
                            <label>
                                <span>
									이메일
                                    <span class="emailChkMsg">
                                        <span class="badge bg-success">이메일 사용가능</span>
                                    </span>
                                </span>
                                <input class="form-control" id="memEmail" name="memEmail" type="text" value="${sessionInfo.memEmail }" autocomplete="off" />
                            </label>
                            <label>
                                <span>핸드폰번호</span>
                                <input class="form-control" id="memPhone" name="memPhone" type="text" value="${sessionInfo.memPhone }" autocomplete="off" />
                            </label>
                            <label>
                                <span>
									우편번호
                                    <span class="badge bg-secondary postcodeBtn" style="cursor: pointer;" onclick="DaumPostcode()">우편번호 찾기</span>
                                </span>
                                <input class="form-control" type="text" id="memPostcode" name="memPostcode" autocomplete="off" value="${sessionInfo.memPostcode }" />
                            </label>
                            <label>
                                <span>기본주소</span>
                                <input class="form-control" type="text" id="memAddress1" name="memAddress1" autocomplete="off" value="${sessionInfo.memAddress1 }" />
                            </label>
                            <label>
                                <span>상세주소</span>
                                <input class="form-control" type="text" id="memAddress2" name="memAddress2" autocomplete="off" value="${sessionInfo.memAddress2 }" />
                            </label>
                            <div style="text-align: right;">
                                <button type="button" class="btn btn-primary myInfoUpdBtn">회원정보수정</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <div class="tabcont">
                <!-- 신고내역 -->
				신고내역
            </div>
            <div class="tabcont">
                <!-- 좋아요내역 -->
				좋아요내역
            </div>
            <div class="tabcont">
                <!-- 알림내역 -->
				알림내역
            </div>
            <c:if test="${sessionInfo.memCategory ne '03' }">
	            <div class="tabcont">
	                <!-- 회원탈퇴 -->
					<div class="memResign">
	                    <div>
	                        <div>
	                            <h1>회원탈퇴</h1>
	                        </div>
	                        <div>
	                            <h2>회원을 탈퇴하시겠습니까?</h2>
	                            <p>
									회원탈퇴 시 개인정보 및 여기갈래에서 만들어진 모든 데이터는 삭제됩니다.
	                                <br />
	                                (단, 아래 항목은 표기된 법률에 따라 특정 기간 동안 보관됩니다.)
	                            </p>
	                            <article>
	                                <ol>
	                                    <li>
											계약 또는 청약철회 등에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존 기간 : 5년
	                                    </li>
	                                    <li>
											대금결제 및 재화 등의 공급에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 / 보존 기간 : 5년
	                                    </li>
	                                    <li>
											전자금융 거래에 관한 기록 보존 이유 : 전자금융거래법 보존 기간 / 보존 기간 : 5년
	                                    </li>
	                                    <li>
											소비자의 불만 또는 분쟁처리에 관한 기록 보존 이유 : 전자상거래 등에서의 소비자보호에 관한 법률 보존 기간 / 보존 기간 : 3년
	                                    </li>
	                                    <li>
											신용정보의 수집/처리 및 이용 등에 관한 기록 보존 이유 : 신용정보의 이용 및 보호에 관한 법률 보존 기간 / 보존 기간 : 3년
	                                    </li>
	                                    <li>
											전자(세금)계산서 시스템 구축 운영하는 사업가가 지켜야 할 사항 고시(국세청 고시 제 2016-3호)(전자세금계산서 사용자에 한함) / 보존 기간 5년
	                                        <br />
	                                        (단, (세금)계산서 내 개인식별번호는 3년 경과 후 파기)
	                                    </li>
	                                </ol>
	                            </article>
	                        </div>
	                        <div>
	                            <h2>유의사항</h2>
	                            <article>
	                                <ul>
	                                    <li>
											회원탈퇴 처리 후에는 회원님의 개인정보를 복원할 수 없으며, 회원탈퇴 진행 시 해당 아이디는 영구적으로 삭제되어 재가입이 불가능합니다.
	                                    </li>
	                                    <li>
											탈퇴한 아이디가 존재할 경우, "탈퇴" 회원으로 조회됩니다.
	                                    </li>
	                                    <li>
											탈퇴한 아이디가 여기갈래 내에 존재하는 경우, 회사에 귀속된 데이터에 대해서는 보관됩니다.
	                                    </li>
	                                </ul>
	                            </article>
	                            <div>
	                                <input id="memRemove" name="memRemove" type="checkbox" />
	                                <label for="memRemove">해당 내용을 모두 확인했으며, 회원 탈퇴에 동의합니다.</label>
	                            </div>
	                        </div>
	                        <div>
	                            <button id="goToHome" type="button">홈으로</button>
	                            <button id="memExit" type="button">탈퇴하기</button>
	                        </div>
	                    </div>
	                </div>
	            </div>
            </c:if>
        </div>
    </article>
</section>

<!-- 마이 페이지 js -->
<script src="${contextPath }/resources/js/mypage.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
$(function(){
    var myInfoUpdBtn = $(".myInfoUpdBtn");
    var myinfoupdForm = $("#myinfoupdForm");
    
    var imgFile = $("#imgFile");
    var profileImg = $("#profileImg");

    var memPw = $("#memPw");
    var memName = $("#memName");
    var memAgedate = $("#memAgedate");
    var memEmail = $("#memEmail");
    var memPhone = $("#memPhone");
    var memPostcode = $("#memPostcode");
    var memAddress1 = $("#memAddress1");
    var memAddress2 = $("#memAddress2");
    
    // 공통 함수
    $.lnbHequalContHFn();
    $.myPageTabbtnFn();
    $.profileImgClickTriggerFn();
    $.myInfoActivationFn();
    
    // 이미지 미리보기 함수
    $.imgPreviewFn(imgFile, profileImg);
    
    // 이메일 중복체크 여부
    var emailChkFlag = true;
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
    
    // 회원 정보 수정 validation 체크
    myInfoUpdBtn.click(function(){
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
    	
    	if(emailChkFlag) {
	    	myinfoupdForm.submit();
    	}else {
    		alert("이메일 중복 체크를 해주세요.");
    	}
    });
    
	// 회원 탈퇴 함수
    var memExit = $("#memExit");
    memExit.click(function(){
    	var memRemove = $("#memRemove");
    	var memExitChkVal = memRemove.prop("checked");
    	if(memExitChkVal) { // 회원 탈퇴 동의
    		location.href = "/mypage/memDelete.do?memId=${sessionInfo.memId }";
    	}else { // 회원 탈퇴 거부
    		alert("회원 탈퇴에 동의해 주셔야 합니다.");
    	}
    });
    
    // 메인 페이지로 이동
    var goToHome = $("#goToHome");
    goToHome.click(function(){
    	location.href = "/index.do";
    });
    
    // 종횡비 함수
    var myInfoImgBox = $(".myInfoImgBox");
    var myInfoImg = $(".myInfoImgBox img");
    $.ratioBoxH(myInfoImgBox, myInfoImg);
});
</script>
// 공통 함수
// 마우스 오버/아웃 이벤트
$.findMouseOverEvent = function(cont){
    cont.mouseover(function(){
        donttouch.stop().fadeOut();
    });
};

$.findMouseOutEvent = function(cont){
    cont.mouseout(function(){
        donttouch.stop().fadeIn();
    });
};

// 로그인 화면 페이지 함수
var logCont = $("#loginContainer>article");
var comp_fir = $(".stylecomp_firstbar");
var comp_sec = $(".stylecomp_secondbar");
var donttouch = $(".donttouch");

$.loginMouseOverEvent = function(){
    logCont.mouseover(function(){
        comp_fir.css({
            transform : "translate(-50%, -80%) rotate(70deg)"
        });
        comp_sec.css({
            transform : "translate(-50%, -20%) rotate(70deg)"
        });
        donttouch.stop().fadeOut();
    });
};

$.loginMouseOutEvent = function(){
    logCont.mouseout(function(){
        comp_fir.css({
            transform : "translate(-50%, -50%) rotate(70deg)"
        });
        comp_sec.css({
            transform : "translate(-50%, -50%) rotate(70deg)"
        });
        donttouch.stop().fadeIn();
    });
};

$.enterKeyUpEvent = function(){
    $(window).keyup(function(e){
        //console.log(e.keyCode);
        // enter키 : 13
        if(e.keyCode == 13) {
            $("#loginBtn").trigger("click");
        }
    });
};

// 아이디/비밀번호 찾기 페이지 함수
var loginPageGoBtn = $(".loginPageGoBtn");

var profileIcon = $(".profileIcon");
var imgFile = $("#imgFile");

$.loginPageGoFn = function(){
    loginPageGoBtn.click(function(){
        location.href = "/login/signin.do";
    });
};

// 회원가입 페이지 함수
$.fileChangeEvent = function(){
    profileIcon.click(function(){
        imgFile.trigger("click");
        imgFile.change(function() {
            console.log("Selected file: " + this.files[0].name); // 이슈 확인
        });
    });
};

// 아이디, 비밀번호 찾기 함수
// 객체 비구조화 할당 사용
$.findChkFn = function(findOutObj, {url, msgEl, msg}){
	console.log(findOutObj);
	$.ajax({
        type: "post",
        url: url,
        data: JSON.stringify(findOutObj),
        contentType: "application/json;charset=utf-8",
        success: function(res){
        	console.log("결과 : " + res);
            if(!res) {
                $(msgEl).html("회원님의 "+msg+" 정보를 찾을 수 없습니다.");
            }else {
                if(msg == "아이디"){
                    var id = res.memId;
                    $(msgEl).html("회원님의 "+msg+"는 [<span class='searchTxt'>"+id+"</span>] 입니다.");
                }else if(msg == "비밀번호"){
                    //var pw = res.memPw;
                    //$(msgEl).html("회원님의 "+msg+"는 [<span class='searchTxt'>"+pw+"</span>] 입니다.");
                    $(msgEl).html("회원님의 "+msg+"를 재설정합니다.");
                    
                    // 비밀번호 재설정 팝업창
                    var modalHtmlTxt = `
                    <div class="modal fade" id="chgPwModal">
                        <div class="modal-dialog modal-dialog-centered modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h4 class="modal-title">비밀번호 재설정</h4>
                                </div>
                                <div class="modal-body">
                                    <div>
                                        <p>새로 등록할 비밀번호를 입력해 주세요.</p>
                                        <div class="chgPwChkBadge">
                                            <span class="badge bg-danger">비밀번호 불일치</span>
                                        </div>
                                    </div>
                                    <form action="/login/changePw.do" method="post" id="chgPwForm" name="chgPwForm">
                                        <input type="hidden" id="memId2" name="memId" />
                                        <div>
                                            <label for="memPw">비밀번호 입력</label>
                                            <input style="margin-bottom: 0px;" class="form-control" type="password" id="memPw" name="memPw" placeholder="새로 변경할 비밀번호 입력" />
                                        </div>
                                        <div>
                                            <label for="memPwChk">비밀번호 확인</label>
                                            <input class="form-control" type="password" id="memPwChk" name="memPwChk" placeholder="새로 변경할 비밀번호 입력" />
                                        </div>
                                        <button class="btn btn-primary" type="button" id="chgPwBtn">비밀번호 재설정</button>
                                    </form>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    `;

					$("#chgPwModal").remove();

                    $("body").append(modalHtmlTxt);

                    var chgPwModal = new bootstrap.Modal(document.getElementById('chgPwModal'));
                    chgPwModal.show();
                    
                    // 회원 아이디 보내기
                    var memIdVal = $("#memId");
                    var chgMemid = $("#memId2");
                    chgMemid.val(memIdVal.val());
                    
                    // 비밀번호 재설정 > 비밀번호 확인 메서드
                    var memPw = $("#memPw");
                    var memPwChk = $("#memPwChk");
                    
	                var pwChkFlag = false;
	             	var pwObj = {
	             		el1: memPw,
	             		el2: memPwChk,
	             		msgEl: ".chgPwChkBadge",
	             		msg: "비밀번호"
	             	};

	             	$.inputValMismatchChkFn(pwObj, function(result){
	                	pwChkFlag = result;
	             	});

                    var chgPwForm = $("#chgPwForm");
					var chgPwBtn = $("#chgPwBtn");
					chgPwBtn.click(function(){
	                    if(pwChkFlag) {
	                        chgPwForm.submit();
	                    }else {
	                        //alert("비밀번호가 일치하는지 확인해주세요.");
	                        Swal.fire({
					            title: "안내",
					            text: "비밀번호가 일치하는지 확인해주세요.",
					            icon: "info"
					        });
	                    }
					});
                }
            }
        }
    });
};

// 쓸데없이 하는 거에 비해서 복잡, 매개변수는 많으면 {} 처리 -> 넹 센세...
// 객체 비구조화 할당 사용
$.matchKeyupEvent = function({el, msgEl, msg, col, url}, callback){
    el.keyup(function(){
        var valTxt = $(this).val();
        //console.log("valTxt : ",valTxt);
        if(!valTxt) {
        	$(msgEl).html("<span class='badge bg-danger'>"+msg+" 사용불가</span>");
        	callback(false);
        }else {
            var data = {
                [col] : valTxt
            };
            //console.log("data : ", data);
            $.ajax({
                type: "post",
                url: url,
                data: JSON.stringify(data),
                contentType: "application/json;charset=utf-8",
                success: function(res){
                    if(res === "NOTEXIST") {
                        $(msgEl).html("<span class='badge bg-success'>"+msg+" 사용가능</span>");
                        callback(true);
                    }else {
                        $(msgEl).html("<span class='badge bg-danger'>"+msg+" 사용불가</span>");
                        callback(false);
                    }
                }
            });
        }
    });
};

// 두 input 사이 간의 값 비교
$.inputValMismatchChkFn = function({el1, el2, msgEl, msg}, callback){
	el1.keyup(function(){
        var el1Val = el1.val();
        var el2Val = el2.val();
        if(!el1Val){
        	$(msgEl).html("<span class='badge bg-danger'>"+msg+" 불일치</span>");
	        callback(false);
        }else {
	        if(el1Val === el2Val){
	            $(msgEl).html("<span class='badge bg-success'>"+msg+" 일치</span>");
	            callback(true);
	        }else {
	            $(msgEl).html("<span class='badge bg-danger'>"+msg+" 불일치</span>");
	            callback(false);
	        }
        }
    });
	el2.keyup(function(){
        var el1Val = el1.val();
        var el2Val = el2.val();
        if(!el2Val){
        	$(msgEl).html("<span class='badge bg-danger'>"+msg+" 불일치</span>");
	        callback(false);
        }else {
	        if(el1Val === el2Val){
	            $(msgEl).html("<span class='badge bg-success'>"+msg+" 일치</span>");
	            callback(true);
	        }else {
	            $(msgEl).html("<span class='badge bg-danger'>"+msg+" 불일치</span>");
	            callback(false);
	        }
        }
    });
};

// 관리자, 테스트 계정 버튼 기능
$.testAccountFn = function(){
	var testBtnShow = $(".testBtnShow");
	var testBtnGroup = $(".testBtnGroup");
	var loginBox = $(".loginBox");
	
	var token = false; // 현재 테스트 박스가 눈에 보이지 않는 상태
	testBtnShow.click(function(){
		if(!token) { // 눈에 보이게 한다!
			loginBox.css({
				paddingBottom: "0px"
			});
			testBtnGroup.show();
			token = true; // 눈에 보이는 상태임을 표시
		}else {
			loginBox.css({
				paddingBottom: "30px"
			});
			testBtnGroup.hide();
			token = false; // 눈에 보이지 않는 상태임을 표시
		}
	});
	
	var loginIdEl = $("#loginForm #memId");
	var loginPwEl = $("#loginForm #memPw");
	var loginBtn = $("#loginBtn")
	
	var adminAccount = $("#adminAccount");
	var lgjAccount = $("#lgjAccount");
	var iuAccount = $("#iuAccount");
	var wonAccount = $("#wonAccount");
	var haAccount = $("#haAccount");
	var kiAccount = $("#kiAccount");
	
	// 관리자 계정 로그인 처리 함수
	adminAccount.click(function(){
		var adminId = "admin";
		var adminPw = "admin1234";
		loginIdEl.val(adminId);
		loginPwEl.val(adminPw);
		loginBtn.trigger("click");
	});
	
	// 테스트 계정 로그인 처리 함수
	lgjAccount.click(function(){
		var testId = "chantest1";
		var testPw = "1234";
		loginIdEl.val(testId);
		loginPwEl.val(testPw);
		loginBtn.trigger("click");
	});
	
	// 아이유 계정 로그인 처리 함수
	iuAccount.click(function(){
		var testId = "iuforever9802";
		var testPw = "dkdldb9802";
		loginIdEl.val(testId);
		loginPwEl.val(testPw);
		loginBtn.trigger("click");
	});
	
	// 장원영 계정 로그인 처리 함수
	wonAccount.click(function(){
		var testId = "wonyoung0408";
		var testPw = "dnjsdud0408";
		loginIdEl.val(testId);
		loginPwEl.val(testPw);
		loginBtn.trigger("click");
	});
	
	// 하루토 계정 로그인 처리 함수
	haAccount.click(function(){
		var testId = "haru0404";
		var testPw = "gkfnxh0404";
		loginIdEl.val(testId);
		loginPwEl.val(testPw);
		loginBtn.trigger("click");
	});
	
	// 키이오 계정 로그인 처리 함수
	kiAccount.click(function(){
		var testId = "kio0411";
		var testPw = "zldh0411";
		loginIdEl.val(testId);
		loginPwEl.val(testPw);
		loginBtn.trigger("click");
	});
};

// daum 주소 API(주소 찾기)
function DaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('memPostcode').value = data.zonecode;
            document.getElementById("memAddress1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("memAddress2").focus();
        }
    }).open();
};

// 윈도우 가로 길이 변경 이벤트
$(window).resize(function(){
    //console.log("화면길이 조정중이유");
    var winW = $(this).outerWidth();
    
    // 로그인 페이지 컴포넌트 스타일 초기화
    comp_fir.removeAttr("style");
    comp_sec.removeAttr("style");
    
    // 아이디/비밀번호 찾기 버튼 크기 조정
    var findContentsBtns = $(".findContents button");
    if(winW > 630) {
        findContentsBtns.removeClass("btn-sm");
    }else {
        findContentsBtns.addClass("btn-sm");
    }
    
    // 종횡비 함수
    var profileBox = $(".profileContents>div");
    var profileImg = $(".profileContents img");
    $.ratioBoxH(profileBox, profileImg);
});
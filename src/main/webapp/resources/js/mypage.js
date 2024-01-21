// 높이 조절 함수
$.lnbHequalContHFn = function(){
    var myPageLnbContents = $(".myPageLnbContents");
    var mypageContainer = $(".mypageContainer");
    
    mypageContainer.outerHeight("auto");
    myPageLnbContents.outerHeight("auto");
    
    var myPageLnbContentsH = myPageLnbContents.outerHeight();
    console.log("myPageLnbContentsH : " + myPageLnbContentsH);
    var mypageContainerH = mypageContainer.outerHeight();
    console.log("mypageContainerH : " + mypageContainerH);
    
    if(myPageLnbContentsH > mypageContainerH) {
        mypageContainer.outerHeight(myPageLnbContentsH);
    }else if(myPageLnbContentsH < mypageContainerH) {
        myPageLnbContents.outerHeight(mypageContainerH);
    }
};

// 탭 버튼 함수
$.myPageTabbtnFn = function(){
    var myPageTabbtn = $(".myPageTabbtnGroup .tabbtn");
    var myPageTabcontBox = $(".myPageTabcontBox .tabcont");
    myPageTabbtn.click(function(){
        var thisIs = $(this);
        myPageTabbtn.removeClass("tactive");
        thisIs.addClass("tactive");
        var idx = thisIs.index();
        myPageTabcontBox.hide();
        myPageTabcontBox.eq(idx).show();
        $.lnbHequalContHFn();
    });
};

// 이미지 업로드 트리거 함수
$.profileImgClickTriggerFn = function(){
    var profileIcon = $(".profileIcon");
    profileIcon.click(function(){
        $("#imgFile").trigger("click");
    });
};

// 회원정보수정 활성화 함수
$.myInfoActivationFn = function(){
    var updBlockBtn = $("#updBlockBtn");
    updBlockBtn.click(function(){
        $(".updBlockLayer").hide();
    });
};

// 이메일 검증 함수
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
            document.getElementById("memPostcode").value = data.zonecode;
            document.getElementById("memAddress1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("memAddress2").focus();
        }
    }).open();
}
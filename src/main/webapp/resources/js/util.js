// 공통 함수

// falsy한 값들 체크
$.falsyCheckFn = function(value, msg){
    var value = value.val();
    if(!value) {
        //alert(msg + "을(를) 입력해주세요.");
    	Swal.fire({
            title: "안내",
            text: msg + "을(를) 입력해주세요.",
            icon: "info"
        });        
        return false;
    }
    return true;
};

// falsy한 값들 체크2
$.showWarningPopupFn = function(title, message) {
    Swal.fire({
        title: title,
        text: message,
        icon: "info"
    });
}

// 이미지 종횡비 계산 기능
$.ratioBoxH = function(boxEl, imgEl) {
    var boxSel = $(boxEl);
    var boxW = boxSel.width();
    var boxH = boxSel.height();
    var boxRatio = boxH / boxW;

    var imgSel = $(imgEl);
    
    var setImgDimensions = function() {
        var imgW = imgSel.width();
        var imgH = imgSel.height();
        var imgRatio = imgH / imgW;

        if (boxRatio < imgRatio) {
            //console.log("boxW :", boxW);
            imgSel.width(boxW).height("auto");
        } else {
            //console.log("boxH :", boxH);
            imgSel.height(boxH).width("auto");
        }
    };

    // 이미지의 로드 이벤트 핸들러 등록
    imgSel.on("load", setImgDimensions);

    // 초기 설정
    setImgDimensions();
};

// 이미지 미리보기 함수
$.imgPreviewFn = function(imgEl, profileImg){
    imgEl.on("change", function(e){
        var file = event.target.files[0];

        if(isImageFile(file)) {
            var reader = new FileReader();
            reader.onload = function(e){
                profileImg.attr("src", e.target.result);
            }
            reader.readAsDataURL(file);
        }else { // 이미지 파일이 아닐 때
            //alert("이미지 파일을 선택해주세요!");
            Swal.fire({
				title: "안내",
				text: "이미지 파일을 선택해주세요!",
				icon: "info"
			});
            imgEl.val("");
        }
        
        console.log(imgEl.val());
    });
};

// 이미지 파일인지 체크
function isImageFile(file){
    var ext = file.name.split(".").pop().toLowerCase(); // 파일명에서 확장자를 가져옵니다.
    return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;
}

$.dateFickerNorFn = function(dateElement, callback){
    flatpickr(dateElement, {
      dateFormat: "Y-m-d",
      enableTime: false,
      minDate: "today",
      defaultDate: "today",
      locale: "ko",
    });
};

// 로그인/로그아웃 감지 웹소켓 기능
$.loginDetectWebSocketFn = function(memId){
	var loginDetectWebSocket; // 페이지가 바뀌지 않도록 주의!

	var loginEndpoint = "/logindetect";

	// 공통 함수 선언
	function loginConnect(){
		loginDetectWebSocket = new SockJS(loginEndpoint); // 엔드 포인트
		
		loginDetectWebSocket.onopen = function(event) {
			console.log("WebSocket connection opened:", event);
			loginDetectWebSocket.send("로그인/로그아웃 감지 웹 소켓 시작");
		};
		
		loginDetectWebSocket.onmessage = function(event) {
			console.log("WebSocket message received:", event.data);
			loginDetectMessage(event);
		};
		
		loginDetectWebSocket.onclose = function(event) {
			console.log("WebSocket connection closed:", event);
		};
		
		loginDetectWebSocket.onerror = function(event) {
			console.error("WebSocket error:", event);
		};
	}

	function loginDetectMessage(event){
		var loginData = event.data;
		console.log("loginData : ", loginData);
		
        // 텍스트로 넘겨진 로그인한 아이디 값을 배열로 바꿈
        var realTimeLoginUsersId = JSON.parse(loginData);
        console.log("realTimeLoginUsersId : ", realTimeLoginUsersId);
		
        // 여기서 로그인을 감지하는 로직 추가
        // 예를 들어, 서버로부터 특정 신호를 받아와서 로그인을 판단할 수 있음
        if (realTimeLoginUsersId.indexOf(memId) !== -1) {
            console.log("로그인 감지됨");
            // 여기서 로그인 처리를 수행

            // 1. 신청 멤버 로그인 처리
            $(".waitMemList li:not(:first-of-type)").each(function(i, v){
                console.log(`${i}번째 배열 : `, v);
                var thisIs = $(this);
                var detectMemId = thisIs.find(".detectMemId").text();
                console.log("detectMemId : ", detectMemId);
                
                if (realTimeLoginUsersId.indexOf(detectMemId) !== -1) {
			        // 여기서 로그인 처리를 수행
			        // 추가적인 처리를 여기에 추가하세요
			        console.log("로그인된 사용자 감지!");
			        thisIs.find(".fa-circle").css("color", "green");
                    thisIs.find(".loginAlert").remove();
                    thisIs.find(".logoutAlert").remove();
                    thisIs.find(".appendStatus").append(`<i style="font-style: normal; margin-left: 5px;" class="badge bg-success loginAlert">로그인</i>`);
			    }
            });
        }
        
        // 여기서 로그아웃을 감지하는 로직 추가
        // 예를 들어, 서버로부터 특정 신호를 받아와서 로그아웃을 판단할 수 있음
        if (realTimeLoginUsersId.indexOf(memId) !== -1) {
            console.log("로그아웃 감지됨");
            // 여기서 로그아웃 처리를 수행

            // 1. 신청 멤버 로그아웃 처리
            $(".waitMemList li:not(:first-of-type)").each(function(i, v){
                console.log(`${i}번째 배열 : `, v);
                var thisIs = $(this);
                var detectMemId = thisIs.find(".detectMemId").text();

                if (realTimeLoginUsersId.indexOf(detectMemId) === -1) {
                    // 여기서 로그아웃 처리를 수행
                    // 추가적인 처리를 여기에 추가하세요
                    console.log("로그아웃된 사용자 감지!");
                    thisIs.find(".fa-circle").css("color", "red");
                    thisIs.find(".loginAlert").remove();
                    thisIs.find(".logoutAlert").remove();
                    thisIs.find(".appendStatus").append(`<i style="font-style: normal; margin-left: 5px;" class="badge bg-danger logoutAlert">로그아웃</i>`);
                }
            });
        }

	}

	// 연결
	loginConnect();

};

// 채팅방 접속/미접속 감지 웹소켓 기능
$.chatInOutDetectWebSocketFn = function(memId){
	var chatInOutDetectWebSocket; // 페이지가 바뀌지 않도록 주의!

	var chatInOutEndpoint = "/chatinoutdetect";

	// 공통 함수 선언
	function chatInOutConnect(){
		chatInOutDetectWebSocket = new SockJS(chatInOutEndpoint); // 엔드 포인트
		
		chatInOutDetectWebSocket.onopen = function(event) {
			console.log("WebSocket connection opened:", event);
			chatInOutDetectWebSocket.send("채팅방 접속/미접속 감지 웹 소켓 시작");
		};
		
		chatInOutDetectWebSocket.onmessage = function(event) {
			console.log("WebSocket message received:", event.data);
			chatInOutDetectMessage(event);
		};
		
		chatInOutDetectWebSocket.onclose = function(event) {
			console.log("WebSocket connection closed:", event);
		};
		
		chatInOutDetectWebSocket.onerror = function(event) {
			console.error("WebSocket error:", event);
		};
	}

	function chatInOutDetectMessage(event){
		var chatInOutData = event.data;
		console.log("chatInOutData : ", chatInOutData);
		
        // 텍스트로 넘겨진 로그인한 아이디 값을 배열로 바꿈
        var realTimechatInOutUsersId = JSON.parse(chatInOutData);
        console.log("realTimechatInOutUsersId : ", realTimechatInOutUsersId);
		
        // 여기서 접속 감지하는 로직 추가
        // 예를 들어, 서버로부터 특정 신호를 받아와서 접속 판단할 수 있음
        if (realTimechatInOutUsersId.indexOf(memId) !== -1) {
            console.log("접속 감지됨");
            // 여기서 접속 처리를 수행

            // 1. 현재 멤버 접속 처리
            $(".currentMemList li:not(:first-of-type)").each(function(i, v){
                console.log(`${i}번째 배열 : `, v);
                var thisIs = $(this);
                var detectMemId = thisIs.find(".detectMemId").text();
                console.log("detectMemId : ", detectMemId);
                
                if (realTimechatInOutUsersId.indexOf(detectMemId) !== -1) {
			        // 여기서 접속 처리를 수행
			        // 추가적인 처리를 여기에 추가하세요
			        console.log("접속 사용자 감지!");
			        thisIs.find(".fa-circle").css("color", "green");
                    thisIs.find(".loginAlert").remove();
                    thisIs.find(".logoutAlert").remove();
                    thisIs.find(".appendStatus").append(`<i style="font-style: normal; margin-left: 5px;" class="badge bg-success loginAlert">접속</i>`);
			    }
            });
        }
        
        // 여기서 미접속 감지하는 로직 추가
        // 예를 들어, 서버로부터 특정 신호를 받아와서 미접속 판단할 수 있음
        if (realTimechatInOutUsersId.indexOf(memId) !== -1) {
            console.log("미접속 감지됨");
            // 여기서 미접속 처리를 수행

            // 1. 현재 멤버 미접속 처리
            $(".currentMemList li:not(:first-of-type)").each(function(i, v){
                console.log(`${i}번째 배열 : `, v);
                var thisIs = $(this);
                var detectMemId = thisIs.find(".detectMemId").text();

                if (realTimechatInOutUsersId.indexOf(detectMemId) === -1) {
                    // 여기서 미접속 처리를 수행
                    // 추가적인 처리를 여기에 추가하세요
                    console.log("미접속 사용자 감지!");
                    thisIs.find(".fa-circle").css("color", "red");
                    thisIs.find(".loginAlert").remove();
                    thisIs.find(".logoutAlert").remove();
                    thisIs.find(".appendStatus").append(`<i style="font-style: normal; margin-left: 5px;" class="badge bg-danger logoutAlert">미접속</i>`);
                }
            });
        }

	}

	// 연결
	chatInOutConnect();

};

// 실시간 알림 웹소켓 기능
$.realTimeAlertWebSocketFn = function(rtAlert, dbSaveFlag, userImgSrc, realrecNo){

	var realTimeAlertWebSocket; // 페이지가 바뀌지 않도록 주의!
	var realTimeAlertEndpoint = "/alert";
	console.log("realTimeAlertWebSocketFn > rtAlert : ", rtAlert);

	// 공통 함수 선언
	function realTimeAlertConnect(){
		realTimeAlertWebSocket = new SockJS(realTimeAlertEndpoint); // 엔드 포인트
		
		realTimeAlertWebSocket.onopen = function(event) {
			console.log("WebSocket connection opened:", event);
			realTimeAlertWebSocket.send("실시간 알림 웹 소켓 시작"); // 기존 chatOpen 함수와 합침
			
            // 소켓 타기 전에 멤버 리스트를 제외한 메시지 1건만 정제
            var rtAlertTxt = {
                "realsenId": rtAlert.realsenId,
                "realsenName": rtAlert.realsenName,
                "realsenTitle": rtAlert.realsenTitle,
                "realsenContent": rtAlert.realsenContent,
                "realsenType": rtAlert.realsenType,
                "realsenReadyn": rtAlert.realsenReadyn,
                "realsenUrl": rtAlert.realsenUrl,
                "realsenPfimg" : userImgSrc
            };

            if(realrecNo !== "empty") {
                console.log("realrecNo : ", realrecNo);
                rtAlertTxt.realrecNo = realrecNo;
            }

            console.log("rtAlertTxt : ", rtAlertTxt);

            if(dbSaveFlag == true) {
                console.log("db에 저장해용~ : ", dbSaveFlag);

                // 전체 멤버에게 실시간 알림 보내기 전에 저장
                $.ajaxAllMemberRtAlertSaveFn(rtAlert);
            }else {
                console.log("db에 저장하지 않아용~ : ", dbSaveFlag);

                // 메시지 1건을 소켓에 전송
                realTimeAlertSend(rtAlertTxt);
            }
		};
		
		realTimeAlertWebSocket.onmessage = function(event) {
			console.log("WebSocket message received:", event.data);
			realTimeAlertMessage(event); // event 매개변수를 loginDetectMessage 함수에 전달
		};
		
		realTimeAlertWebSocket.onclose = function(event) {
			console.log("WebSocket connection closed:", event);
		};
		
		realTimeAlertWebSocket.onerror = function(event) {
			console.error("WebSocket error:", event);
		};
	}

    // 실시간 알림시 실행되는 함수
    function realTimeAlertSend({realsenId, realsenName, realsenTitle, realsenContent, realsenType, realsenReadyn, realsenUrl, realsenPfimg, realrecNo}){
        console.log("realsenId : ", realsenId);
        console.log("realsenName : ", realsenName);
        console.log("realsenTitle : ", realsenTitle);
        console.log("realsenContent : ", realsenContent);
        console.log("realsenType : ", realsenType);
        console.log("realsenReadyn : ", realsenReadyn);
        console.log("realsenUrl : ", realsenUrl);
        console.log("realsenPfimg : ", realsenPfimg);
        if(realrecNo !== "empty") {
            console.log("realrecNo : ", realrecNo);
        }

        var realTimeAlertMsgTxt = `${realsenId}|${realsenName}|${realsenTitle}|${realsenContent}|${realsenType}|${realsenReadyn}|${realsenUrl}|${realsenPfimg}|${realrecNo}`;
        realTimeAlertWebSocket.send(realTimeAlertMsgTxt);
    }

	function realTimeAlertMessage(event){
		var realTimeAlertData = event.data;
		console.log("realTimeAlertData : ", realTimeAlertData);

        // 웹 소켓에서 브로드캐스팅된 text를 정제
        var rtArr = realTimeAlertData.split("|");
        console.log("rtArr : ", rtArr);

        var rtAlertBox = $(".rtAlertBox");

        // 구분자가 없는 경우 배열의 길이가 1이상이어야 함
        if(rtArr.length > 1) {
            var realsenId = rtArr[0].trim();
            var realsenName = rtArr[1].trim();
            var realsenTitle = rtArr[2].trim();
            var realsenContent = rtArr[3].trim();
            var realsenType = rtArr[4].trim();
            var realsenReadyn = rtArr[5].trim();
            var realsenUrl = rtArr[6].trim();
            var realsenPfImg = rtArr[7].trim();
            var realrecNo = rtArr[8].trim();

            var rtAlertBox = $(".rtAlertBox");
            rtAlertBox.find(".rtImgBox img").attr("src", realsenPfImg);
            rtAlertBox.find(".card-title").html(realsenTitle);
            rtAlertBox.find(".card-text").html(realsenContent);

            console.log("realsenUrl : ", realsenUrl);
            console.log("realsenUrl > empty ", realsenUrl !== "empty");

            console.log("realrecNo : ", realrecNo);
            console.log("realrecNo > empty : ", realrecNo !== "empty");

            if(realsenUrl !== "empty") {
                rtAlertBox.find(".rtAlertFadeBtn").remove();

                if(realrecNo !== "empty") {
                    rtAlertBox.find(".card-body").append(`
                        <div class="rtAlertFadeBtn" style="text-align: right;">
                            <a href="${realsenUrl}" class="btn btn-primary" data="${realrecNo}">바로가기</a>
                        </div>
                    `);
                }else {
                    rtAlertBox.find(".card-body").append(`
                        <div class="rtAlertFadeBtn" style="text-align: right;">
                            <a href="${realsenUrl}" class="btn btn-primary">바로가기</a>
                        </div>
                    `);
                }
            }

            rtAlertBox.fadeIn(1000, function() {
                setTimeout(function() {
                    rtAlertBox.fadeOut(1000);
                }, 2000);
            });
        }
        
	}

	// 연결
	realTimeAlertConnect();

};

// ajax > 멤버 id 리스트 가져오기
$.ajaxMembersIdListGetFn = function(callback){
    var realrecIdList = [];
	$.ajax({
		type : "get",
		url : "/membersIdGet.do",
		dataType : "json",
		success : function(res){
			//console.log("ajaxMembersIdListGetFn > res : ", res);
			for(var i=0; i<res.length; i++) {
                //console.log("memId : ", res[i].memId);
                realrecIdList.push(res[i].memId);
            }
            //console.log("realrecIdList ", realrecIdList);
            callback(realrecIdList);
		}
	});
};

// ajax > 모든 멤버에게 실시간 알림 내용을 DB에 저장, insert
$.ajaxAllMemberRtAlertSaveFn = function(rtAlert){

	//console.log("ajaxAllMemberRtAlertSaveFn > rtAlert : ", rtAlert);
	//console.log("rtAlert.realrecIdArr : ", rtAlert.realrecIdArr);

    var ajaxRtAlert = {
        "realrecIdArr": rtAlert.realrecIdArr,
        "realsenId": rtAlert.realsenId,
        "realsenName": rtAlert.realsenName,
        "realsenTitle": rtAlert.realsenTitle,
        "realsenContent": rtAlert.realsenContent,
        "realsenType": rtAlert.realsenType,
        "realsenReadyn": rtAlert.realsenReadyn,
        "realsenUrl": rtAlert.realsenUrl,
        "realsenPfimg": rtAlert.realsenPfimg
    };
    //console.log("ajaxRtAlert : ", ajaxRtAlert);
    
    $.ajax({
        type : "post",
        url : "/allMemberRtAlertSave.do",
        data : ajaxRtAlert,
        dataType : "text",
        success : function(res){
            console.log("ajaxAllMemberRtAlertSaveFn > res : ", res);
        }
    });

};

// ajax > 실시간 알림 메시지를 전역으로 가져와 뿌리자
$.ajaxRtSenderGetMsgFn = function(callback){
    $.ajax({
        type : "get",
        url : "/rtAlertGetMsg.do",
        dataType : "json",
        success : function(res){
            console.log("ajaxRtSenderGetMsgFn > res : ", res);
            callback(res);
        }
    });
};

// ajax > 로그인 알림 1번만 받고 바로 삭제하는 기능 구현
$.ajaxLoginRtAlertRemove = function(){
    $.ajax({
        type : "post",
        url: "/ajaxLoginRtAlertRemove.do",
        dataType: "json",
        success: function(res){
            console.log("res : ", res);
        }
    });
};

// 딸랑이 클릭하면 마이 페이지 > 알림 목록으로 이동하고, 모두 읽음 처리 하기
$.rtAlertClickInitFn = function(sessionMemid){
	console.log("sessionMemid : ", sessionMemid);
	var alarmIcon = $(".alarmIcon");
	alarmIcon.click(function(){
        $.ajax({
            type: "get",
            url: "/rtAlertClickInit.do",
            data: {memId : sessionMemid},
            contentType: "application/json",
            dataType: "text",
            success: function(res){
                console.log("res : ", res);
            }
        });
	
	    location.href = "/mypage/myinfo.do?submenu=2";
	});
};

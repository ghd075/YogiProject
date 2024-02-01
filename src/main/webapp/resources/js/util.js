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
            alert("이미지 파일을 선택해주세요!");
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
			loginDetectWebSocket.send("웹 소켓 시작");
			sendLoginSignal();
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
            $(".currentMemList li:not(:first-of-type)").each(function(i, v){
                console.log(`${i}번째 배열 : `, v);
                var thisIs = $(this);
                var detectMemId = thisIs.find(".detectMemId").text();
                console.log("detectMemId : ", detectMemId);
                
                if (realTimeLoginUsersId.indexOf(detectMemId) !== -1) {
			        // 여기서 로그인 처리를 수행
			        // 추가적인 처리를 여기에 추가하세요
			        console.log("찾았다 요놈!");
			        thisIs.find(".fa-circle").css("color", "green");
			    }
            });
        }
        
        // 여기서 로그아웃을 감지하는 로직 추가
        // 예를 들어, 서버로부터 특정 신호를 받아와서 로그아웃을 판단할 수 있음
        if (realTimeLoginUsersId.indexOf(memId) !== -1) {
            console.log("로그아웃 감지됨");
            // 여기서 로그아웃 처리를 수행
            $(".currentMemList li:not(:first-of-type)").each(function(i, v){
                console.log(`${i}번째 배열 : `, v);
                var thisIs = $(this);
                var detectMemId = thisIs.find(".detectMemId").text();

                if (realTimeLoginUsersId.indexOf(detectMemId) === -1) {
                    // 여기서 로그아웃 처리를 수행
                    // 추가적인 처리를 여기에 추가하세요
                    console.log("로그아웃된 사용자 감지!");
                    thisIs.find(".fa-circle").css("color", "red");
                }
            });
        }
	}

	function logOutDisconnect(){
		loginDetectWebSocket.send("웹 소켓 종료");
		loginDetectWebSocket.close();
	}
	
	// 클라이언트에서 로그인 이벤트가 발생했을 때 서버로 신호를 보냄
	function sendLoginSignal() {
	    var signalData = {
	        type: 'loginSignal',
	        // 여기에 필요한 다른 정보들을 추가할 수 있음
	    };
	
	    // WebSocket을 통해 서버로 데이터 전송
	    loginDetectWebSocket.send(JSON.stringify(signalData));
	}
	
	// 클라이언트에서 로그아웃 이벤트가 발생했을 때 서버로 신호를 보냄
	function sendLogoutSignal() {
	    var signalData = {
	        type: 'logoutSignal',
	        // 여기에 필요한 다른 정보들을 추가할 수 있음
	    };
	
	    // WebSocket을 통해 서버로 데이터 전송
	    loginDetectWebSocket.send(JSON.stringify(signalData));
	}
	
	// 로그아웃 버튼을 눌렀을 때 서버로 신호를 보내자
	$(".loginOutIcon").click(function(){
		sendLogoutSignal();
	});

	// 연결
	loginConnect();

};
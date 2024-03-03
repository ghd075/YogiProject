<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
    $(function(){
    	// 공통 변수
    	var sessionMemid = "${sessionInfo.memId}";
    	sessionMemid = sessionMemid.trim();
    	console.log("sessionMemid : ", sessionMemid);
    	
        // 공통 함수
        $.mLnbClickEvent();
        $.footerRelatedSiteFn();
        $.mmainClickEvent700();
        
     	// 로그인/로그아웃 감지 기능
        $.loginDetectWebSocketFn(sessionMemid);
        
     	// 실시간 알림 기능 > 전역으로 실시간 알림 뿌리기
     	// 1. 먼저 ajax로 실시간 알림 메시지를 가져온다.
     	$.ajaxRtSenderGetMsgFn(function(result){
     		console.log("result : ", result);
     		
     		// 2. 실시간 알림이 있다면, 최신 1건만 뿌려라!
     		if(result.journeySender != "" && result.journeySender != null && result.journeySender != undefined){
     			console.log("실시간 알림이 최신 1건 있음!");
     			console.log("result.journeySender > ", result.journeySender);
     			
     			console.log("현재 로그인한 멤버와 수신자 아이디가 같음!");
     				
     			var realsenId = result.journeySender.realsenId; // 발신자 아이디
   		        var realsenName = result.journeySender.realsenName; // 발신자 이름
   		        var realsenTitle = result.journeySender.realsenTitle; // 실시간 알림 제목
   		        var realsenContent = result.journeySender.realsenContent; // 실시간 알림 내용
   		        var realsenType = result.journeySender.realsenType; // 여행정보 타입 알림
   		        var realsenReadyn = result.journeySender.realsenReadyn; // 안 읽음
   		        var realsenUrl = result.journeySender.realsenUrl; // 여행 정보 페이지로 이동
    		        
   		        var dbSaveFlag = false; // db에 저장하지 않고 알림만 발송.
   		        var userImgSrc = result.journeySender.realsenPfimg; // 발신자 프로파일 이미지 정보
   		        var realrecNo = result.journeySender.realrecNo;
    		        
   		        var rtAlert = {
      		        "realsenId": realsenId,
      		        "realsenName": realsenName,
      		        "realsenTitle": realsenTitle,
      		        "realsenContent": realsenContent,
      		        "realsenType": realsenType,
      		        "realsenReadyn": realsenReadyn,
      		       	"realsenUrl": realsenUrl,
      		        "realsenPfimg": userImgSrc
      		    };
       		    console.log("플래너 등록 알림 > rtAlert : ", rtAlert);
       		        
    		    $.realTimeAlertWebSocketFn(rtAlert, dbSaveFlag, userImgSrc, realrecNo);
    		        
    		  	// 바로 가기 클릭 시 안 본 실시간 알림을 본 것으로 처리
    	        $(document).on("click", ".rtAlertFadeBtn a", function(e){
    	            e.preventDefault();
    	            console.log("실시간 알림 본 것으로 처리 > realrecNo : ", realrecNo);
    	            $.ajax({
    	                type: "post",
    	                url: "/readRtAlert.do",
    	                data: JSON.stringify(realrecNo),
    	                contentType: "application/json",
    	                dataType: "text",
    	                success: function(res){
    	                	console.log("res : ", res);
    	                }
    	            });
    	            var oriAHref = $(this).attr("href");
    	            location.href = oriAHref;
    	        });
       		  		
     		}
     		
     		// 실시간 알림이 없다면 알림 카운트 숨겨라!
     		if(result.journeyCnt == 0) {
         		$(".alarmIcon span").hide();
         	}
         	
     		// 알림 카운트가 1건 이상 있다면 실행해라!
         	if(result.journeyCnt != "" && result.journeyCnt != null && result.journeyCnt != undefined){
         		// 3. 실시간 알림이 1건 이상 있다면, 카운트를 세서 딸랑이를 울려라!
            	var loginOutIconA = $(".alarmIcon");
            	var loginOutIcon = $(".alarmIcon i");
            	
            	function animateAlert() {
            		loginOutIconA.css("padding-top", "15px");
            		loginOutIcon.css("color", "gold");
            	    loginOutIcon.animate({
            	        rotation: 45,  // 목표 회전 각도
            	        lineHeight : "0px"
            	    }, {
            	        step: function (now, fx) {
            	            if (fx.prop === 'rotation') {
            	                loginOutIcon.css('transform', 'rotate(' + now + 'deg)');
            	            }
            	        },
            	        duration: 500,  // 애니메이션 지속 시간 (0.5초)
            	        complete: function () {
            	            // 두 번째 애니메이션 시작
            	            loginOutIcon.animate({
            	                rotation: -45,  // 초기 회전 각도
            	                lineHeight : "0px"
            	            }, {
            	                step: function (now, fx) {
            	                    if (fx.prop === 'rotation') {
            	                        loginOutIcon.css('transform', 'rotate(' + now + 'deg)');
            	                    }
            	                },
            	                duration: 500,  // 애니메이션 지속 시간 (0.5초)
            	                complete: function () {
            	                    // 세 번째 애니메이션 시작
            	                    loginOutIcon.animate({
            	                        rotation: 0, // 초기 회전 각도
            	                        lineHeight : "0px"
            	                    }, {
            	                        step: function (now, fx) {
            	                            if (fx.prop === 'rotation') {
            	                                loginOutIcon.css('transform', 'rotate(' + now + 'deg)');
            	                            }
            	                        },
            	                        duration: 500  // 애니메이션 지속 시간 (0.5초)
            	                    });
            	                }
            	            });
            	        }
            	    });
            	}

                // 페이지 로드 후 애니메이션 시작
                animateAlert();
                
        	    $(".alarmIcon").find("span").text(result.journeyCnt);
     		} 
         	
     	});
     	
     	// 로그인 알림 1번만 받고 바로 끄는 기능 구현, 1초 뒤에 삭제
     	setTimeout(function(){
        	$.ajaxLoginRtAlertRemove();
     	}, 50);
     	
     	// 딸랑이 클릭하면 마이 페이지 > 알림 목록으로 이동하고, 모두 읽음 처리 하기
     	$.rtAlertClickInitFn(sessionMemid);
	    
        // 종횡비 함수
        var pcgnbMainProfileImgCont = $(".pcgnb .mainProfileImgCont");
        var pcgnbMainProfileImg = $(".pcgnb .mainProfileImgCont img")
        $.ratioBoxH(pcgnbMainProfileImgCont, pcgnbMainProfileImg);
        
        var mgnbMainProfileImgCont = $(".mgnb .mainProfileImgCont");
        var mgnbMainProfileImg = $(".mgnb .mainProfileImgCont img");
        $.ratioBoxH(mgnbMainProfileImgCont, mgnbMainProfileImg);
        
        // 실시간 알림 모달창 기능
        var rtImgBox = $("header .rtImgBox");
        var rtImg = $("header .rtImgBox img")
        $.ratioBoxH(rtImgBox, rtImg);
        
        var rtCloseBtn = $(".rtCloseBtn");
        var rtAlertBox = $(".rtAlertBox");
        rtCloseBtn.click(function(){
            rtAlertBox.hide();
        });
    });
</script>
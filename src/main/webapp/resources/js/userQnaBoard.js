// 높이 조절 함수
$.qnaLnbHequalContHFn = function(){
    var qnaLnb = $(".qnaLnb");
    var qnaListSet = $(".qnaListSet");
    
    qnaLnb.outerHeight("auto");
    qnaListSet.outerHeight("auto");
    
    var qnaLnbH = qnaLnb.outerHeight();
    console.log("qnaLnbH : " + qnaLnbH);
    var qnaListSetH = qnaListSet.outerHeight();
    console.log("qnaListSetH : " + qnaListSetH);
    
    if(qnaLnbH > qnaListSetH) {
        qnaListSet.outerHeight(qnaLnbH);
    }else if(qnaLnbH < qnaListSetH) {
        qnaLnb.outerHeight(qnaListSetH);
    }
};

// qnaLnb 아코디언 메뉴 기능
$.qnaLnbAccordianMenuFn = function(){
    var qnaLnbSubA = $(".qnaLnb .qmain>a");
    qnaLnbSubA.click(function(){
        var thisIs = $(this);
        var visibleSub = thisIs.next().is(":visible");
        console.log("visibleSub : ", visibleSub);
        if(visibleSub) { // 소 메뉴가 눈에 보임
            thisIs.next().stop().slideUp(300);
        }else { // 소 메뉴가 눈에 보이지 않음
            thisIs.next().stop().slideDown(300);
        }
        // 방금 누른 것을 제외한 나머지 .sub는 싹 닫는다.
        thisIs.parent().siblings(".qmain").children(".qsub").stop().slideUp(300);
        
        $.qnaLnbHequalContHFn();
    });
};

// qnaListSet 아코디언 게시판 기능
$.qnaListSetAccordianBoardFn = function(){
    var accordBoardList = $(".accordBoardList");
    accordBoardList.click(function(){
        var thisIs = $(this);
        var visibleDiv = thisIs.parent().find(".visibleDiv").is(":visible");
        console.log("visibleDiv : ", visibleDiv);
        if(visibleDiv) { // 게시글이 눈에 보임
            thisIs.parent().find(".visibleDiv").stop().slideUp(300);
        }else { // 게시글이 눈에 보이지 않음
            thisIs.parent().find(".visibleDiv").stop().slideDown(300);
        }
        // 방금 누른 것을 제외한 나머지 div는 싹 닫는다.
        thisIs.parent().siblings(".accordBoardListCont").children(".visibleDiv").stop().slideUp(300);
        
        $.qnaLnbHequalContHFn();
    });
};

// 메뉴 등록 모달 창
$.qnaMenuAddClickFn = function() {
	var qnaMenuAddBtn = $("#qnaMenuAddBtn");
	qnaMenuAddBtn.click(function(){
        $("#popup").fadeIn();		// 모달창 보이기
        $('#addMenuForm').hide();
	}); 
}

// 메뉴 등록 모달 창 닫기
$.popdownClickFn = function() {
	var popdown = $("#popdown");
	popdown.click(function(){
        $("#popup").fadeOut();		// 모달창 감추기
	}); 
}

// 새 메뉴 등록 폼 보이기
$.addMenuClickFn = function() {
	var addMenuButton = $("#addMenuButton");
	addMenuButton.click(function(){
        $('#addMenuForm').show(); // 새 메뉴 등록 폼 보이기
	}); 
}

function addMainMenu() {
    var menuName = $("#mainMenuNameInput").val();
    var menuOrder = $("#mainMenuOrderInput").val();
    var menuYn = $("#mainMenuYnInput").val();
    var menuUrl = "/yourMenuUrl";  // 대분류 메뉴의 URL을 여기에 입력하세요.
    
    $.ajax({
        url: '/menu/addMainMenu',
        type: 'POST',
        data: JSON.stringify({
            "menuName": menuName,
            "menuOrder": menuOrder,
            "menuYn": menuYn,
            "menuUrl": menuUrl,
            "menuDiv": "main" // 대분류 메뉴임을 나타냅니다.
        }),
        contentType: 'application/json; charset=utf-8',
        success: function(response) {
            if (response === "Success") {
                // 메뉴 추가 성공
                alert("메뉴가 성공적으로 추가되었습니다.");
                // 필요한 경우 여기에 추가적인 작업을 수행하세요.
            } else {
                // 메뉴 추가 실패
                alert("메뉴 추가에 실패하였습니다. 다시 시도해주세요.");
            }
        },
        error: function(xhr, status, error) {
            // 서버에 요청을 보내는 중에 오류 발생
            alert("오류가 발생했습니다. 다시 시도해주세요.");
        }
    });
}

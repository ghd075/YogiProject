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
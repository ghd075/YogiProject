// 사용자 공통 페이지 함수

// 모바일 gnb 창 열기/닫기
$.mLnbClickEvent = function(){
    var mLnbBtn = $(".mLnbBtn");
    var mlnbCloseBtn = $(".mlnbCloseBtn");
    var footerTop = $(".footerTop");
    var token = 1; // mLnb가 눈에 보이는 상태
    mLnbBtn.click(function(){
        $(".mlnb").show();
        footerTop.css({
            zIndex: "-1"
        });
    });
    mlnbCloseBtn.click(function(){
        $(".mlnb").hide();
        footerTop.css({
            zIndex: "0"
        });
    });
};

// 가로 길이 700px 이하일 때 .mmain > .msub 클릭 이벤트
$.mmainClickEvent700 = function(){
    var mmain = $(".mmain");
    mmain.click(function(){
        var winW = $(window).outerWidth();
        console.log("브라우저 가로 길이 : ", winW);
        if(winW <= 700) {
            var thisIs = $(this);
            var visibleMsub = thisIs.children(".msub").is(":visible");
            //console.log(visibleMsub);
            if(visibleMsub) { // msub가 보이면 : 지금 누른 그것 안에 있는 msub를 숨긴다.
                thisIs.children(".msub").stop().slideUp(300);
            }else { // msub가 보이지 않으면 : 지금 누른 그것 안에 있는 msub를 연다
                thisIs.children(".msub").stop().slideDown(300);
            }
            // 지금 누른 그것을 제외한 나머지 mmain 안에 있는 msub를 모두 닫는다.
            thisIs.siblings(".mmain").children(".msub").slideUp(300);
        }else {
            $(".msub").removeAttr("style");
        }
    });
};

// 푸터 > 유관기관사이트 이동 기능
$.footerRelatedSiteFn = function(){
    var siteShowBtn = $(".siteShowBtn");
    var footerTop = $(".footerTop");
    var footerTopContent = $(".footerTop div");
    var sitechevron = $(".sitechevron");
    var siteToken = 0;
    siteShowBtn.click(function(){
        if(!siteToken) {
            // 메뉴가 눈에 보이지 않는 상태
            //alert("메뉴가 누네 안보여유");
            footerTopContent.css({
                "bottom" : "0px",
            });
            sitechevron.css({
                "transform" : "rotate(180deg)"
            });
            footerTop.removeAttr("style");
            siteToken = 1; // 메뉴를 보여야 함
        }else {
            // 메뉴가 눈에 보이는 상태
            //alert("메뉴가 누네 보여유");
            footerTopContent.css({
                "bottom" : "-275px",
            });
            sitechevron.css({
                "transform" : "rotate(0deg)"
            });
            footerTop.css("overflow", "hidden");
            siteToken = 0; // 메뉴를 숨겨야 함
        }
    });
}

// 윈도우 가로 길이 변경 이벤트
$(window).resize(function(){
    var winW = $(this).outerWidth();
    
    // 종횡비 함수
    var pcgnbMainProfileImgCont = $(".pcgnb .mainProfileImgCont");
    var pcgnbMainProfileImg = $(".pcgnb .mainProfileImgCont img");
    $.ratioBoxH(pcgnbMainProfileImgCont, pcgnbMainProfileImg);
    
    var mgnbMainProfileImgCont = $(".mgnb .mainProfileImgCont");
    var mgnbMainProfileImg = $(".mgnb .mainProfileImgCont img");
    $.ratioBoxH(mgnbMainProfileImgCont, mgnbMainProfileImg);
    
    if(winW >= 700) {
        $(".msub").removeAttr("style");
    }
});

// 윈도우 스크롤 이벤트
$(window).scroll(function () {
    var scrD = $(this).scrollTop();
    
    var scrollTopBtn = $("#scrollTopBtn");
    if(scrD >= 300) {
        scrollTopBtn.stop().fadeIn();
        scrollTopBtn.click(function(){
            $("html").stop().animate({
                scrollTop: 0
            }, 400, "linear");
        });
    }else {
        scrollTopBtn.stop().fadeOut();
    }
});
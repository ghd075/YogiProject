$.airplaneSlickFn = function(){
    $(".airMainSlider").slick({
        infinite: true,
        speed: 1000,
        slidesToShow: 1,
        autoplay: true,
        autoplaySpeed: 1000
    });
};

// 여행 슬라이드 각각의 이미지 종횡비 변경 함수
$.eachAirImgResizeFn = function(){
    $(".airMainSlider").each(function(){
        var thisIs = $(this);
        var airSlideBox = thisIs.find(".airSlide");
        var airSlideImg = thisIs.find("img");
        $.ratioBoxH(airSlideBox, airSlideImg);
    });
};

// 여행 정보 각각의 이미지 종횡비 변경 함수
$.eachAirInfoImgResizeFn = function(){
    $(".airInfoCont").each(function(){
        var thisIs = $(this);
        var airImgBox = thisIs.find(".airImgBox");
        var airImg = thisIs.find("img");
        $.ratioBoxH(airImgBox, airImg);
    });
};

// 여행 왕복/편도 탭 기능
$.airplainTabbtnFn = function(){
    var airTabbtn = $(".airTabbtnGroup .tabbtn");
    var airTabcontBox = $(".airTabcontBox .tabcont");
    airTabbtn.click(function(){
        var thisIs = $(this);
        airTabbtn.removeClass("tactive");
        thisIs.addClass("tactive");
        var idx = thisIs.index();
        //console.log("idx : " + idx);
        airTabcontBox.hide();
        airTabcontBox.eq(idx).show();
        
        $(".autoSetOpt").hide();
        counterLayerPopupShow = 0;
        
        autoSetTxt.val("");
        
        $(".switchingDiv").prev().val("");
        $(".switchingDiv").next().next().val("");
    });
};

// 여행 왕복/편도 탭 콘텐츠 영역 높이 설정 기능
$.airplainTabcontHeightFn = function(){
    var airplaneReserveContH = $(".airplaneReserveCont").height();
    //console.log(airplaneReserveContH);
    var airTabbtnGroupH = $(".airTabbtnGroup").height();
    //console.log(airTabbtnGroupH);
    var airTabcontBoxH = airplaneReserveContH - airTabbtnGroupH;
    $(".airTabcontBox").height(airTabcontBoxH);
};

// 출발지/도착지 텍스트 스위칭 함수
$.startEndSwitchingFn = function(){
    var switchingDiv = $(".switchingDiv");
    switchingDiv.click(function(){
        var thisIs = $(this);
        var prevVal = thisIs.prev().val();
        var nextVal = thisIs.next().next().val();
        //console.log("startP : ", prevVal);
        //console.log("endP : ", nextVal);
        thisIs.prev().val(nextVal);
        thisIs.next().next().val(prevVal);
    });
};

// 카운터 모달 기능
var counterLayerPopupShow = 0; // 처음에는 눈에 안보이는 상태
var autoSetTxt = $(".autoSetTxt");
$.counterLayerPopupFn = function(){
    var autoSetOpt = $(".autoSetOpt");
    var cntMinus = $(".cntMinus");
    var cntPlus = $(".cntPlus");
    var choiceCompleteBtn = $(".choiceCompleteBtn");
    autoSetTxt.click(function(){
        if(counterLayerPopupShow == 0) { // 눈에 안 보임
            autoSetOpt.show();
            counterLayerPopupShow = 1;
        }else if(counterLayerPopupShow == 1) { // 눈에 보임
            autoSetOpt.hide();
            counterLayerPopupShow = 0;
        }
    });
    cntMinus.click(function(){
        var thisIs = $(this);
        var countMinusVal = parseInt(thisIs.next().text());
        //console.log("countMinusVal : ", countMinusVal);
        countMinusVal -= 1;
        //console.log("countMinusVal : ", countMinusVal);
        if(countMinusVal <= 0) {
            countMinusVal = 0;
        }
        thisIs.next().text(countMinusVal);
    });
    cntPlus.click(function(){
        var thisIs = $(this);
        var countPlusVal = parseInt(thisIs.prev().text());
        //console.log("countPlusVal : ", countPlusVal);
        countPlusVal += 1;
        //console.log("countPlusVal : ", countPlusVal);
        thisIs.prev().text(countPlusVal);
    });
    choiceCompleteBtn.click(function(){
        var thisIs = $(this);
        var cntNmArr = [];
        $(".removeInput").remove();
        thisIs.parents(".autoSetOpt").find(".countNm").each(function(i, v){
            var thisIs2 = $(this);
            var thisTxt = thisIs2.parent().prev().text();
            console.log(thisTxt);
            console.log(thisIs2.text());
            cntNmArr.push(" " + thisTxt + " : " + thisIs2.text());
            var inputHidden = "";
            if(thisTxt == "성인"){
                inputHidden += `<input class="removeInput" type="hidden" id="adultCnt" name="adultCnt" value=${thisIs2.text()} />`;
            }else if(thisTxt == "소아") {
                inputHidden += `<input class="removeInput" type="hidden" id="soaCnt" name="soaCnt" value=${thisIs2.text()} />`;
            }else if(thisTxt == "유아") {
                inputHidden += `<input class="removeInput" type="hidden" id="yuaCnt" name="yuaCnt" value=${thisIs2.text()} />`;
            }
            thisIs2.parents(".tripFindForm").prepend(inputHidden);
        });
        var chkedVal = thisIs.parents(".autoSetOpt").find("input[name=chkSeat]:checked").parent().text().trim();
        console.log("chkedVal :", chkedVal);
        console.log("cntNmArr : ", cntNmArr);
        autoSetTxt.val(cntNmArr + ", " + chkedVal);
        autoSetOpt.hide();
        counterLayerPopupShow = 0;
        
    });
};

// 데이트픽커 함수
$.dateFickerFn = function(dateElement){
    flatpickr(dateElement, {
      dateFormat: "Y-m-d (D)",
      enableTime: false,
      minDate: "today",
      defaultDate: "today",
      locale: "ko",
    });
};
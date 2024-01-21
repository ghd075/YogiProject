// 여행 정보 모달창 기능
$.JourneyInfoModalFn = function () {
    // 모달창 닫기
    var infoModalClose = $(".infoModalClose");
    var infoModalContents = $(".infoModalContents");
    infoModalClose.click(function () {
        infoModalContents.hide();
    });
    // 모달창 열기
    var journeyInfoContents = $(".journeyInfoContents article");
    var modalInfoSetting = $(".modalInfoSetting");
    journeyInfoContents.click(function () {
        
        var thisIs = $(this);
        var infoImgSrc = thisIs.find("img").attr("src").trim();
        var infoH4 = thisIs.find("h4").text().trim();
        var infoSpan = thisIs.find(".infoTitle").text().trim();
        var infoP = thisIs.find("p").text().trim();
        
        modalInfoSetting.find("span").text(infoH4);
        modalInfoSetting.find("h5").text(infoSpan);
        modalInfoSetting.find("p").text(infoP);
        var infoModalImgBox = $(".infoModalImgBox");
        infoModalImgBox.find("img").attr("src", infoImgSrc);
        
        var airportText = thisIs.find(".airportText").html();
        var airportHtmlEl = $(".infoModalFourSection>div:first-of-type>div:last-of-type");
        airportHtmlEl.html("");

        var visaText = thisIs.find(".visaText").html();
        var visaHtmlEl = $(".infoModalFourSection>div:nth-of-type(2)>div:last-of-type");
        visaHtmlEl.html("");

        var voltageTxt = thisIs.find(".voltageTxt").html();
        var voltageHtmlEl = $(".infoModalFourSection>div:nth-of-type(3)>div:last-of-type");
        voltageHtmlEl.html("");

        var infoTimediferTxt = thisIs.find(".infoTimediferTxt").html();
        var infoTimediferHtmlEl = $(".infoModalFourSection>div:last-of-type>div:last-of-type");
        infoTimediferHtmlEl.html("");

        var emptyHtmlEl = "<span>없음</span><span>-</span>";

        if(airportText != undefined) {
            airportHtmlEl.html(airportText);
        }else {
            airportHtmlEl.html(emptyHtmlEl);
        }

        if(visaText != undefined) {
            visaHtmlEl.html(visaText);
        }else {
            visaHtmlEl.html(emptyHtmlEl);
        }

        if(voltageTxt != undefined) {
            voltageHtmlEl.html(voltageTxt);
        }else {
            voltageHtmlEl.html(emptyHtmlEl);
        }

        if(infoTimediferTxt != undefined) {
            infoTimediferHtmlEl.html(infoTimediferTxt);
        }else {
            infoTimediferHtmlEl.html(emptyHtmlEl);
        }
        
        var infoNoVal = thisIs.find(".infoNo").val();
        $("#choiceInfoNo").val(infoNoVal);
        
        infoModalContents.show();
        
        var infoModalImgBox = $(".infoModalImgBox");
        var infoModalImg = $(".infoModalImgBox img");
        $.ratioBoxH(infoModalImgBox, infoModalImg);
        
    });
};

// 여행 정보 각각의 이미지 종횡비 변경 함수
$.eachJourneyInfoImgResizeFn = function(){
    $(".journeyInfoContents article").each(function(i, v){
        var thisIs = $(this);
        var infoThumbnailBox = thisIs.find(".infoThumbnailBox");
        var infoThumbnailImg = thisIs.find("img");
        $.ratioBoxH(infoThumbnailBox, infoThumbnailImg);
    });
};

// 여행 정보 등록 페이지 이동
$.journeyRegiPageMoveFn = function(){
	var journeyRegiBtn = $("#journeyRegiBtn");
	journeyRegiBtn.click(function(){
		location.href = "/myplan/inforeg.do";
	});
};

// 여행 정보 미리보기 기능 함수
var journeyInfoThumbnailPreview = $(".journeyInfoThumbnailPreview");
var previewModalInfoSetting = $(".previewModalInfoSetting");
$.journeyInfoPreviewFn = function(inputEl){
    var journeyInfoThumbnailPreviewTxt = journeyInfoThumbnailPreview.find("span").text();
    var previewModalInfoSettingH5 = previewModalInfoSetting.find("h5").text();
    inputEl.keyup(function(){
        var inputElVal = inputEl.val();
        if(inputElVal) {
            journeyInfoThumbnailPreview.find("span").text(inputElVal);
            previewModalInfoSetting.find("h5").text(inputElVal);
        }else {
            journeyInfoThumbnailPreview.find("span").text(journeyInfoThumbnailPreviewTxt);
            previewModalInfoSetting.find("h5").text(previewModalInfoSettingH5);
        }
    });
};

var journeyInfoThumbnailPreviewLast = $(".journeyInfoThumbnailPreview>div:last-of-type");
$.journeyInfoPreviewFn2 = function(inputEl){
    var journeyInfoThumbnailPreviewLastTxt = journeyInfoThumbnailPreviewLast.find("h4").text();
    var previewModalInfoSettingH5 = previewModalInfoSetting.find("span").text();
    inputEl.keyup(function(){
        var inputElVal = inputEl.val().toUpperCase();
        inputEl.val(inputElVal);
        if(inputElVal) {
            journeyInfoThumbnailPreview.find("h4").text(inputElVal);
            previewModalInfoSetting.find("span").text(inputElVal);
        }else {
            journeyInfoThumbnailPreview.find("h4").text(journeyInfoThumbnailPreviewLastTxt);
            previewModalInfoSetting.find("span").text(previewModalInfoSettingH5);
        }
    });
};

$.journeyInfoPreviewFn3 = function(textareaEl){
    var previewModalInfoSettingP = previewModalInfoSetting.find("p").text();
    textareaEl.keyup(function(){
        var textareaElVal = textareaEl.val().trim();
        textareaElVal = textareaElVal.replace(/\r?\n/g, ""); // 모든 개행 문자를 제거
        if(textareaElVal) {
            previewModalInfoSetting.find("p").text(textareaElVal);
        }else {
            previewModalInfoSetting.find("p").text(previewModalInfoSettingP);
        }
    });
};

$.flightPreviewFn = function(){
    var infoFlightynBtn = $('input[name="infoFlightyn"]');
    var infoFlightBtn = $('input[name="infoFlight"]');
    var infoFlighttime = $('#infoFlighttime');
    //infoFlightBtn.prop('disabled', true);
    //infoFlighttime.prop('disabled', true);
    infoFlightynBtn.change(function() {
        var selectedValue = $('input[name="infoFlightyn"]:checked').val();
        if(selectedValue == "y") {
            infoFlightBtn.prop('disabled', false);
            infoFlighttime.prop('disabled', false);
        }else {
            infoFlightBtn.prop('disabled', true).prop('checked', false);
            infoFlighttime.prop('disabled', true);
            firstSpanVal.text(firstSpanValTxt);
            infoFlighttime.val("");
            secondSpanVal.text("-");
        }
    });
    
    var firstSpanVal = $(".previewModalFourSection>div:first-of-type>div:last-of-type span:first-of-type");
    var firstSpanValTxt = firstSpanVal.text();
    infoFlightBtn.change(function(){
        var selectedValue = $('input[name="infoFlight"]:checked').val();
        if(selectedValue == "str") {
            firstSpanVal.text("직항");
        }else {
            firstSpanVal.text("왕복");
        }
    });
    
    var secondSpanVal = $(".previewModalFourSection>div:first-of-type>div:last-of-type span:last-of-type");
    infoFlighttime.keyup(function(){
        var thisIs = $(this);
        var timeVal = thisIs.val();
        //console.log("timeVal : " + timeVal);
        if(timeVal) {
            secondSpanVal.text(timeVal);
        }else {
            secondSpanVal.text("-");
        }
    });
};

$.visaPreviewFn = function(){
    var infoVisaynBtn = $('input[name="infoVisayn"]');
    var infoVisaexpBtn = $('input[name="infoVisaexp"]');
    var infoVisatime = $('#infoVisatime');
    //infoVisaexpBtn.prop('disabled', true);
    //infoVisatime.prop('disabled', true);
    infoVisaynBtn.change(function() {
        var selectedValue = $('input[name="infoVisayn"]:checked').val();
        if(selectedValue == "y") {
            infoVisaexpBtn.prop('disabled', false);
            infoVisatime.prop('disabled', false);
        }else {
            infoVisaexpBtn.prop('disabled', true).prop('checked', false);
            infoVisatime.prop('disabled', true);
            firstSpanVal.text(firstSpanValTxt);
            infoVisatime.val("");
            secondSpanVal.text("-");
        }
    });
    
    var firstSpanVal = $(".previewModalFourSection>div:nth-of-type(2)>div:last-of-type span:first-of-type");
    var firstSpanValTxt = firstSpanVal.text();
    infoVisaexpBtn.change(function(){
        var selectedValue = $('input[name="infoVisaexp"]:checked').val();
        if(selectedValue == "visa") {
            firstSpanVal.text("비자");
        }else {
            firstSpanVal.text("무비자");
        }
    });
    
    var secondSpanVal = $(".previewModalFourSection>div:nth-of-type(2)>div:last-of-type span:last-of-type");
    infoVisatime.keyup(function(){
        var thisIs = $(this);
        var timeVal = thisIs.val();
        if(timeVal) {
            secondSpanVal.text(timeVal);
        }else {
            secondSpanVal.text("-");
        }
    });
};

$.voltagePreviewFn = function(){
    var infoVoltageBtn = $('input[name="infoVoltage"]');
    var secondSpanVal = $(".previewModalFourSection>div:nth-of-type(3)>div:last-of-type span:last-of-type");
    infoVoltageBtn.change(function(){
        var selectedValue = $('input[name="infoVoltage"]:checked').val();
        if(selectedValue == "110V"){
            secondSpanVal.text("110V");
        }else {
            secondSpanVal.text("220V");
        }
    });
};

$.timeDifferPreviewFn = function(){
    var infoTimedifer = $("#infoTimedifer");
    var secondSpan = $(".previewModalFourSection>div:last-of-type>div:last-of-type span:last-of-type");
    var secondSpanTxt = secondSpan.text();
    infoTimedifer.keyup(function(){
        var thisIs = $(this);
        var thisVal = thisIs.val().toUpperCase();
        //console.log("thisVal : " + thisVal);
        thisIs.val(thisVal);
        if(thisVal){
            secondSpan.text(thisVal);
        }else{
            secondSpan.text(secondSpanTxt);
        }
    });
};

$.makeplanClickEvent = function(){
    var makePlanSty = $(".makePlanSty");
    makePlanSty.click(function(event){
        event.preventDefault();
        var thisIs = $(this);
        var hrefVal = thisIs.attr("href");
        var spanVal = thisIs.parents(".infoModalLeft").find(".modalInfoSetting>span").text();
        console.log("spanVal : " + spanVal);
        hrefVal += "?infoName=" + spanVal;
        console.log("hrefVal : " + hrefVal);
        location.href = hrefVal;
    });
};

$.journeyModifyPageMoveFn = function(){
	var journeyInfoModify = $("#journeyInfoModify");
	journeyInfoModify.click(function(){
		var choiceInfoNo = $("#choiceInfoNo");
		var infoNoVal = choiceInfoNo.val();
		//console.log("infoNoVal : " + infoNoVal);
		location.href = "/myplan/modify.do?infoNo=" + infoNoVal;
	});
};

$.journeyDeletePageMoveFn = function(){
    var journeyInfoDelete = $("#journeyInfoDelete");
    journeyInfoDelete.click(function(){
        var choiceInfoNo = $("#choiceInfoNo");
		var infoNoVal = choiceInfoNo.val();
        location.href = "/myplan/delete.do?infoNo=" + infoNoVal;
    });
};

// 여행 정보 실시간 검색 기능 함수
$.ajaxJourneyInfoSearchFn = function(){
	var jourInfoSearch = $("#jourInfoSearch");
    jourInfoSearch.keyup(function(){
    
    	//alert("잘 되는가용?");
    
        var thisIs = $(this);
        var thisVal = thisIs.val();
        console.log("thisVal : " + thisVal);
        
        var languageType = detectLanguage(thisVal);
        console.log("languageType : " + languageType);
        
        var journeyVO = {};
        
        if(languageType == "korean") {
            journeyVO.infoName = thisVal;
            journeyVO.infoEngname = "";
        }else if(languageType == "english") {
            journeyVO.infoName = "";
            journeyVO.infoEngname = thisVal;
        }else {
            journeyVO.infoName = "";
            journeyVO.infoEngname = "";
        }
        
        $.ajax({
            type: "get",
            url: "/myplan/ajaxSearch.do",
            data: journeyVO,
            dataType: "json",
            success: function(res){
                console.log("res : ", res);
                var searchHtml = "";
                if(res.length == 0) {
                	searchHtml += `
                		<article style="text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; border-radius: 4px;">
		    				검색된 여행 정보가 없습니다.
		    			</article>
                	`;
                }
                for(var i=0; i<res.length; i++){
                    searchHtml += `
                        <article>
                            <div class="infoThumbnailBox">
                                <img src="${res[i].infoPreviewimg}" alt="여행 정보 썸네일 이미지" />
                            </div>
                            <div>
                                <h4 class="textDrop">${res[i].infoEngname}</h4>
                                <span class="infoTitle textDrop">${res[i].infoName}</span>
                                <p>${res[i].infoDescription}</p>
                                <span class="airportText">`;

                            if(res[i].infoFlightyn == 'y'){
                                searchHtml += `<span>`;

                                if(res[i].infoFlight == "str"){
                                    searchHtml += `직항</span>`;
                                }else {
                                    searchHtml += `왕복</span>`;
                                }

                                searchHtml += `<span>${res[i].infoFlighttime}</span>`;
                            }else {
                                searchHtml += `<span>없음</span>
                                                <span>-</span>`;
                            }

                    searchHtml += `</span>
                                <span class="visaText">`;

                            if(res[i].infoVisayn == 'y'){
                                searchHtml += `<span>`;

                                if(res[i].infoVisaexp == "visa"){
                                    searchHtml += `비자</span>`;
                                }else {
                                    searchHtml += `무비자</span>`;
                                }

                                searchHtml += `<span>${res[i].infoVisatime}</span>`;
                            }else {
                                searchHtml += `<span>없음</span>
                                                <span>-</span>`;
                            }

                    searchHtml += `</span>
                                <span class="voltageTxt">
                                    <span>콘센트</span>
                                    <span>${res[i].infoVoltage}</span>
                                </span>
                                <span class="infoTimediferTxt">
                                    <span>한국대비</span>
                                    <span>${res[i].infoTimedifer}</span>
                                </span>
                                <input type="hidden" class="infoNo" name="infoNo" value="${res[i].infoNo}" />
                            </div>
                        </article>
                    `;
                }
                var journeyInfoContents = $(".journeyInfoContents");
                journeyInfoContents.html("");
                journeyInfoContents.append(searchHtml);
                
                $.JourneyInfoModalFn();
                $.eachJourneyInfoImgResizeFn();
            }
        });
        
    });
};

function detectLanguage(inputValue) {
    // 정규표현식을 사용하여 문자열이 한글인지 영어인지 판별
    var koreanRegex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    var englishRegex = /^[a-zA-Z]*$/;

    if (koreanRegex.test(inputValue)) {
        return "korean";
    } else if (englishRegex.test(inputValue)) {
        return "english";
    } else {
        return "etc";
    }
}

$(window).on("load", function(){
    $('input[name="infoFlightyn"]').trigger("change");
    $('input[name="infoVisayn"]').trigger("change");
});
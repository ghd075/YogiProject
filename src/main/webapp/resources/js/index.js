// 공통 함수
// 메인 슬라이드 > slick
// 일시 정지 속성 : slickPause
// 재생 속성 : slickPlay
$.mainSlideSlickFn = function () {
    $(".mainSlider").slick({
        dots: true,
        infinite: true,
        fade: true,
        speed: 2000,
        slidesToShow: 1,
        autoplay: true,
        autoplaySpeed: 2000
    });
};

$.fn.mainSlideArrowStyle = function () {
    var slickPrev = this.find(".slick-prev");
    var slickNext = this.find(".slick-next");
    slickPrev.html("<i class='fas fa-chevron-left'></i>");
    slickNext.html("<i class='fas fa-chevron-right'></i>");
};

$.fn.mainSlideDotsStyle = function () {
    var slickDots = this.find("[role=tab]");
    slickDots.html("<i class='fas fa-circle'></i>");
};

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
        //console.log("infoImgSrc : ", infoImgSrc);
        var infoH4 = thisIs.find("h4").text().trim();
        //console.log("infoH4 : ", infoH4);
        var infoSpan = thisIs.find(".infoTitle").text().trim();
        //console.log("infoSpan : ", infoSpan);
        var infoP = thisIs.find("p").text().trim();
        //console.log("infoP : ", infoP);
        var airportText = thisIs.find(".airportText").html();
        console.log("airportText : ", airportText);
        //console.log("airportText : ", typeof(airportText));
        
        modalInfoSetting.find("span").text(infoH4);
        modalInfoSetting.find("h5").text(infoSpan);
        modalInfoSetting.find("p").text(infoP);
        var infoModalImgBox = $(".infoModalImgBox");
        infoModalImgBox.find("img").attr("src", infoImgSrc);
        
        var airportHtmlEl = $(".infoModalFourSection>div:first-of-type>div:last-of-type");
        airportHtmlEl.html("");
        
        var emptyHtmlEl = "<span>없음</span><span></span>";
        if(airportText != undefined) {
            airportHtmlEl.html(airportText);
        }else {
            airportHtmlEl.html(emptyHtmlEl);
        }
        
        infoModalContents.show();
        
        var infoModalImgBox = $(".infoModalImgBox");
        var infoModalImg = $(".infoModalImgBox img");
        $.ratioBoxH(infoModalImgBox, infoModalImg);
        
    });
};

// chart.js
$.genderPieGraph = function(genderPercent){
    const ctx1 = document.querySelector("#genderPieGraph");
    var pieChart = new Chart(ctx1, {
        type: 'pie',
        data: {
            labels: ['남자', '여자'],
            datasets: [
                {
                    label: '성별 사이트 이용자 수(%)',
                    data: genderPercent,
                    borderWidth: 1
                }
            ]
        },
        options: {
            responsive: true, // Enable responsiveness
            maintainAspectRatio: false, // Allow aspect ratio to be adjusted
            scales: {
                y: {
                    beginAtzero: true
                }
            }
        }
    });
};

// 파스텔톤 랜덤 색상 함수
function generateRandomPastelColor() {
    const hue = Math.floor(Math.random() * 360);
    const pastelColor = `hsl(${hue}, 70%, 80%)`;
    return pastelColor;
}

// 주어진 주간 연령별 사이트 이용 고객 수 배열을 기반으로
// 각 연령대의 사이트 이용 비율을 계산하여 퍼센트 배열을 반환하는 함수
function calculatePercentage(ageWeekUseSiteCnt) {
    // 주어진 배열의 총 합을 계산
    const totalCustomers = ageWeekUseSiteCnt.reduce((total, count) => total + count, 0);

    // 각 연령대의 사이트 이용 비율을 계산하여 퍼센트로 변환
    const percentageValues = ageWeekUseSiteCnt.map(count => ((count / totalCustomers) * 100).toFixed(2));

    return percentageValues;
}

$.ageMixedGraph = function(ageWeekUseSiteCnt){
    var ageUseSitePercent = calculatePercentage(ageWeekUseSiteCnt);
    console.log(ageUseSitePercent);
    
    const ctx2 = document.querySelector("#ageBarGraph");
    var mixedChart = new Chart(ctx2, {
        data: {
            labels: ['10대', '20대', '30대', '40대', '50대', '60대 이상'],
            datasets: [
                {
                    type: 'line',
                    label: '주간 연령별 사이트 이용 현황(%)',
                    data: ageUseSitePercent,
                    borderWidth: 1,
                    backgroundColor: 'rgba(255, 99, 132, 1)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    yAxisID: 'percentageYAxis'
                },
                {
                    type: 'bar',
                    label: '주간 연령별 사이트 이용 고객 수(명)',
                    data: ageWeekUseSiteCnt,
                    borderWidth: 1,
                    backgroundColor: Array.from({ length: 6 }, () => generateRandomPastelColor()),
                    yAxisID: 'countYAxis'
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            scales: {
                percentageYAxis: {
                    type: 'linear',
                    position: 'left',
                    title: {
                        display: true,
                        text: '사이트 이용 비율 (%)'
                    },
                    ticks: {
                        beginAtZero: true,
                        max: 100
                    }
                },
                countYAxis: {
                    type: 'linear',
                    position: 'right',
                    title: {
                        display: true,
                        text: '사이트 이용 고객 수(명)'
                    },
                    ticks: {
                        beginAtZero: true
                    }
                }
            }
        }
    });
};

$.areaPolarGraph = function(nineSectionPreference){
    const ctx3 = document.querySelector("#areaPolarGraph");
    var polarChart = new Chart(ctx3, {
        type: 'polarArea',
        data: {
            // 9개 광역행정구역(도)
            labels: ['경기도', '강원도', '충청남도', '충청북도', '전라남도', '전라북도', '경상남도', '경상북도', '제주특별자치도'],
            datasets: [
                {
                    label: '여행지역 선호도(%)',
                    data: nineSectionPreference,
                    borderWidth: 1
                }
            ]
        },
        options: {
            responsive: true, // Enable responsiveness
            maintainAspectRatio: false, // Allow aspect ratio to be adjusted
            scales: {
                y: {
                    beginAtzero: true
                },
                r: {
                    pointLabels: {
                        display: true,
                        centerPointLabels: true,
                        font: {
                            size: 14
                        }
                    }
                }
            },
        }
    });
};

// 객체 비구조화 할당 : weekVisiterAgeCnt = {teen, twenties, thirties, forties, fifties, sixties};
$.visitorStackGraph = function({teen, twenties, thirties, forties, fifties, sixties}){
    const ctx4 = document.querySelector("#visitorStackGraph");
    
    const getLast7Days = () => {
        const today = new Date();
        const last7Days = Array.from({ length: 7 }, (_, i) => {
            const day = new Date(today);
            day.setDate(today.getDate() - i);
            const formattedDate = day.toISOString().slice(2, 10); // Format as 'YY-MM-DD'
            return formattedDate;
        });
        return last7Days.reverse();
    };
    
    const weekDays = getLast7Days();
    console.log(weekDays);
    
    var stackChart = new Chart(ctx4, {
        type: 'bar',
        data: {
            labels: weekDays,
            datasets: [
                {
                    label: '10대(명)',
                    data: teen
                },
                {
                    label: '20대(명)',
                    data: twenties
                },
                {
                    label: '30대(명)',
                    data: thirties
                },
                {
                    label: '40대(명)',
                    data: forties
                },
                {
                    label: '50대(명)',
                    data: fifties
                },
                {
                    label: '60대 이상(명)',
                    data: sixties
                },
            ]
        },
        options: {
            responsive: true, // Enable responsiveness
            maintainAspectRatio: false, // Allow aspect ratio to be adjusted
            scales: {
                x: {
                    stacked: true,
                },
                y: {
                    stacked: true
                }
            }
        }
    });
};

// CSS in JS 기법
// 원본 CSS 스타일을 건드리지 않고 특정 페이지에서만 스타일링을 변경해야 하는 경우 자주 사용하는 기법
var headerEl = $("header");
var logoTxt = $(".logoTxt");
var loginHello = $(".loginHello");
var mLnbBtnDiv = $(".mLnbBtn div");
var pclnbA = $(".pclnb .main>a");
var mlnbLogoTxt = $(".mlnb .logoTxt");
var mlnbLoginHello = $(".mlnb .loginHello");
var msubA = $(".msub a");
var gnbBtnGroupA = $(".gnbBtnGroup a");
var gnbBtnGroupI = $(".gnbBtnGroup i");
var mlnbGnbBtnGroupA = $(".mlnb .gnbBtnGroup a");
var mlnbGnbBtnGroupI = $(".mlnb .gnbBtnGroup i");

$.initHeaderStyle = function () {
    headerEl.removeAttr("style");
    logoTxt.removeAttr("style");
    loginHello.removeAttr("style");
    mLnbBtnDiv.removeAttr("style");
    pclnbA.removeAttr("style");
    mlnbLogoTxt.removeAttr("style");
    mlnbLoginHello.removeAttr("style");
    msubA.removeAttr("style");
    gnbBtnGroupA.removeAttr("style");
    gnbBtnGroupI.removeAttr("style");
    mlnbGnbBtnGroupA.removeAttr("style");
    mlnbGnbBtnGroupI.removeAttr("style");
};

$.startHeaderStyle = function () {
    headerEl.css({
        transition: "all 0.4s",
        backgroundColor: "rgba(0,0,0,0.6)"
    });
    logoTxt.css({
        color: "#eee"
    });
    mlnbLogoTxt.css({
        color: "#333"
    });
    loginHello.css({
        color: "#eee"
    });
    mlnbLoginHello.css({
        color: "#333"
    });
    pclnbA.css({
        color: "#eee"
    });
    mLnbBtnDiv.css({
        backgroundColor: "#eee"
    });
    msubA.css({
        color: "#333"
    });
    gnbBtnGroupA.css({
        backgroundColor: "#eee"
    });
    gnbBtnGroupI.css({
        color: "#333"
    });
    mlnbGnbBtnGroupA.css({
        backgroundColor: "#333"
    });
    mlnbGnbBtnGroupI.css({
        color: "#eee"
    });
    gnbBtnGroupA.mouseover(function () {
        var thisIs = $(this);
        thisIs.css({
            backgroundColor: "#333"
        });
        thisIs.find("i").css({
            color: "#eee"
        });
    });
    gnbBtnGroupA.mouseout(function () {
        var thisIs = $(this);
        thisIs.css({
            backgroundColor: "#eee"
        });
        thisIs.find("i").css({
            color: "#333"
        });
    });
    mlnbGnbBtnGroupA.mouseover(function () {
        var thisIs = $(this);
        thisIs.css({
            backgroundColor: "#eee"
        });
        thisIs.find("i").css({
            color: "#333"
        });
    });
    mlnbGnbBtnGroupA.mouseout(function () {
        var thisIs = $(this);
        thisIs.css({
            backgroundColor: "#333"
        });
        thisIs.find("i").css({
            color: "#eee"
        });
    });
};

$.scrollHeaderStyle = function () {
    headerEl.css({
        backgroundColor: "white"
    });
    logoTxt.css({
        color: "#333"
    });
    loginHello.css({
        color: "#333"
    });
    pclnbA.css({
        color: "#333"
    });
    mLnbBtnDiv.css({
        backgroundColor: "#333"
    });
    gnbBtnGroupA.css({
        backgroundColor: "black"
    });
    gnbBtnGroupI.css({
        color: "white"
    });
    gnbBtnGroupA.mouseover(function () {
        var thisIs = $(this);
        thisIs.css({
            backgroundColor: "#eee"
        });
        thisIs.find("i").css({
            color: "#333"
        });
    });
    gnbBtnGroupA.mouseout(function () {
        var thisIs = $(this);
        thisIs.css({
            backgroundColor: "#333"
        });
        thisIs.find("i").css({
            color: "#eee"
        });
    });
}

// 여행 정보 각각의 이미지 종횡비 변경 함수
$.eachJourneyInfoImgResizeFn = function(){
    $(".journeyInfoContents article").each(function(i, v){
        var thisIs = $(this);
        var infoThumbnailBox = thisIs.find(".infoThumbnailBox");
        var infoThumbnailImg = thisIs.find("img");
        $.ratioBoxH(infoThumbnailBox, infoThumbnailImg);
    });
};

$.startHeaderEmpty = function(){
    var winW = $(this).outerWidth();
    /* 가로길이 600px 이하일 때 헤더에 공백 주기 */
    var mainSlideContainer = $(".mainSlideContainer");
    if(winW < 600) {
        mainSlideContainer.addClass("emptySpace");
    }else {
        mainSlideContainer.removeClass("emptySpace");
    }
};

// 윈도우 가로 길이 변경 이벤트
$(window).resize(function(){
    var winW = $(this).outerWidth();
    
    if(winW < 1060) {
        $.eachJourneyInfoImgResizeFn();
    }
    if(winW < 680) {
        $.eachJourneyInfoImgResizeFn();
    }
    
    $.startHeaderEmpty();
});

// 윈도우 스크롤 이벤트
$(window).scroll(function () {
    var scrD = $(this).scrollTop();
    console.log("현재 스크롤의 위치 : " + scrD + " px");

    // 스크롤 위치가 0px이면 herder를 투명하게, 아니면 하얀색 배경
    if (scrD == 0) {
        $.initHeaderStyle();
        $.startHeaderStyle();
    } else {
        $.scrollHeaderStyle();
    }
});

//ajax type setting 
const AJAX_TYPE_POST = "POST";
const AJAX_TYPE_GET = "GET";

/* 요소 */
const dayCreationbtn = document.querySelector("#btn");              // 일정생성 버튼 Element            
const testbtn = document.querySelector("#testbtn");              // 일정생성 버튼 Element            
var dateElement = document.getElementById("startDate");     // 출발일 Element
var daysElement = document.getElementById("days");          // 일수 Element
var decreaseButton = document.getElementById("decrease");   // - 버튼 Element 
var increaseButton = document.getElementById("increase");   // + 버튼 Element
var sdate;	                                              // 시작일 Element
var edate;	                                              // 종료일 Element

/* 플래그 */
var daysCheckFlag = false;                                   // 일정생성 flag
let isBtnSecondClick = false;

/* 계산을 위한 전역 변수들(초기화 필요) */
var sp_day = 0;                                           // 일자별 num Element
let betDistance = 0;
let totalDistance = 0;
let dpArrForAddedCheck = [];

/* 마커, 원, 선, 오버레이 등 객체와 배열 */
var marker;                                                 // 마커 Element
var over;	                                                  // over 열고/닫기 Element
var overlay;                                                // overlay Element
const distanceOverlays = [];
const betDistanceArr = [];

/* 세팅 */
let lineCrSet = [
  {
    "color" : "#FF0000"
  },
  {
    "color" : "#ff7300"
  },
  {
    "color" : "#89cf48"
  },
  {
    "color" : "#797EFC"
  },
  {
    "color" : "#ffad29"
  }
];



// =============== 공통 함수 ===============
var common =  {

	getInfo : function (method, url, type, data, callbackFunction) {
		$.ajax({
			type: method,
			url: 	url,
			data : (AJAX_TYPE_POST === type ? JSON.stringify ( data ) : data),
			contentType: (AJAX_TYPE_POST === type ? "application/json; charset=utf-8" : undefined),
			success : function(data) {
				callbackFunction(data);
			}
		});
  },
	getInfoSimple : function (method, url, callbackFunction) {
		$.ajax({
			type: method,
			url: 	url,
			success : function(data) {
				callbackFunction(data);
			}
		});
	}
}

// =============== 데이터 파싱 ===============
var parsing = {
	test : function(data) {
		console.log(data);
	},
	dataParsing  : function(data) {
		var html = "";
		var html1 = "";
		var list = data.lists;
		var count = data.count;
		if (count > 0) {
			html1 += `<p>${count} 개의 검색결과가 있습니다.</p>`;
		} else {
			html1 += `<tr><td colspan='4' align='center'>검색 결과가 없습니다.</td></tr>`;
		}
		if (Array.isArray(list)) {
			$.each(list, function (i, item) {
				html += `
						<div class="card mb-2">
								<div class="planCropImgBox">
									<img onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstImage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude});" class="card-img-top fixed1" src="${item.firstImage}" alt="Card image cap">
								</div>
								<div class="movie-item-body" style="text-align: center;padding-top: 2%;">
										<h6 onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstImage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude});" style="margin-bottom: 2%;font-weight: bold;">${item.title}</h6>
								</div>
								<div style="padding: .1rem 0 .1rem 0.3rem;background-color: rgba(0, 0, 0, .03); border-top: 1px solid rgba(0, 0, 0, .125);text-align: right;margin-right: 3%;">
										<button style="border-radius: 7%;" onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstImage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude}); showMovie(${item.contentId})" class="btn-primary btn-show-movie fixed2" data-toggle="modal" data-target="#show-movie-modal" data-id="${item.contentId}">More</button>
										<button style="border-radius: 7%;margin-left: 2%;" class="btn-info btn-add-favorite" data-id="${item.contentId}" onclick="addS_plan(${item.contentId})">+</button>
								</div>
						</div>`;
			});
		}
		$("#result").html(html1);
		$("#data-panel").html(html);
	},
  areaListParsing : function(data) {
    var areaCode = $('#areaCode');
    var areaCd;
    var areaNm;
    if (Array.isArray(data)) {
      $.each(data, function (i, item) {
        areaCd = item.areaCode;
        areaNm = item.areaName;

        areaCode.append($('<option>', {
          value: areaCd,
          text: areaNm,
          'data-latitude': item.latitude,
          'data-longitude': item.longitude,
          class: "item"
        }));
      });
    }
  },
  sigunguListParsing : function(data) {
    var areaCode = $('#areaCode').val();
    var sigunguCode = $('#sigunguCode');
    var sigunguCd;
    var sigunguNm;
    if (Array.isArray(data)) {
      $.each(data, function (i, item) {
        sigunguCd = item.sigunguCode;
        sigunguNm = item.sigunguName;
        sigunguCode.append($('<option>', {
          value: sigunguCd,
          text: sigunguNm,
          'data-latitude': item.latitude,
          'data-longitude': item.longitude,
          class: "item2"
        }));
      });
    }
  }
}


// =============== 데이터 랜더링 ===============
var draw = {
	elements : function(data) {
		common.getInfo('POST', '/myplan/selectTour', AJAX_TYPE_POST, data, parsing.dataParsing);
	},
  areaList : function() {
    common.getInfoSimple('GET', '/myplan/selectAreaLIst.json', parsing.areaListParsing);
  },
  sigunguList : function(data) {
    common.getInfo('POST', '/myplan/selectSigunguList', AJAX_TYPE_POST, data, parsing.sigunguListParsing);
  },
}


// =============== 유틸 함수 ===============

function sweetFn(msg, text, type) {
  Swal.fire({
      title: msg,
      text: text,
      icon: type
  });
}


// 유효성 검사
function checkNull() {
  //console.log("초기 sp_day 값 : " + sp_day)
  var areaCode = $("#areaCode").val();
  var sigunguCode = $("#sigunguCode").val();
  if (!areaCode) {
    sweetFn("", "지역을 선택해주세요.", "info");
    return false;
  } 
  if (!sigunguCode) {
    sweetFn("", "세부 지역을 선택해 주세요.", "info");
    return false;
  } 
  if (!daysCheckFlag) {
    sweetFn("", "일정 생성 버튼을 클릭해 주세요.", "info");
    return false;
  } 
  if (sp_day === 0) {
    sweetFn("", "Day 버튼을 클릭하여 Day를 선택해주세요.", "info");
    return false;
  }  
  return true;
  
}

// 플래너 작성 각각의 이미지 종횡비 변경 함수
$.eachPlanImgResizeFn = function(){
	$(".sidebar-menu").each(function(){
		var thisIs = $(this);
		var planCropImgBox = thisIs.find(".planCropImgBox");
		var planCropImg = thisIs.find("img");
		$.ratioBoxH(planCropImgBox, planCropImg);
	});
};


// =============== 기능 함수 ===============

// =============== 일정 관련 함수 ===============

// 버튼 클릭 이벤트
$("#keyword").on("keypress", function(e) {
  if(e.keyCode == '13'){
  	$('#searchBtn').click();
  }
});

// 카테고리별 검색
function search(value) {
	var keyword = document.querySelector("#keyword").value;
  var searchOption = value;
  var areaindex = $("#areaCode option:selected").attr("value");
  var sigunguIndex = $("#sigunguCode option:selected").attr("value");

	var data = {
    searchOption: searchOption,
    keyword: keyword,
    areaCode: areaindex,
    sigunguCode: sigunguIndex,
  };

  if (checkNull()) {
    draw.elements(data);
  }
}

// 데이트픽커 함수
flatpickr(dateElement, {
  dateFormat: "Y-m-d (D)",
  enableTime: true,
  minDate: "today",
  defaultDate: "today",
  locale: "ko",
});

// 요일 계산
dateElement.addEventListener("click", function () {
  var today = new Date();
  dateElement.textContent =
    today.getFullYear() + "-" + (today.getMonth() + 1) + "-" + today.getDate();
});

// 일수 빼기
decreaseButton.addEventListener("click", function () {
  var days = parseFloat(daysElement.value);
  if (days > 0.5) {
    days -= 0.5;
    daysElement.value = days;
  }
});

// 일수 더하기
increaseButton.addEventListener("click", function () {
  var days = parseFloat(daysElement.value);
  if (days < 5) {
    days += 0.5;
    daysElement.value = days;
  }
});

// 일정 생성 버튼 핸들러
const dcBtnClickHandler = () => {

  // console.log("isBtnSecondClick Check", isBtnSecondClick);
  // console.log("dpArrForAddedCheckBefore", dpArrForAddedCheck);

  // 첫번째 클릭이 아니면...
  if(isBtnSecondClick == false) {
    dpArrForAddedCheck = [{"day":1, "tourArrForDay":[]}]
    // console.log("첫번째 후 추가", dpArrForAddedCheck);
  }

  let startDate = dateElement.value;
  var days = parseInt(daysElement.value, 10);

  daysCheckFlag = true;
  if (days == 0) {
    days += 1;
  }

  console.log("값을 찍어보자 : " + startDate, days);

  if(isBtnSecondClick == true) {
    console.log("두번째 선택시 부터 처리입니다");

    //dpArrForAddedCheck.length = 기존 길이
    //days = 변경될 길이

    if(days >= dpArrForAddedCheck.length) {
      // console.log("날짜가 기존과 같거나 많아서 상관없음. 그려줄때만 다르게 처리");
      // 기존의 데이터들을 유지하되, days가 늘어난 만큼 배열을 추가함
    } else {
      // console.log("날짜가 기존보다 적어서 체크 필요함");
      let isExistData = false;

      let curDays = dpArrForAddedCheck.length;

      for(let i = curDays-1; i >= days; i--) {

        // 변경될 일수가 기존의 일수보다 적을때, 데이터가 존재하면 변경되지 않도록 해야한다.
        if(dpArrForAddedCheck[i].tourArrForDay.length != 0) {
          isExistData = true;  
        }

      }

      if(isExistData == true) {
        // console.log("날짜가 기존보다 적은데 줄어들 날짜에 데이터가 들어있습니다. 일수 변경을 중지합니다.");
        sweetFn("", "기존보다 줄어들 일수에 등록된 세부 플랜 데이터가 존재합니다. 삭제 후 진행해주세요.", "error");
        return;
      }
    }
  }

   generateSchedule(startDate, days);
  //  console.log("dpArrForAddedCheckAfter", dpArrForAddedCheck);

   isBtnSecondClick = true;

};

// 일수 선택 버튼
dayCreationbtn.addEventListener("click", dcBtnClickHandler);

// 시작일과 일수를 입력받아 일정을 생성하는 함수
function generateSchedule(startDate, days) {

  const scheduleElement = document.querySelector("#myTable > tbody");

  //console.log("시작일: " + startDate);

  sdate = getFormatDate(startDate);
  //console.log("시작일 포맷: " + sdate);

  // 종료일 계산
  edate = getEndDate(sdate, days);
  //console.log("종료일: " + edate);

  // 시작일을 Date 객체로 변환
  const currentDate = new Date(startDate);

  // 일정 비우기
  $("#plan-plansboxtitle").empty();

  // scheduleElement를 초기화
  scheduleElement.innerHTML = "";

  // 각 날짜에 대한 일정 생성 및 표시
  for (let i = 1; i <= days; i++) {
    // 한국 기준으로 날짜 표시를 위해 'ko-KR' 로케일을 사용합니다.
    const options = { month: "2-digit", day: "2-digit", weekday: "short" };
    const formattedDate = currentDate.toLocaleDateString("ko-KR", options);

    //console.log(formattedDate); // 출력: 01.11 (목)
    const dayElement = document.createElement("tr");
    dayElement.classList.add("day");
    dayElement.innerHTML =
      `<td class="day-cell">
				<button class="btn day-btn" id="daybtn${i}" value="${i}" onclick="daydo(value)">DAY ${i}</strong></button><br/>
				<span class="day-date">${formattedDate}</span>
			</td>`;
    scheduleElement.appendChild(dayElement);

    // 다음 날짜로 이동
    currentDate.setDate(currentDate.getDate() + 1);


    if(isBtnSecondClick == true) {
      // 변경될 일수가 더 많거나 같은경우
      let curSeq = dpArrForAddedCheck[dpArrForAddedCheck.length - 1].day;
      if(days == dpArrForAddedCheck.length) {
        daydo(days);
        console.log("같으면", sp_day);
      }
  
      if(days > dpArrForAddedCheck.length) {
        dpArrForAddedCheck.push({"day": curSeq+1, "tourArrForDay": []});
        daydo(days);
        console.log("크면", sp_day);
      }
    }

  }

  // 변경될 일수가 적은 경우, 줄어든 만큼 전체 배열에서 뺀다.(데이터가 존재하는지는 dcBtnClickHandler에서 체크.)
  if(days < dpArrForAddedCheck.length) {
    let tempLength = dpArrForAddedCheck.length
    for(let i = 0; i < tempLength - days; i++) {
      dpArrForAddedCheck.pop();
    }
    daydo(days);
    console.log("적으면", sp_day);
  }
    
}

// 요일 이름을 가져오는 함수
function getDayName(dayIndex) {
  var days = ["일", "월", "화", "수", "목", "금", "토"];
  return days[dayIndex];
}

// DAY 초기화 버튼(현재 사용되지 않음)
function dayReset() {
  var trCnt = $("#myTable tr").length;
  if (trCnt > 0) {

    // 일정 비우기
    $("#plan-plansboxtitle").empty();

    sp_day = 0; 
    daysCheckFlag = false;
    $("#myTable > tbody:last > tr ").remove();
    daysElement.value = 1;
    // dateElement를 초기화하는 부분
    var today = new Date();
    var formattedToday =
      today.getFullYear() +
      "-" +
      (today.getMonth() + 1).toString().padStart(2, "0") +
      "-" +
      today.getDate().toString().padStart(2, "0");
    formattedToday += " (" + getDayName(today.getDay()) + ")";

    dateElement._flatpickr.setDate(formattedToday); // flatpickr를 통해 날짜 설정
  } else {
    return false;
  }
}

// 일(Day1, Day2 ... 버튼) 선택
function daydo(value) {
  // alert("일정을 선택했습니다." + value);
  sp_day = value;
  // var plNo = $("#plNo").val();
  //console.log("sp_day 값 : " + sp_day);
  //console.log("플랜번호 : " + plNo);
  $("#plan-plansboxtitle").text("DAY" + sp_day);

  getDpForDay(sp_day);

}

//날짜 포멧 함수
function getFormatDate(inputDateStr) {
  const match = inputDateStr.match(/\d{4}-\d{2}-\d{2}/);

  const extractedDateStr = match ? match[0] : '';

  return extractedDateStr;
}

// 종료일자 가져오기
function getEndDate(startDate, days) {
  const currentDate = new Date(startDate);
  currentDate.setDate(currentDate.getDate() + days - 1);
  const endDate = currentDate.toISOString().split('T')[0];
  return endDate;
}


// 상단의 시작일을 변경하면, 왼쪽 박스에 날짜들도 함께 변경되는데, 
// 첫번째 클릭인 경우에는 이 이벤트를 발생시키지 않음
$("#startDate").on("change", function() {
  if(isBtnSecondClick == false) {
    return;
  } 

  // 날짜변경이라면...
  const startDate = dateElement.value;
  var days = parseInt(daysElement.value, 10);

  daysCheckFlag = true;
  if (days == 0) {
    days += 1;
  }
  
  generateSchedule(startDate, days);

});

// 여행 시작일을 변경하려고 클릭할 때, 두번째 클릭이라면 클릭 이벤트를 막고, 
// 바꾸려는 일수 days가 전체 일정의 갯수와 동일하지 않으면 변경을 막는다. 
$("#startDate").on("click", function(event) {
  if(isBtnSecondClick != false){
    event.preventDefault();
    clickResume();
  }
});

function clickResume(){
  var days = parseInt(daysElement.value, 10);

  if(days != dpArrForAddedCheck.length) {
    $(".flatpickr-calendar").hide();
    sweetFn("", "여행 일수가 기존의 일정과 일치하지 않아 변경하실 수 없습니다. 일수 조정 후 다시 시도해주세요.", "error");
    // alert("여행 일수가 기존의 일정과 일치하지 않아 변경하실 수 없습니다. 일수 조정 후 다시 시도해주세요.");
    return;
  } else {
    $(".flatpickr-calendar").show();
  }

}


// =============== 세부 플랜 CRUD ===============

// 세부 플랜 리스트 항목을 렌더링
function commonRendering(resArr) {
  var html = "";
    
  if (resArr.length === 0) {
    html += "<tr>";
    html += "<td colspan='4' align='center'>장소를 추가해주세요</td>";
    html += "</tr>";
  } else {
    $.each(resArr, function (i, item) {
        html += "<tbody class='list-tbody'><tr><td>"+(i+1)+"</td><td style='width: 30%;padding-top: 5%;font-size: smaller;'><img class='pic list-pic' src='" + item.firstImage + "'/>";
        
        if (item.title != null) {
          html += "" + item.title + "</td></tr>";
        } else {
            html += "장소명이 없습니다.</td></tr>";
        }

        if (item.address != null) {
            html += "<tr style='width: 100%;'><td style='width:5%;' rowspan='3'><img class='dpUp' style='cursor:pointer; width:18px; height:9px;' src='/resources/images/planner/dpUp.png'/><img class='dpDown' style='cursor:pointer; width:18px; height:9px;' src='/resources/images/planner/dpDown.png'/></td><td class='td-list' style='font-size: x-small;'>" + item.address + "</td></tr>";
        } else {
            html += "<tr style='width: 100%;'><tr><td class='td-list' style='font-size: x-small;'>주소가 없습니다.</td></tr>";
        }

        html += "<tr style='align-self:end;'><td class='td-del'><a class='link_a' style='font-size: smaller;margin-right: 10px;' onclick='delS_plan(" + item.spNo + ")'>삭 제</a></td></tr><tbody>";
    });
  }
  
  $("#card3").html(html);
}

/* 하루 전체 세부 플랜 조회 */
function getDpForDay(spDay) {
  if(marker!=null) {
    closeOverlay();
  }
  // 범위 리셋
  resetBounds();
  // 주요 변수 초기화
  resetVarAll();
  // 화면 초기화
  clearAll();

  if(spDay < 1) {
    return;
  }
  
  let plNo = $("#plNo").val();
  let data = {
    plNo: plNo, spDay : spDay
  };
  
  $.ajax({
    type: 'post',
    url: 	'/myplan/dayselect',
    data : JSON.stringify(data),
    contentType: "application/json; charset=utf-8",
    success : function(dataForDay) {

      if(!dataForDay) {
        sweetFn("", "데이터 조회 실패!", "error");
        return;
      }

      commonRendering(dataForDay);

      if(dataForDay.length > 0) {
        drawAllSps(dataForDay);
      }
      

      for(let i = 0; i < dataForDay.length; i++) {
        tourArr.push(dataForDay[i]);
        for(let i = 0; i < dpArrForAddedCheck.length-1; i++) {
          if(dpArrForAddedCheck[i].day == spDay) {
            dpArrForAddedCheck[i].tourArrForDay.push(dataForDay[i]);
          }
        }
      }

      // console.log("dataForDay", dataForDay);
      // console.log("dpArrForAddedCheck 데이 선택시", dpArrForAddedCheck);
      
    }
  });
}

/* 세부 플랜 등록(장소 선택) */
function addS_plan(contentid) {
  if(marker != null) {
    closeOverlay();
  }

  let plNo = $("#plNo").val();
  let parent =  $("#card3");
  let num = parent.find(".list-tbody").length;
  let sp_sday = sdate;
  let sp_eday = edate;

  const insData = {
    spDay: sp_day,
    spSday: sp_sday,
    spEday: sp_eday,
    contentId: contentid, 
    plNo: plNo,
    spOrder : tourArr.length + 1
  };

  // 일정을 9까지만 추가 가능하도록
  if(num < 9) {
    // 조회하고 마커 찍기
    getTour(insData, insDp);
  } else {
    sweetFn("", "일정은 최대 9개로 제한됩니다.", "info");
    return;
  }

}

/* 하나의 장소를 조회 */
function getTour(insData, insDpCallback) {
  $.ajax({
    type: 'get',
    url: 	'/myplan/getTour',
    data : { "contentId" : insData.contentId },
    success : function(tourData) {

      if(!tourData) {
        sweetFn("", "해당 장소는 플랜에 등록할 수 없습니다. 관리자에게 문의해주시기 바랍니다.", "error");
        return;
      }

      // 조회 후, 인서트 작업
      insDpCallback(insData, tourData);
    }
  });
}

/* 세부플랜 인서트 */
let insDp = function insDp(insData, tourData) {
  
  $.ajax({
    type: 'post',
    url: 	'/myplan/insDp',
    contentType : "application/json; charset=utf-8",
    data : JSON.stringify(insData),
    success : function(res) {

      if(res == null || res.length == 0) {
        
        sweetFn("", "세부플랜 등록에 실패하였습니다.", "error");
        clearAll();
        getDpForDay(sp_day);
        return;
      }

      // 등록한 장소 배열에 추가
      tourArr.push(res);
      for(let i = 0; i < dpArrForAddedCheck.length; i++) {
        if(dpArrForAddedCheck[i].day == sp_day) {
          dpArrForAddedCheck[i].tourArrForDay.push(res);
        }
      }

      console.log("등록 장소 체크", dpArrForAddedCheck);

      // 세부플랜 리스트
      commonRendering(tourArr);
      
      // 마커
      drawOneDp(res);
      
    }
  });
}


function clickDayDelAll() {

  Swal.fire({
    title: "전체삭제",
    text: "해당일자의 일정들을 전체 삭제하시겠습니까?",
    icon: "question",
    showDenyButton: true,
    confirmButtonText: "예",
    denyButtonText: "아니오"
  }).then((result) => {
    /* Read more about isConfirmed, isDenied below */
    if (result.isConfirmed) {
      dayDelAll();
    } else if (result.isDenied) {
      return;
    }
  });
  
}

/* 일자내 세부플랜 전체 삭제 */
function dayDelAll() {

  var plNo = $("#plNo").val();
  var parent =  $("#card3");
  var num = parent.find(".list-tbody").length;
  var delData = {
    spDay: sp_day,
    plNo: plNo
  };

  if(num == 0) {
    sweetFn("", "등록된 장소가 하나도 없습니다.", "error");
    return;
  }

  $.ajax({
    type: 'post',
    url: 	'/myplan/delAllDp',
    contentType : "application/json; charset=utf-8",
    data : JSON.stringify(delData),
    success : function(res) {

      if(res === "OK") {
        getDpForDay(sp_day);

        for(let i = 0; i < dpArrForAddedCheck.length; i++) {
          if(dpArrForAddedCheck[i].day == sp_day) {
            dpArrForAddedCheck[i].tourArrForDay.length = 0;
          }
        }
        // console.log("전체삭제 완료1", dpArrForAddedCheck);
        // console.log("전체삭제 완료2", tourArr);

      } else {
        sweetFn("", "세부플랜 전체 삭제에 실패하였습니다.", "error");
        return;
      }
    }
  });
}

/* 세부플랜 개별 삭제 */
function delS_plan(spNo) {

  var plNo = $("#plNo").val();
  var delOnedata = {
    spDay: sp_day,
    spNo: spNo,
    plNo: plNo
  };

  //console.log("JSON.stringify(delOnedata):", JSON.stringify(delOnedata));

  $.ajax({
    type: 'post',
    url: 	'/myplan/delOneDp',
    contentType : "application/json; charset=utf-8",
    data : JSON.stringify(delOnedata),
    success : function(res) {

      if(res === "OK") {
        getDpForDay(sp_day);

        for(let i = 0; i < dpArrForAddedCheck.length; i++) {
          if(dpArrForAddedCheck[i].day == sp_day) {
            dpArrForAddedCheck[i].tourArrForDay.length = 0;
          }
        }

      } else {
        sweetFn("", "세부플랜 삭제에 실패하였습니다.", "error");
        return;
      }
    }
  });
}

function delAllAllDp(resetInputAllCallback, isGoListBtnClicked) {

  var plNo = $("#plNo").val();
  //console.log("plNo", plNo);
  var parent =  $("#card3");
  var num = parent.find(".list-tbody").length;
  var delData = {
    plNo: plNo
  };

  // if(num == 0) {
  //   return;
  // }

  $.ajax({
    type: 'post',
    url: 	'/myplan/delAllAllDp',
    contentType : "application/json; charset=utf-8",
    data : JSON.stringify(delData),
    success : function(res) {

      if(res === "OK") {
        getDpForDay(sp_day);
      } else {
        //alert("전체 삭제에 실패하였습니다.");
      }

      if(isGoListBtnClicked == true) {
        location.href="/myplan/planMain.do";
      }
      resetInputAllCallback();

    }
  });
}

$("#plannerResetBtn").on("click", function() {

  Swal.fire({
    title: "",
    text: "작성한 모든 정보가 초기화됩니다. 계속하시겠습니까?",
    icon: "question",
    showDenyButton: true,
    confirmButtonText: "예",
    denyButtonText: "아니오"
  }).then((result) => {
    if (result.isConfirmed) {
      sweetFn("", "모든 내용이 초기화되었습니다.", "success");
      delAllAllDp(resetInputAll, false);
    } else if (result.isDenied) {
      return;
    }
  });

});

$("#plannerListGoBtn").on("click", function() {
  // let isGoListBtnClicked = true;
  // delAllAllDp(resetInputAll, isGoListBtnClicked);
  Swal.fire({
    text: "현재 작성하고 있는 플랜의 데이터가 저장되지 않습니다. 계속하시겠습니까?",
    icon: "question",
    showDenyButton: true,
    confirmButtonText: "예",
    denyButtonText: "아니오"
  }).then((result) => {
    if (result.isConfirmed) {
      delPlan();
    } else if (result.isDenied) {
      return;
    }
  });
  
});

function delPlan() {
  var plNo = $("#plNo").val();

  $.ajax({
    type: 'get',
    url: 	'/myplan/delPlan',
    data : {"plNo" : plNo},
    success : function(res) {

      if(res === "OK") {
        location.href="/myplan/planMain.do";
      } else {
        // sweetFn("", "삭제실패", "error")
      }

    }
  });

}


let resetInputAll = function resetInputAll() {
  isBtnSecondClick = false;

  $("#p_title").val('');
  // $("#startDate").val('');
  $("#areaCode option:eq(0)").prop("selected", true);
  $("#sigunguCode option:eq(0)").prop("selected", true);
  $("#days").val('1');
  $("#test1 option:eq(0)").prop("selected", true);
  $("#test2 option:eq(0)").prop("selected", true);
  dayReset();
  let tempArr = [];
  commonRendering(tempArr);
  $("#card3").html('');
  $("#data-panel").empty();
  $("#keyword").val('');
  $(".select-job-items2").find("#result").empty();
}

let test2El = $("#test2");
let test1El = $("#test1");
test2El.change(function(){
  let tempStr = "";
  if($("#test2 option:selected").val() == '혼자') {
    tempStr += `<option value="" selected="selected">인원 선택</option>
  <option value="1">1인</option>`;
    test1El.empty();
    test1El.html(tempStr);
    test1El.val('1').trigger('change');
  } else {
    tempStr += `<option value="" selected="selected">인원 선택</option>
    <option value="1">1인</option>
    <option value="2">2인</option>
    <option value="3">3인</option>
    <option value="4">4인</option>
    <option value="5">5인 이상</option>`;
    test1El.empty();
    test1El.html(tempStr);
    test1El.val('').trigger('change');
  }
});

// 플랜 저장
function savePlanner(){

  let noDataFlg = false;
  // 시작일 계산
  let tempDays = parseInt(daysElement.value);
  let tempSdate = getFormatDate(dateElement.value);
  // 종료일 계산
  let tempEdate = getEndDate(tempSdate, tempDays);

  let sp = document.getElementById('card3').innerText;
  let p_title = $("#p_title").val();
  let plMsize = $("#test1 option:selected").val();
  let plTheme = $("#test2 option:selected").val();

  /* 검증 */
  if(p_title == null || p_title==""){
    sweetFn("", "여행 플래너의 제목을 입력해주세요.", "info");
    $("#p_title").focus();
    return false;
  }

  // if(!checkNull()) {
  //   return false;
  // }
  
  if(sp==null || sp == "장소를 추가해주세요" || sp==""){
    sweetFn("", "여행 플래너에 장소를 추가해주세요.", "info");
    return false;
  } 
  
  if (plTheme == null || plTheme == "") {
    sweetFn("", "여행테마가 선택되지 않았습니다.", "info");
    return false;
  }
  
  if (plMsize == null || plMsize == "") {
    sweetFn("", "모집인원이 선택되지 않았습니다.", "info");
    return false;
  }
  


  /* 장소가 등록되지 않은 날짜 존재여부 확인 */
 for(let i = 0; i < dpArrForAddedCheck.length; i++) {
    if(dpArrForAddedCheck[i].tourArrForDay.length == 0) {
      noDataFlg = true;
    }
  }
  
  if(noDataFlg == true) {
    sweetFn("", "장소를 등록하지 않은 일자가 존재합니다.", "info");
    return;
  }

  /* 폼 전송 위한 데이터 세팅 */
  $("#plMsize").val(plMsize);
  $("#plTitle").val(p_title);
  $("#plTheme").val(plTheme);
  $("#spSday").val(tempSdate);
  $("#spEday").val(tempEdate);

  document.planSaveForm.submit();

}


// =============== 지도 제어 관련 함수 ===============

// 지도의 중심지점으로 이동
function moveMapCenter(latitude, longitude) {
  // 이동할 위도 경도 위치를 생성합니다 
  let moveLatLon = new kakao.maps.LatLng(latitude, longitude);
   
   // 지도 중심을 이동 시킵니다
  map.setCenter(moveLatLon);
}

// 마크 좌표 이동
function setMapitems(latitude, longitude, title, firstimage, address, zipcode) {
  marker = new kakao.maps.Marker({
    map : map,
    position : new kakao.maps.LatLng(latitude, longitude)
  });
  markers.push(marker);
  
  var content = '<div class="wrap" id="over">' +
  '    <div class="info">' +
  '        <div class="title1">' +
  '          ' + title + '' +
  '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
  '        </div>' +
  '        <div class="body">' +
  '            <div class="img">' +
  '                <img src=' + firstimage + '; width="73" height="70">' +
  '           </div>' +
  '            <div class="desc">' +
  '                <div class="ellipsis">' + address + '</div>' +
  '                <div class="jibun ellipsis">(우) ' + zipcode + '</div>' +
  '            </div>' +
  '        </div>' +
  '    </div>' +
  '</div>';
  
  overlay = new kakao.maps.CustomOverlay({
    content: content,
    map: map,
    position: marker.getPosition(),
    yAnchor: 1,
    zIndex: 3
  });
  
  // 마커를 클릭했을 때 커스텀 오버레이를 표시합니다
  kakao.maps.event.addListener(marker, 'click', function () {
    closeOverlay();
    overlay.setMap(map);
  });
}

// 마크 셋팅
function markerm(latitude, longitude, title, firstimage, address, zipcode) {
  if (marker != null || overlay != null) {
    closeOverlay();
    setMapitems(latitude, longitude, title, firstimage, address, zipcode);
  } else {
    setMapitems(latitude, longitude, title, firstimage, address, zipcode);
  }
}

// 이동할 위도 경도 위치 생성
function panTo(latitude, longitude) {
  // 이동할 위도 경도 위치를 생성합니다 
  var moveLatLon = new kakao.maps.LatLng(latitude, longitude);

  // 지도 중심을 부드럽게 이동시킵니다
  // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
  map.panTo(moveLatLon);
}

// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
  over = document.getElementById('over');
  if (over != null) over.remove();
  marker.setMap(null);
}



// =============== 그리기 관련 함수 ===============

// 선택한 장소 한개 그리기
function drawOneDp(oneTour) {
  clearOverlays(distanceOverlays);
  const latlng = new kakao.maps.LatLng(oneTour.latitude, oneTour.longitude);

  createMarkerAndCircle(latlng, tourArr.length);

  getTourBounds.extend(latlng);
  map.setBounds(getTourBounds);

  //console.log("지금까지 선택된 장소", tourArr);

  // 장소가 2개 이상일때 부터 선 찍기 / 두 선사이의 거리 측정
  if(tourArr.length > 1) {

        let tour1 = tourArr[tourArr.length-2];
        let tour2 = tourArr[tourArr.length-1];

        const tourPosition1 = new kakao.maps.LatLng(tour1.latitude, tour1.longitude);
        const tourPosition2 = new kakao.maps.LatLng(tour2.latitude, tour2.longitude);

  const twolatLngArr = [];
  twolatLngArr.push(tourPosition1);
  twolatLngArr.push(tourPosition2);
  createPolyLine(twolatLngArr);

  }

}

/* 세부플랜 전부 그리기 */
function drawAllSps(spForDayArr) {
			
  const allLatLng = [];			// 선 그리기를 위해 모든 장소의 좌표를 담을 배열

  // ajax로 가져온 전체 장소 반복문 돌려서 그리기
  for (let i = 0; i < spForDayArr.length; i ++) {
      //console.log("haruSpArr에서 가져온 세부플랜 조회 : ", spForDayArr[i]);

      // 마커찍기 위해 최소한의 정보들 저장
      const spOrder = spForDayArr[i].spOrder;
      const latitude = spForDayArr[i].latitude;
      const longitude = spForDayArr[i].longitude;
      const latlng = new kakao.maps.LatLng(latitude, longitude)

      createMarkerAndCircle(latlng, i+1);      // * 마커, 점 찍기 (DB에서 가져올때 중간에 숫자가 비는 경우가 생길 수 있으니까 index로 spOrder를 설정)
      getTourBounds.extend(latlng);                   // 범위 재설정을 위한 범위 확장
      allLatLng.push(latlng);                  // 선 그리기 위해서 모든 좌표 객체 한 배열에 담기
      
  }

  createPolyLine(allLatLng);                  // * 선 그리기
  map.setBounds(getTourBounds);                      // 범위 재설정

}




// =============== 그리기 관련 세부 함수 ===============

// 마커 찍기
function createMarkerAndCircle(latlng, spOrder) {	

// 마커 이미지 세팅
let imageSrc = '/resources/images/planner/marker_red.png';
//let imageSrc = '/resources/images/planner/marker_blue.png';
console.log("sp_day",sp_day);
if(sp_day > 0 && sp_day < 6) {
  imageSrc = '/resources/images/planner/marker_number_d'+sp_day+'.png';
}

let imageSize = new kakao.maps.Size(36, 37);

const imgOptions =  {
    spriteSize : new kakao.maps.Size(36, 691),                      // 스프라이트 이미지의 크기
    spriteOrigin : new kakao.maps.Point(0, ((spOrder-1)*46)+10),    // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
    offset: new kakao.maps.Point(13, 37)                            // 마커 좌표에 일치시킬 이미지 내에서의 좌표
};

let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions); 

// 마커 생성
let marker = new kakao.maps.Marker({
    position: latlng, 
    // title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
    image : markerImage,
    zIndex: 2 
});

// 점 생성(커스텀 오버레이)
const circleOverlay = new kakao.maps.CustomOverlay({
    content: '<span class="dot"></span>',
    position: latlng,
    zIndex: 1
});

markers2.push(marker);           // 마커 모음 배열에 저장(삭제 등 제어를 위함)
marker.setMap(map);             // 모든 마커 표시
circleOverlays.push(circleOverlay);
// circleOverlay.setMap(map);

}


// 선
function createPolyLine(latLngs) {

  let lineColor = "#FF0000";

  if(sp_day > 1 && sp_day < 6) {
    lineColor = lineCrSet[sp_day-1].color;
    //console.log("sp_day", sp_day);
    //console.log("lineCrSet[sp_day-1].color", lineCrSet[sp_day-1].color);
  }

  // 지도에 선을 표시
  const polyline = new kakao.maps.Polyline({
      map : map, 					// 선을 표시할 지도 객체 
      path : latLngs,				// 선을 구성하는 좌표
      strokeWeight : 6, 			// 선의 두께
      strokeColor : lineColor, 	// 선 색
      // strokeColor : '#434ff5', 	// 선 색
      strokeOpacity : 0.7, 		// 선 투명도
      strokeStyle : 'dotted' 		// 선 스타일
  });

  polylines.push(polyline);

  // 거리 측정
  console.log("두 장소 간 거리: " + polyline.getLength());

  // 거리 누적
  totalDistance += polyline.getLength();

  betDistance = polyline.getLength();
  betDistanceArr.push(betDistance);
  // 삭제나 수정인 경우 거리측정 하지 않도록 하기(일단은)
  // if(isUpDel) {
  //     isUpDel = false;
  //     return;
  // }


  let content;
  if(tourArr.length < 9) {
      console.log("현재까지의 누적 거리: " + totalDistance);
      // displayDistance(new kakao.maps.LatLng(testLat, testLng), Math.round(polyline.getLength()));
      content = getTimeHTML(Math.round(polyline.getLength()), "");
  } else {
      console.log("총 누적 거리: " + totalDistance);
      content = getTimeHTML(Math.round(totalDistance), "총 ");
  }	

  displayDistance(content, latLngs[latLngs.length-1]);

}

// 동선 거리
function displayDistance(content, position) {

  let distanceOverlay = new kakao.maps.CustomOverlay({
      content: content,
      position: position,
      yAnchor: 1,
      zIndex: 2
  });


  distanceOverlays.push(distanceOverlay);
  // 거리표시
  distanceOverlay.setMap(map);

}


function getTimeHTML(distance, isTotal) {

    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
    var walkkTime = distance / 67 | 0;
    var walkHour = '', walkMin = '';

    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
    if (walkkTime > 60) {
        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
    }
    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
    var bycicleTime = distance / 227 | 0;
    var bycicleHour = '', bycicleMin = '';

    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
    if (bycicleTime > 60) {
        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
    }
    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
    var content = '<ul class="dotOverlay distanceInfo">';
    content += '    <li>';
    if(distance > 1000) {
        content += '        <span class="label">'+isTotal+'거리</span><span class="number">' + (distance/1000).toFixed(1) + '</span>km';
    } else {
        content += '        <span class="label">'+isTotal+'거리</span><span class="number">' + distance + '</span>m';
    }
    content += '    </li>';
    content += '    <li>';
    content += '        <span class="label">도보</span>' + walkHour + walkMin;
    content += '    </li>';
    content += '    <li>';
    content += '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
    content += '    </li>';
    content += '</ul>'

    return content;
}        




// =============== 초기화 관련 함수 ===============

// 범위 재생성
function resetBounds() {
  // console.log("getTourbounds before", getTourBounds);
  getTourBounds = new kakao.maps.LatLngBounds();
  // map.setCenter(new kakao.maps.LatLng(37.56682, 126.97865));
  // 선택된 옵션을 가져옴
  var selectedAreaOption = $("#areaCode").find(':selected');
  var selectedOption = $("#sigunguCode").find(':selected');

  // 데이터 속성에서 위도와 경도 값을 가져옴
  var latitude = selectedOption.data('latitude');
  var longitude = selectedOption.data('longitude');
  
  if (!latitude || !longitude) {
    latitude = selectedAreaOption.data('latitude');
    longitude = selectedAreaOption.data('longitude');
    
    if(!latitude || !longitude) {
      latitude = 37.56682; // 서울의 위도
      longitude = 126.97865; // 서울의 경도
    }

  }

  moveMapCenter(latitude, longitude);	
  map.setLevel(6);

}


// 오버레이 추상화
function clearOverlays(overlays) {
  overlays.forEach(overlay => overlay.setMap(null));
  overlays.length = 0;
}

// 전부 지우기(마커, 선, 원)
function clearAll() {
  clearOverlays(markers2);
  clearOverlays(polylines);
  clearOverlays(circleOverlays);
  clearOverlays(distanceOverlays);
}
  
function resetVarAll() {
  tourArr.length = 0;
  // console.log("장소선택 초기화");
  //haruSpArr.length = 0;
  // console.log("전체일정 초기화");
  totalDistance = 0;
  // console.log("누적 거리 초기화");
  betDistance = 0;
  // console.log("두 장소 간 거리 초기화");
  betDistanceArr.length = 0;
  // console.log(sp_day);
  for(let i = 0; i < dpArrForAddedCheck.length-1; i++) {
    // console.log(dpArrForAddedCheck[i].day);
    if(dpArrForAddedCheck[i].day == sp_day) {
      dpArrForAddedCheck[i].tourArrForDay = [];
    }
  }
  // console.log("초기화 후...",  dpArrForAddedCheck);

}

/* 마커 삭제시 위치 재조정 */

// =============== 테스트용 함수 ===============

// 마커 테스트를 위한 테스트 환경
// 날짜, 지역 자동 선택 
// 컨트롤러에서 로그인 체크 부분 하드코딩 주석 풀기
const testButtonClickHandler = () => {
  if(isBtnSecondClick == false) {
    dpArrForAddedCheck = [{"day":1, "tourArrForDay":[]}]
    //console.log("추가", dpArrForAddedCheck);
  }
  generateSchedule(dateElement.value, 5);
  var areaCodeOpt = $("#areaCode").find(".item");
  for(var i = 0; i < areaCodeOpt.length; i++){
    if(areaCodeOpt[i].value == "3"){
      areaCodeOpt[i].selected = true;
    }
  }
  $('#areaCode').change();
  setTimeout(() => {
    var gugunCodeOpt = $("#sigunguCode").find(".item2");
    for(var i = 0; i < gugunCodeOpt.length; i++){
      if(gugunCodeOpt[i].value == "3"){
        gugunCodeOpt[i].selected = true;
      }
    }
    $("#sigunguCode").change();
    $("#daybtn1").trigger("click");
    $("#touraBtn[value='A01']").trigger("click");
  }, 300);
  daysCheckFlag = true;
  sigunguCode = true;
}
testbtn.addEventListener("click", testButtonClickHandler);

//
function fnForDebug() {
  console.log("*******************************************");
  console.log("디버깅(tourArr) : " , tourArr );
  console.log("디버깅(sdate) : " , sdate );
  console.log("디버깅(edate) : " , edate );
  console.log("디버깅(daysCheckFlag) : " , daysCheckFlag );
  console.log("디버깅(sp_day) : " , sp_day );
  console.log("디버깅(markers) : " , markers );
  console.log("디버깅(markers2) : " , markers2 );
  console.log("디버깅(getTourBounds) : " , getTourBounds);
  console.log("디버깅(circleOverlays) : " , circleOverlays);
  console.log("디버깅(polylines) : " , polylines);
  console.log("디버깅(totalDistance) : " , totalDistance );
  console.log("디버깅(distanceOverlays) : " , distanceOverlays );
  console.log("디버깅(betDistance) : " , betDistance );
  console.log("*******************************************");

}

// 사진 업로드 모달창
$.PicUpModalFn = function () {
  // 모달창 닫기
  var modalSave = $(".modalSave");
  var modalClose = $(".modalClose");
  var infoModalContents = $(".infoModalContents");
  let profileImg = $("#profileImg");
  modalSave.click(function () {
      infoModalContents.hide();
  });
  modalClose.click(function () {
      $("#imgFile").val("");
      profileImg.attr("src", "/resources/images/default_profile.png");
      infoModalContents.hide();
  });
  // 모달창 열기
  var journeyInfoContents = $(".journeyInfoContents");
  journeyInfoContents.click(function () {
      
      infoModalContents.show();
      
  });
};

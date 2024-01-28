//ajax type setting 
const AJAX_TYPE_POST = "POST";
const AJAX_TYPE_GET = "GET";

/* 요소 */
const daybtn = document.querySelector("#btn");              // 일정생성 버튼 Element            
const testbtn = document.querySelector("#testbtn");              // 일정생성 버튼 Element            
var dateElement = document.getElementById("startDate");     // 출발일 Element
var daysElement = document.getElementById("days");          // 일수 Element
var decreaseButton = document.getElementById("decrease");   // - 버튼 Element 
var increaseButton = document.getElementById("increase");   // + 버튼 Element
var sdate;	                                              // 시작일 Element
var edate;	                                              // 종료일 Element

/* 플래그 */
var daysCheckFlag = false;                                   // 일정생성 flag

/* 계산을 위한 전역 변수들(초기화 필요) */
var sp_day = 0;                                           // 일자별 num Element
let betDistance = 0;
let totalDistance = 0;

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
    "color" : "#ecff24"
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
				//console.log("체킁:",data);
				callbackFunction(data);
			}
		});
  },
	getInfoSimple : function (method, url, callbackFunction) {
		$.ajax({
			type: method,
			url: 	url,
			success : function(data) {
				//console.log("체킁:",data);
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
			// console.log("배열입니다.");
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
    // console.log("값들 : ", data);
    if (Array.isArray(data)) {
      // console.log("배열입니다.");
      $.each(data, function (i, item) {
        areaCd = item.areaCode;
        areaNm = item.areaName;

        //console.log("지역코드 : ", areaCd);
        //console.log("지역명 : ", areaNm);
        areaCode.append($('<option>', {
          value: areaCd,
          text: areaNm,
          'data-latitude': item.latitude, // Add latitude as a data attribute
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
    //console.log("지역코드 : ", areaCode);
    //console.log("값들 : ", data);
    if (Array.isArray(data)) {
      //console.log("배열입니다.");
      $.each(data, function (i, item) {
        sigunguCd = item.sigunguCode;
        sigunguNm = item.sigunguName;
        //console.log("시군구코드 : ", sigunguCd);
        //console.log("시군구명 : ", sigunguNm);
        sigunguCode.append($('<option>', {
          value: sigunguCd,
          text: sigunguNm,
          'data-latitude': item.latitude, // Add latitude as a data attribute
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

// 유효성 검사
function checkNull() {
  console.log("초기 sp_day 값 : " + sp_day)
  var areaCode = $("#areaCode").val();
  var sigunguCode = $("#sigunguCode").val();
  if (!areaCode) {
    alert("지역을 선택해주세요.");
    return false;
  } 
  if (!sigunguCode) {
    alert("세부 지역을 선택해 주세요.");
    return false;
  } 
  if (!daysCheckFlag) {
    alert("일정 생성 버튼을 클릭해 주세요.");
    return false;
  } 
  if (sp_day === 0) {
    alert("Day 버튼을 클릭하여 Day를 선택해주세요.");
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

// 카테고리별 검색
function search(value) {
	var keyword = document.querySelector("#keyword").value;
  var searchOption = value;
  var areaindex = $("#areaCode option:selected").attr("value");
  var sigunguIndex = $("#sigunguCode option:selected").attr("value");
  console.log("입력한 키워드 : " + keyword);
  console.log("선택한 옵션 : " + searchOption);
  console.log("선택한 지역 : " + areaindex);
  console.log("선택한 시군구 : " + sigunguIndex);

	var data = {
    searchOption: searchOption,
    keyword: keyword,
    areaCode: areaindex,
    sigunguCode: sigunguIndex,
  };

  if (checkNull()) {
    // console.log("checkNull 값 : " + checkNull);
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

const buttonClickHandler = () => {
  // alert('Button clicked!');
  const startDate = dateElement.value;
  var days = parseInt(daysElement.value, 10);

  console.log("daysCheckFlag 값 : " + daysCheckFlag);
  
  daysCheckFlag = true;
  if (days == 0) {
    days += 1;
  }
  console.log("daysCheckFlag 값 : " + daysCheckFlag);

  console.log("값을 찍어보자 : " + startDate, days);

  generateSchedule(startDate, days);
};


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
  }
}

daybtn.addEventListener("click", buttonClickHandler);


// 요일 이름을 가져오는 함수
function getDayName(dayIndex) {
  var days = ["일", "월", "화", "수", "목", "금", "토"];
  return days[dayIndex];
}

// DAY 초기화 버튼
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

// 일정 선택
function daydo(value) {
  // alert("일정을 선택했습니다." + value);
  sp_day = value;
  var plNo = $("#plNo").val();
  console.log("sp_day 값 : " + sp_day);
  console.log("플랜번호 : " + plNo);
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
        alert("데이터 조회 실패!");
        return;
      }

      console.log("dataForDay", dataForDay)

      commonRendering(dataForDay);

      if(dataForDay.length > 0) {
        drawAllSps(dataForDay);
      }
      
      for(let i = 0; i < dataForDay.length; i++) {
        tourArr.push(dataForDay[i]);
      }
      
    }
  });
}

/* 세부 플랜 등록(장소 선택) */
function addS_plan(contentid) {
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
    alert("일정은 최대 9개로 제한됩니다.");
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
        alert("해당 장소는 플랜에 등록할 수 없습니다. 관리자에게 문의해주시기 바랍니다.");
        return;
      }

      // 결과 출력(디버깅)
      // fnForDebug();

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
        alert("세부플랜 등록에 실패하였습니다.");
        clearAll();
        getDpForDay(sp_day);
        return;
      }

      // 등록한 장소 배열에 추가
      tourArr.push(res);

      console.log("돼냐 : ", tourArr);
      // 세부플랜 리스트
      commonRendering(tourArr);
      // 마커
      drawOneDp(res);
      
    }
  });
}

/* 일자내 세부플랜 전체 삭제 */
function dayDelAll() {
  if(!confirm("해당일자의 일정들을 전체 삭제하시겠습니까?")) {
    return;
  }

  var plNo = $("#plNo").val();
  var parent =  $("#card3");
  var num = parent.find(".list-tbody").length;
  var delData = {
    spDay: sp_day,
    plNo: plNo
  };

  if(num == 0) {
    alert("등록된 장소가 하나도 없습니다.");
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
      } else {
        alert("세부플랜 전체 삭제에 실패하였습니다.");
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

  console.log("JSON.stringify(delOnedata):", JSON.stringify(delOnedata));

  $.ajax({
    type: 'post',
    url: 	'/myplan/delOneDp',
    contentType : "application/json; charset=utf-8",
    data : JSON.stringify(delOnedata),
    success : function(res) {

      if(res === "OK") {
        getDpForDay(sp_day);
      } else {
        alert("세부플랜 삭제에 실패하였습니다.");
        return;
      }
    }
  });
}

function delAllAllDp(resetInputAllCallback, isGoListBtnClicked) {

  var plNo = $("#plNo").val();
  console.log("plNo", plNo);
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
  if(!confirm("작성한 모든 정보가 초기화됩니다. 계속하시겠습니까?")) {
    return;
  }

  delAllAllDp(resetInputAll, false);

});

$("#plannerListGoBtn").on("click", function() {
  let isGoListBtnClicked = true;
  delAllAllDp(resetInputAll, isGoListBtnClicked);
});

let resetInputAll = function resetInputAll() {
  $("#p_title").val('');
  $("#startDate").val('');
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
	  var sp = document.getElementById('card3').innerText;
	  var p_title = $("#p_title").val();
    var plMsize = $("#test1 option:selected").val();
    var plTheme = $("#test2 option:selected").val();
    let plNo = $("#plNo").val();
    let planSaveForm = $("#planSaveForm");
	  console.log("sp : " + sp);
	  console.log("제목 : " + p_title);
	  console.log("시작일 : " + sdate);
	  console.log("종료일 : " + edate);
    console.log("plMsize : " + plMsize);
    console.log("plTheme : " + plTheme);
	  if(p_title == null || p_title==""){
	    alert("여행 플래너의 제목을 입력해주세요.");
	    $("#p_title").focus();
	    return false;
	  }
    
    if(sp==null || sp == "장소를 추가해주세요" || sp==""){
	  	alert("여행 플래너에 장소를 추가해주세요.");
	  	return false;
	  } 
    
    if (plMsize == null || plMsize == "") {
      alert("모집인원이 선택되지 않았습니다.");
      return false;
	  }
    
    if (plTheme == null || plTheme == "") {
      alert("여행테마가 선택되지 않았습니다.");
      return false;
	  }
    console.log("document.planSaveForm : ", document.planSaveForm);

    $("#plMsize").val(plMsize);
    $("#plTitle").val(p_title);
    $("#plTheme").val(plTheme);

    document.planSaveForm.submit();
    // var udtData = {
    //   "plNo" : plNo,
    //   "plTitle" : p_title,
    //   "plMsize" : plMsize,
    //   "plTheme" : plTheme
    // }
    // console.log("JSON.stringify", JSON.stringify(udtData));

    // $.ajax({
    //   type: 'post',
    //   url: 	'/myplan/updatePlan',
    //   contentType : "application/json; charset=utf-8",
    //   data : JSON.stringify(udtData),
    //   success : function(res) {
  
    //     if(res === "OK") {
    //       alert("등록 성공!");
    //       location.href="/myplan/planMain.do";
    //     } else {
    //       alert("등록에 실패하였습니다. 모든 정보를 입력했는지 확인해주세요");
    //       return;
    //     }
    //   }
    // });

    

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

  console.log("지금까지 선택된 장소", tourArr);

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
    console.log("sp_day", sp_day);
    console.log("lineCrSet[sp_day-1].color", lineCrSet[sp_day-1].color);
  }

  // 지도에 선을 표시
  const polyline = new kakao.maps.Polyline({
      map : map, 					// 선을 표시할 지도 객체 
      path : latLngs,				// 선을 구성하는 좌표
      strokeWeight : 6, 			// 선의 두께
      strokeColor : lineColor, 	// 선 색
      // strokeColor : '#434ff5', 	// 선 색
      strokeOpacity : 1, 		// 선 투명도
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
}

/* 마커 삭제시 위치 재조정 */

// =============== 테스트용 함수 ===============

// 마커 테스트를 위한 테스트 환경
// 날짜, 지역 자동 선택 
// 컨트롤러에서 로그인 체크 부분 하드코딩 주석 풀기
const testButtonClickHandler = () => {
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
  var modalClose = $(".modalClose");
  var infoModalContents = $(".infoModalContents");
  modalClose.click(function () {
      infoModalContents.hide();
  });
  // 모달창 열기
  var journeyInfoContents = $(".journeyInfoContents");
  journeyInfoContents.click(function () {
      
      infoModalContents.show();
      
  });
};

//ajax type setting 
const AJAX_TYPE_POST = "POST";
const AJAX_TYPE_GET = "GET";

const daybtn = document.querySelector("#btn");              // 일정생성 버튼 Element            

var dateElement = document.getElementById("startDate");     // 출발일 Element
var daysElement = document.getElementById("days");          // 일수 Element
var decreaseButton = document.getElementById("decrease");   // - 버튼 Element 
var increaseButton = document.getElementById("increase");   // + 버튼 Element
var marker;                                                 // 마커 Element
var overlay;                                                // overlay Element
var over;	                                                  // over 열고/닫기 Element
var sdate;	                                              // 시작일 Element
var edate;	                                              // 종료일 Element
var daysCheckFlag = false;                                   // 일정생성 flag
var sp_day = 0;                                           // 일자별 num Element

// 공통 함수
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

// 데이터 파싱
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
								<img onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstimage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude});" class="card-img-top fixed1" src="${item.firstimage}" alt="Card image cap">
								<div class="movie-item-body" style="text-align: center;padding-top: 2%;">
										<h6 onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstimage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude});" style="margin-bottom: 2%;font-weight: bold;">${item.title}</h6>
								</div>
								<div style="padding: .1rem 0 .1rem 0.3rem;background-color: rgba(0, 0, 0, .03); border-top: 1px solid rgba(0, 0, 0, .125);text-align: right;margin-right: 3%;">
										<button style="border-radius: 7%;" onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstimage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude}); showMovie(${item.contentid})" class="btn-primary btn-show-movie fixed2" data-toggle="modal" data-target="#show-movie-modal" data-id="${item.contentid}">More</button>
										<button style="border-radius: 7%;margin-left: 2%;" class="btn-info btn-add-favorite" data-id="${item.contentid}" onclick="addS_plan(${item.contentid})">+</button>
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
          'data-longitude': item.longitude
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
          'data-longitude': item.longitude
        }));
      });
    }
  }
}

// 데이터 랜더링
var draw = {
	elements : function(data) {
		common.getInfo('POST', '/selectTour', AJAX_TYPE_POST, data, parsing.dataParsing);
	},
  areaList : function() {
    common.getInfoSimple('GET', '/myplan/selectAreaLIst.json', parsing.areaListParsing);
  },
  sigunguList : function(data) {
    common.getInfo('POST', '/myplan/selectSigunguList', AJAX_TYPE_POST, data, parsing.sigunguListParsing);
  }
}

// 카테고리별 검색
function search(value) {
	var keyword = document.querySelector("#keyword").value;
  var searchOption = value;
  var areaindex = $("#areacode option:selected").attr("value");
  var sigunguIndex = $("#sigunguCode option:selected").attr("value");
  console.log("입력한 키워드 : " + keyword);
  console.log("선택한 옵션 : " + searchOption);
  console.log("선택한 지역 : " + areaindex);
  console.log("선택한 시군구 : " + sigunguIndex);

	var data = {
    searchOption: searchOption,
    keyword: keyword,
    areacode: areaindex,
    sigungucode: sigunguIndex,
  };

  if (checkNull()) {
    // console.log("checkNull 값 : " + checkNull);
    draw.elements(data);
  }
}

// 데이트픽커 함수
flatpickr(dateElement, {
  dateFormat: "Y-m-d (D)",
  enableTime: false,
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

  console.log("시작일: " + startDate);

  sdate = getFormatDate(startDate);
  console.log("시작일 포맷: " + sdate);

  // 종료일 계산
  edate = getEndDate(sdate, days);
  console.log("종료일: " + edate);

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

    console.log(formattedDate); // 출력: 01.11 (목)
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

// 마크 좌표 이동
function setMapitems(latitude, longitude, title, firstimage, address, zipcode) {
  marker = new kakao.maps.Marker({
    map : map,
    position : new kakao.maps.LatLng(latitude, longitude)
  });
  markers.push(marker);
  
  var content = '<div class="wrap" id="over">' +
  '    <div class="info">' +
  '        <div class="title">' +
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
    yAnchor: 1 
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

// 유효성 검사
function checkNull() {
  var areacode = $("#areacode").val();
  var sigunguCode = $("#sigunguCode").val();
  if (!areacode) {
    alert("지역을 선택해주세요.");
    return false;
  } 
  if (!sigunguCode) {
    alert("세부 지역을 선택해 주세요.");
    return false;
  } 
  if (!daysCheckFlag) {
    alert("일정 생성 버튼을 클릭해 주세요.");
    if (sp_day == 0) {
      alert("Day 버튼을 클릭하여 Day를 선택해주세요.");
      return false;
    }
    return false;
  } 
    
  return true;
  
}

// 일정 선택
function daydo(value) {
  sp_day = value;
  console.log("sp_day 값 : " + sp_day);
  $("#plan-plansboxtitle").text("DAY" + sp_day);
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

// 장소 추가
function addS_plan(contentid) {
  sp_sday = sdate;
  sp_eday = edate;

  console.log("시작일 : " + sp_sday);
  console.log("종료일 : " + sp_eday);

}
// 필요한 변수 선언

var sp_day = 0;                                           // 일자별 num Element
let betDistance = 0;
let totalDistance = 0;
let lineCrSet = [ { "color" : "#FF0000" }, { "color" : "#ff7300" }, { "color" : "#89cf48" }, { "color" : "#797EFC" }, { "color" : "#ffad29" } ];
let idxForColor = 0;//기본

var marker;                                                 // 마커 Element
var over;	                                                  // over 열고/닫기 Element
var overlay;                                                // overlay Element
const distanceOverlays = [];
const betDistanceArr = [];
const markers = [];
const polylines = [];
let getTourBounds = new kakao.maps.LatLngBounds();
let iwOverlay;




/* 한번에 받아온 세부플랜 데이터를 날짜별로 정리하는 작업 */
//1. 배열선언
const arrForDay = [];
// 구조
// const arrForDay = [ 
//						{	<- tempObj
//							"day":1,
//							"dayArr": [ {1번세부플랜},{2번세부플랜} ] <-tempArr
//						}, 
//
//						{
//							"day":2, 
//						 	"dayArr":[ {1번 세부플랜}, {2번세부플랜} ]
//						}
//					]

//2. 객체를 dayCount만큼 생성
for(let i = 0; i < dayCount; i++) {

  const tempObj = {};			// 배열에 순서대로 들어갈 임시객체 생성
  tempObj.day = i+1;			// day는 언제나 인덱스보다 1많음
  arrForDay.push(tempObj);	// day를 객체에 세팅
  const tempArrForDayArr = [];			// tempObj의 두번째 속성값으로 들어갈 배열선언

  for(let j = 0; j < allDpsAllDays.length; j++) {
    if(allDpsAllDays[j].spDay-1 === i) {
      tempArrForDayArr.push(allDpsAllDays[j]);
    }
  }

  tempObj.dayArr = tempArrForDayArr;

}

// day1에 해당하는 세부플랜을 뽑고싶으면 arrForDay[1(날짜)-1].dayArr로 뽑아오면 됨
// 전체 일정 그리기
drawAllDps(arrForDay);

// 리스트에서 하나 선택시 해당하는 곳의 정보 인포윈도우로 표시
$(".dayContents").on("click", function() {
  let thisIs = $(this);
  for(let i = 0; i<arrForDay.length; i++) {
    let tempDayArr= arrForDay[i].dayArr;
    // console.log("tempDayArr", tempDayArr)
    for(j = 0; j < tempDayArr.length; j++) {
      if(tempDayArr[j].tourVO.contentId == thisIs.data("selloc")){
        let tempTour = tempDayArr[j].tourVO;
        console.log("선택된 contentid", tempTour.contentId);
        console.log("선택된 좌표", tempTour.latitude);
        console.log("선택된 좌표2", tempTour.longitude);
        // 인포윈도우 표시
        drawInfoWindow(tempTour);
      }
    }
  }
});

const overlayForIws = [];

function drawInfoWindow(tour) {
  clearOverlays(overlayForIws);
  let overlayForIw;

  let positionForIw = new kakao.maps.LatLng(tour.latitude, tour.longitude);
  console.log("tour", tour);
  var contentForIw = '<div class="wrap" id="over">' +
  '    <div class="info">' +
  '        <div class="title1 textDrop">' +
  '          ' + tour.title + '' +
  '            <div class="close" onclick="closeOverlay()" title="닫기"></div>' +
  '        </div>' +
  '        <div class="body">' +
  '            <div class="img">' +
  '                <img src=' + tour.firstImage + '; width="73" height="70">' +
  '           </div>' +
  '            <div class="desc">' +
  '                <div class="ellipsis">' + tour.address + '</div>' +
  '                <div class="jibun ellipsis">(우) ' + tour.zipcode + '</div>' +
  '            </div>' +
  '        </div>' +
  '    </div>' +
  '</div>';
  
  overlayForIw = new kakao.maps.CustomOverlay({
    content: contentForIw,
    map: map,
    position: positionForIw,
    yAnchor: 1,
    zAnchor: 0.2,
    zIndex: 3
  });

      map.setCenter(positionForIw);

  overlayForIws.push(overlayForIw);

}

/* 버튼 이벤트 */
$(".groupBanOrDenied").on("click", function() {
	Swal.fire({
	    text: "참가요청이 거부되었거나 강퇴당하여 동행참가를 진행하실 수 없습니다.",
	    icon: "info"
	});
});

$(".groupCanceled").on("click", function() {
	Swal.fire({
	    text: "동행을 취소하여 동행참가를 진행하실 수 없습니다.",
	    icon: "info"
	});
});

$(".goToGroup").on("click", function() {
  Swal.fire({
      title: "페이지 이동",
      text: "해당 플랜의 그룹 페이지로 이동하시겠습니까?",
      icon: "question",
      showDenyButton: true,
      confirmButtonText: "예",
      denyButtonText: "아니오"
  }).then((result) => {
      if (result.isConfirmed) {
          Swal.fire({
            title: "페이지 이동",
            text: "그룹 페이지로 이동합니다.",
            icon: "info"
        }).then((result) => {
            // 모달이 닫힌 후에 실행될 코드
            if (result.isConfirmed) {
                // 확인 버튼이 클릭되었을 때
                location.href = "/partner/meetsquare.do?plNo=" + plNo;
            }
        });
      } else if (result.isDenied) {
          Swal.fire({
            title: "페이지 이동",
            text: "그룹 페이지 이동을 취소합니다.",
            icon: "error"
        });
      }
  });
});

// 참가 신청 이벤트
$(".groupAttendBtn").on("click", function() {
  // if(confirm("참가 신청 하시겠습니까?")) {
    // }
    Swal.fire({
      title: "동행참가 신청",
      text: "참가 신청 하시겠습니까?",
      icon: "question",
      showDenyButton: true,
      confirmButtonText: "예",
      denyButtonText: "아니오"
    }).then((result) => {
      if (result.isConfirmed) {
        location.href="/myplan/groupJoin.do?plNo=" + plNo;    // plNo는 JSP에 선언됨
      }
    });
});

// 일차 탭버튼 클릭 이벤트
$(".customBadge").on("click", function() {
  // 화면 및 변수 초기화
  clearOverlays(overlayForIws);
  clearAll();

  let thisIs = $(this);
  let selectedDay = thisIs.data("selday");
  sp_day = selectedDay;
  
  console.log("선택된 날짜 : " + sp_day);
  thisIs.addClass('active').siblings().removeClass('active');

  if(selectedDay != 0) {
    $(".dayAll").hide();
  }

  for(let i = 0; i < 5; i++) {
    $(".day"+(i+1)).hide();
  }
  
  idxForColor = sp_day;

  if(selectedDay == 0) {
    $(".dayAll").show();
    //console.log("testetstset",arrForDay);
    // console.log("all선택?");
    drawAllDps(arrForDay);
  } else {
    $(".day"+selectedDay).show();
    //console.log("testetstset",arrForDay[selectedDay-1].dayArr);
    drawAllDpsForDays(arrForDay[selectedDay-1].dayArr);
  }

})

// 상단 탭버튼 이벤트(일정표 구현용)
$.planDetailTabbtnFn = function(){
  var planDetailTabbtn = $(".planDetailTabbtnGroup .tabbtn");
  var planDetailTabcontBox = $(".planDetailTabcontBox .tabcont");
  planDetailTabcontBox.hide();
  planDetailTabcontBox.eq(0).show();
  // 탭버튼 클릭 이벤트
  planDetailTabbtn.click(function(){
    var thisIs = $(this);
    planDetailTabbtn.removeClass("tactive");
    thisIs.addClass("tactive");
    var idx = thisIs.index();
    planDetailTabcontBox.hide();
    planDetailTabcontBox.eq(idx).show();
  });
};

$.planDetailTabbtnFn();


/* 그리기 함수 */
// 세부플랜 모든날짜 그리기
function drawAllDps(arrForDay) {
  // arrForDay -> 날짜별로 모든 세부플랜이 담긴 배열 중첩for문 사용
  // console.log("arrForDay", arrForDay);

  for(let i = 0; i < arrForDay.length; i++) {
    totalDistance = 0;
    const allLatLng = [];			                  // 선 그리기를 위해 모든 장소의 좌표를 담을 배열
    const tempArrForDay = arrForDay[i].dayArr;
    let tempDay = arrForDay[i].day;

    // tempArrForDay -> 날짜별 세부플랜 배열
    for(let j = 0; j < tempArrForDay.length; j++) {

      const latitude = tempArrForDay[j].tourVO.latitude;
      const longitude = tempArrForDay[j].tourVO.longitude;
      const latlng = new kakao.maps.LatLng(latitude, longitude)

      createMarkers(latlng, j+1, tempDay);  // j+1 -> spOrder(세부플랜 순서) / tempDay -> 날짜마다 다른 색깔 적용을 위한 일(Day) 수
      getTourBounds.extend(latlng);
      allLatLng.push(latlng);
      
      console.log("tempDay", tempDay);
      // console.log("tempArrForDay[j].spNo", tempArrForDay[j].spNo);
      if(allLatLng.length > 0 && j > 0) {
        const tourPosition1 = allLatLng[j-1]
        const tourPosition2 = allLatLng[j]

        const twolatLngArr = [];
        twolatLngArr.push(tourPosition1);
        twolatLngArr.push(tourPosition2);
        createPolyLine(twolatLngArr, tempDay);
      
        let tempHtml = "";
        if(betDistance > 1000) {
          tempHtml += (betDistance/1000).toFixed(1) + "km";
        } else {
          tempHtml += betDistance.toFixed(0) + "m";
        }

        $(".setDistance[data-spno='"+tempArrForDay[j].spNo+"']").text(tempHtml);
        
      } else {
        $(".setDistance[data-spno='"+tempArrForDay[j].spNo+"']").text(0 + "m");
        
      }
      
    }

    let tempTotalHtml = "총 이동거리 ";
    if(totalDistance > 1000) {
      tempTotalHtml += (totalDistance/1000).toFixed(1) + "km";
    } else {
      tempTotalHtml += totalDistance.toFixed(0) + "m";
    }
    $(".setDistance[data-dayday="+tempDay+"]").text(tempTotalHtml);

    map.setBounds(getTourBounds);                      // 범위 재설정
    
  }

};


/* 날짜별 세부플랜 전부 그리기 */
function drawAllDpsForDays(allDpsAllDays) {
      
  const allLatLng = [];			// 선 그리기를 위해 모든 장소의 좌표를 담을 배열

  // ajax로 가져온 전체 장소 반복문 돌려서 그리기
  for (let i = 0; i < allDpsAllDays.length; i ++) {
    //console.log("haruSpArr에서 가져온 세부플랜 조회 : ", spForDayArr[i]);

    // 마커찍기 위해 최소한의 정보들 저장
    // const spOrder = allDpsAllDays[i].spOrder;
    const latitude = allDpsAllDays[i].tourVO.latitude;
    const longitude = allDpsAllDays[i].tourVO.longitude;
    const latlng = new kakao.maps.LatLng(latitude, longitude)

    let tempDay = 0;

    createMarkers(latlng, i+1, tempDay);      // * 마커, 점 찍기 (DB에서 가져올때 중간에 숫자가 비는 경우가 생길 수 있으니까 index로 spOrder를 설정)
    getTourBounds.extend(latlng);                     // 범위 재설정을 위한 범위 확장
    allLatLng.push(latlng);                           // 선 그리기 위해서 모든 좌표 객체 한 배열에 담기
    if(allLatLng.length > 0 && i > 0) {

      const tourPosition1 = allLatLng[i-1]
      const tourPosition2 = allLatLng[i]

      const twolatLngArr = [];
      twolatLngArr.push(tourPosition1);
      twolatLngArr.push(tourPosition2);
      createPolyLine(twolatLngArr);
      
      let tempHtml = "";
      // let content = "";
      if(betDistance > 1000) {
        tempHtml += (betDistance/1000).toFixed(1) + "km";
      } else {
        tempHtml += betDistance.toFixed(0) + "m";
      }
      $(".setDistance[data-spno='"+allDpsAllDays[i].spNo+"']").text(tempHtml);
    } else {
      $(".setDistance[data-spno='"+allDpsAllDays[i].spNo+"']").text(0 + "m");
    }

  }

  let tempTotalHtml = "총 이동거리 ";
  if(totalDistance > 1000) {
    tempTotalHtml += (totalDistance/1000).toFixed(1) + "km";
  } else {
    tempTotalHtml += totalDistance.toFixed(0) + "m";
  }
  $(".setDistance[data-dayday="+sp_day+"]").text(tempTotalHtml);

  map.setBounds(getTourBounds);                      // 범위 재설정

}


/* 그리기 관련 세부 함수 */
// 마커 찍기
function createMarkers(latlng, spOrder, tempDay) {	

  // 마커 이미지 세팅
  // 일차에 따라 마커 색을 다르게 줌
  // let imageSrc = '/resources/images/planner/marker_red.png';
  // let imageSrc = '/resources/images/planner/marker_number_custom.png';
  let imageSrc = '/resources/images/planner/marker_number_d1.png';  //default
  if(tempDay > 0) {
    imageSrc = '/resources/images/planner/marker_number_d'+tempDay+'.png';
  } else if(tempDay == 0){
    if(sp_day > 0 && sp_day < 6) {
      imageSrc = '/resources/images/planner/marker_number_d'+sp_day+'.png';
    }
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
      image : markerImage,
      zIndex: 2,
      xAnchor: 0.6
  });
  
  markers.push(marker);           // 마커 모음 배열에 저장(삭제 등 제어를 위함)
  marker.setMap(map);             // 모든 마커 표시
  
}

// 선
function createPolyLine(latLngs, index) {

  let lineColor = "#FF0000";

  if(index > 1 && index < 6) {
    lineColor = lineCrSet[index-1].color;
  }

  if(idxForColor > 0) {
    lineColor = lineCrSet[idxForColor-1].color;
  }

  // 지도에 선을 표시
  const polyline = new kakao.maps.Polyline({
      map : map, 					// 선을 표시할 지도 객체 
      path : latLngs,				// 선을 구성하는 좌표
      strokeWeight : 5, 			// 선의 두께
      strokeColor : lineColor, 	// 선 색
      strokeOpacity : 0.7, 		// 선 투명도
      strokeStyle : 'dotted' 		// 선 스타일
  });

  polylines.push(polyline);

  // 거리 측정

  // 거리 누적
  totalDistance += polyline.getLength();

  betDistance = polyline.getLength();
  betDistanceArr.push(betDistance);

  let content = getTimeHTML(Math.round(totalDistance), "총 ");
  // displayDistance(content, latLngs[latLngs.length-1]);

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
  
// 거리, 시간 계산
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

    
    // 자동차의 평균 시속은 60km/h 이고 이것을 기준으로 자동차의 분속은 1000m/min입니다
    var carTime = distance / 1000 | 0;
    var carHour = '', carMin = '';

    // 계산한 자동차 시간이 60분 보다 크면 시간으로 표출합니다
    if (carTime > 60) {
        carHour = '<span class="number">' + Math.floor(carTime / 60) + '</span>시간 ';
    }
    carMin = '<span class="number">' + carTime % 60 + '</span>분';


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
    content += '        <span class="label">자동차</span>' + carHour + carMin;
    content += '    </li>';
    content += '</ul>'

    return content;
}    
  


/* 초기화 관련 함수 */
// 범위 재생성
function resetBounds() {
  getTourBounds = new kakao.maps.LatLngBounds();
  latitude = 37.56682; // 서울의 위도
  longitude = 126.97865; // 서울의 경도
}

/* 유틸 */
// 오버레이 추상화
function clearOverlays(overlays) {
  overlays.forEach(overlay => overlay.setMap(null));
  overlays.length = 0;
}

// 전부 지우기(마커, 선, 원)
function clearAll() {
  clearOverlays(markers);
  clearOverlays(polylines);
  clearOverlays(distanceOverlays);

  resetBounds();
  resetVarAll();
}
  
function resetVarAll() {
  sp_day = 0;
  totalDistance = 0;
  betDistance = 0;
  betDistanceArr.length = 0;
}

function closeOverlay() {
  over = document.getElementById('over');
  if (over != null) over.remove();
}

// 종횡비
$.ratioBoxH = function(boxEl, imgEl) {
  var boxSel = $(boxEl);
  var boxW = boxSel.width();
  var boxH = boxSel.height();
  var boxRatio = boxH / boxW;

  var imgSel = $(imgEl);
  
  var setImgDimensions = function() {
      var imgW = imgSel.width();
      var imgH = imgSel.height();
      var imgRatio = imgH / imgW;

      if (boxRatio < imgRatio) {
          //console.log("boxW :", boxW);
          imgSel.width(boxW).height("auto");
      } else {
          //console.log("boxH :", boxH);
          imgSel.height(boxH).width("auto");
      }
  };

  // 이미지의 로드 이벤트 핸들러 등록
  imgSel.on("load", setImgDimensions);

  // 초기 설정
  setImgDimensions();
};

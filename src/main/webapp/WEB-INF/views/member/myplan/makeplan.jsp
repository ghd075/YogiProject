<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    

<style>
    
.dot {overflow:hidden;float:left;width:12px;height:12px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/mini_circle.png');}    
.dotOverlay {position:relative;bottom:10px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;font-size:12px;padding:5px;background:#fff;}
.dotOverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}    
.number {font-weight:bold;color:#ee6152;}
.dotOverlay:after {content:'';position:absolute;margin-left:-6px;left:50%;bottom:-8px;width:11px;height:8px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white_small.png')}
.distanceInfo {position:relative;top:10px;left:100px;list-style:none;margin:0;}
.distanceInfo .label {display:inline-block;width:50px;}
.distanceInfo:after {content:none;}
</style>

<!-- 마이플랜 css -->
<link href="${contextPath }/resources/css/userPlan.css" rel="stylesheet" />    
<!-- nice-select css -->
<link rel="stylesheet" href="${contextPath }/resources/css/nice-select.css">
<!-- flatpickr css -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
<!-- flatpickr JS -->
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
    
<!-- 구현할 페이지를 여기에 작성 -->
<section class="makePlanContainer emptySpace">
	<article class="plan-header">
		<div>
			<label class="title">여행 제목 : </label>
			<input id="p_title" type="text" class="title_input form-control" placeholder="여행 제목을 작성해주세요.." />
		</div>
		<div class="calendar">
			<label class="calendar_detail_01">여행 시작일 : </label>
			<input class="input-date" type="date" id="startDate" value="" min="" />
			<label class="calendar_detail_02">여행 일수 : </label>
			<button id="decrease" class="btn btn-outline-info">-</button>
			<input type="text" id="days" value="1" class="wave">
			<button id="increase" class="btn btn-outline-info">+</button>
			<button id="btn" class="btn btn-primary btn-sm">일정 생성</button>
			<button id="testbtn" class="btn btn-primary btn-sm">테스트</button>
		</div>
		<div class="form-group mt-10">
			<form method="post" name="planSaveForm" action="">
				<input type="hidden" name="plNo" value="${plNo}" id="plNo" />
				<input type="hidden" name="plTitle" value="" />
				<input type="hidden" name="plMsize" value="" />
				<input type="hidden" name="plTheme" value="" />
				<input type="hidden" name="memId" value="${sessionInfo.memId }" />
	           <button id="plannerSaveBtn" type="button" onclick="savePlanner();" class="btn btn-outline-warning">저장</button>
			</form>
           <button id="plannerResetBtn" type="button" class="btn btn-outline-danger">초기화</button>
           <button id="plannerListGoBtn" type="button" class="btn btn-outline-success">목록</button>
	 	</div>
	</article>
	<article class="planInsertTbl">
		<div class="form-group" >
			<select id="test1" name="test1" class="nice-select top-select">
				<option value="" selected="selected">인원</option>
				<option value="1인">1인</option>
				<option value="2인">2인</option>
				<option value="3인">3인</option>
				<option value="4인">4인</option>
				<option value="5인 이상">5인 이상</option>
			</select> 
			<select id="test2" name="test2" class="nice-select top-select">
				<option value="" selected="selected">테마</option>
				<option value="혼자">혼자</option>
				<option value="동행">동행</option>
			</select> 
			<select name="areaCode" id=areaCode class="nice-select top-select">
				<option value="">지역 선택</option>
			</select> 
			<select name="sigunguCode" class="nice-select top-select" id="sigunguCode">
				<option value="">전체</option>
			</select>
		</div>
	</article>
</section>
<section class="plan-container">
	<!-- 해당 날짜가 추가하는 영역 -->
	<article class="plan-daysbox">
		<div class="plan-daysboxtitle">DAY</div>
		<div class="category-listing">
			<div class="single-listing">
				<div class="select-job-items1">
					<div class="card" id="card2">
						<table id="myTable" class="table">
							<thead>
							</thead>
							<tbody id="tbody">
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="single-listing" style="margin-top: 20px;">
				<button onclick="dayReset()" class="btn btn-outline-danger" style="font-size: small;">DAY 초기화</button>
			</div>
		</div>			
	</article>
	<!-- 해당 날짜에 일정을 추가하는 영역 -->
	<article class="plan-planscontainer">
		<!-- 사용자 입력을 받은 데이터를 반복문으로 사용 -->
		<div class="plan-plansboxtitle" id="plan-plansboxtitle"></div>
		<div class="plan-plansbox">
			<!-- 선택된 day 리스트 -->
			<div class="category-listing" style="overflow-y: scroll;">
				<div class="single-listing">
					<div class="select-job-items2">
						<div class="card" id="card3" style="min-height: 460px;"></div>
					</div>
				</div>
			</div>
			<div class="single-listing" style="text-align: center;">
				<a onclick="dayDelAll()" class="btn btn-outline-danger" style="font-size: small;">전체 삭제</a>
			</div>
		</div>
    </article>
     <!-- 관광지 검색 리스트 영역 -->
    <article class="plan-searchbox">
       <!-- 관광지 검색 리스트 -->
       <div class="category-listing">
           <div class="single-listing">
               <div class="searchContents">
               	<div>
                	<input type="text" class="form-control" id="keyword" name="keyword" placeholder="키워드 검색" />
		            <button type="button" id="searchBtn" onclick="search(value)" >
		                <i class="fas fa-search"></i>
		            </button>
               	</div>
               </div>
               <div class="select-job-items2">
                   <button id="touraBtn" value="A01" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/plan/camera.png" title="명소">
                   </button>
                   <button id="shoppingBtn" value="A04" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/plan/shopping.png" title="쇼핑">
                   </button>
                   <button id="foodBtn" value="A05" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/plan/food.png" title="맛집">
                   </button>
                   <button id="hotelBtn" value="B02" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/plan/hotel.png" title="숙소">
                   </button>
                   <button id="likeBtn" value="C01" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/plan/like.png" title="추천!">
                   </button>
               </div>
               <div class="select-job-items2">
	               <div id="result"></div>
               	   <div class="sidebar-menu" id="data-panel"></div>
                   <!-- <div class="row" id="data-panel"></div> -->
               </div>
           </div>
       </div>
    </article>
    <!-- 지도 API -->
	<article class="plan-mapbox">
		<div class="plan-map">
			<div id="map" style="width: 1165px; height: 633px;"></div>
		</div>
	</article>
	<!-- 지도 API -->
</section>

<!-- 공지사항 JS -->
<script src="${contextPath }/resources/js/userPlan.js"></script>

<!-- 카카오 지도 JS  -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5d692983b8638035f4f288e59aea36fe&libraries=services"></script>

<script>
	// 마커를 담을 배열생성
	let markers = [];
	let mapContainer = document.getElementById('map'); // 지도를 표시할 div 
	let mapOption = {
		center: new kakao.maps.LatLng(37.56682, 126.97865), // 지도의 중심좌표
		level : 6
	// 지도의 확대 레벨
	};

	// scs
	let markers2 = [];
	let getTourBounds = new kakao.maps.LatLngBounds();
	const polylines = [];
	let tourArr = [];
	let circleOverlays = [];


	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	let map = new kakao.maps.Map(mapContainer, mapOption);
</script>
<!-- 지도 -->
<script type="text/javascript">
	$(function () {
		draw.areaList();
		
		setTimeout(() => {
			var areaCodeOpt = $("#areaCode").find(".item");
			for(var i = 0; i < areaCodeOpt.length; i++){
				if(areaCodeOpt[i].value == "${planList.areaCode}"){
					areaCodeOpt[i].selected = true;
				}
			}
			$('#areaCode').change();  // Rendering
			/* if("${planList.sigunguCode}") {
				$("#sigunguCode").html("<option value='${planList.sigunguCode}'>${planList.sigunguName}</option>");
			} else {
				$('#sigunguCode').append("<option value=''>-- 전체 --</option>");
			} */


			setTimeout(()=>{
			//alert("쳌킁${planList.sigunguCode}체킁");

			if("${planList.sigunguCode}") {	
					console.log("메롱",$("#sigunguCode")[0]);
				//				$("#sigunguCode").val("${planList.sigunguCode}").prop("selected", true);
				$("#sigunguCode").val("${planList.sigunguCode}");
				var sigunguCodeOpt = $("#sigunguCode").find(".item2"); // 수정된 부분
				console.log("sigunguCodeOpt 값 들 : ", sigunguCodeOpt);
				console.log("sigunguCode 값 들 : ", $("#sigunguCode").val("${planList.sigunguCode}"));
				console.log("sigunguCodeOpt 길이 : " + sigunguCodeOpt.length);
				$('#sigunguCode').change();  // 강제로 요따구 이벤트를 발생시키는 것은 아주 못된 습관! 
		}

// $('#sigunguCode').change();

			},300);
		}, 300);
	});

	// 지역 좌표 이동
	$('#areaCode').change(function() {
		$('#sigunguCode').find('option').each(function() {
			$(this).remove();
	   	});
		
		$('#sigunguCode').append("<option value=''>-- 전체 --</option>");
		// 선택된 옵션을 가져옴
		var selectedOption = $(this).find(':selected');

		// 데이터 속성에서 위도와 경도 값을 가져옴
		var latitude = selectedOption.data('latitude');
		var longitude = selectedOption.data('longitude');

		// 만약 위도와 경도 값이 없으면 서울의 위도와 경도를 사용
		if (!latitude || !longitude) {
			latitude = 37.56682; // 서울의 위도
			longitude = 126.97865; // 서울의 경도
		}

		// 선택된 select 박스의 value 값을 data 객체에 추가
		var areaCodeValue = selectedOption.val();
		if(areaCodeValue != "") {
			var data = {
				areaCode: areaCodeValue
			};
	
			draw.sigunguList(data);
		}

		moveMapCenter(latitude, longitude);	
		
	});
	
	// 세부 지역 좌표 이동
	$('#sigunguCode').change(function() {
		var selectedOption = $(this).find(':selected');

		// 데이터 속성에서 위도와 경도 값을 가져옴
		var latitude = selectedOption.data('latitude');
		var longitude = selectedOption.data('longitude');

		var areaCode = $('#areaCode').find(':selected');
		
		var areaLatitude = areaCode.data('latitude');
		var areaLongitude = areaCode.data('longitude');
		
		// 만약 위도와 경도 값이 없으면 해당 지역의 위도와 경도를 사용
		if (!latitude || !longitude) {
			latitude = areaCode.data('latitude'); // 해당 지역 위도
			longitude = areaCode.data('longitude'); // 해당 지역 경도
		}

		moveMapCenter(latitude, longitude);
		
	});
	
	// 플래너 작성 각각의 이미지 종횡비 변경 함수
	// $.eachPlanImgResizeFn();
	
	// 플랜 저장
	function savePlanner(){
	  var sp = document.getElementById('card3').innerText;
	  var p_title = $("#p_title").val();
	  console.log("sp : " + sp);
	  console.log("제목 : " + p_title);
	  console.log("시작일 : " + sdate);
	  console.log("종료일 : " + edate);
	  if(p_title == null || p_title==""){
	    alert("여행 플래너의 제목을 입력해주세요.");
	    $("#p_title").focus();
	    return false;
	  } else if( sp==null || sp == "장소를 추가해주세요" || sp==""){
	  	alert("여행 플래너에 장소를 추가해주세요.");
	  	return false;
	  } else {
	  	var plMsize = $("#test1 option:selected").val();
	  	console.log("plMsize : " + plMsize);
		var plTheme = $("#test2 option:selected").val();
	  	console.log("plTheme : " + plTheme);
	  	console.log("document.planSaveForm : ", document.planSaveForm);
	  }
	}
	
</script>

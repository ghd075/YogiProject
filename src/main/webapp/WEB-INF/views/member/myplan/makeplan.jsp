<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- 마이플랜 css -->
<link href="${contextPath }/resources/css/userPlan.css" rel="stylesheet" />    
<!-- nice-select css -->
<link rel="stylesheet" href="${contextPath }/resources/css/nice-select.css">
    
<!-- 구현할 페이지를 여기에 작성 -->
<section class="makePlanContainer emptySpace">
	<article class="plan-header">
		<div>
			<label class="title">여행 제목 : </label>
			<input id="p_title" type="text" class="title_input form-control" placeholder="여행 제목을 작성해주세요.." />
		</div>
		<div class="calendar">
			<label class="calendar_detail_01">여행 시작일 : </label>
			<input class="input-date" type="date" id="startDate" value="" min="${formattedDate}" />
			<label class="calendar_detail_02">여행 일수 : </label>
			<button id="decrease" class="btn btn-outline-info">-</button>
			<input type="text" id="days" value="1" class="wave">
			<button id="increase" class="btn btn-outline-info">+</button>
			<button id="btn" class="btn btn-primary btn-sm">일정 생성</button>
		</div>
		<div class="form-group mt-10">
           <button id="plannerSaveBtn" type="button" class="btn btn-outline-warning">저장</button>
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
			</select> <select id="test2" name="test1"
				class="nice-select top-select">
				<option value="" selected="selected">테마</option>
				<option value="혼자">혼자</option>
				<option value="동행">동행</option>
			</select> <select name="area" id="areacode"
				class="nice-select top-select" onchange="changes(value)">
				<option value="">지역 선택</option>
			</select> <select name="sigungu" class="nice-select top-select"
				id="sigunguCode">
				<option value="">세부 지역</option>
			</select>
		</div>
	</article>
</section>
<section class="plan-container">
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
			<div class="category-listing">
				<div class="single-listing">
					<div class="select-job-items1">
						<div class="card" id="card2"></div>
					</div>
				</div>
				<div class="single-listing" style="margin-top: 20px; text-align: center;">
					<a onclick="dayDelAll()" class="btn btn-outline-danger" style="font-size: small;">전체 삭제</a>
				</div>
			</div>
		</div>
    </article>
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
                       <img src="${contextPath }/resources/images/camera.png" title="명소">
                   </button>
                   <button id="shoppingBtn" value="A04" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/shopping.png" title="쇼핑">
                   </button>
                   <button id="foodBtn" value="A05" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/food.png" title="맛집">
                   </button>
                   <button id="hotelBtn" value="B02" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/hotel.png" title="숙소">
                   </button>
                   <button id="likeBtn" value="C01" onclick="search(value)" class="cat1-btn">
                       <img src="${contextPath }/resources/images/like.png" title="추천!">
                   </button>
               </div>
               <div id="result"></div>
               <div class="select-job-items2">
                   <div class="row" id="data-panel"></div>
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
<!-- 지도 -->
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b32a29fe75c5dec3cc66391aed3fe468&libraries=services"></script>
<script>
	// 마커를 담을 배열생성
	let markers = [];
	let mapContainer = document.getElementById('map'); // 지도를 표시할 div 
	let mapOption = {
		center: new kakao.maps.LatLng(37.56682, 126.97865), // 지도의 중심좌표
		level : 6
	// 지도의 확대 레벨
	};

	// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
	let map = new kakao.maps.Map(mapContainer, mapOption);
</script>
<!-- 지도 -->
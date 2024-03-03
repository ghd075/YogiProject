<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 숙박 검색결과 화면 CSS -->
<link href="${contextPath}/resources/css/stay/searchList.css" rel="stylesheet" />
 <!-- 구글폰트 -->
 <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<section class="emptySpace">

    

    <!-- [상단영역] -->
	<div class="container-fluid mt-3" id="container-top">
	  <div class="row">
	    <div class="col-sm-1 text-white top">
	     <a href="/reserve/air/search/form.do"><img id="topImg" src="/resources/images/air/list/돋보기.PNG"></a>
	    </div>
	    <div class="col-sm-5 text-white top">
	      <p id="topText1">  
	          <span style="font-size: 20px;">
	                         제주 &nbsp; | &nbsp;
	          </span>
	          <span style="font-size: 20px;">
	            2024.03.25 (월) ~ 2024.03.30 (토) &nbsp;|&nbsp;
	          </span>
	          <span style="font-size: 20px;">
	                        인원 4명 
	          </span>
	       </p>
	    </div>
	    <div class="col-sm-6 text-white top">
	    </div>
	  </div>
    </div>
     
       <!-- [left side 검색조건 영역] -->
       <div id="container-left">
	    <div class="accordion" id="accordionPanelsStayOpenExample">
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
		        <strong>가격 (1박 기준)</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show">
		      <div class="accordion-body">
		         <label for="depRange" class="form-label">
					<strong>0원</strong> ~ <strong>800,000원 이상</strong><br>
				 </label>
                 <input type="range" class="form-range" id="depRange" min="0" max="1440" step="30" value="1440">  
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="true" aria-controls="panelsStayOpen-collapseTwo">
		         <strong>숙소유형</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse show">
		      <div class="accordion-body">
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">전체</label><br><hr>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" >
				  &nbsp;<label class="form-check-label">모텔</label><br><hr>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" >
				  &nbsp;<label class="form-check-label">호텔/리조트</label><br><hr>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" >
				  &nbsp;<label class="form-check-label">펜션</label><br><hr>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" >
				  &nbsp;<label class="form-check-label">홈&빌라</label><br><hr>
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="true" aria-controls="panelsStayOpen-collapseThree">
		              <strong>객식 내 시설</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse show">
		      <div class="accordion-body">
		        <div class="form-check">
				  <div class="accom">사우나</div><div class="accom">수영장</div><br>
				  <div class="accom">객실스파</div><div class="accom">BBQ</div><br>
				  <div class="accom">레스토랑</div><div class="accom">피트니스</div><br>
				  <div class="accom">물놀이시설</div><br>
				  &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;<a href="#">더보기 ▼</a>
				</div>
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
		         <strong>등급</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse show">
		      <div class="accordion-body">
		        <div class="form-check">
				   <div class="accom">5성급</div><div class="accom">4성급</div><br>
				  <div class="accom">3성급</div><div class="accom">블랙</div><br>
				  <div class="accom">풀빌라</div><br><br>
				  &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp; &nbsp;<a href="#">더보기 ▼</a>
				</div>
		      </div>
		    </div>
		  </div>
		 </div>
	  </div>
    
	 <!-- [중앙 컨텐츠 영역] -->
	 <!-- 중앙 컨텐츠 최상단 -->
     <div class="container-fluid mt-3" id="container-content">
	   <div class="row content-top">
	     <div class="col-sm-8">총
	        <strong id="resultCnt">13개의 숙소가 검색되었습니다...</strong>
	     </div>
	     <div class="col-sm-4 basicSelect">
	            정렬기준 &nbsp;&nbsp;
	      <select id="selectSort">
	        <option selected="selected" id="priceSelect" value="priceSelect">추천순</option>
	        <option id="durationSelect" value="durationSelect">평점높은순</option>
	        <option id="recoSelect" value="recoSelect">리뷰순</option>
	        <option id="recoSelect" value="recoSelect">가격순</option>
	      </select> 
	     </div>
	   </div>
	   
		 <!-- 메인컨텐츠 -->
		 <div class="contentSet"> 
		       <div class="mainContent">
		          <!-- 숙박업소 -->
		          <div class="row accommodation" >
			         <div class="col-sm-7 left" style="border-right: 1px solid lightgray;">
			             <img src="/resources/images/stay/list/제주신라.PNG">
			             <img src="/resources/images/stay/list/제주신라2.PNG" style="height: 110px; margin-bottom: 110px;"><br>
			             <img src="/resources/images/stay/list/제주신라3.PNG" style="height: 110px; position: relative; bottom: 120px; left: 265px;">
			         </div>
			         <div class="col-sm-5 middle">
			                        블랙 / 5성급 / 호텔
			                        <br>
			            <span style="font-size: 20px; font-weight: bolder; margin-bottom: 10px;">제주신라호텔</span><br>
			            <span style="font-size: 15px; color: gray;">서귀포시 서귀포터미널 차량 7분 거리</span><br>
			            <div style="background-color: orange; color: white; border-radius: 20px; width: 70px; text-align: center; display: inline-block;">★ 9.8</div> &nbsp;&nbsp;12명 평가
			            <br><br>
			             <img src="/resources/images/stay/list/제주신라편의시설2.PNG" style="width: 380px; height: 70px; padding-bottom: 0px;">
			            <br><p style="font-size: 18px; font-weight: bolder; color: red; margin-left: 230px; margin-top: 5px;">1박 / 350,472원</p>
			         </div>
		          </div>
		          <!-- 객실 -->
		          <div class="row room" >
			         <div class="col-sm-4 room">
			           <img src="/resources/images/stay/list/산정상스탠다드.PNG">
			           <span style="font-weight: bold;">산전망 스탠다드 더블 룸</span>
			           <span class="material-symbols-outlined">schedule</span>
			           <span style="font-size: 15px; color: gray;">입실 14:00</span> ~
			           <span style="font-size: 15px; color: gray;">퇴실 11:00</span><br>
			           <span class="material-symbols-outlined">person</span>
			           <span style="font-size: 15px; color: gray;">기준 2인</span> /
			           <span style="font-size: 15px; color: gray;">최대 4인</span><br>
			           <span style="font-size: 15px; color: orange;">남은객실 : 2개</span><br>
			           <span style="font-size: 17px; font-weight:bolder;  color: red;">350,472원(1박)</span>
			           <button type="button" class="btn btn-secondary cartPopover" data-bs-toggle="popover" title="<strong>찜하기</strong>"  data-bs-html="true" data-bs-content="${popover}" style="float: right; margin-right: 10px; border-radius: 20px; background-color: gray;">♥</button>
			           &nbsp;&nbsp;&nbsp;<button class="btn btn-warning">예약하기</button>
			         </div>
			         <div class="col-sm-4 room">
			           <img src="/resources/images/stay/list/정원전망테라스더블.PNG">
			           <span style="font-weight: bold;">정원 전망 테라스 더블 룸</span>
			           <span class="material-symbols-outlined">schedule</span>
			           <span style="font-size: 15px; color: gray;">입실 14:00</span> ~
			           <span style="font-size: 15px; color: gray;">퇴실 11:00</span><br>
			           <span class="material-symbols-outlined">person</span>
			           <span style="font-size: 15px; color: gray;">기준 2인</span> /
			           <span style="font-size: 15px; color: gray;">최대 4인</span><br>
			           <span style="font-size: 15px; color: orange;">남은객실 : 4개</span><br>
			           <span style="font-size: 17px; font-weight:bolder;  color: red;">416,472원(1박)</span>
			           <button type="button" class="btn btn-secondary cartPopover" data-bs-toggle="popover" title="<strong>찜하기</strong>"  data-bs-html="true" data-bs-content="${popover}" style="float: right; margin-right: 10px; border-radius: 20px; background-color: gray;">♥</button>
			           &nbsp;&nbsp;&nbsp;<button class="btn btn-warning">예약하기</button>
			         </div>
			         <div class="col-sm-4 room">
			           <img src="/resources/images/stay/list/바다전망스위트룸.PNG">
			           <span style="font-weight: bold;">바다전망 퍼시픽디럭스룸</span>
			           <span class="material-symbols-outlined">schedule</span>
			           <span style="font-size: 15px; color: gray;">입실 14:00</span> ~
			           <span style="font-size: 15px; color: gray;">퇴실 11:00</span><br>
			           <span class="material-symbols-outlined">person</span>
			           <span style="font-size: 15px; color: gray;">기준 2인</span> /
			           <span style="font-size: 15px; color: gray;">최대 4인</span><br>
			           <span style="font-size: 15px; color: orange;">남은객실 : 1개</span><br>
			           <span style="font-size: 17px; font-weight:bolder;  color: red;">900,472원(1박)</span>
			           <button type="button" class="btn btn-secondary cartPopover" data-bs-toggle="popover" title="<strong>찜하기</strong>"  data-bs-html="true" data-bs-content="${popover}" style="float: right; margin-right: 10px; border-radius: 20px; background-color: gray;">♥</button>
			           &nbsp;&nbsp;&nbsp;<button class="btn btn-warning">예약하기</button>
			         </div>
		          </div>
		          <hr>
		          <div class="row accommodation" >
			         <div class="col-sm-7 left" style="border-right: 1px solid lightgray;">
			             <img src="/resources/images/stay/list/신라스테이1.PNG">
			             <img src="/resources/images/stay/list/신라스테이2.PNG" style="height: 110px; margin-bottom: 110px;"><br>
			             <img src="/resources/images/stay/list/신라스테이3.PNG" style="height: 110px; position: relative; bottom: 120px; left: 265px;">
			         </div>
			         <div class="col-sm-5 middle">
			                        4성급 / 호텔
			                        <br>
			            <span style="font-size: 20px; font-weight: bolder; margin-bottom: 10px;">신라스테이 제주</span><br>
			            <span style="font-size: 15px; color: gray;">제주시 제주국제공항 부근</span><br>
			            <div style="background-color: orange; color: white; border-radius: 20px; width: 70px; text-align: center; display: inline-block;">★ 8.8</div> &nbsp;&nbsp;6명 평가
			            <br><br>
			             <img src="/resources/images/stay/list/제주신라편의시설2.PNG" style="width: 380px; height: 70px; padding-bottom: 0px;">
			            <br><p style="font-size: 18px; font-weight: bolder; color: red; margin-left: 230px; margin-top: 5px;">1박 / 142,019원</p>
			         </div>
		          </div>
		          <!-- 객실 -->
		          <div class="row room" >
			         <div class="col-sm-4 room">
			           <img src="/resources/images/stay/list/패밀리트윈.PNG">
			           <span style="font-weight: bold;">[힐링 특가]패밀리 트윈</span>
			           <span class="material-symbols-outlined">schedule</span>
			           <span style="font-size: 15px; color: gray;">입실 15:00</span> ~
			           <span style="font-size: 15px; color: gray;">퇴실 13:00</span><br>
			           <span class="material-symbols-outlined">person</span>
			           <span style="font-size: 15px; color: gray;">기준 2인</span> /
			           <span style="font-size: 15px; color: gray;">최대 4인</span><br>
			           <span style="font-size: 15px; color: orange;">남은객실 : 7개</span><br>
			           <span style="font-size: 17px; font-weight:bolder;  color: red;">142,019원(1박)</span>
			           <button type="button" class="btn btn-secondary cartPopover" data-bs-toggle="popover" title="<strong>찜하기</strong>"  data-bs-html="true" data-bs-content="${popover}" style="float: right; margin-right: 10px; border-radius: 20px; background-color: gray;">♥</button>
			           &nbsp;&nbsp;&nbsp;<button class="btn btn-warning">예약하기</button>
			         </div>
			         <div class="col-sm-4 room">
			           <img src="/resources/images/stay/list/패밀리트윈2.PNG">
			           <span style="font-weight: bold;">[RoomOnly]패밀리트윈</span>
			           <span class="material-symbols-outlined">schedule</span>
			           <span style="font-size: 15px; color: gray;">입실 15:00</span> ~
			           <span style="font-size: 15px; color: gray;">퇴실 12:00</span><br>
			           <span class="material-symbols-outlined">person</span>
			           <span style="font-size: 15px; color: gray;">기준 2인</span> /
			           <span style="font-size: 15px; color: gray;">최대 4인</span><br>
			           <span style="font-size: 15px; color: orange;">남은객실 : 4개</span><br>
			           <span style="font-size: 17px; font-weight:bolder;  color: red;">155,083원(1박)</span>
			           <button type="button" class="btn btn-secondary cartPopover" data-bs-toggle="popover" title="<strong>찜하기</strong>"  data-bs-html="true" data-bs-content="${popover}" style="float: right; margin-right: 10px; border-radius: 20px; background-color: gray;">♥</button>
			           &nbsp;&nbsp;&nbsp;<button class="btn btn-warning">예약하기</button>
			         </div>
			         <div class="col-sm-4 room">
			           <img src="/resources/images/stay/list/프리미어디럭스더블.PNG">
			           <span style="font-weight: bold;">프리미어 디럭스 더블</span>
			           <span class="material-symbols-outlined">schedule</span>
			           <span style="font-size: 15px; color: gray;">입실 15:00</span> ~
			           <span style="font-size: 15px; color: gray;">퇴실 12:00</span><br>
			           <span class="material-symbols-outlined">person</span>
			           <span style="font-size: 15px; color: gray;">기준 2인</span> /
			           <span style="font-size: 15px; color: gray;">최대 4인</span><br>
			           <span style="font-size: 15px; color: orange;">남은객실 : 1개</span><br>
			           <span style="font-size: 17px; font-weight:bolder;  color: red;">164,983원(1박)</span>
			           <button type="button" class="btn btn-secondary cartPopover" data-bs-toggle="popover" title="<strong>찜하기</strong>"  data-bs-html="true" data-bs-content="${popover}" style="float: right; margin-right: 10px; border-radius: 20px; background-color: gray;">♥</button>
			           &nbsp;&nbsp;&nbsp;<button class="btn btn-warning">예약하기</button>
			         </div>
		          </div>
		
		       </div>
		  </div>
	  
      <!-- 더보기 버튼 -->
      <div class="row more">
        <div class="col-sm-12"><button type="button" class="btn btn-primary" id="moreBtn">더 많은 결과를 표시하기</button></div>
      </div><br>
	 
   </div>  
	
   <!-- [right side 광고영역] -->
   <div id="container-right">
	  <div class="row">
	  <a href="#"><img src="/resources/images/stay/list/숙박광고1.PNG" width="285" height="200" style="border-radius: 20px; margin-bottom: 12px;"></a> 
	  <br><br>
	  <a href="#"><img src="/resources/images/stay/list/숙박광고2.PNG" width="285" height="280" style="border-radius: 20px; margin-bottom: 12px;"></a> 
	  <a href="#"><img src="/resources/images/stay/list/숙박광고3.PNG" width="285" height="200" style="border-radius: 20px; margin-bottom: 12px;"></a> 
	  </div>
   </div> 
</section>

<!-- 항공리스트 JS -->
<script src="${contextPath }/resources/js/air/list.js"></script>
  
<script>
  $(function(){
	var depFlightCode;
	var arrFlightCode;
	var totalPrice;
	var totalPassenger = $('#totalPassenger').text();
	  
	//popover 기능 활성화
	var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
	var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
	                    return new bootstrap.Popover(popoverTriggerEl)
	                  })
	  
	  /*정렬 및 조회 관련 모든 기능*/
	  $.sortBtnFn();
	  
	  /*찜하기 버튼 클릭 시 이벤트*/
	  $(document).on('click', '.cartPopover', function(){
		  var thisIs = $(this);
		  //버튼 색상 변경
		  if(thisIs.css('background-color') == 'rgb(128, 128, 128)'){
			  thisIs.css('background-color', 'red');
		  }
		  if(thisIs.css('background-color') == 'rgb(255, 0, 0)'){
			  thisIs.css('background-color', 'gray');
		  }
	  });
	  
	  /* 찜하기 클릭 시 이벤트*/
	  $(document).on('click', '.popoverSpan', function(){
		  var url = '/partner/buyPlan.do?plNo=';  //전송 url제작
		  var plNo = $(this).attr('id');  //플래너 번호 세팅
		  url += plNo;
		  url += '&stay=true';
		  console.log('url : '+url);
		  location.href = url;
	  });
	  
	  
	  /* 개인장바구니 이동 클릭 시 이벤트*/

	  
  })
</script>





























  
  



    
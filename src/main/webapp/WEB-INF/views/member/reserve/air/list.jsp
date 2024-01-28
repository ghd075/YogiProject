<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 항공 검색결과 화면 CSS -->
<link href="${contextPath}/resources/css/air/searchList.css" rel="stylesheet" />

<section class="emptySpace">

     <c:if test="${searchInfo.seatClass eq 'economy'}">
	    <c:set value="일반석" var="seatClass"/>
     </c:if>
     <c:if test="${searchInfo.seatClass eq 'business'}">
	    <c:set value="비즈니스석" var="seatClass"/>
     </c:if>
     <c:if test="${searchInfo.seatClass eq 'firstClass'}">
	    <c:set value="일등석" var="seatClass"/>
     </c:if>

    <!-- [상단영역] -->
	<div class="container-fluid mt-3" id="container-top">
	  <div class="row">
	    <div class="col-sm-1 text-white top">
	     <a href="/reserve/air/search/form.do"><img id="topImg" src="/resources/images/air/list/돋보기.PNG"></a>
	    </div>
	    <div class="col-sm-3 text-white top">
	      <p id="topText1">  
	          <span style="font-size: 20px;">
	              ${searchInfo.flightDepairport}(${searchInfo.flightDepportcode}) 
	              - 
	              ${searchInfo.flightArrairport}(${searchInfo.flightArrportcode})
	          </span><br>
	              ${seatClass} | 총 승객 ${searchInfo.totalCnt} | 
	                          성인  ${searchInfo.adultCnt} | 유아  ${searchInfo.yuaCnt} | 
	                          소아  ${searchInfo.soaCnt}  </p>
	    </div>
	    <div class="col-sm-8 text-white top">
	      <p id="topText2">
	        <span>◁</span>&nbsp; ${searchInfo.originDeptime} &nbsp;<span>▷</span>
	        &nbsp;&nbsp;   
	        <span>◁</span>&nbsp; ${searchInfo.originArrtime} &nbsp;<span>▷</span> 
	      </p>   
	    </div>
	  </div>
    </div>
     
       <!-- [left side 검색조건 영역] -->
       <div id="container-left">
	    <div class="accordion" id="accordionPanelsStayOpenExample">
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true" aria-controls="panelsStayOpen-collapseOne">
		        <strong>출발시간대 설정</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse show">
		      <div class="accordion-body">
		         <label for="depRange" class="form-label">
					<strong>가는날 출발시간</strong><br>
					<small>오전 00:00</small> ~ <small id="depRangeVal">오후 11:59</small>
				 </label>
                 <input type="range" class="form-range" id="depRange" min="0" max="1440" step="30" value="1440">  
                 <br><br> 
		         <label for="arrRange" class="form-label">
					<strong>오는날 출발시간</strong><br>
					<small>오전 00:00</small> ~ <small id="arrRangeVal">오후 11:59</small>
				 </label>
                 <input type="range" class="form-range" id="arrRange" min="0" max="1440" step="30" value="1440">
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="true" aria-controls="panelsStayOpen-collapseTwo">
		                 <strong>총 소요시간</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse show">
		      <div class="accordion-body">
		         <label for="durRange" class="form-label">
					<small>0분</small> ~ <small id="durRangeVal">240분</small>
				 </label>
                 <input type="range" class="form-range" id="durRange" min="0" max="240" step="10" value="240">
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="true" aria-controls="panelsStayOpen-collapseThree">
		              <strong> 항공사</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse show">
		      <div class="accordion-body">
		        <div class="form-check">
		          <button type="button" class="btn btn-primary">모두선택</button>
		          <button type="button" class="btn btn-primary">모두지우기</button><br><br>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">대한항공</label><br>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">아시아나항공</label><br><hr>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">제주항공</label><br>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">진에어</label><br>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">티웨이항공</label><br><hr>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">에어부산</label><br>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">에어서울</label><br>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">이스타항공</label><br>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">플라이강원</label><br>
				  &nbsp;<input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  &nbsp;<label class="form-check-label">하이에어</label><br>
				</div>
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
		         <strong> 경유</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse show">
		      <div class="accordion-body">
		        <div class="form-check">
		          <button type="button" class="btn btn-primary">모두선택</button>
		          <button type="button" class="btn btn-primary">모두지우기</button><br><br>
				  <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  <label class="form-check-label">편도</label><br><br>
				  <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something">
				  <label class="form-check-label">1회 경유</label><br><br>
				  <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something">
				  <label class="form-check-label">2회 경유</label><br><br>
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
	        <strong id="resultCnt">${searchInfo.totalRecord}개의 검색결과...</strong>
	       <div class="progress">
			  <div class="progress-bar" style="width:100%"></div>
		   </div>   
	     </div>
	     <div class="col-sm-4 basicSelect">
	            정렬기준 &nbsp;&nbsp;
	      <select id="selectSort">
	        <option selected="selected" id="priceSelect" value="priceSelect">최저가</option>
	        <option id="durationSelect" value="durationSelect">최단여행시간</option>
	        <option id="recoSelect" value="recoSelect">추천순</option>
	      </select> 
	     </div>
	   </div>
	   
	   <c:choose>
	    <c:when test="${msg eq 'NO'}">
		   <div class="mainContent">
		    <div class="row">
		     <div class="col-sm-12" style="padding-left: 280px;">
		        <br>&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
		       <img src="/resources/images/air/list/nothing.PNG"><br><br>
		       <p style="font-size: 20px; font-weight: bolder;">죄송합니다. 검색조건에 일치하는 항공권이 없습니다.</p>
		     </div>
		    </div>
		  </div>
	    </c:when>
	    <c:otherwise>
	      <!-- 정렬조건 선택 영역 -->
		  <div class="row basicSearch">
		     <div class="col-sm-4" id="lowestPrice"><br>
		       <strong>최저가</strong><br>
		       <span id="lowPrice">
		         <fmt:formatNumber value="${sortVO.lowestPrice}" type="currency" currencySymbol="₩" />
		       </span><br>
		       <span id="lowDuration" style="font-size: 16px;">${sortVO.lowestDuration}(평균)</span>
		     </div>
		     <div class="col-sm-4" id="shortDuration"><br>
		       <strong>최단시간여행</strong><br>
	           <span id="shortestPrice">
	             <fmt:formatNumber value="${sortVO.shortestPrice}" type="currency" currencySymbol="₩"/>
	           </span><br>
	           <span id="shortestDuration" style="font-size: 16px;">${sortVO.shortestDuration}(평균)</span>
		     </div>
		     <div class="col-sm-4" id="recommendation"><br>
		        <strong>추천순</strong><br>
		        <span id="recoPrice">
		          <fmt:formatNumber value="${sortVO.recoPrice}" type="currency" currencySymbol="₩"/>
		        </span><br>
		        <span id="recoDuration" style="font-size: 16px;">${sortVO.recoDuration}(평균)</span>
		     </div>
		   </div>
		   
		 <!-- 메인컨텐츠 -->
		 <div class="contentSet"> 
		   <c:forEach items="${pageList}" var="flight" varStatus="loop">
		     <form action="/reserve/air/reserve/reserve.do" method="get"> 
		       <!-- 왕복편 -->
		       <div class="mainContent">
		          <!-- 출발편 -->
		          <div class="row">
		             <input type="hidden" value="${flight.departure.flightCode}" name="depFlightCode">
			         <div class="col-sm-2">
			           <c:if test="${empty flight.departure.airlineLogo}">
			             <img src="/resources/images/air/list/basic.PNG">
			           </c:if>
			           <c:if test="${not empty flight.departure.airlineLogo}">
			             <img src="${flight.departure.airlineLogo}">
			           </c:if>
			         </div>
			         <div class="col-sm-2 middle">
			            <span>
			              <fmt:parseDate value="${flight.departure.flightDeptime}" pattern="yyyyMMddHHmm" var="depTime1"/>
			              <fmt:formatDate value="${depTime1}" pattern="a h:mm"/>
			            </span><br>
			            <span style="font-weight: normal; font-size: 16px;">${flight.departure.flightDepairport}(${flight.departure.flightDepportcode})</span>  
			         </div>
			         <div class="col-sm-3 middle">
			            <span style="font-size: 15px;">${flight.departure.flightDuration} (편도)</span>
			            <img src="/resources/images/air/list/경로.PNG">
			         </div>
			         <div class="col-sm-2 middle third" >
			            <span>
			              <fmt:parseDate value="${flight.departure.flightArrtime}" pattern="yyyyMMddHHmm" var="arrTime1"/>
			              <fmt:formatDate value="${arrTime1}" pattern="a h:mm"/>
			            </span>  <br>
			            <span style="font-weight: normal; font-size: 16px;">${flight.departure.flightArrairport}(${flight.departure.flightArrportcode})</span>
			         </div>
			         <div class="col-sm-3 end" style="border-left: 2px solid rgb(239, 241, 242);">
			           <span style="font-size: 22px;" id="roundTripPrice">
			            <fmt:formatNumber value="${flight.roundTripPrice}" type="currency" currencySymbol="₩"/>
			           </span>
			           <svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" viewBox="0 0 512 512">
			             <path d="M225.8 468.2l-2.5-2.3L48.1 303.2C17.4 274.7 0 234.7 0 192.8v-3.3c0-70.4 50-130.8 119.2-144C158.6 37.9 198.9 47 231 69.6c9 6.4 17.4 13.8 25 22.3c4.2-4.8 8.7-9.2 13.5-13.3c3.7-3.2 7.5-6.2 11.5-9c0 0 0 0 0 0C313.1 47 353.4 37.9 392.8 45.4C462 58.6 512 119.1 512 189.5v3.3c0 41.9-17.4 81.9-48.1 110.4L288.7 465.9l-2.5 2.3c-8.2 7.6-19 11.9-30.2 11.9s-22-4.2-30.2-11.9zM239.1 145c-.4-.3-.7-.7-1-1.1l-17.8-20c0 0-.1-.1-.1-.1c0 0 0 0 0 0c-23.1-25.9-58-37.7-92-31.2C81.6 101.5 48 142.1 48 189.5v3.3c0 28.5 11.9 55.8 32.8 75.2L256 430.7 431.2 268c20.9-19.4 32.8-46.7 32.8-75.2v-3.3c0-47.3-33.6-88-80.1-96.9c-34-6.5-69 5.4-92 31.2c0 0 0 0-.1 .1s0 0-.1 .1l-17.8 20c-.3 .4-.7 .7-1 1.1c-4.5 4.5-10.6 7-16.9 7s-12.4-2.5-16.9-7z"/>
			           </svg><br><br>
			           <span id="totalPrice">(총가격 : <fmt:formatNumber value="${flight.totalPrice}" type="currency" currencySymbol="₩"/>)</span><br>
			         </div>
		          </div>
		          
			      <!-- 돌아오는 편 -->
		          <div class="row">
		              <input type="hidden" value="${flight.arrival.flightCode}" name="arrFlightCode">
			          <div class="col-sm-2">
			            <c:if test="${empty flight.arrival.airlineLogo}">
			              <img src="/resources/images/air/list/basic.PNG">
			            </c:if>
			            <c:if test="${not empty flight.arrival.airlineLogo}">
			              <img src="${flight.arrival.airlineLogo}">
			            </c:if>
			          </div>
			          <div class="col-sm-2 middle">
			            <span>
			              <fmt:parseDate value="${flight.arrival.flightDeptime}" pattern="yyyyMMddHHmm" var="depTime2"/>
			              <fmt:formatDate value="${depTime2}" pattern="a h:mm"/>
			            </span> <br>
			            <span style="font-weight: normal; font-size: 16px;" id="flightDepairport2">${flight.arrival.flightDepairport}(${flight.arrival.flightDepportcode})</span>    
			          </div>
			          <div class="col-sm-3 middle">
			             <span style="font-size: 15px;">${flight.arrival.flightDuration} (편도)</span>
			             <img src="/resources/images/air/list/경로.PNG">
			          </div>
			          <div class="col-sm-2 middle">
			            <span>
			              <fmt:parseDate value="${flight.arrival.flightArrtime}" pattern="yyyyMMddHHmm" var="arrTime2"/>
			              <fmt:formatDate value="${arrTime2}" pattern="a h:mm"/>
			            </span> <br>
			            <span style="font-weight: normal; font-size: 16px;">${flight.arrival.flightArrairport}(${flight.arrival.flightArrportcode})</span>
			          </div>
			          <div class="col-sm-3 end" style="border-left: 2px solid rgb(239, 241, 242);">
			            <button type="submit" class="btn btn-primary">예매하기</button> 
			          </div>
		           </div>
		       </div>
		      </form>
		    </c:forEach>
		  </div>
	    </c:otherwise>
	  </c:choose> 
	  
      <!-- 더보기 버튼 -->
      <br>
      <div class="row more">
        <div class="col-sm-12"><button type="button" class="btn btn-primary" id="moreBtn">더 많은 결과를 표시하기</button></div>
      </div><br>
	 
   </div>  
	
   <!-- [right side 광고영역] -->
   <div id="container-right">
	  <div class="row">
	  <a href="#"><img src="/resources/images/air/list/호텔광고링크1.PNG" width="285" height="300" style="border-radius: 20px; margin-bottom: 12px;"></a> 
	  <br><br>
	  <a href="#"><img src="/resources/images/air/list/호텔광고링크2.PNG" width="285" height="300" style="border-radius: 20px; margin-bottom: 12px;"></a> 
	  <a href="#"><img src="/resources/images/air/list/호텔광고링크3.PNG" width="285" height="400" style="border-radius: 20px; margin-bottom: 12px;"></a> 
	  </div>
   </div>
</section>

<!-- 항공리스트 JS -->
<script src="${contextPath }/resources/js/air/list.js"></script>
  
<script>
  $(function(){
	  //정렬 및 조회 관련 모든 기능
	  $.sortBtnFn();
  })
</script>





























  
  



    
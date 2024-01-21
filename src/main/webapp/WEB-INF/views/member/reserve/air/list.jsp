<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	        <span>◁</span>&nbsp;&nbsp; 3월 25일 (월) &nbsp;&nbsp;<span>▷</span>
	        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;    
	        <span>◁</span>&nbsp;&nbsp; 3월 30일 (금) &nbsp;&nbsp;<span>▷</span> 
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
		         <strong>가는날 출발시간</strong><br>
		         <small>오전 12:00 ~ 오후 11:59</small>
		         <label for="customRange" class="form-label"></label>
                 <input type="range" class="form-range" id="customRange">  
                 <br><br> 
		         <strong>오는날 출발시간</strong><br>
                 <small>오전 12:00 ~ 오후 11:59</small>
		         <label for="customRange" class="form-label"></label>
                 <input type="range" class="form-range" id="customRange">
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
		                 <strong>총 소요시간</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse">
		      <div class="accordion-body">
                 <small>40분 ~ 129분</small>
		         <label for="customRange" class="form-label"></label>
                 <input type="range" class="form-range" id="customRange">
		      </div>
		    </div>
		  </div>
		  
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">
		              <strong> 항공사</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse">
		      <div class="accordion-body">
		        <div class="form-check">
		          <button type="button" class="btn btn-primary">모두선택</button>
		          <button type="button" class="btn btn-primary">모두지우기</button><br><br>
				  <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  <label class="form-check-label">제주항공</label><br><br>
				  <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  <label class="form-check-label">인천국제공항</label><br><br>
				  <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  <label class="form-check-label">김해공항</label><br><br>
				  <input class="form-check-input" type="checkbox" id="check1" name="option1" value="something" checked>
				  <label class="form-check-label">Option 1</label>
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
		    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse">
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
	     <div class="col-sm-8">
	        <strong>${searchInfo.totalRecord}개의 검색결과...</strong>
	       <div class="progress">
			  <div class="progress-bar" style="width:70%"></div>
		   </div>  
	     </div>
	     <div class="col-sm-4 basicSelect">
	            정렬기준 &nbsp;&nbsp;
	      <select>
	        <option selected="selected">최저가</option>
	        <option>최단여행시간</option>
	        <option>추천순</option>
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
		     <div class="col-sm-4"><br>
		       <strong>최저가</strong><br>
		       <span>
		         <fmt:formatNumber value="${sortVO.lowestPrice}" type="currency" currencySymbol="₩" />
		       </span><br>
		       ${sortVO.lowestDuration}(평균)
		     </div>
		     <div class="col-sm-4"><br>
		       <strong>최단시간여행</strong><br>
	           <span>
	             <fmt:formatNumber value="${sortVO.shortestPrice}" type="currency" currencySymbol="₩"/>
	           </span><br>
	           ${sortVO.shortestDuration}(평균)
		     </div>
		     <div class="col-sm-4"><br>
		        <strong>추천순</strong><br>
		        <span>
		          <fmt:formatNumber value="${sortVO.recoPrice}" type="currency" currencySymbol="₩"/>
		        </span><br>
		        ${sortVO.recoDuration}(평균)
		     </div>
		   </div>
		   
		   <!-- 메인컨텐츠 -->
		   <c:forEach items="${pageList}" var="flight" varStatus="loop">
		       <div class="mainContent">
		          <!-- 출발편 -->
		          <div class="row">
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
			            ${flight.departure.flightDepairport}(${flight.departure.flightDepportcode})   
			         </div>
			         <div class="col-sm-3 middle">
			            <span style="font-size: 15px;">${flight.departure.flightDuration} (편도)</span>
			            <img src="/resources/images/air/list/경로.PNG">
			         </div>
			         <div class="col-sm-2 middle">
			            <span>
			              <fmt:parseDate value="${flight.departure.flightArrtime}" pattern="yyyyMMddHHmm" var="arrTime1"/>
			              <fmt:formatDate value="${arrTime1}" pattern="a h:mm"/>
			            </span>  <br>
			            ${flight.departure.flightArrairport}(${flight.departure.flightArrportcode})
			         </div>
			         <div class="col-sm-3 end" style="border-left: 2px solid rgb(239, 241, 242);">
			           <span id="roundTripPrice">
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
			             ${flight.arrival.flightDepairport}(${flight.arrival.flightDepportcode})    
			          </div>
			          <div class="col-sm-3 middle">
			             <span style="font-size: 15px;">${flight.arrival.flightDuration} (편도)</span>
			             <img src="/resources/images/air/list/경로.PNG">
			          </div>
			          <div class="col-sm-2 middle">
			            <span>
			              <fmt:parseDate value="${flight.departure.flightArrtime}" pattern="yyyyMMddHHmm" var="arrTime2"/>
			              <fmt:formatDate value="${arrTime2}" pattern="a h:mm"/>
			            </span> <br>
			            ${flight.arrival.flightArrairport}(${flight.arrival.flightArrportcode})
			          </div>
			          <div class="col-sm-3 end" style="border-left: 2px solid rgb(239, 241, 242);">
			            <button type="button" class="btn btn-primary">선택하기</button> 
			          </div>
		           </div>
		       </div>
		    </c:forEach>
	    </c:otherwise>
	  </c:choose> 
	  
      <!-- 더보기 버튼 -->
      <br>
      <div class="row more">
        <div class="col-sm-12"><button type="button" class="btn btn-primary" onclick="location.href='/reserve/air/search/moreList.do'">더 많은 결과를 표시하기</button></div>
      </div><br>
	 
   </div>  
	
   <!-- [right side 광고영역] -->
   <div id="container-right">
	  <div class="row">
	  <a href="#"><img src="/resources/images/air/list/호텔광고링크1.PNG" width="285" height="300" style="border-radius: 20px; margin-bottom: 12px;"></a> 
	  <br><br>
	  <a href="#"><img src="/resources/images/air/list/호텔광고링크2.PNG" width="285" height="300" style="border-radius: 20px; margin-bottom: 12px;"></a> 
	  </div>
   </div>
</section>

<script>
  $(function(){

  })
</script>





























  
  



    
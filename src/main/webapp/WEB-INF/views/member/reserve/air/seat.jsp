<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 항공 좌석선택 화면 CSS -->
<link href="${contextPath}/resources/css/air/seat.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<section class="emptySpace">

    <!-- [상단영역] -->
	<div class="container-fluid mt-3" id="container-top">
	  <div class="row">
	    <div class="col-sm-4 text-white top" style="background-color: rgb(207, 226, 255);">
	      Step<span class="material-symbols-outlined">counter_1</span> &nbsp;여행자 및 항공편 정보
	    </div>
	    <div class="col-sm-4 text-white top" style="background-color: rgb(13, 110, 253); box-shadow: 2px 2px 2px black;">
	      Step <span class="material-symbols-outlined">counter_2</span> &nbsp;좌석 선택하기
	    </div>
	    <div class="col-sm-4 text-white top" style="background-color: rgb(207, 226, 255);">
	      Step <span class="material-symbols-outlined">counter_3</span> &nbsp;결제하기
	    </div>
	  </div>
    </div>
    
   <div id="container-main"><br>
	  <div class="container-fluid">
	     <!-- 탭버튼 영역 -->
         <div class="row nav">
           <div class="col-sm-4 left-tab tabBtn tactive"><p>가는편</p></div>
           <div class="col-sm-8 right-tab tabBtn"><p>오는편</p></div>
         </div>
         
         <!-- 상단 정보영역(가는편) -->
         <div class="row content-top">
           <div class="col-sm-5">
	          <h5>
	            <span class="material-symbols-outlined">travel</span>
	            <span>${searchInfo.flightDepairport}(${searchInfo.flightDepportcode})</span> 
	            &nbsp; → &nbsp; <span>${searchInfo.flightArrairport}(${searchInfo.flightArrportcode})</span>
	          </h5>
           </div>
           <div class="col-sm-3">
              <span class="material-symbols-outlined">flight</span><span><strong>기종</strong> &nbsp;|&nbsp; ${departure.airplaneName}</span>
           </div>
           <div class="col-sm-4">
             <span class="material-symbols-outlined">airline_seat_recline_normal</span>
             <span><strong>전체</strong> &nbsp;|&nbsp; <span>남은좌석 ${departure.airplaneRemaineconomy + departure.airplaneRemainbusiness + departure.airplaneRemainfirst}</span>
              / 전체좌석 ${departure.airplaneTotaleconomy + departure.airplaneTotalbusiness + departure.airplaneTotalfirst}</span><br>
             <span><strong>일반석</strong> &nbsp;|&nbsp; <span>남은좌석 ${departure.airplaneRemaineconomy}</span> / 전체좌석 ${departure.airplaneTotaleconomy}</span><br>
             <span class="material-symbols-outlined">airline_seat_recline_normal</span>
             <span><strong>비즈니스석</strong>  &nbsp;|&nbsp; <span>남은좌석  ${departure.airplaneRemainbusiness}</span> / 전체좌석 ${departure.airplaneTotalbusiness}</span><br>
             <span><strong>일등석</strong> &nbsp;|&nbsp; <span>남은좌석 ${departure.airplaneRemainfirst}</span> / 전체좌석 ${departure.airplaneTotalfirst}</span>
           </div>
         </div>
         
         
         <!-- 상단 정보영역(오는편) -->
         <div class="row content-top" style="display: none;">
           <div class="col-sm-5">
	          <h5>
	            <span class="material-symbols-outlined">travel</span>
	            <span>${searchInfo.flightArrairport}(${searchInfo.flightArrportcode})</span> 
	            &nbsp; → &nbsp; <span>${searchInfo.flightDepairport}(${searchInfo.flightDepportcode})</span>
	          </h5>
           </div>
           <div class="col-sm-3">
              <span class="material-symbols-outlined">flight</span><span><strong>기종</strong> &nbsp;|&nbsp; ${airReturn.airplaneName}</span>
           </div>
           <div class="col-sm-4">
             <span class="material-symbols-outlined">airline_seat_recline_normal</span>
             <span><strong>전체</strong> &nbsp;|&nbsp; <span>남은좌석 ${airReturn.airplaneRemaineconomy + airReturn.airplaneRemainbusiness + airReturn.airplaneRemainfirst}</span>
              / 전체좌석 ${airReturn.airplaneTotaleconomy + airReturn.airplaneTotalbusiness + airReturn.airplaneTotalfirst}</span><br>
             <span><strong>일반석</strong> &nbsp;|&nbsp; <span>남은좌석 ${airReturn.airplaneRemaineconomy}</span> / 전체좌석 ${airReturn.airplaneTotaleconomy}</span><br>
             <span class="material-symbols-outlined">airline_seat_recline_normal</span>
             <span><strong>비즈니스석</strong>  &nbsp;|&nbsp; <span>남은좌석  ${airReturn.airplaneRemainbusiness}</span> / 전체좌석 ${airReturn.airplaneTotalbusiness}</span><br>
             <span><strong>일등석</strong> &nbsp;|&nbsp; <span>남은좌석 ${airReturn.airplaneRemainfirst}</span> / 전체좌석 ${airReturn.airplaneTotalfirst}</span>
           </div>
         </div>
         
         
         <div class="row content-middleTop">
           <div class="col-sm-6 before">
              <br><span style="font-weight: bolder; font-size: 17px; color: gray;">항공기 앞쪽</span>
           </div>
           <div class="col-sm-6 after">
              <br><span style="font-weight: bolder; font-size: 17px; color: gray;">항공기 뒤쪽</span>
           </div>
         </div>
         
         <div class="row content-middleTop2">
           <div class="col-sm-5 before" style="background-color: lightgray;"></div>
           <div class="col-sm-7 after" style="border-bottom: 1px solid lightgray;"></div>
         </div>
         
         <div class="row content-middle1">
           <div class="col-sm-2" id="first">
             <div id="seatNo" style="margin-left: 33px;">1</div>
             <div id="seatNo" style="width: 25px;">2</div>
             <div id="seatNo" style="width: 25px;">3</div>
           </div>
           <div class="col-sm-1" id="etc">
           </div>
           <div class="col-sm-3" id="business" style="border-right: 1px solid lightgray;">
             <div id="seatNo" style="margin-left: 30px;">4</div>
             <div id="seatNo" style="margin-left: 10px;">5</div>
             <div id="seatNo" style="margin-left: 10px;">6</div>
             <div id="seatNo" style="margin-left: 10px;">7</div>
           </div>
           <div class="col-sm-6" id="economy">
            <div id="seatNo" style="margin-left: 25px;">8</div>
            <div id="seatNo">9</div>
            <div id="seatNo">10</div>
            <div id="seatNo">11</div>
            <div id="seatNo">12</div>
            <div id="seatNo">13</div>
            <div id="seatNo">14</div>
            <div id="seatNo">15</div>
            <div id="seatNo">16</div>
            <div id="seatNo">17</div>
           </div>
         </div>
         
         <!-- 좌석선택영역(가는편) -->
         <div class="row content-middle2">
           <!-- 일등석  -->
           <div class="col-sm-2" id="first">
	           &nbsp;<div class="seatAlp">A</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="A1,A2,A3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.depSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
	             <c:if test="${flag ne 'ok'}">
	               &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
	             </c:if>
	           </c:forEach><br>
	           <c:remove var="firstArr"/>
	           
	           &nbsp;<div class="seatAlp">B</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="B1,B2,B3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	           <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.depSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
	             <c:if test="${flag ne 'ok'}">
	              &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
	             </c:if>
	           </c:forEach><br><br>
	           <c:remove var="firstArr"/>
	           
	           &nbsp;<div class="seatAlp">C</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="C1,C2,C3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.depSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
                 <c:if test="${flag ne 'ok'}">
                   &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
	           </c:forEach><br>
	           <c:remove var="firstArr"/>
           
             &nbsp;<div class="seatAlp">D</div><br>
             &nbsp;<div class="seatAlp">E</div><br>
             &nbsp;<div class="seatAlp">F</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="F1,F2,F3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.depSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
                 <c:if test="${flag ne 'ok'}">
                   &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
	           </c:forEach><br><br>
	           <c:remove var="firstArr"/>
	           
               &nbsp;<div class="seatAlp">G</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="G1,G2,G3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.depSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
                 <c:if test="${flag ne 'ok'}">
                   &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
	           </c:forEach><br>
	           <c:remove var="firstArr"/>
	           
               &nbsp;<div class="seatAlp">H</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="H1,H2,H3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.depSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
                 <c:if test="${flag ne 'ok'}">
                   &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
	           </c:forEach><br>
	           <c:remove var="firstArr"/>
           </div>
           
           <!-- 기타 시설 -->
           <div class="col-sm-1" id="etc">
             <div class="seat-etc">
               <span class="material-symbols-outlined">man</span>
               <span class="material-symbols-outlined">woman</span>
             </div><br><br>
             <div class="seat-etc" style="height: 140px;">
               <span class="material-symbols-outlined">local_cafe</span>
               <span class="material-symbols-outlined">dining</span><br>
               <span class="material-symbols-outlined">accessible</span>
               <span class="material-symbols-outlined">accessible</span>
             </div><br><br>
             <div class="seat-etc">
               <span class="material-symbols-outlined">man</span>
               <span class="material-symbols-outlined">woman</span>
             </div>
           </div>
           
           <!-- business석 -->
           <div class="col-sm-3" id="business" style="border-right: 1px solid lightgray;">
           
             <c:set var="businessArray" value="A4,A5,A6,A7,B4,B5,B6,B7,C4,C5,C6,C7,D4,D5,D6,D7,E4,E5,E6,E7,F4,F5,F6,F7,G4,G5,G6,G7,H4,H5,H6,H7"/>
	           <c:forEach var="seatNo" items="${fn:split(businessArray, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.depSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-business choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
	             <c:if test="${flag ne 'ok'}">
	                   &nbsp;<div class="seat-business choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
                   <c:if test="${loop.count == 8 or loop.count == 24}">
                     <br><br>
                   </c:if>
                   <c:if test="${loop.count % 4 == 0 and loop.count != 8 and loop.count != 24 and loop.count != 32}">
                     <br>
                   </c:if>
	           </c:forEach>
	           <c:remove var="businessArray"/>
           </div>
           
           <!-- economy석 -->
           <div class="col-sm-6" id="economy">
               <c:set var="economyArray" value="A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,G8,G9,G10,G11,G12,G13,G14,G15,G16,G17,H8,H9,H10,H11,H12,H13,H14,H15,H16,H17"/>
	           <c:forEach var="seatNo" items="${fn:split(economyArray, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.depSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-economy choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
	             <c:if test="${flag ne 'ok'}">
	                   &nbsp;<div class="seat-economy choiceSeat" id="${seatNo}">${seatNo}</div>
	             </c:if>
                   <c:if test="${loop.count == 20 or loop.count == 60}">
                     <br><br>
                   </c:if>
                   <c:if test="${loop.count % 10 == 0 and loop.count != 20 and loop.count != 60}">
                     <br>
                   </c:if>
	           </c:forEach>
	           <c:remove var="economyArray"/>
           </div>
         </div>
         
         
         <!-- 좌석선택영역(오는편) -->
         <div class="row content-middle2" style="display: none;">
           <!-- 일등석  -->
           <div class="col-sm-2" id="first">
	           &nbsp;<div class="seatAlp">A</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="A1,A2,A3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.returnSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
	             <c:if test="${flag ne 'ok'}">
	               &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
	             </c:if>
	           </c:forEach><br>
	           <c:remove var="firstArr"/>
	           
	           &nbsp;<div class="seatAlp">B</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="B1,B2,B3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	           <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.returnSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
	             <c:if test="${flag ne 'ok'}">
	              &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
	             </c:if>
	           </c:forEach><br><br>
	           <c:remove var="firstArr"/>
	           
	           &nbsp;<div class="seatAlp">C</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="C1,C2,C3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.returnSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
                 <c:if test="${flag ne 'ok'}">
                   &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
	           </c:forEach><br>
	           <c:remove var="firstArr"/>
           
             &nbsp;<div class="seatAlp">D</div><br>
             &nbsp;<div class="seatAlp">E</div><br>
             &nbsp;<div class="seatAlp">F</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="F1,F2,F3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.returnSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
                 <c:if test="${flag ne 'ok'}">
                   &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
	           </c:forEach><br><br>
	           <c:remove var="firstArr"/>
	           
               &nbsp;<div class="seatAlp">G</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="G1,G2,G3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.returnSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
                 <c:if test="${flag ne 'ok'}">
                   &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
	           </c:forEach><br>
	           <c:remove var="firstArr"/>
	           
               &nbsp;<div class="seatAlp">H</div>&nbsp;&nbsp;&nbsp;&nbsp;
	           <c:set var="firstArr" value="H1,H2,H3"/>
	           <c:forEach var="seatNo" items="${fn:split(firstArr, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.returnSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-first choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
                 <c:if test="${flag ne 'ok'}">
                   &nbsp;<div class="seat-first choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
	           </c:forEach><br>
	           <c:remove var="firstArr"/>
           </div>
           
           <!-- 기타 시설 -->
           <div class="col-sm-1" id="etc">
             <div class="seat-etc">
               <span class="material-symbols-outlined">man</span>
               <span class="material-symbols-outlined">woman</span>
             </div><br><br>
             <div class="seat-etc" style="height: 140px;">
               <span class="material-symbols-outlined">local_cafe</span>
               <span class="material-symbols-outlined">dining</span><br>
               <span class="material-symbols-outlined">accessible</span>
               <span class="material-symbols-outlined">accessible</span>
             </div><br><br>
             <div class="seat-etc">
               <span class="material-symbols-outlined">man</span>
               <span class="material-symbols-outlined">woman</span>
             </div>
           </div>
           
           <!-- business석 -->
           <div class="col-sm-3" id="business" style="border-right: 1px solid lightgray;">
           
             <c:set var="businessArray" value="A4,A5,A6,A7,B4,B5,B6,B7,C4,C5,C6,C7,D4,D5,D6,D7,E4,E5,E6,E7,F4,F5,F6,F7,G4,G5,G6,G7,H4,H5,H6,H7"/>
	           <c:forEach var="seatNo" items="${fn:split(businessArray, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.returnSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-business choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
	             <c:if test="${flag ne 'ok'}">
	                   &nbsp;<div class="seat-business choiceSeat" id="${seatNo}">${seatNo}</div>
                 </c:if>
                   <c:if test="${loop.count == 8 or loop.count == 24}">
                     <br><br>
                   </c:if>
                   <c:if test="${loop.count % 4 == 0 and loop.count != 8 and loop.count != 24 and loop.count != 32}">
                     <br>
                   </c:if>
	           </c:forEach>
	           <c:remove var="businessArray"/>
           </div>
           
           <!-- economy석 -->
           <div class="col-sm-6" id="economy">
               <c:set var="economyArray" value="A8,A9,A10,A11,A12,A13,A14,A15,A16,A17,B8,B9,B10,B11,B12,B13,B14,B15,B16,B17,C8,C9,C10,C11,C12,C13,C14,C15,C16,C17,D8,D9,D10,D11,D12,D13,D14,D15,D16,D17,E8,E9,E10,E11,E12,E13,E14,E15,E16,E17,F8,F9,F10,F11,F12,F13,F14,F15,F16,F17,G8,G9,G10,G11,G12,G13,G14,G15,G16,G17,H8,H9,H10,H11,H12,H13,H14,H15,H16,H17"/>
	           <c:forEach var="seatNo" items="${fn:split(economyArray, ',')}" varStatus="loop">
	             <c:set var="flag" value="no"/>
	             <c:forEach var="reserved" items="${reservedSeats.returnSeat}">
	                 <c:if test="${seatNo eq reserved}">
	                   <c:set var="flag" value="ok"/>
	                   &nbsp;<div class="seat-economy choiceSeat" style="background-color: gray; color: white;">X</div>
	                 </c:if>
	             </c:forEach>
	             <c:if test="${flag ne 'ok'}">
	                   &nbsp;<div class="seat-economy choiceSeat" id="${seatNo}">${seatNo}</div>
	             </c:if>
                   <c:if test="${loop.count == 20 or loop.count == 60}">
                     <br><br>
                   </c:if>
                   <c:if test="${loop.count % 10 == 0 and loop.count != 20 and loop.count != 60}">
                     <br>
                   </c:if>
	           </c:forEach>
	           <c:remove var="economyArray"/>
           </div>
         </div>
         
         
         <div class="row content-middle3">
           <div class="col-sm-2" id="first">
             <div id="seatNo" style="margin-left: 33px;">1</div>
             <div id="seatNo" style="width: 25px;">2</div>
             <div id="seatNo" style="width: 25px;">3</div>
           </div>
           <div class="col-sm-1" id="etc">
           </div>
           <div class="col-sm-3" id="business" style="border-right: 1px solid lightgray;">
             <div id="seatNo" style="margin-left: 30px;">4</div>
             <div id="seatNo" style="margin-left: 10px;">5</div>
             <div id="seatNo" style="margin-left: 10px;">6</div>
             <div id="seatNo" style="margin-left: 10px;">7</div>
           </div>
           <div class="col-sm-6" id="economy">
            <div id="seatNo" style="margin-left: 25px;">8</div>
            <div id="seatNo">9</div>
            <div id="seatNo">10</div>
            <div id="seatNo">11</div>
            <div id="seatNo">12</div>
            <div id="seatNo">13</div>
            <div id="seatNo">14</div>
            <div id="seatNo">15</div>
            <div id="seatNo">16</div>
            <div id="seatNo">17</div>
          </div>
         </div>
         
         <div class="row content-bottom1">
           <div class="col-sm-5 before" style="background-color: lightgray;"></div>
           <div class="col-sm-7 after" style="border-top: 1px solid lightgray;"></div>
         </div>
      
      <div class="row content-bottom2">
          <div class="col-sm-2">
            <img src="/resources/images/air/seat/xbox2.PNG">
            <span>선택불가</span>
          </div>
          <div class="col-sm-2">
            <img src="/resources/images/air/seat/checked2.PNG">
            <span>선택됨</span>
          </div>
          <div class="col-sm-2">
            <span class="material-symbols-outlined">man</span>
            <span class="material-symbols-outlined">woman</span>
            <span>화장실</span>
          </div>
          <div class="col-sm-2">
            <span class="material-symbols-outlined">accessible_forward</span>
            <span>장애인 좌석</span>
          </div>
          <div class="col-sm-1">
          <span class="material-symbols-outlined">local_cafe</span>
            <span>카페</span>
          </div>
          <div class="col-sm-1">
          <span class="material-symbols-outlined">dining</span>
            <span>주방</span>
          </div>
        </div>
	  </div>
	</div>   <!-- main container끝 -->
    
   <!-- [전송form] -->
   <form action="/reserve/air/reserve/payment.do" method="post" id="submitForm">
    <div class="depForm" style="display: none;">
      <c:forEach items="${myReservation.ticketList}" var="ticket">
        <c:if test="${ticket.ticketType  eq 'DAPARTURE'}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketSeatnum">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketFirstname" value="${ticket.ticketFirstname}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketName" value="${ticket.ticketName}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketClass" value="${ticket.ticketClass}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketType" value="${ticket.ticketType}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketPassenage" value="${ticket.ticketPassenage}">
        </c:if>
       </c:forEach>
    </div>
    <div class="returnForm" style="display: none;">
      <c:forEach items="${myReservation.ticketList}" var="ticket">
        <c:if test="${ticket.ticketType  eq 'RETURN'}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketSeatnum">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketFirstname" value="${ticket.ticketFirstname}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketName" value="${ticket.ticketName}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketClass" value="${ticket.ticketClass}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketType" value="${ticket.ticketType}">
          <input type="hidden" class="${ticket.ageCnt}" name="ticketPassenage" value="${ticket.ticketPassenage}">
        </c:if>
       </c:forEach>
    </div>
   </form>
   
   <!-- [좌석선택 현황 영역] -->
   <!-- 가는편 탑승객 현황 -->
   <div class="container-fluid mt-3 passenger">
      <div class="row">
        <select id="departureSelect">
         <c:forEach items="${myReservation.ticketList}" var="ticket">
           <c:if test="${ticket.ticketType  eq 'DAPARTURE'}">
             <option value="${ticket.ageCnt}">${ticket.ageCnt}</option>
           </c:if>
         </c:forEach>
        </select>
      </div><br>
	  <div class="row passengerDep" style="height: 50px;">
	     <div class="col-sm-12" id="passengertop">가는편 탑승객<span></span></div>
	  </div>
	  <div class="row head">
	     <div class="col-sm-6">이름</div>
	     <div class="col-sm-2">구분</div>
	     <div class="col-sm-2">좌석</div>
	  </div>
   </div>
   
   <!-- 오는편 탑승객 현황 -->
   <br><br>
   <div class="container-fluid mt-3 passenger">
    <div class="row">
        <select id="returnSelect">
         <c:forEach items="${myReservation.ticketList}" var="ticket">
           <c:if test="${ticket.ticketType  eq 'RETURN'}">
             <option value="${ticket.ageCnt}">${ticket.ageCnt}</option>
           </c:if>
         </c:forEach>
        </select>
      </div><br>
	  <div class="row passengerReturn" style="height: 50px;">
	     <div class="col-sm-12" id="passengertop">오는편 탑승객<span></span></div>
	  </div>
	  <div class="row head">
	     <div class="col-sm-6">이름</div>
	     <div class="col-sm-2">구분</div>
	     <div class="col-sm-2">좌석</div>
	  </div><br>
	  
	   <!-- 다음화면 버튼 -->
       <div class="row more">
         <div class="col-sm-6"><button type="button" class="btn" id="nextBtn1">모두 취소</button></div>
         <div class="col-sm-6"><button type="button" class="btn btn-primary" id="nextBtn">저장 후 다음 화면으로</button></div>
       </div>
   </div>
</section>
  
<!-- 좌석선택 js -->
<script src="${contextPath}/resources/js/air/seat.js"></script>
<script>
$(function(){

  var choiceSeat = $('.choiceSeat');
  var clickSeat;
  var depInput;
  var nextBtn = $('#nextBtn');
  var submitForm = $('#submitForm');
  
  /*가는편,오는편 탭버튼 동작*/
  $.tabBtnFn();
  
  /*좌석 클릭 시 이벤트*/
  choiceSeat.on('click', function(){
	 var form;
	 var depSelect;
	 var tabBtn = $('.tabBtn');
	 var passengerArea;
	 //0.가는편 or 오는편 확인 
	 if(tabBtn.eq(0).attr('class') == 'col-sm-4 left-tab tabBtn tactive'){
		 passengerArea = $('.passengerDep').next();
		 depSelect = $('#departureSelect').val();
		 depInput = document.querySelectorAll('.depForm .'+depSelect);
		 form = 'depForm';
	 }
	 
	 if(tabBtn.eq(1).attr('class') == 'col-sm-8 right-tab tabBtn tactive'){
		 passengerArea = $('.passengerReturn').next();
		 depSelect = $('#returnSelect').val();
		 depInput = document.querySelectorAll('.returnForm .'+depSelect);
		 form = 'returnForm';
	 } 
	 
	 clickSeat = $(this);  //선택좌석요소
	 
	 //1.예약된 좌석 선택 시 통제
	 if(clickSeat.text() == 'X'){
		 Swal.fire({
             title: "안내",
             text: '이미 예약된 좌석입니다!',
             icon: "info"
         });
		 return false;
	 }
	 
	//2.이미 다른 탑승객이 선택한 좌석은 선택불가하도록 통제
	var ticketSeatnum = $('.'+form+' input[name="ticketSeatnum"]');
	ticketSeatnum.each(function(i, elem){
	  if(clickSeat.attr('id') == elem.value){
		  Swal.fire({
	             title: "안내",
	             text: '이미 선택된 좌석입니다. 다른좌석을 선택해주세요!',
	             icon: "info"
	      });
	      return false;	
	  }
	});
	 
	 //3.탑승객별 좌석을 하나씩만 선택하도록 통제  ex) 성인1, 성인2, 유아1 당 1개의 좌석만 선택하도록 체크
	 if(depInput[0].value != null && depInput[0].value != ''){
		 Swal.fire({
             title: "안내",
             text: '다른탑승객을 선택해 주세요!',
             icon: "info"
         });
		 return false;
	 }
	 
     //4.검색 시 선택한 좌석등급만 선택할 수 있도록 통제 
	 if(depInput[3].value == 'firstClass'){
		if(!(clickSeat.attr('class') == 'seat-first choiceSeat')){
			 Swal.fire({
	             title: "안내",
	             text: '퍼스트 클래스 좌석을 선택해주세요!',
	             icon: "info"
	         });
			 return false;
		}
	 }else if(depInput[3].value == 'business'){
		 if(!(clickSeat.attr('class') == 'seat-business choiceSeat')){
			 Swal.fire({
	             title: "안내",
	             text: '비즈니스 등급 좌석을 선택해주세요!',
	             icon: "info"
	         });
			 return false;
		  }
	 }else if(depInput[3].value == 'economy'){
		 if(!(clickSeat.attr('class') == 'seat-economy choiceSeat')){
			 Swal.fire({
	             title: "안내",
	             text: '일반 등급의 좌석을 선택해주세요!',
	             icon: "info"
	         });
			 return false;
		  }
	 }
	 
	 //5.선택좌석 색 변경
	 clickSeat.css('background-color', 'red');
	 clickSeat.css('color', 'red');
	 var seatVal = clickSeat.text();
	 
	 //6.선택좌석 추가
	 var str = '<div class="row head">';
	 str += '  <div class="col-sm-6" id="name">' + depInput[1].value.toUpperCase()+' '+depInput[2].value.toUpperCase() + '</div>';
	 str += '  <div class="col-sm-2" id="age">'+depSelect+'</div>';
	 str += '  <div class="col-sm-2" id="chair">'+seatVal+'</div>';
	 str += '  <div class="col-sm-1" id="deleteSeat"><span class="material-symbols-outlined">cancel</span></div>';
	 str += '</div>';
	 passengerArea.after(str);
	 depInput[0].value = seatVal;
  });
 
  
  /*삭제버튼 클릭 시 이벤트*/
  $(document).on('click', '#deleteSeat', function(){
	  var eventElem = $(this);
	  var val = eventElem.prev().text();  
	  var seletedSeat = $('#'+val);
	  if(seletedSeat.parent().attr('id') === 'first'){
		  seletedSeat.css('background-color', 'skyblue');  //선택한 좌석 색 변경
		  seletedSeat.css('color', 'white');
	  }else if(seletedSeat.parent().attr('id') === 'business'){
		  seletedSeat.css('background-color', '#5AD18F');  //선택한 좌석 색 변경
		  seletedSeat.css('color', 'white');
	  }else if(seletedSeat.parent().attr('id') === 'economy'){
		  seletedSeat.css('background-color', '#41A541');  //선택한 좌석 색 변경
		  seletedSeat.css('color', 'white');
	  }
	  eventElem.parent().remove();  //탑승객 현황 삭제
	  
	  //input요소의 데이터 삭제
	  var searchInput = eventElem.prev().prev().text();
	  console.log('searchInput : '+searchInput);
	  $('.'+searchInput).filter('[name="ticketSeatnum"]').val('');
  });
  
  nextBtn.on('click', function(){
	  Swal.fire({
	    title: '선택한 좌석을 저장하시겠습니까?',
	    showDenyButton: true,
	    showCancelButton: true,
	    confirmButtonText: "예",
	    denyButtonText: "아니오"
	  }).then((result) => {
	    if (result.isConfirmed) {
	      Swal.fire("성공이요!", "", "success");
	      submitForm.submit(); 
	    } else if (result.isDenied) {
	      Swal.fire("실패요", "", "info");
	      return;
	    }
	  });
	  
  });
  
});

</script>



























  
  



    
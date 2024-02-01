<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 항공 검색결과 화면 CSS -->
<link href="${contextPath}/resources/css/air/reserve.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<section class="emptySpace">

    <!-- [상단영역] -->
	<div class="container-fluid mt-3" id="container-top">
	  <div class="row">
	    <div class="col-sm-4 text-white top" style="background-color: rgb(13, 110, 253); box-shadow: 2px 2px 2px black;">
	      Step<span class="material-symbols-outlined">counter_1</span> &nbsp;여행자 및 항공편 정보
	    </div>
	    <div class="col-sm-4 text-white top" style="background-color: rgb(207, 226, 255);">
	      Step <span class="material-symbols-outlined">counter_2</span> &nbsp;좌석 선택하기
	    </div>
	    <div class="col-sm-4 text-white top" style="background-color: rgb(207, 226, 255);">
	      Step <span class="material-symbols-outlined">counter_3</span> &nbsp;결제하기
	    </div>
	  </div>
    </div>
     
    <div id="container-left">
      <!-- [예약자 정보 영역] -->
      <form action="/reserve/air/reserve/seat.do" class="was-validated" id="reserveForm" method="post"><br>
         <input type="hidden" id="airPersonnum" name="airPersonnum" value="${passenger.totalCnt}">
         <input type="hidden" id="tripType" name="tripType" value="round-trip">
         <h5>예약자 정보</h5><hr>
	     <div class="col-sm-12" id="basicInfo">
		   <label for="text">아이디<span style="color: red;">*</span></label>
		   <input type="text" class="form-control" id="memId" name="memId" value="${sessionInfo.memId}" placeholder="성명을 입력해주세요." readonly="readonly"><br>
		   <label for="text">휴대폰번호<span style="color: red;">*</span></label>
		   <input type="text" class="form-control" id="airReservetel" name="airReservetel" value="${sessionInfo.memPhone}" placeholder="휴대폰 번호를 입력해주세요."><br>
		   <label for="text">이메일<span style="color: red;">*</span></label>
		   <input type="text" class="form-control" id="airReserveemail" name="airReserveemail" value="${sessionInfo.memEmail}" placeholder="이메일을 입력해주세요.">
	     </div>
	     
	    <!-- [탑승객 정보 영역] --> 
	    <div class="accordion" id="accordionPanelsStayOpenExample"><br>
		  <h5>탑승객 정보</h5>
		  
		  <!-- 성인 탑승객 -->
		  <c:set value="${passenger.adultCnt}" var="adultCnt"/>
		  <c:if test="${adultCnt > 0}">
		    <c:forEach var="cnt" begin="0" end="${adultCnt-1}" step="1">
		      <!-- 첫번째 성인탑승객만 열린상태로 유지 -->
		      <c:choose>
		       <c:when test="${cnt + 1 == 1}"><c:set value="show" var="open"/></c:when>
		       <c:otherwise><c:remove var="open"/></c:otherwise>
		      </c:choose>
		    
			  <div class="accordion-item">
			    <h2 class="accordion-header">
			      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse-adult${cnt}" aria-expanded="false" aria-controls="#panelsStayOpen-collapse-adult${cnt}">
			        <strong>성인${cnt+1}</strong>
			        <input type="hidden" name="ticketList[${cnt}].ageCnt" value="성인${cnt+1}">
			      </button>
			    </h2>
			    <div id="panelsStayOpen-collapse-adult${cnt}" class="accordion-collapse collapse ${open}" data-bs-parent="#accordionPanelsStayOpenExample">
			       <div class="accordion-body"> 
			          <div class="alert alert-danger">
	                    <strong>탑승객 정보는 신분증 정보와 동일하게 작성해주세요.</strong><br>
	                                          탑승객 성명이 신분증 정보와 다르면 탑승이 거절될 수 있습니다.
	                  </div>
	                  <input type="hidden" name="ticketList[${cnt}].ticketPassenage" value="성인">
					  <div class="mb-3 mt-3">
					    <label for="uname" class="form-label">성(영문)<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketFirstname" placeholder="kim" name="ticketList[${cnt}].ticketFirstname" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">성을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <label for="pwd" class="form-label">이름(영문)<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketName" placeholder="min jae" name="ticketList[${cnt}].ticketName" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">이름을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <label for="pwd" class="form-label">생년월일<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketDayofbirth" name="ticketList[${cnt}].ticketDayofbirth" placeholder="YYYYMMDD" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">생년월일을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <input type="radio" id="ticketPassengenderM" class="form-check-input" name="ticketList[${cnt}].ticketPassengender"  value="M" checked> 남자
	                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="radio" id="ticketPassengenderF" class="form-check-input" name="ticketList[${cnt}].ticketPassengender" value="F"> 여자
					  </div>
					  <div class="mb-3">
					    <label for="sel1" class="form-label">국적<span style="color: red;">*</span></label>
					    <select class="form-select" id="ticketNationality" name="ticketList[${cnt}].ticketNationality" required="required">
					      <option value="KO">대한민국</option>
					      <option value="JAPAN">일본</option>
					      <option value="CHINA">중국</option>
					      <option value="RUSSIA">러시아</option>
					      <option value="USA">미국</option>
					      <option value="TAIWAN">대만</option>
					      <option value="VIETNAM">베트남</option>
					      <option value="INDONESIA">인도네시아</option>
					      <option value="INDIA">인도</option>
					      <option value="CANADA">캐나다</option>
					    </select>
					  </div>
			      </div>
			    </div>
			  </div>
		    </c:forEach>
		  </c:if>
		  
		  <!-- 유아 탑승객 -->
		  <c:set value="${passenger.yuaCnt}" var="yuaCnt"/>
		  <c:if test="${yuaCnt > 0}">
		    <c:forEach var="cnt" begin="${adultCnt}" end="${adultCnt + yuaCnt - 1}" step="1">
		      <div class="accordion-item">
			    <h2 class="accordion-header">
			      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse-yua${cnt}" aria-expanded="false" aria-controls="#panelsStayOpen-collapse-yua${cnt}">
			        <strong>유아${cnt + 1 - adultCnt}</strong>
			        <input type="hidden" name="ticketList[${cnt}].ageCnt" value="유아${cnt + 1 - adultCnt}">
			      </button>
			    </h2>
			    <div id="panelsStayOpen-collapse-yua${cnt}" class="accordion-collapse collapse" data-bs-parent="#accordionPanelsStayOpenExample">
			       <div class="accordion-body"> 
			          <div class="alert alert-danger">
	                    <strong>탑승객 정보는 신분증 정보와 동일하게 작성해주세요.</strong><br>
	                                          탑승객 성명이 신분증 정보와 다르면 탑승이 거절될 수 있습니다.
	                  </div>
	                  <input type="hidden" name="ticketList[${cnt}].ticketPassenage" value="유아">
					  <div class="mb-3 mt-3">
					    <label for="uname" class="form-label">성(영문)<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketFirstname" placeholder="kim" name="ticketList[${cnt}].ticketFirstname" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">성을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <label for="pwd" class="form-label">이름(영문)<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketName" placeholder="min jae" name="ticketList[${cnt}].ticketName" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">이름을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <label for="pwd" class="form-label">생년월일<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketDayofbirth" placeholder="YYYYMMDD" name="ticketList[${cnt}].ticketDayofbirth" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">생년월일을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <input type="radio" id="ticketPassengenderM" class="form-check-input" name="ticketList[${cnt}].ticketPassengender"  value="M" checked> 남자
	                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="radio" id="ticketPassengenderF" class="form-check-input" name="ticketList[${cnt}].ticketPassengender" value="F"> 여자
					  </div>
					  <div class="mb-3">
					    <label for="sel1" class="form-label">국적<span style="color: red;">*</span></label>
					    <select class="form-select" id="ticketNationality" name="ticketList[${cnt}].ticketNationality" required="required">
			              <option value="KO">대한민국</option>
					      <option value="JAPAN">일본</option>
					      <option value="CHINA">중국</option>
					      <option value="RUSSIA">러시아</option>
					      <option value="USA">미국</option>
					      <option value="TAIWAN">대만</option>
					      <option value="VIETNAM">베트남</option>
					      <option value="INDONESIA">인도네시아</option>
					      <option value="INDIA">인도</option>
					      <option value="CANADA">캐나다</option>
					    </select>
					  </div>
			      </div>
			    </div>
			  </div>
		    </c:forEach>
		  </c:if>
		  
		  <!-- 소아 탑승객 -->
		  <c:set value="${passenger.soaCnt}" var="soaCnt"/>
		  <c:if test="${soaCnt > 0}">
		    <c:forEach var="cnt" begin="${adultCnt + yuaCnt}" end="${adultCnt + yuaCnt + soaCnt - 1}" step="1">
		      <div class="accordion-item">
			    <h2 class="accordion-header">
			      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse-soa${cnt}" aria-expanded="false" aria-controls="#panelsStayOpen-collapse-soa${cnt}">
			        <strong>소아${cnt + 1 - (adultCnt + yuaCnt)}</strong>
			        <input type="hidden" name="ticketList[${cnt}].ageCnt" value="소아${cnt + 1 - (adultCnt + yuaCnt)}">
			      </button>
			    </h2>
			    <div id="panelsStayOpen-collapse-soa${cnt}" class="accordion-collapse collapse" data-bs-parent="#accordionPanelsStayOpenExample">
			       <div class="accordion-body"> 
			          <div class="alert alert-danger">
	                    <strong>탑승객 정보는 신분증 정보와 동일하게 작성해주세요.</strong><br>
	                                          탑승객 성명이 신분증 정보와 다르면 탑승이 거절될 수 있습니다.
	                  </div>
	                  <input type="hidden" name="ticketList[${cnt}].ticketPassenage" value="소아">
					  <div class="mb-3 mt-3">
					    <label for="uname" class="form-label">성(영문)<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketFirstname" placeholder="kim" name="ticketList[${cnt}].ticketFirstname" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">성을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <label for="pwd" class="form-label">이름(영문)<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketName" placeholder="min jae" name="ticketList[${cnt}].ticketName" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">이름을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <label for="pwd" class="form-label">생년월일<span style="color: red;">*</span></label>
					    <input type="text" class="form-control" id="ticketDayofbirth" placeholder="YYYYMMDD" name="ticketList[${cnt}].ticketDayofbirth" required>
					    <div class="valid-feedback">checked!</div>
					    <div class="invalid-feedback">생년월일을 입력해주세요.</div>
					  </div>
					  <div class="mb-3">
					    <input type="radio" id="ticketPassengenderM"  name="ticketList[${cnt}].ticketPassengender"  value="M" checked> 남자
	                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	                    <input type="radio" id="ticketPassengenderF"  name="ticketList[${cnt}].ticketPassengender" value="F"> 여자
					  </div>
					  <div class="mb-3">
					    <label for="sel1" class="form-label">국적<span style="color: red;">*</span></label>
					    <select class="form-select" id="ticketNationality" name="ticketList[${cnt}].ticketNationality" required="required">
					      <option value="KO">대한민국</option>
					      <option value="JAPAN">일본</option>
					      <option value="CHINA">중국</option>
					      <option value="RUSSIA">러시아</option>
					      <option value="USA">미국</option>
					      <option value="TAIWAN">대만</option>
					      <option value="VIETNAM">베트남</option>
					      <option value="INDONESIA">인도네시아</option>
					      <option value="INDIA">인도</option>
					      <option value="CANADA">캐나다</option>
					    </select>
					  </div>
			      </div>
			    </div>
			  </div>
		    </c:forEach>
		  </c:if>
		  <c:remove var="adultCnt"/>
		  <c:remove var="yuaCnt"/>
		  <c:remove var="soaCnt"/>
		</div>  <!-- accordion끝 -->
      </form>  <!--  form끝 -->
	</div>   <!-- container-left끝 -->
    
	 <!-- [항공편 영역] -->
     <div class="container-fluid mt-3" id="container-content"><br>
	      <!-- 가는편 -->
	      <h5>가는편 &nbsp;
	      <span style="font-size: 17px; font-weight: normal; color: gray;">
	        <fmt:parseDate value="${roundTripVO.departure.flightDeptime}" pattern="yyyyMMddHHmm" var="depTime1"/>
	        <fmt:parseDate value="${roundTripVO.departure.flightArrtime}" pattern="yyyyMMddHHmm" var="arrTime1"/>
	        <fmt:formatDate value="${depTime1}"  pattern="yyyy년 MM월 dd일 (E)"/>
	         &nbsp;|&nbsp;&nbsp; ${roundTripVO.departure.flightCode}편
	      </span></h5>
		  <div class="row basicSearch">
		     <div class="col-sm-4 content"><br>
		       <div>
		          <p>
		            <span style="font-weight: bold; font-size: 18px;">
		            | ${roundTripVO.departure.flightDepairport} ${roundTripVO.departure.flightDepportcode} →
		              ${roundTripVO.departure.flightArrairport} ${roundTripVO.departure.flightArrportcode}
		            </span><br>
		              <img id="airportName" src="${roundTripVO.departure.airlineLogo}">
		            <span id="returnDuration">${roundTripVO.departure.flightDuration} <br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 비행 예정</span>
		          </p>
		       </div>
		     </div>
		     <div class="col-sm-1 content"><br>
		        <img src="/resources/images/air/reserve/경로표시2.PNG" width="33px;" height="130px;">
		     </div>
		     <div class="col-sm-5 rightArea"><br>
		        <div> 
		         <span>
		           <strong><fmt:formatDate value="${depTime1}" pattern="a hh:mm"/></strong>
		           &nbsp;${roundTripVO.departure.depAirportFullname} 출발
		         </span>
		           <br><br><br><br>
		         <span>
		           <strong><fmt:formatDate value="${arrTime1}" pattern="a hh:mm"/></strong> 
		           &nbsp;${roundTripVO.departure.arrAirportFullname} 도착
		         </span>
		        </div>
		     </div>
		   </div>
		   
		  <!-- 오는편 -->
		  <br><h5>오는편 &nbsp;
		  <span style="font-size: 17px; font-weight: normal; color: gray;">
		    <fmt:parseDate value="${roundTripVO.arrival.flightDeptime}" pattern="yyyyMMddHHmm" var="depTime2"/>
		    <fmt:parseDate value="${roundTripVO.arrival.flightArrtime}" pattern="yyyyMMddHHmm" var="arrTime2"/>
	        <fmt:formatDate value="${depTime2}"  pattern="yyyy년 MM월 dd일 (E)"/> 
		    &nbsp;|&nbsp;&nbsp; ${roundTripVO.arrival.flightCode}편
		  </span></h5>
		  <div class="row basicSearch">
		     <div class="col-sm-4 content"><br>
		       <div>
		         <p>
		           <span style="font-weight: bold; font-size: 18px;">
		            | ${roundTripVO.arrival.flightDepairport} ${roundTripVO.arrival.flightDepportcode} →
		              ${roundTripVO.arrival.flightArrairport} ${roundTripVO.arrival.flightArrportcode}
		           </span><br>
		             <img id="airportName" src="${roundTripVO.arrival.airlineLogo}">
		           <span id="returnDuration">${roundTripVO.arrival.flightDuration} <br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 비행 예정</span>
		         </p>
		       </div>
		     </div>
		     <div class="col-sm-1 content"><br>
		        <img src="/resources/images/air/reserve/경로표시2.PNG" width="33px;" height="130px;">
		     </div>
		     <div class="col-sm-5 rightArea"><br>
		        <div> 
		         <span>
		          <strong><fmt:formatDate value="${depTime2}" pattern="a hh:mm"/></strong>  
		         &nbsp;${roundTripVO.arrival.depAirportFullname} 출발</span>
		         <br><br><br><br>
		         <span>
		          <strong><fmt:formatDate value="${arrTime2}" pattern="a hh:mm"/></strong>  
		          &nbsp;${roundTripVO.arrival.arrAirportFullname} 도착
		         </span>
		        </div>
		     </div>
		   </div>
		   
		  <!-- [수하물 영역] -->
		  <br><h5>수하물 정보</h5>
		  <div class="row baggage">
		     <div class="col-sm-12 content"><br>
		        <span class="material-symbols-outlined">luggage</span>
		        <h5>개인 용품</h5>
		        <p>- 개인 물품은 이 여행에 포함되지 않습니다.</p><br>
		        <span class="material-symbols-outlined">work</span>
		        <h5>기내 수하물</h5>
		        <p>- 1x8 kg 포함(모든 승객)</p><br>
		        <span class="material-symbols-outlined">work_history</span>
		        <h5>위탁 수하물</h5>
		        <p>- 1x15 kg 승객당</p>
		     </div>
		   </div>
	  
      <!-- 다음화면 버튼 -->
      <br><br><br>
      <div class="row more">
        <div class="col-sm-12"><button type="button" class="btn btn-primary" id="nextBtn">다음 화면으로</button></div>
      </div><br>
   </div>  
</section>

<script>
   $(function(){
	  var reserveForm = $('#reserveForm');
	  var nextBtn = $('#nextBtn');
	  var totalCnt = $('#totalCnt').val();
	  
	  /* 탑승객 정보 제출 시 */
	  nextBtn.on('click', function(){
		  //예약자 정보 입력검증
		  var airReservetel = $('#airReservetel').val();
		  var airReserveemail = $('#airReserveemail').val();
		  if(airReservetel == null || airReservetel == ''){
			  alert('예약자 번호를 입력해주세요!');
			  return false;
		  }
		  if(airReserveemail == null || airReserveemail == ''){
			  alert('예약자 이메일을 입력해주세요!');
			  return false;
		  }
		  var ticketFirstname = $('input[name="ticketList[0].ticketFirstname"]').val();
		  console.log('ticketFirstname : ', ticketFirstname);
		  
		  //탑승객 정보 입력검증
		  for(var i = 0; i < totalCnt; i++){
			  var ticketFirstname = $('input[name="ticketList['+i+'].ticketFirstname"]').val();
			  if(ticketFirstname == null || ticketFirstname == ''){
				  alert('성(영문)을 입력해주세요!');
				  return false;
			  }
			  var ticketName = $('input[name="ticketList['+i+'].ticketName"]').val();
			  if(ticketName == null || ticketName == ''){
				  alert('이름(영문)을 입력해주세요!');
				  return false;
			  }
			  var ticketDayofbirth = $('input[name="ticketList['+i+'].ticketDayofbirth"]').val();
			  if(ticketDayofbirth == null || ticketDayofbirth == ''){
				  alert('생년월일을 입력해주세요!');
				  return false;
			  }
			  var ticketPassengender = $('input[name="ticketList['+i+'].ticketPassengender"]:checked').val();
			  if(ticketPassengender == null || ticketPassengender == ''){
				  alert('성별을 선택해주세요!');
				  return false;
			  }
			  var ticketNationality = $('select[name="ticketList['+i+'].ticketNationality"]').val();
			  if(ticketNationality == null || ticketNationality == ''){
				  alert('국적을 선택해주세요!');
				  return false;
			  }
		  }
		  reserveForm.submit(); 
	  });
	   
   });

</script>
  





























  
  



    
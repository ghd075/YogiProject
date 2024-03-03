<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 항공 결제화면 CSS -->
<link href="${contextPath}/resources/css/air/payment.css" rel="stylesheet" />
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

<section class="emptySpace">
  <!-- [상단영역] -->
	<div class="container-fluid mt-3" id="container-top">
	  <div class="row">
	    <div class="col-sm-4 text-white top" style="background-color: rgb(207, 226, 255);">
	      Step<span class="material-symbols-outlined">counter_1</span> &nbsp;여행자 및 항공편 정보
	    </div>
	    <div class="col-sm-4 text-white top" style="background-color: rgb(207, 226, 255);">
	      Step <span class="material-symbols-outlined">counter_2</span> &nbsp;좌석 선택하기
	    </div>
	    <div class="col-sm-4 text-white top" style="background-color: rgb(13, 110, 253); box-shadow: 2px 2px 2px black;">
	      Step <span class="material-symbols-outlined">counter_3</span> &nbsp;결제하기
	    </div>
	  </div>
    </div>
   
      <!-- [왼쪽 상세결제정보 영역] -->
	  <div id="container-left">
	    <div class="row">
	      <div class="col-sm-12" style="width : 740px; margin-left: 15px;">
	        <span style="font-size: 23px; font-weight: bolder;">1. 상세 결제정보</span>
	      </div>
	    </div><hr>
	    
	    <!-- 가는편 영역 -->
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <p class="tableHead"><span class="material-symbols-outlined">flight_takeoff</span>가는편 Departing Flight</p>
	    <div class="row rowtable">
	      <div class="col-sm-9 table">
	        <table class="table table-hover">
			  <thead style="border-bottom: 2px solid gray;">
			     <tr>
			       <th></th>
			       <th>운항요금</th>
			       <th>유류할증료</th>
			       <th>제세공과금</th>
			       <th>발권수수료</th>
			       <th>합계</th>
			     </tr>
			  </thead>
			  <tbody>
			    <c:choose>
			      <c:when test="${empty myReservation.ticketList}">
			        <tr><td style="font-weight: bold; text-align: center;" colspan="6">조회된 상세 요금정보가 없습니다.</td></tr>
			      </c:when>
			      <c:otherwise>
			         <c:set value="${0}" var="deptotalCnt"/>
			         <c:forEach items="${myReservation.ticketList}" var="ticket">
			           <c:if test="${ticket.ticketType eq 'DAPARTURE'}">
				        <tr>
				          <td style="font-weight: bold; text-align: center;">${ticket.ageCnt}</td>
				          <td><fmt:formatNumber value="${ticket.ticketAircharge}" pattern="#,###"/>원</td>
				          <td><fmt:formatNumber value="${ticket.ticketFuelsurcharge}" pattern="#,###"/>원</td>
				          <td><fmt:formatNumber value="${ticket.ticketTax}" pattern="#,###"/>원</td>
				          <td><fmt:formatNumber value="${ticket.ticketCommission}" pattern="#,###"/>원</td>
				          <td><fmt:formatNumber value="${ticket.ticketTotalprice}" pattern="#,###"/>원</td>
				        </tr>
				        <c:set value="${deptotalCnt + ticket.ticketTotalprice}" var="deptotalCnt"/>
			           </c:if>
			         </c:forEach>
			         
			         <tr class="table-danger">
			            <td style="font-weight: bold; text-align: center;">가는편 총계</td>
			            <td></td>
			            <td></td>
			            <td></td>
			            <td></td>
			            <td style="font-weight: bolder;">
			              <fmt:formatNumber value="${deptotalCnt}" pattern="#,###"/>원
			            </td>
  			         </tr>
			      </c:otherwise>
			    </c:choose>
			  </tbody>
		    </table>
	      </div>
	    </div>
	    
	    <!-- 오는편 영역 -->
	    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	    <p class="tableHead"><span class="material-symbols-outlined">flight_land</span>오는편 Returning Flight</p>
	    <div class="row rowtable">
	      <div class="col-sm-9 table">
	        <table class="table table-hover">
			  <thead>
			     <tr>
			       <th></th>
			       <th>운항요금</th>
			       <th>유류할증료</th>
			       <th>제세공과금</th>
			       <th>발권수수료</th>
			       <th>합계</th>
			     </tr>
			  </thead>
			  <tbody>
			    <c:choose>
			      <c:when test="${empty myReservation.ticketList}">
			        <tr><td style="font-weight: bold; text-align: center;" colspan="6">조회된 상세 요금정보가 없습니다.</td></tr>
			      </c:when>
			      <c:otherwise>
			         <c:set value="${0}" var="returnTotalCnt"/>
			         <c:forEach items="${myReservation.ticketList}" var="ticket">
			           <c:if test="${ticket.ticketType eq 'RETURN'}">
				        <tr>
				          <td style="font-weight: bold; text-align: center;">${ticket.ageCnt}</td>
				          <td><fmt:formatNumber value="${ticket.ticketAircharge}" pattern="#,###"/>원</td>
				          <td><fmt:formatNumber value="${ticket.ticketFuelsurcharge}" pattern="#,###"/>원</td>
				          <td><fmt:formatNumber value="${ticket.ticketTax}" pattern="#,###"/>원</td>
				          <td><fmt:formatNumber value="${ticket.ticketCommission}" pattern="#,###"/>원</td>
				          <td><fmt:formatNumber value="${ticket.ticketTotalprice}" pattern="#,###"/>원</td>
				        </tr>
				        <c:set value="${returnTotalCnt + ticket.ticketTotalprice}" var="returnTotalCnt"/>
			           </c:if>
			         </c:forEach>
			         
			         <tr class="table-danger">
			            <td style="font-weight: bold; text-align: center;">가는편 총계</td>
			            <td></td>
			            <td></td>
			            <td></td>
			            <td></td>
			            <td style="font-weight: bolder;">
			              <fmt:formatNumber value="${returnTotalCnt}" pattern="#,###"/>원
			            </td>
  			         </tr>
			      </c:otherwise>
			    </c:choose>
			  </tbody>
		    </table>
	      </div>
	    </div>
	  </div>
	  
	  <!-- [오른쪽 결제하기 영역] -->
	  <div id="container-right">
	    <div class="row" style="background-color: rgb(239, 241, 242); height: 80px;">
	      <div class="col-sm-12" style="border-bottom: 1px solid lightgray; width: 590px; margin-left: 15px;">
	        <span style="font-size: 23px; font-weight: bolder;">2. 결제하기</span>
	      </div>
	    </div>
	    <div class="row total">
	      <div class="col-sm-12 totalPrice"><br>
	         <span class="total1" style="font-size: 19px; font-weight: bolder;">총 결제금액</span>
	         <span class="total2" style="font-weight: 600; font-size: 25px; color: rgb(230, 55, 64);">
	           <fmt:formatNumber value="${deptotalCnt + returnTotalCnt}" pattern="#,###"/>원
	         </span>
	      </div>
	    </div>
	    
	     <!-- 전송form -->
	    <form id="paymentForm" action="/reserve/air/reserve/payment.do" method="get">
	      <input type="hidden" name="totalPrice" id="totalPrice" value="${deptotalCnt + returnTotalCnt}">
	      <input type="hidden" name="finalRemain" id="finalRemain">
	      <input type="hidden" name="planerNo" id="planerNo">
	    </form>
	    
	    <div class="row paymethod">
	      <div class="col-sm-3">
	         &nbsp;&nbsp;&nbsp;&nbsp;
	         <span style="font-size: 17px; font-weight: bolder;">결제방식</span>
	      </div>
	      <div class="col-sm-4">
	         <input type="radio" name="paymethod" class="form-check-input" id="myPoint" checked="checked">&nbsp; 나의 포인트
	      </div>
          <c:if test="${not empty pointMap.groupList}">
	        <div class="col-sm-4">
	          <input type="radio" name="paymethod" class="form-check-input" id="groupPoint">&nbsp; 동행그룹 포인트
	        </div>
	      </c:if>
	    </div>
	    
	    <div class="row">
	      <div class="col-sm-3">
	         &nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 15px; font-weight: bolder;">사용할 포인트</span>
	      </div>
	      <div class="col-sm-6">
             <input type="text" id="usePoint" class="form-control" placeholder="포인트를 입력하세요." readonly="readonly">
	      </div>
	      <div class="col-sm-3">
             <button class="btn btn-success" type="button" id="useBtn">전부차감</button>
	      </div>
	    </div>
	    <br>
	    <div class="row groupSelect" style="display: none;">
	      <div class="col-sm-3">
	         &nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 15px; font-weight: bolder;">동행그룹 선택</span>
	      </div>
	      <div class="col-sm-6">
            <select class="form-select" id="groupSelectBox">
               <c:if test="${empty pointMap.groupList}">
                   <option>동행그룹이 존재하지 않습니다.</option>
               </c:if>
               <c:if test="${not empty pointMap.groupList}">
                 <c:forEach items="${pointMap.groupList}" var="group">
                   <option value="${group.plNo}">${group.plTitle}</option>
                 </c:forEach>
                 <c:forEach items="${pointMap.groupList}" var="group">
                   <input type="hidden" id="${group.plNo}" value="${group.mategroupPoint}">
                 </c:forEach>
               </c:if>
			</select> 
	      </div>
	    </div>
	    
	    <br>
	    <div class="row">
	      <div class="col-sm-8">
	         &nbsp;&nbsp;&nbsp;&nbsp;<span style="font-size: 15px; font-weight: bolder; color: rgb(230, 55, 64);">*현재 사용 가능한 포인트 : </span>
	         &nbsp;&nbsp;&nbsp;
	         <input type="hidden" value="${pointMap.privPoint}" id="privPoint">
	           <span style="font-weight: bolder;" id="remainPoint">${pointMap.privPoint}</span>P
	      </div>
	    </div>
	    
	    <div class="row bottom">
	      <div class="col-sm-12">
	        <div class="alert alert-warning"><strong style="color: green;">안심하고 예약하세요</strong><br>
	                  지금 예약하면 당일 출발을 제외한 항공권은 수수료 없이 취소할 수 있습니다. 이후,
	         <a href="#">항공사 운임 규정</a>에 따라 취소 수수료가 발생합니다.
	        </div>
	      </div>
	    </div>
	    
	    <!-- 약관영역 -->
	    <div class="row bottom2">
	      <div class="col-sm-12">
	        <input type="checkbox" class="form-check-input" id="allAgree"> &nbsp;&nbsp; 필수 약관 전체 동의
	      </div>
	    </div>
	    <div class="row bottom2">
	      <div class="col-sm-10">
	        <input type="checkbox" class="form-check-input" id="agree1"> &nbsp;&nbsp; [필수] 취소 및 환불 규칙
	      </div>
	      <div class="col-sm-2">
	        <a href="#">보기</a>
	      </div>
	    </div>
	    <div class="row bottom2">
	      <div class="col-sm-10">
	        <input type="checkbox" class="form-check-input" id="agree2"> &nbsp;&nbsp; [필수] 운임 규정
	      </div>
	      <div class="col-sm-2">
	        <a href="#">보기</a>
	      </div>
	    </div>
	    <div class="row bottom2">
	      <span style="font-size: 14px; font-weight: normal; color: gray;">
	        [여기갈래] 항공 운임규정을 확인하고 동의하실 경우 결제하기를 눌러주세요.</span>
	    </div>
	    
	    <!-- 버튼 영역 -->
	    <div class="row bottom2">
	      <div class="col-sm-5" id="paymentBtn" style="height : 50px; background: rgb(230, 55, 64); color: white;">
	         <span>결제하기</span>
	      </div>
	      <div class="col-sm-5" id="cancelBtn" style="height : 50px; background: rgb(13,110,253); color: white;">
	         <span>취소하기</span>
	      </div>
	    </div>
	  </div>
</section>

<script>
  $(function(){
	  var groupPoint = $('#groupPoint');
	  var myPoint = $('#myPoint');
	  var groupSelect = $('.groupSelect');
	  var groupSelectBox = $('#groupSelectBox');
	  var remainPoint = $('#remainPoint');
	  var privPoint = $('#privPoint').val();
	  var useBtn = $('#useBtn');
	  var totalPrice = $('#totalPrice').val();
	  var usePoint = $('#usePoint');
	  var finalRemain = $('#finalRemain');
	  var allAgree = $('#allAgree');
	  var agree1 = $('#agree1');
	  var agree2 = $('#agree2');
	  var submitFlag = false;
	  var groupFlag = false;
	  var paymentBtn = $('#paymentBtn');
	  var paymentForm = $('#paymentForm');
	  
	  /*결제포인트 > 그룹 선택 시 이벤트*/
	  groupPoint.on('click', function(){
		  groupSelect.show();
		  var groupNo = groupSelectBox.val();
		  var newVal = $('input[id="'+groupNo+'"]').val();
		  remainPoint.text('');
		  remainPoint.text(newVal);
		  groupFlag = true;
	  });
	  
	  /*결제포인트 > 개인 선택 시 이벤트*/
	  myPoint.on('click', function(){
		  groupSelect.hide();
		  remainPoint.text('');
		  remainPoint.text(privPoint);
		  groupFlag = false;
	  });
	  
	  /*select박스로 그룹종류 선택 시  이벤트*/
	  groupSelectBox.on('change', function(){
		  var groupNo = groupSelectBox.val();
		  var newVal = $('input[id="'+groupNo+'"]').val();
		  remainPoint.text('');
		  remainPoint.text(newVal);
	  });
	  
	  /*차감버튼 클릭 시 이벤트*/
	  useBtn.on('click', function(){
		  var remainVal = parseInt(remainPoint.text());
		  var totalVal = parseInt(totalPrice);
		  if(totalVal > remainVal){  //포인트가 부족할 때
			  finalRemain.val('');
			  usePoint.val('');
			  submitFlag = false;
			  Swal.fire({
                  title: "실패",
                  text: "포인트가 부족합니다!",
                  icon: "error"
              });
			  return false;
		  }
		  if(totalVal < remainVal){  //포인트가 더 많을 때
			  var finalRemainPoint = remainVal - totalVal;
			  finalRemain.val(finalRemainPoint);
			  usePoint.val(totalVal+'P');
			  submitFlag = true;
		  }
		  if(totalVal == remainVal){  //같을 때
			  finalRemain.val(0);
			  usePoint.val(totalVal+'P');
			  submitFlag = true;
		  }
	  });
	  
	  /*약관동의 클릭 시 이벤트
	   (주의)체크박스를 클릭하면 이벤트 핸들러보다 먼저 체크박스 요소의 속성이 checked로 변함*/
	  //전체동의 클릭 시 이벤트
	  allAgree.on('click', function(){
		  if(allAgree.prop('checked')){
			  agree1.prop('checked', true);
			  agree2.prop('checked', true);
		  }
		  if(!(allAgree.prop('checked'))){
			  agree1.prop('checked', false);
			  agree2.prop('checked', false);  
		  }
	  });
  
      //첫번째 약관 클릭 시 이벤트
      agree1.on('click', function(){
    	  if(!(agree1.prop('checked')) && allAgree.prop('checked')){
    		  allAgree.prop('checked', false); //전체동의 상태에서 개별약관 해제 시 전체동의도 해제
    	  }
    	  if(agree1.prop('checked') && agree2.prop('checked') && !(allAgree.prop('checked'))){
    		  allAgree.prop('checked', true); //전체동의 해제상태에서 개별약관 모두 체크 시 천제동의 체크
    	  }
      });
      //두번째 약관 클릭 시 이벤트
      agree2.on('click', function(){
    	  if(!(agree2.prop('checked')) && allAgree.prop('checked')){
    		  allAgree.prop('checked', false);
    	  }
    	  if(agree1.prop('checked') && agree2.prop('checked') && !(allAgree.prop('checked'))){
    		  allAgree.prop('checked', true);
    	  }
      });
	  
	  /*결제하기 버튼 클릭 시 이벤트*/
      paymentBtn.on('click', function(){
    	//1.포인트 사용여부 체크
    	if(!submitFlag){
   		  Swal.fire({
                 title: "안내",
                 text: "포인트 차감을 진행해주세요!",
                 icon: "info"
             });
		  return false;
    	}
    	//2.약관동의 여부 체크
    	if(!(allAgree.prop('checked') 
    			&& agree1.prop('checked') 
    			   && agree2.prop('checked'))){
	      Swal.fire({
	          title: "안내",
	          text: "모든 약관을 동의해주세요.",
	          icon: "info"
	      });
		  return false;
    	}
    	//3.그룹결제여부 확인 후 그룹이면 그룹번호 전송    	
    	if(groupFlag){
    		$('#planerNo').val(groupSelectBox.val());	
    	}
	  	  Swal.fire({   //4.제출 진행
	  	    title: '결제 하시겠습니까?',
	  	    showDenyButton: true,
	  	    showCancelButton: false,
	  	    confirmButtonText: "예",
	  	    denyButtonText: "아니오"
	  	  }).then((result) => {
	  	    if (result.isConfirmed) {
	  	       paymentForm.submit();
	  	    } else if (result.isDenied) {
	  	      return;
	  	    }
	  	  });
      });
  })
</script>





























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
	     <!--  <img src="/resources/images/air/reserve/숫자1.PNG" width="30px;" height="30px;" style="border-radius: 30px;"> -->
	      <span class="material-symbols-outlined">counter_1</span> &nbsp;여행자 및 항공편 정보
	    </div>
	    <div class="col-sm-4 text-white top" style="background-color: rgb(207, 226, 255);">
	      <span class="material-symbols-outlined">counter_2</span> &nbsp;좌석 선택하기
	    </div>
	    <div class="col-sm-4 text-white top" style="background-color: rgb(207, 226, 255);">
	      <span class="material-symbols-outlined">counter_3</span> &nbsp;결제하기
	    </div>
	  </div>
    </div>
     
       <!-- [left side 검색조건 영역] -->
       <div id="container-left">
         <form action="/action_page.php" class="was-validated">
         <br>
         <h5>예약자 정보</h5><hr>
	       <div class="col-sm-12" id="basicInfo">
		        <label for="email">성명<span style="color: red;">*</span></label>
		        <input type="text" class="form-control" id="memName" placeholder="성명을 입력해주세요." name="memName" value="${sessionInfo.memName}"><br>
		        <label for="pwd">휴대폰번호<span style="color: red;">*</span></label>
			    <input type="text" class="form-control" id="memPhone" placeholder="휴대폰 번호를 입력해주세요." name="memPhone" value="${sessionInfo.memPhone}"><br>
			    <label for="pwd">이메일<span style="color: red;">*</span></label>
			    <input type="email" class="form-control" id="memEmail" placeholder="이메일을 입력해주세요." name="memEmail" value="${sessionInfo.memEmail}">
	       </div>
	    <div class="accordion" id="accordionPanelsStayOpenExample">
		  <br>
		  <h5>탑승객 정보</h5>
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse1" aria-expanded="false" aria-controls="#panelsStayOpen-collapse1">
		        <strong>성인1</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapse1" class="accordion-collapse collapse show" data-bs-parent="#accordionPanelsStayOpenExample">
		       <div class="accordion-body"> 
		          <div class="alert alert-danger">
                    <strong>탑승객 정보는 신분증 정보와 동일하게 작성해주세요.</strong><br>
                                          탑승객 성명이 신분증 정보와 다르면 탑승이 거절될 수 있습니다.
                  </div>
				  <div class="mb-3 mt-3">
				    <label for="uname" class="form-label">성(영문)<span style="color: red;">*</span></label>
				    <input type="text" class="form-control" id="uname" placeholder="kim" name="uname" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">성을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <label for="pwd" class="form-label">이름(영문)<span style="color: red;">*</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="min jae" name="pswd" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">이름을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <label for="pwd" class="form-label">생년월일<span style="color: red;">*</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="YYYYMMDD" name="pswd" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">생년월일을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <input type="radio" id="radio1" class="form-check-input" name="gender"  value="M" checked> 남자
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="radio2" class="form-check-input" name="gender" value="F"> 여자
				  </div>
				  <div class="mb-3">
				    <label for="sel1" class="form-label">국적<span style="color: red;">*</span></label>
				    <select class="form-select" id="sel1" name="sellist1" required="required">
				      <option>대한민국</option>
				      <option>일본</option>
				      <option>중국</option>
				      <option>러시아</option>
				      <option>미국</option>
				      <option>대만</option>
				      <option>베트남</option>
				      <option>인도네시아</option>
				      <option>인도</option>
				      <option>캐나다</option>
				    </select>
				  </div>
		      </div>
		    </div>
		    
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse2" aria-expanded="true" aria-controls="#panelsStayOpen-collapse2">
		        <strong>소아1</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapse2" class="accordion-collapse collapse" data-bs-parent="#accordionPanelsStayOpenExample">
		      <div class="accordion-body">
		     	  <div class="alert alert-danger">
                    <strong>탑승객 정보는 신분증 정보와 동일하게 작성해주세요.</strong><br>
                                          탑승객 성명이 신분증 정보와 다르면 탑승이 거절될 수 있습니다.
                  </div>
				  <div class="mb-3 mt-3">
				    <label for="uname" class="form-label">성(영문)<span style="color: red;">*</span></label>
				    <input type="text" class="form-control" id="uname" placeholder="kim" name="uname" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">성을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <label for="pwd" class="form-label">이름(영문)<span style="color: red;">*</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="min jae" name="pswd" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">이름을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <label for="pwd" class="form-label">생년월일<span style="color: red;">*</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="YYYYMMDD" name="pswd" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">생년월일을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <input type="radio" id="radio1" class="form-check-input" name="gender"  value="M" checked> 남자
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="radio2" class="form-check-input" name="gender" value="F"> 여자
				  </div>
				  <div class="mb-3">
				    <label for="sel1" class="form-label">국적<span style="color: red;">*</span></label>
				    <select class="form-select" id="sel1" name="sellist1" required="required">
				      <option>대한민국</option>
				      <option>일본</option>
				      <option>중국</option>
				      <option>러시아</option>
				      <option>미국</option>
				      <option>대만</option>
				      <option>베트남</option>
				      <option>인도네시아</option>
				      <option>인도</option>
				      <option>캐나다</option>
				    </select>
				  </div>
		      </div>
		    </div>
		  </div>
		    
		  <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse3" aria-expanded="false" aria-controls="#panelsStayOpen-collapse3">
		        <strong>유아1</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapse3" class="accordion-collapse collapse" data-bs-parent="#accordionPanelsStayOpenExample">
		      <div class="accordion-body">
		      	<div class="alert alert-danger">
                    <strong>탑승객 정보는 신분증 정보와 동일하게 작성해주세요.</strong><br>
                                          탑승객 성명이 신분증 정보와 다르면 탑승이 거절될 수 있습니다.
                  </div>
				  <div class="mb-3 mt-3">
				    <label for="uname" class="form-label">성(영문)<span style="color: red;">*</span></label>
				    <input type="text" class="form-control" id="uname" placeholder="kim" name="uname" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">성을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <label for="pwd" class="form-label">이름(영문)<span style="color: red;">*</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="min jae" name="pswd" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">이름을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <label for="pwd" class="form-label">생년월일<span style="color: red;">*</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="YYYYMMDD" name="pswd" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">생년월일을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <input type="radio" id="radio1" class="form-check-input" name="gender"  value="M" checked> 남자
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="radio2" class="form-check-input" name="gender" value="F"> 여자
				  </div>
				  <div class="mb-3">
				    <label for="sel1" class="form-label">국적<span style="color: red;">*</span></label>
				    <select class="form-select" id="sel1" name="sellist1" required="required">
				      <option>대한민국</option>
				      <option>일본</option>
				      <option>중국</option>
				      <option>러시아</option>
				      <option>미국</option>
				      <option>대만</option>
				      <option>베트남</option>
				      <option>인도네시아</option>
				      <option>인도</option>
				      <option>캐나다</option>
				    </select>
				  </div>
		      </div>
		    </div>
		  </div> 
		  
		    <div class="accordion-item">
		    <h2 class="accordion-header">
		      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapse4" aria-expanded="false" aria-controls="#panelsStayOpen-collapse3">
		        <strong>유아2</strong>
		      </button>
		    </h2>
		    <div id="panelsStayOpen-collapse4" class="accordion-collapse collapse" data-bs-parent="#accordionPanelsStayOpenExample">
		      <div class="accordion-body">
		      	<div class="alert alert-danger">
                    <strong>탑승객 정보는 신분증 정보와 동일하게 작성해주세요.</strong><br>
                                          탑승객 성명이 신분증 정보와 다르면 탑승이 거절될 수 있습니다.
                </div>
				  <div class="mb-3 mt-3">
				    <label for="uname" class="form-label">성(영문)<span style="color: red;">*</span></label>
				    <input type="text" class="form-control" id="uname" placeholder="kim" name="uname" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">성을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <label for="pwd" class="form-label">이름(영문)<span style="color: red;">*</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="min jae" name="pswd" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">이름을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <label for="pwd" class="form-label">생년월일<span style="color: red;">*</span></label>
				    <input type="password" class="form-control" id="pwd" placeholder="YYYYMMDD" name="pswd" required>
				    <div class="valid-feedback">checked!</div>
				    <div class="invalid-feedback">생년월일을 입력해주세요.</div>
				  </div>
				  <div class="mb-3">
				    <input type="radio" id="radio1" class="form-check-input" name="gender"  value="M" checked> 남자
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" id="radio2" class="form-check-input" name="gender" value="F"> 여자
				  </div>
				  <div class="mb-3">
				    <label for="sel1" class="form-label">국적<span style="color: red;">*</span></label>
				    <select class="form-select" id="sel1" name="sellist1" required="required">
				      <option>대한민국</option>
				      <option>일본</option>
				      <option>중국</option>
				      <option>러시아</option>
				      <option>미국</option>
				      <option>대만</option>
				      <option>베트남</option>
				      <option>인도네시아</option>
				      <option>인도</option>
				      <option>캐나다</option>
				    </select>
				  </div>
		      </div>
		    </div>
		  </div> 
		   
		</div>
		  
		  
		</div>
     </form>
	</div>
    
	 <!-- [중앙 컨텐츠 영역] -->
	 <!-- 중앙 컨텐츠 최상단 -->
     <div class="container-fluid mt-3" id="container-content">
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
	      <br><h5>가는편 &nbsp;<span style="font-size: 17px; font-weight: normal; color: gray;">2024년 01월 24일 (수) &nbsp;|&nbsp;&nbsp; ADSDDF-121313편</span></h5>
		  <div class="row basicSearch">
		     <div class="col-sm-4 content"><br>
		       <div>
		          <p>
		            <span style="font-weight: bold; font-size: 18px;">| 김포 GMP → 제주 GMP </span><br><br>
		              <img id="airportName" src="/resources/images/air/list/대한항공.PNG">
		            <span id="returnDuration">4시간 30분 <br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 비행 </span>
		          </p>
		       </div>
		     </div>
		     <div class="col-sm-1 content"><br>
		        <img src="/resources/images/air/reserve/경로표시2.PNG" width="33px;" height="130px;">
		     </div>
		     <div class="col-sm-4 rightArea"><br>
		        <div> 
		         <span>오후 6:30 &nbsp;부산국제공항 출발</span>
		         <br><br><br><br>
		         <span>오후 6:30 &nbsp;제주국제공항 도착</span>
		        </div>
		     </div>
		   </div>
		   
		  <br><h5>오는편 &nbsp;<span style="font-size: 17px; font-weight: normal; color: gray;">2024년 01월 24일 (수) &nbsp;|&nbsp;&nbsp; ADSDDF-121313편</span></h5>
		  <div class="row basicSearch">
		     <div class="col-sm-4 content"><br>
		       <div>
		         <p>
		           <span style="font-weight: bold; font-size: 18px;">| 김포 GMP ← 제주 GMP</span><br><br>
		             <img id="airportName" src="/resources/images/air/list/제주항공.PNG">
		           <span id="returnDuration">4시간 30분 <br>&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 비행</span>
		         </p>
		       </div>
		     </div>
		     <div class="col-sm-1 content"><br>
		        <img src="/resources/images/air/reserve/경로표시2.PNG" width="33px;" height="130px;">
		     </div>
		     <div class="col-sm-4 rightArea"><br>
		        <div> 
		         <span>오후 6:30  &nbsp;부산국제공항 출발</span>
		         <br><br><br><br>
		         <span>오후 6:30  &nbsp;제주국제공항 도착</span>
		        </div>
		     </div>
		   </div>
		   
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
		
	     </c:otherwise>
	   </c:choose> 
	  
      <!-- 더보기 버튼 -->
      <br><br><br>
      <div class="row more">
        <div class="col-sm-12"><button type="button" class="btn btn-primary" id="nextBtn">다음 화면으로</button></div>
      </div><br>
   </div>  


</section>

  
<script></script>





























  
  



    
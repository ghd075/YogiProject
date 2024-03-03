<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <!-- 숙소 검색화면 css -->
 <link href="${contextPath }/resources/css/stay/searchForm.css" rel="stylesheet" />
 <!-- 구글폰트 -->
 <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
        
 <!-- 숙소 메인 화면 영역 -->
 <section class="airplaneSlideContainer emptySpace">
   <div class="airplaneReserveContents cen">
     <div class="airplaneSlideTxt">
            <h2>
                YoGi Stay<br />
                숙박 예약
            </h2>
            <p>
               국내 숙박 예약,<br />
               쉽고 빠르게!<br />
            </p>
      </div>
      <div class="airplaneReserveCont">
        <div class="airTabbtnGroup">
            <div class="tabbtn tactive">
                                 국내숙소
            </div>
        </div>
        <div class="airTabcontBox">

            <div class="tabcont">
               <form action="/reserve/air/search/list.do" method="post" id="roundTripForm" name="roundTripForm" class="tripFindForm">
                 <div>
                    <i class="fas fa-map-marker-alt" style="margin-right: 300px; float: left;"></i>
                    <input id="flightDepairport" name="flightDepairport" type="text" class="form-control startP" placeholder="여행지나 숙소를 검색해보세요." />
                    <div class="switchingDiv">
                    </div>
                     <i class="fas fa-map-marker-alt" style="display: none;"></i>
                 </div>

                 <div>
                    <!-- 날짜선택 -->
                    <div>
                        <input id="flightDeptime" name="flightDeptime" type="datetime-local" class="form-control" />
                        <input id="flightArrtime" name="flightArrtime" type="datetime-local" class="form-control" />
                    </div>
                        
                    <div>&nbsp;</div>
                        
                    <!-- 인원 선택 -->
                    <div>
                        <div class="autoSetFn">
                            <input type="text" class="form-control autoSetTxt" placeholder="인원수 선택" readonly/>
                            <div class="autoSetOpt">
                                <div>
                                    <h3>인원</h3>
                                    <div>
                                        <h4>인원</h4> 
                                        <div>
                                            <span class="cntMinus">-</span>
                                            <span class="countNm">0</span>
                                            <span class="cntPlus">+</span>
                                        </div>
                                        <span style="font-size: 13px; color: gray;"> *유아 및 아동도 인원수에 포함해 주세요.</span>
                                    </div>
                                </div>
                                <div>
                                    <button type="button" class="btn btn-primary choiceCompleteBtn" style="margin-right: 195px;">취소</button>
                                    <button type="button" class="btn btn-primary choiceCompleteBtn">선택완료</button>
                                </div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary" id="searchBtn1">숙소 검색</button>
                    </div>
                </div>
            </form>
           </div>

        </div>
        </div>
    </div>
    
    <!-- 슬라이딩 이미지 -->
    <article class="airMainSlider">
        <div class="airSlide">
            <img src="${contextPath }/resources/images/stay/searchForm/숙박메인3.PNG"/>
        </div>
        <div class="airSlide">
            <img src="${contextPath }/resources/images/stay/searchForm/숙박메인4.PNG"/>
        </div>
    </article>
</section>

<!-- 하단 추천 숙소1-->
<section class="airplaneInfoContainer cen"><br>
    <h3>
       <span class="material-symbols-outlined">cottage</span> 
             인기 추천 숙소
    </h3><br>
    <article class="airInfoContents">
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/stay/searchForm/세인트존스.PNG"/>
            </div>
            <div>블랙/특급/호텔</div>
            <div>
                             세인트존스 호텔
            </div>
            <div>강릉시 강릉 강문해변 앞</div>
            <div>45,100원</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/stay/searchForm/스카이베이호텔.PNG"/>
            </div>
            <div>블랙/특급/호텔</div>
            <div>
                              스카이베이호텔 경포
            </div>
            <div>강릉시 강릉 강문해변 앞 차량 2분</div>
            <div>124,000원</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/stay/searchForm/가평어거스트.PNG"/>
            </div>
            <div>펜션</div>
            <div>
                             가평 어거스트청평           
            </div>
            <div>가평군 청평호 차량11분</div>
            <div>61,300원</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/stay/searchForm/제주와흘.PNG"/>
            </div>
            <div>펜션</div>
            <div>
                           제주 와흘 팽나무집          
            </div>
            <div>제주시 함덕해수욕장 차량 16분</div>
            <div>다른 날짜 확인</div>
        </div>
    </article>
</section>

<!-- 하단 추천 숙소2 -->
<section class="airplaneInfoContainer cen">
  
    <article class="airInfoContents">
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/stay/searchForm/길동.PNG"/>
            </div>
            <div>모텔</div>
            <div>
                            길동 MARI-마리
            </div>
            <div>길동역 도보 3분</div>
            <div>35,000원</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/stay/searchForm/의정부.PNG"/>
            </div>
            <div>모텔</div>
            <div>
                               의정부 STAY79
            </div>
            <div>동작구 구로디지털단지역 도보 7분</div>
            <div>35,100</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/stay/searchForm/신라스테이구로.PNG"/>
            </div>
            <div>3성급/호텔</div>
            <div>
               [반짝특가]신라스테이 구로
            </div>
            <div>동작구 구로디지털단지역 도보 7분</div>
            <div>76,000원</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/stay/searchForm/호텔리베라.PNG"/>
            </div>
            <div>4성급/호텔</div>
            <div>
                                     ★당일특가★ 호텔 리베라
            </div>
            <div>강남구 청담역 도보 5분</div>
            <div>104,000원</div>
        </div>
    </article>
</section>
      <!-- 항공 예약 js -->
      <script src="${contextPath }/resources/js/air/airplane.js"></script>
      <!-- slick slide -->
      <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
      <script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
      <!-- flatpickr css -->
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
      <!-- flatpickr JS -->
      <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
      <script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>
      <script>
          $(function(){
              /*기본기능함수*/
              $.airplaneSlickFn();     //슬라이드 작동
              $.airplainTabbtnFn();    //왕복/편도 탭 기능
              $.airplainTabcontHeightFn(); //왕복/편도 탭 콘텐츠 영역 높이 설정 기능
              
              $.startEndSwitchingFn();  // 출발지&도착지 텍스트 스위칭 함수

              /*1.클릭 시 모달 열기,닫기 기능
                2. +,- 버튼 클릭 시 이벤트
                3. 적용버튼 클릭 시 이벤트*/
              $.counterLayerPopupFn();  
              
              // 데이트픽커 함수
              var flightDeptime = $("#flightDeptime");
              var flightArrtime = $("#flightArrtime");
              var flightDeptime2 = $("#flightDeptime2");
              $.dateFickerFn(flightDeptime);
              $.dateFickerFn(flightArrtime);
              $.dateFickerFn(flightDeptime2);
              
              // 종횡비 함수
              $.eachAirImgResizeFn();
              $.eachAirInfoImgResizeFn();

              /*업무영역*/
              var roundTripForm = $('#roundTripForm');
              var searchBtn1 = $('#searchBtn1');

              //왕복 선택 후 검색
              searchBtn1.on('click', function(){
                var flightDepairport = $('#flightDepairport').val();
                var depTime = flightDeptime.val();
                var arrTime = flightArrtime.val();
                
                //입력값 검사 - 모든 입력값 필수
                if(flightDepairport == '' || flightDepairport == null){
                   alert('여행지나 숙소를 입력해주세요!');
                   return false;
                }
                if(depTime == '' || depTime == null){
                   alert('출발날짜를 입력해주세요!');
                   return false;
                }
                if(arrTime == '' || arrTime == null){
                   alert('돌아오는 날짜를 입력해주세요!');
                   return false;
                }
                location.href = '/reserve/stays/search/stayList.do';
              })
          });
      </script>




















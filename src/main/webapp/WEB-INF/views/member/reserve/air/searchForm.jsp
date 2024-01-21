<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <!-- 항공 검색화면 css -->
 <link href="${contextPath }/resources/css/air/airplane.css" rel="stylesheet" />
        
 <!-- 항공 메인 화면 영역 -->
 <section class="airplaneSlideContainer emptySpace">
   <div class="airplaneReserveContents cen">
     <div class="airplaneSlideTxt">
            <h2>
                YoGi Air<br />
                 항공 예약
            </h2>
            <p>
               국내 항공편 예약?<br />
               가장 쉽게! 가장 빠르게!<br />
            </p>
      </div>
      <div class="airplaneReserveCont">
        <!-- 왕복/편도 선택 -->
        <div class="airTabbtnGroup">
            <div class="tabbtn tactive">
                <i class="fas fa-ticket-alt"></i>
                왕복
            </div>
            <div class="tabbtn">
                <i class="fas fa-ticket-alt"></i>
                편도
            </div>
        </div>
        <div class="airTabcontBox">

            <!-- [왕복영역] -->
            <div class="tabcont">
               <form action="/reserve/air/search/list.do" method="post" id="roundTripForm" name="roundTripForm" class="tripFindForm">
                 <!-- 출발지/도착지 선택 -->
                 <div>
                    <i class="fas fa-map-marker-alt"></i>
                    <input id="flightDepairport" name="flightDepairport" type="text" class="form-control startP" placeholder="출발지" />
                    <div class="switchingDiv">
                        <i class="fas fa-exchange-alt"></i>
                    </div>
                    <i class="fas fa-map-marker-alt"></i>
                    <input id="flightArrairport" name="flightArrairport" type="text" class="form-control endP" placeholder="도착지" />
                 </div>

                 <div>
                    <!-- 날짜선택 -->
                    <div>
                        <input id="flightDeptime" name="flightDeptime" type="datetime-local" class="form-control" />
                        <input id="flightArrtime" name="flightArrtime" type="datetime-local" class="form-control" />
                    </div>
                        
                    <div>&nbsp;</div>
                        
                    <!-- 인원/좌석등급 선택 -->
                    <div>
                        <div class="autoSetFn">
                            <input type="text" class="form-control autoSetTxt" placeholder="인원/좌석등급 선택" readonly/>
                            <div class="autoSetOpt">
                                <div>
                                    <h3>인원</h3>
                                    <div>
                                        <h4>성인</h4> 
                                        <div>
                                            <span class="cntMinus">-</span>
                                            <span class="countNm">0</span>
                                            <span class="cntPlus">+</span>
                                        </div>
                                        <span style="font-size: 13px; color: gray;"> *만16세 이상</span>
                                    </div>
                                    <div>
                                        <h4>소아</h4>
                                        <div>
                                            <span class="cntMinus">-</span>
                                            <span class="countNm">0</span>
                                            <span class="cntPlus">+</span>
                                        </div>
                                        <span style="font-size: 13px; color: gray;"> *만 2세 이상 ~ 만 16세 미만</span>
                                    </div>
                                    <div>
                                        <h4>유아</h4>
                                        <div>
                                            <span class="cntMinus">-</span>
                                            <span class="countNm">0</span>
                                            <span class="cntPlus">+</span>
                                        </div>
                                        <span style="font-size: 13px; color: gray;"> *만 2세 미만</span>
                                    </div>
                                </div>
                                <div class="roundTripSeat">
                                    <h3>좌석 등급</h3>
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio" id="normalSeat" name="seatClass" value="economy" checked />
                                                                                                일반석
                                    </label>
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio" id="businessSeat" name="seatClass" value="business" />
                                                                                                비즈니스석
                                    </label>
                                    <label class="form-check-label">
                                        <input class="form-check-input" type="radio" id="firstClassSeat" name="seatClass" value="firstClass" />
                                                                                                일등석
                                    </label>
                                </div><br>
                                    <p style="font-size: 13px; color: gray;"> 여행 시 탑승객의 나이는 예약 시 나이 카테고리(성인 또는 유/소아)와 일치해야 합니다. 항공사에는 만18세 미만 승객의 단독 탑승에 대한 규정이 있습니다.</p>
                                    <p style="font-size: 13px; color: gray;"> 유/소아 동반 여행 시 나이 제한과 정책은 항공사별로 다를 수 있으니 예약하기 전에
                                                                                                    해당 항공사와 확인하시기 바랍니다.</p> 
                                <div>
                                    <button type="button" class="btn btn-primary choiceCompleteBtn" style="margin-right: 195px;">취소</button>
                                    <button type="button" class="btn btn-primary choiceCompleteBtn">선택완료</button>
                                </div>
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary" id="searchBtn1">항공권 검색</button>
                    </div>
                </div>
            </form>
           </div>

            <!-- [편도영역] -->
            <div class="tabcont">
                <form action="bbb.do" method="post" id="oneWayForm" name="oneWayForm">
                    <div>
                        <i class="fas fa-map-marker-alt"></i>
                        <input id="flightDepairport2" name="flightDepairport" type="text" class="form-control startP" placeholder="출발지" />
                        <div class="switchingDiv">
                            <i class="fas fa-exchange-alt"></i>
                        </div>
                        <i class="fas fa-map-marker-alt"></i>
                        <input id="flightArrairport2" name="flightArrairport" type="text" class="form-control endP" placeholder="도착지" />
                    </div>
                    <div>
                        <div>
                            <input id="flightDeptime2" name="flightDeptime" type="date" class="form-control" />
                        </div>
                        <div>&nbsp;</div>
                        <div>
                            <div class="autoSetFn">
                                <input type="text" class="form-control autoSetTxt" placeholder="인원/좌석등급 선택" readonly />
                                 <div class="autoSetOpt">
                                    <div>
                                        <div>
                                            <h4>성인</h4>
                                            <div>
                                                <span class="cntMinus">-</span>
                                                <span class="countNm">0</span>
                                                <span class="cntPlus">+</span>
                                            </div>
                                            <span style="font-size: 13px; color: gray;"> *만16세 이상</span>
                                        </div>
                                        <div>
                                            <h4>소아</h4>
                                            <div>
                                                <span class="cntMinus">-</span>
                                                <span class="countNm">0</span>
                                                <span class="cntPlus">+</span>
                                            </div>
                                            <span style="font-size: 13px; color: gray;"> *만 2세 이상 ~ 만 16세 미만</span>
                                        </div>
                                        <div>
                                            <h4>유아</h4>
                                            <div>
                                                <span class="cntMinus">-</span>
                                                <span class="countNm">0</span>
                                                <span class="cntPlus">+</span>
                                            </div>
                                            <span style="font-size: 13px; color: gray;"> *만 2세 미만</span>
                                        </div>
                                    </div>
                                    <div class="oneWaySeat">
                                        <h3>좌석 등급</h3>
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" id="normalSeat2" name="seatClass" value="normalSeat" checked />
                                                                                                  일반석
                                        </label>
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" id="businessSeat2" name="seatClass" value="businessSeat" />
                                                                                                비즈니스석
                                        </label>
                                        <label class="form-check-label">
                                            <input class="form-check-input" type="radio" id="firstClassSeat2" name="seatClass" value="firstClassSeat" />
                                                                                                 일등석
                                        </label>
                                    </div><br>
                                       <p style="font-size: 13px; color: gray;"> 여행 시 탑승객의 나이는 예약 시 나이 카테고리(성인 또는 유/소아)와 일치해야 합니다. 항공사에는 만18세 미만 승객의 단독 탑승에 대한 규정이 있습니다.</p>
                                       <p style="font-size: 13px; color: gray;"> 유/소아 동반 여행 시 나이 제한과 정책은 항공사별로 다를 수 있으니 예약하기 전에
                                                                                                      해당 항공사와 확인하시기 바랍니다.</p> 
                                    <div>
                                        <button type="button" class="btn btn-primary choiceCompleteBtn">선택완료</button>
                                    </div>
                                </div> 
                            </div>
                            <button type="button" class="btn btn-primary" id="searchBtn2">항공권 검색</button>
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
            <img src="${contextPath }/resources/images/air/search/airplane_bg1.png" alt="항공 예약 슬라이드 이미지" />
        </div>
        <div class="airSlide">
            <img src="${contextPath }/resources/images/air/search/airplane_bg2.png" alt="항공 예약 슬라이드 이미지" />
        </div>
        <div class="airSlide">
            <img src="${contextPath }/resources/images/air/search/airplane_bg3.png" alt="항공 예약 슬라이드 이미지" />
        </div>
        <div class="airSlide">
            <img src="${contextPath }/resources/images/air/search/airplane_bg4.png" alt="항공 예약 슬라이드 이미지" />
        </div>
    </article>
</section>

<!-- 하단 추천 여행지1 -->
<section class="airplaneInfoContainer cen"><br>
    <h3>
       HOT PICK 국내 항공 특가
        <i class="fas fa-plane"></i>
    </h3><br>
    <article class="airInfoContents">
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg01.jpg" alt="항공 예약 썸네일 이미지" />
            </div>
            <div>국내 MD 추천</div>
            <div>
                                김포
                <i class="fas fa-arrow-right"></i>
                                제주
            </div>
            <div>2월 6일 출발</div>
            <div>20,900원~</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg02.jpg" alt="항공 예약 썸네일 이미지" />
            </div>
            <div>국내 MD 추천</div>
            <div>
                               김포
                <i class="fas fa-arrow-right"></i>
                               부산
            </div>
            <div>2월 6일 출발</div>
            <div>39,100원~</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg03.jpg" alt="항공 예약 썸네일 이미지" />
            </div>
            <div>국내 MD 추천</div>
            <div>
                            김포
                <i class="fas fa-arrow-right"></i>
                           여수
            </div>
            <div>2월 5일 출발</div>
            <div>62,900원~</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg04.jpg" alt="항공 예약 썸네일 이미지" />
            </div>
            <div>국내 MD 추천</div>
            <div>
                            김포
                <i class="fas fa-arrow-right"></i>
                            제주
            </div>
            <div>2월 5일 출발</div>
            <div>35,800원~</div>
        </div>
    </article>
</section>

<!-- 하단 추천 여행지2 -->
<section class="airplaneInfoContainer cen">
  
    <article class="airInfoContents">
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg01.jpg" alt="항공 예약 썸네일 이미지" />
            </div>
            <div>국내 MD 추천</div>
            <div>
                             김포
                <i class="fas fa-arrow-right"></i>
                             제주
            </div>
            <div>2월 6일 출발</div>
            <div>20,900원~</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg02.jpg" alt="항공 예약 썸네일 이미지" />
            </div>
            <div>국내 MD 추천</div>
            <div>
                               김포
                <i class="fas fa-arrow-right"></i>
                               부산
            </div>
            <div>2월 6일 출발</div>
            <div>39,100원~</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg03.jpg" alt="항공 예약 썸네일 이미지" />
            </div>
            <div>국내 MD 추천</div>
            <div>
                             김포
                <i class="fas fa-arrow-right"></i>
                              여수
            </div>
            <div>2월 5일 출발</div>
            <div>62,900원~</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg04.jpg" alt="항공 예약 썸네일 이미지" />
            </div>
            <div>국내 MD 추천</div>
            <div>
                                김포
                <i class="fas fa-arrow-right"></i>
                                제주
            </div>
            <div>2월 5일 출발</div>
            <div>35,800원~</div>
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
              var oneWayForm = $('#oneWayForm');
              var searchBtn1 = $('#searchBtn1');

              //왕복 선택 후 검색
              searchBtn1.on('click', function(){
                var flightDepairport = $('#flightDepairport').val();
                var flightArrairport = $('#flightArrairport').val();
                var adultCnt = $('#adultCnt').val();
                var soaCnt = $('#soaCnt').val();
                var yuaCnt = $('#yuaCnt').val();
                var normalSeat = $('#normalSeat').val();
                var businessSeat = $('#businessSeat').val();
                var firstClassSeat = $('#firstClassSeat').val();
                var depTime = flightDeptime.val();
                var arrTime = flightArrtime.val();
                
               console.log('adultCnt : ', adultCnt);
               console.log('soaCnt : ', soaCnt);
               console.log('yuaCnt : ', yuaCnt);
                
                //입력값 검사 - 모든 입력값 필수
                if(flightDepairport == '' || flightDepairport == null){
                   alert('출발지를 입력해주세요!');
                   return false;
                }
                if(flightArrairport == '' || flightArrairport == null){
                   alert('도착지를 입력해주세요!');
                   return false;
                }
                if(adultCnt == null || soaCnt == null || yuaCnt == null){
                   alert('인원을 설정해주세요!');
                   return false;
                }
                if(adultCnt == '0' && soaCnt == '0' && yuaCnt == '0'){
                   alert('1명 이상 인원을 설정해주세요!');
                   return false;
                }
                if(normalSeat == '' || normalSeat == null && 
                		businessSeat == '' || businessSeat == null && 
                		firstClassSeat == '' || firstClassSeat == null){
                   alert('좌석등급을 입력해주세요!');
                   return false;
                }
                if(depTime == '' || depTime == null){
                   alert('출발날짜를 입력해주세요!');
                   return false;
                }
                if(arrTime == '' || arrTime == null){
                   alert('귀국날짜를 입력해주세요!');
                   return false;
                }

                roundTripForm.submit();
              })


             /*편도 선택 후 검색*/
          });
      </script>




















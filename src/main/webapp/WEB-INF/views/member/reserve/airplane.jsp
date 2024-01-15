<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 항공 예약 css -->    
<link href="${contextPath }/resources/css/airplane.css" rel="stylesheet" />    
    
<!-- 구현할 페이지를 여기에 작성 -->
<section class="airplaneSlideContainer emptySpace">
    <div class="airplaneReserveContents cen">
        <div class="airplaneSlideTxt">
            <h2>
                YoGi gAlE<br />
                항공 예약
            </h2>
            <p>
                국내 항공편 예약?<br />
                가장 쉽게! 가장 빠르게!<br />
            </p>
        </div>
        <div class="airplaneReserveCont">
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
                <div class="tabcont">
                    <form action="aaa.do" method="post" id="roundTripForm" name="roundTripForm" class="tripFindForm">
                        <div>
                            <i class="fas fa-map-marker-alt"></i>
                            <input id="startPoint" name="startPoint" type="text" class="form-control startP" placeholder="출발지" />
                            <div class="switchingDiv">
                                <i class="fas fa-exchange-alt"></i>
                            </div>
                            <i class="fas fa-map-marker-alt"></i>
                            <input id="endPoint" name="endPoint" type="text" class="form-control endP" placeholder="도착지" />
                        </div>
                        <div>
                            <div>
                                <input id="startDate" name="startDate" type="date" class="form-control" />
                                <input id="endDate" name="endDate" type="date" class="form-control" />
                            </div>
                            <div>&nbsp;</div>
                            <div>
                                <div class="autoSetFn">
                                    <input type="text" class="form-control autoSetTxt" readonly />
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
                                            </div>
                                            <div>
                                                <h4>소아</h4>
                                                <div>
                                                    <span class="cntMinus">-</span>
                                                    <span class="countNm">0</span>
                                                    <span class="cntPlus">+</span>
                                                </div>
                                            </div>
                                            <div>
                                                <h4>유아</h4>
                                                <div>
                                                    <span class="cntMinus">-</span>
                                                    <span class="countNm">0</span>
                                                    <span class="cntPlus">+</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <h3>좌석 등급</h3>
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" id="normalSeat" name="chkSeat" value="normalSeat" checked />
                                                일반석
                                            </label>
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" id="premiumSeat" name="chkSeat" value="premiumSeat" />
                                                프리미엄 일반석
                                            </label>
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" id="businessSeat" name="chkSeat" value="businessSeat" />
                                                비즈니스석
                                            </label>
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" id="firstClassSeat" name="chkSeat" value="firstClassSeat" />
                                                일등석
                                            </label>
                                        </div>
                                        <div>
                                            <button type="button" class="btn btn-primary choiceCompleteBtn">선택완료</button>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary">항공권 검색</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="tabcont">
                    <form action="bbb.do" method="post" id="oneWayForm" name="oneWayForm">
                        <div>
                            <i class="fas fa-map-marker-alt"></i>
                            <input id="startPoint2" name="startPoint" type="text" class="form-control startP" placeholder="출발지" />
                            <div class="switchingDiv">
                                <i class="fas fa-exchange-alt"></i>
                            </div>
                            <i class="fas fa-map-marker-alt"></i>
                            <input id="endPoint2" name="endPoint" type="text" class="form-control endP" placeholder="도착지" />
                        </div>
                        <div>
                            <div>
                                <input id="startDate2" name="startDate" type="date" class="form-control" />
                            </div>
                            <div>&nbsp;</div>
                            <div>
                                <div class="autoSetFn">
                                    <input type="text" class="form-control autoSetTxt" readonly />
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
                                            </div>
                                            <div>
                                                <h4>소아</h4>
                                                <div>
                                                    <span class="cntMinus">-</span>
                                                    <span class="countNm">0</span>
                                                    <span class="cntPlus">+</span>
                                                </div>
                                            </div>
                                            <div>
                                                <h4>유아</h4>
                                                <div>
                                                    <span class="cntMinus">-</span>
                                                    <span class="countNm">0</span>
                                                    <span class="cntPlus">+</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <h3>좌석 등급</h3>
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" id="normalSeat2" name="chkSeat" value="normalSeat" checked />
                                                일반석
                                            </label>
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" id="premiumSeat2" name="chkSeat" value="premiumSeat" />
                                                프리미엄 일반석
                                            </label>
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" id="businessSeat2" name="chkSeat" value="businessSeat" />
                                                비즈니스석
                                            </label>
                                            <label class="form-check-label">
                                                <input class="form-check-input" type="radio" id="firstClassSeat2" name="chkSeat" value="firstClassSeat" />
                                                일등석
                                            </label>
                                        </div>
                                        <div>
                                            <button type="button" class="btn btn-primary choiceCompleteBtn">선택완료</button>
                                        </div>
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary">항공권 검색</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <article class="airMainSlider">
        <div class="airSlide">
            <img src="${contextPath }/resources/images/air/airplane_bg1.png" alt="항공 예약 슬라이드 이미지" />
        </div>
        <div class="airSlide">
            <img src="${contextPath }/resources/images/air/airplane_bg2.png" alt="항공 예약 슬라이드 이미지" />
        </div>
        <div class="airSlide">
            <img src="${contextPath }/resources/images/air/airplane_bg3.png" alt="항공 예약 슬라이드 이미지" />
        </div>
        <div class="airSlide">
            <img src="${contextPath }/resources/images/air/airplane_bg4.png" alt="항공 예약 슬라이드 이미지" />
        </div>
    </article>
</section>

<section class="airplaneInfoContainer cen">
    <h2>
        Hot Pick 국내 항공 특가
        <i class="fas fa-plane"></i>
    </h2>
    <article class="airInfoContents">
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/airBg01.jpg" alt="항공 예약 썸네일 이미지" />
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
                <img src="${contextPath }/resources/images/air/airBg02.jpg" alt="항공 예약 썸네일 이미지" />
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
                <img src="${contextPath }/resources/images/air/airBg03.jpg" alt="항공 예약 썸네일 이미지" />
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
                <img src="${contextPath }/resources/images/air/airBg04.jpg" alt="항공 예약 썸네일 이미지" />
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

<section class="airplaneInfoContainer cen">
    <h2>
        Hot Pick 국내 항공 특가
        <i class="fas fa-plane"></i>
    </h2>
    <article class="airInfoContents">
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/airBg01.jpg" alt="항공 예약 썸네일 이미지" />
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
                <img src="${contextPath }/resources/images/air/airBg02.jpg" alt="항공 예약 썸네일 이미지" />
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
                <img src="${contextPath }/resources/images/air/airBg03.jpg" alt="항공 예약 썸네일 이미지" />
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
                <img src="${contextPath }/resources/images/air/airBg04.jpg" alt="항공 예약 썸네일 이미지" />
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
<script src="${contextPath }/resources/js/airplane.js"></script>
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
        $.airplaneSlickFn();
        $.airplainTabbtnFn();
        $.airplainTabcontHeightFn();
        
        $.startEndSwitchingFn();
        $.counterLayerPopupFn();
        
        var startDate = $("#startDate");
        var endDate = $("#endDate");
        var startDate2 = $("#startDate2");
        $.dateFickerFn(startDate);
        $.dateFickerFn(endDate);
        $.dateFickerFn(startDate2);
        
        // 종횡비 함수
        $.eachAirImgResizeFn();
        $.eachAirInfoImgResizeFn();
    });
</script>
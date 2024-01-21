<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 랜딩페이지 css -->
<link href="${contextPath }/resources/css/index.css" rel="stylesheet" />

<!-- 메인 슬라이드 구역 -->
<section class="mainSlideContainer">
	<div class="mainSlideTxt">
		<h2>
			<span>YoGi gAlE</span>
			<br />
			TRIP ROAD
		</h2>
		<p>
			우리 지금, 떠나요!<br />
			가장 쉽게! 가장 빠르게! 가장 즐겁게!<br />
			대한민국의 중심으로 통하는 길
 		</p>
	</div>
    <article class="mainSlider">
        <div>
            <img src="${contextPath }/resources/images/slide1.jpg" alt="슬라이드 이미지" />
        </div>
        <div>
            <img src="${contextPath }/resources/images/slide2.jpg" alt="슬라이드 이미지" />
        </div>
        <div>
            <img src="${contextPath }/resources/images/slide3.jpg" alt="슬라이드 이미지" />
        </div>
        <div>
            <img src="${contextPath }/resources/images/slide4.jpg" alt="슬라이드 이미지" />
        </div>
        <div>
            <img src="${contextPath }/resources/images/slide5.jpg" alt="슬라이드 이미지" />
        </div>
    </article>
</section>

<!-- 여행 정보 구역 -->
<section class="journeyInfoContainer cen">
    <h3>어디로 여행을 떠나시나요?</h3>
    <div class="journeyInfoSearchContents">
        <div>
            <input type="text" class="form-control" id="jourInfoSearch" name="jourInfoSearch" placeholder="도시명으로 검색해보세요." />
            <button type="button" id="searchBtn">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </div>
    <div class="journeyInfoContents">
    	<!-- 반복 시작 구간 -->
    	<c:choose>
    		<c:when test="${not empty journeyList8 }">
    			<c:forEach items="${journeyList8 }" var="journey">
    				<article>
			            <div class="infoThumbnailBox">
			                <img src="${journey.infoPreviewimg }" alt="여행 정보 썸네일 이미지" />
			            </div>
			            <div>
			                <h4 class="textDrop">${journey.infoEngname }</h4>
			                <span class="infoTitle textDrop">${journey.infoName }</span>
			                <p>
								${journey.infoDescription }
			                </p>
			                <c:if test="${journey.infoFlightyn eq 'y' }">
				                <span class="airportText">
				                    <span>
				                    	<c:if test="${journey.infoFlight eq 'str' }">
				                    		직항
				                    	</c:if>
				                    	<c:if test="${journey.infoFlight eq 'round' }">
				                    		왕복
				                    	</c:if>
				                    </span>
				                    <span>${journey.infoFlighttime }</span>
				                </span>
			                </c:if>
			                <c:if test="${journey.infoVisayn eq 'y' }">
			                	<span class="visaText">
				                    <span>
				                    	<c:if test="${journey.infoVisaexp eq 'visa' }">
				                    		비자
				                    	</c:if>
				                    	<c:if test="${journey.infoVisaexp eq 'none' }">
				                    		무비자
				                    	</c:if>
				                    </span>
				                    <span>${journey.infoVisatime }</span>
				                </span>
			                </c:if>
			                <span class="voltageTxt">
			                	<span>콘센트</span>
			                	<span>${journey.infoVoltage }</span>
			                </span>
			                <span class="infoTimediferTxt">
			                	<span>한국대비</span>
			                	<span>${journey.infoTimedifer }</span>
			                </span>
			                <input type="hidden" class="infoNo" name="infoNo" value="${journey.infoNo }" />
			            </div>
			        </article>
    			</c:forEach>
    		</c:when>
    		<c:otherwise>
    			<article style="text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; border-radius: 4px;">
    				등록된 여행 정보가 없습니다.
    			</article>
    		</c:otherwise>
    	</c:choose>
    </div>
</section>

<!-- 여행 정보 모달창 -->
<section class="infoModalContents">
    <div class="infoModalBox cen">
        <div class="infoModalClose">
            <div></div>
            <div></div>
        </div>
        <article class="infoModalLeft">
            <div>
                <div class="modalInfoSetting">
                    <span>여행 장소(영어)</span>
                    <h5>여행 장소</h5>
                    <p>여행 내용</p>
                </div>
                <div class="infoModalFourSection">
                    <div>
                        <div>
                            <i class="fas fa-plane"></i>
							항공
                        </div>
                        <div>
                            <span>없음</span>
                            <span>-</span>
                        </div>
                    </div>
                    <div>
                        <div>
                            <i class="fas fa-passport"></i>
							비자
                        </div>
                        <div>
                            <span>없음</span>
                            <span>-</span>
                        </div>
                    </div>
                    <div>
                        <div>
                            <i class="fas fa-plug"></i>
							전압
                        </div>
                        <div>
                            <span>콘센트</span>
                            <span>220V</span>
                        </div>
                    </div>
                    <div>
                        <div>
                            <i class="fas fa-clock"></i>
							시차
                        </div>
                        <div>
                            <span>한국대비</span>
                            <span>없음</span>
                        </div>
                    </div>
                </div>
                <a href="/myplan/makeplan.do" class="btn btn-info makePlanSty <c:if test="${empty sessionInfo }">noUserBlockModal</c:if>" style="color: white;">
					일정만들기 
                    <i class="fas fa-chevron-right"></i>
                </a>
            </div>
        </article>
        <article class="infoModalRight">
            <div class="infoModalImgBox">
                <img src="${contextPath }/resources/images/Jeju.jpg" alt="여행 정보 이미지" />
            </div>
        </article>
    </div>
</section>

<!-- 사이트 그래프 표출 영역 -->
<section class="siteGraphContainer cen">
    <h3>누가 어디로 여행을 떠날까요?</h3>
    <div class="siteGraphContents">
        <article class="siteGraph">
            <h4>성별 사이트 이용자 수(%)</h4>
            <canvas id="genderPieGraph"></canvas>
        </article>
        <article class="siteGraph">
            <h4>주간 연령별 사이트 이용자 수</h4>
            <canvas id="ageBarGraph"></canvas>
        </article>
        <article class="siteGraph">
            <h4>여행지역 선호도(%)</h4>
            <canvas id="areaPolarGraph"></canvas>
        </article>
        <article class="siteGraph">
            <h4>주간 방문자 현황(명)</h4>
            <canvas id="visitorStackGraph"></canvas>
        </article>
    </div>
</section>

<!-- 랜딩페이지 js -->
<script src="${contextPath }/resources/js/index.js"></script>
<!-- slick slide -->
<link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css"/>
<script type="text/javascript" src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<!-- chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
	$(function(){
		$.startHeaderStyle();
        $.mainSlideSlickFn();
        $(".mainSlider").mainSlideArrowStyle();
        $(".slick-dots").mainSlideDotsStyle();
        $.JourneyInfoModalFn();
        $.startHeaderEmpty();
        $.ajaxIndexJourneyInfoSearchFn();
        $.makeplanClickEvent();
        
        /* 종횡비 함수 */
        $.eachJourneyInfoImgResizeFn();
        var infoModalImgBox = $(".infoModalImgBox");
        var infoModalImg = $(".infoModalImgBox img");
        $.ratioBoxH(infoModalImgBox, infoModalImg);
        
        /* chart.js */
        
        /*
			성별 사이트 이용자 수(%)
            var genderPercent 에 담을 파라미터 값
            param1 : 남자 성비(%)
            param2 : 여자 성비(%)
        */
        var genderPercent = [33, 67];
        $.genderPieGraph(genderPercent);
        
        /*
		        연령별 사이트 이용 현황(%)
	        var ageWeekUseSiteCnt 에 담을 파라미터 값
	        param1 : 주간 10대 이용 현황(명)
	        param2 : 주간 20대 이용 현황(명)
	        param3 : 주간 30대 이용 현황(명)
	        param4 : 주간 40대 이용 현황(명)
	        param5 : 주간 50대 이용 현황(명)
	        param6 : 주간 60대 이용 현황(명)
	    */
	    var ageWeekUseSiteCnt = [255, 194, 296, 155, 126, 99];
	    $.ageMixedGraph(ageWeekUseSiteCnt);
        
        /*
			여행지역 선호도(%)
            var nineSectionPreference 에 담을 파라미터 값
            param1 : 경기도 선호도(%)
            param2 : 강원도 선호도(%)
            param3 : 충청남도 선호도(%)
            param4 : 충청북도 선호도(%)
            param5 : 전라남도 선호도(%)
            param6 : 전라북도 선호도(%)
            param7 : 경상남도 선호도(%)
            param8 : 경상북도 선호도(%)
            param9 : 제주특별자치도 선호도(%)
        */
        var nineSectionPreference = [45, 67, 43, 52, 73, 82, 91, 82, 95];
        $.areaPolarGraph(nineSectionPreference);
        
        /*
			주간 방문자 현황(명)
	        var weekVisiterAgeCnt 에 담을 파라미터 값
	        teen : 10대, 오늘 기준으로 일주일치 방문자 수
	        twenties : 20대, 오늘 기준으로 일주일치 방문자 수
	        thirties : 30대, 오늘 기준으로 일주일치 방문자 수
	        forties : 40대, 오늘 기준으로 일주일치 방문자 수
	        fifties : 50대, 오늘 기준으로 일주일치 방문자 수
	        sixties : 60대, 오늘 기준으로 일주일치 방문자 수
	    */
	    var weekVisiterAgeCnt = {
	        teen : [15, 18, 20, 22, 17, 19, 21],
	        twenties : [25, 28, 30, 32, 27, 29, 31],
	        thirties : [35, 38, 40, 42, 37, 39, 41],
	        forties : [45, 48, 50, 52, 47, 49, 51],
	        fifties : [55, 58, 60, 62, 57, 59, 61],
	        sixties : [10, 12, 15, 18, 14, 16, 20]
	    };
	    $.visitorStackGraph(weekVisiterAgeCnt);
        
	});
</script>
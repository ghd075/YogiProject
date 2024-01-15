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
        <article>
            <div class="infoThumbnailBox">
                <img src="${contextPath }/resources/images/Jeju.jpg" alt="여행 정보 썸네일 이미지" />
            </div>
            <div>
                <h4>JEJU</h4>
                <span class="infoTitle">대한민국 제주</span>
                <p>
					섬 전체가 하나의 거대한 관광자원인 제주도. 에메랄드빛 물빛이 인상적인 협재 해수욕장은 제주 대표 여행지며, 파도가 넘보는 주상절리와 바다 위 산책로인 용머리 해안은 제주에서만 볼 수 있는 천혜의 자연경관으로 손꼽힌다. 드라마 촬영지로 알려진 섭지코스는 꾸준한 사랑을 받고 있으며 한라봉과 흑돼지, 은갈치 등은 제주를 대표하는 음식이다.
                </p>
                <span class="airportText">
                    <span>직항</span>
                    <span>약 30분</span>
                </span>
            </div>
        </article>
        <article>
            <div class="infoThumbnailBox">
                <img src="${contextPath }/resources/images/Busan.jpg" alt="여행 정보 썸네일 이미지" />
            </div>
            <div>
                <h4>BUSAN</h4>
                <span class="infoTitle">대한민국 부산</span>
                <p>
					우리나라 제2의 수도 부산광역시. 부산 대표 관광지로 손꼽히는 해운대는 밤에는 마린시티의 야경이 더해져 더욱 화려한 해변이 된다. 감천문화마을은 사진 찍기에 좋으며, 매해 가을마다 개최되는 아시아 최대 규모의 영화제인 부산국제영화제와 함께 부산의 구석구석을 즐겨보는 것도 좋다. 전통시장 투어가 있을 만큼 먹거리가 가득한 부산의 맛기행은 필수!
                </p>
            </div>
        </article>
        <article>
            <div class="infoThumbnailBox">
                <img src="${contextPath }/resources/images/Seoul.jpg" alt="여행 정보 썸네일 이미지" />
            </div>
            <div>
                <h4>SEOUL</h4>
                <span class="infoTitle">대한민국 서울</span>
                <p>
					과거와 현재가 공존하며 하루가 다르게 변하는 서울을 여행하는 일은 매일이 새롭다. 도시 한복판에서 600년의 역사를 그대로 안고 있는 아름다운 고궁들과 더불어 대한민국의 트렌드를 이끌어나가는 예술과 문화의 크고 작은 동네들을 둘러볼 수 있는 서울은 도시 여행에 최적화된 장소다.
                </p>
            </div>
        </article>
        <article>
            <div class="infoThumbnailBox">
                <img src="${contextPath }/resources/images/Gyeongju.jpg" alt="여행 정보 썸네일 이미지" />
            </div>
            <div>
                <h4>GYEONGJU</h4>
                <span class="infoTitle">대한민국 경주</span>
                <p>
					지붕 없는 박물관 경주. 경주는 그만큼 발길이 닿는 어느 곳이든 문화 유적지를 만날 수 있는 곳이다. 밤이면 더 빛나는 안압지를 비롯해 허허벌판에 자리를 굳건히 지키고 있는 첨성대. 뛰어난 건축미를 자랑하는 불국사 석굴암까지 어느 하나 빼놓을 수 없다. 경주 여행의 기록을 남기고 싶다면 스탬프 투어를 이용해보는 것도 좋다. 16곳의 명소를 탐방할 때마다 찍히는 도장 모으는 재미가 쏠쏠하다. 모바일 앱으로도 스탬프 투어 참여가 가능하다.
                </p>
            </div>
        </article>
        <article>
            <div class="infoThumbnailBox">
                <img src="${contextPath }/resources/images/Jeonju.jpg" alt="여행 정보 썸네일 이미지" />
            </div>
            <div>
                <h4>JEONJU</h4>
                <span class="infoTitle">대한민국 전주</span>
                <p>
					한국의 멋이 살아있는 전주. 도심 한복판에 자리한 한옥마을에 들어서면 시대를 거슬러가는 기분이다. '경사스러운 터에 지어진 궁궐'이란 의미의 경기전에 들어서면 대나무가 서로 부대끼며 내는 소리에 귀 기울이게 된다. 전주 야경투어 명소의 대표인 전동성당과 한옥마을을 한눈에 내려다볼 수 있는 오목대 역시 빼놓을 수 없는 곳. 마을 전체가 미술관인 자만 벽화마을은 전주의 대표 포토 존이다.
                </p>
            </div>
        </article>
        <article>
            <div class="infoThumbnailBox">
                <img src="${contextPath }/resources/images/Pohang.jpg" alt="여행 정보 썸네일 이미지" />
            </div>
            <div>
                <h4>POHANG</h4>
                <span class="infoTitle">대한민국 포항</span>
                <p>
					경북 동남부에 위치해 한반도에서 가장 빨리 해가 뜨는 고장으로 알려진 경상북도 포항은 천혜의 해안선을 가진 해양경관의 보고이다. 특히 감포에서 구룡포까지 바닷가 도로에 펼쳐지는 풍광은 세계적인 미항인 나폴리나 시드니를 능가하는 아름답고 환상적 해양자원이다. 북부, 칠포해수욕장을 비롯한 여러 해수욕장이 있고 국립 등대박물관, 호미곶 등 해양관광자원은 포항의 대표적 관광자원이다.
                </p>
            </div>
        </article>
        <article>
            <div class="infoThumbnailBox">
                <img src="${contextPath }/resources/images/Incheon.jpg" alt="여행 정보 썸네일 이미지" />
            </div>
            <div>
                <h4>INCHEON</h4>
                <span class="infoTitle">대한민국 인천</span>
                <p>
					살짝 비릿한 바다향이 매력적인 인천광역시. 지리적 특징을 잘 이용하여 내륙과 해안 지역의 관광이 두루 발달한 곳이다. 대표적인 해양관광지로는 을왕리 해수욕장을 비롯해 문화의 거리가 갖춰진 월미도 등이 있으며, 한국 속 작은 중국이라 불리는 차이나타운도 인천 여행지로 손꼽힌다. 이 외에도 인천 각처에 오랜 역사 유물들이 산재해 있어 역사를 테마로 여행 코스를 잡아보는 것도 좋다.
                </p>
            </div>
        </article>
        <article>
            <div class="infoThumbnailBox">
                <img src="${contextPath }/resources/images/Daejeon.jpg" alt="여행 정보 썸네일 이미지" />
            </div>
            <div>
                <h4>DAEJEON</h4>
                <span class="infoTitle">대한민국 대전</span>
                <p>
					 다양한 테마 여행이 가능한 대전광역시. 맨발로 걸을 수 있는 계족산 황톳길은 온몸으로 자연을 느끼는 여행을 할 수 있으며, 대전 근현대 전시관과 남간정사 등 대전에 있는 역사 문화 공간을 코스로 잡아도 좋다. 아이들이 좋아하는 동물원이 있는 오월드와 가볍게 산책하기 좋은 유림공원도 있어 주말 가족 나들이 코스로도 손색이 없다.
                </p>
            </div>
        </article>
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
                            <span>직항</span>
                            <span>약 30분</span>
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
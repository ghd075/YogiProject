<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- 여행 정보 css -->
<link href="${contextPath }/resources/css/journeyInfo.css" rel="stylesheet" />

<section class="journeyInfoHeadStyle emptySpace">
	<article>
	    <div class="jourImgBox">
	        <img src="${contextPath }/resources/images/journeyBgImg.jpg" alt="커뮤니티 배경 이미지" />
	    </div>
	    <div>
	        <h3>마이 플랜</h3>
	        <span>MY PLAN</span>
	    </div>
	</article>
</section>

<section class="journeyInfoContainer cen">
	<c:if test="${sessionInfo.memCategory eq '03' }">
	    <button id="journeyRegiBtn" type="button">
	        <i class="fas fa-map-marked-alt"></i>
	    </button>
	</c:if>
    <h3>여행 정보 검색</h3>
    <div class="journeyInfoSearchContents">
        <div>
            <input type="text" class="form-control" id="jourInfoSearch" name="jourInfoSearch" placeholder="도시명으로 검색해보세요." />
            <button type="button" id="searchBtn">
                <i class="fas fa-search"></i>
            </button>
        </div>
    </div>
    <div class="journeyInfoContents">
    	<!-- 반복 구간 -->
    	<c:choose>
    		<c:when test="${not empty journeyList }">
	    		<c:forEach items="${journeyList }" var="journey">
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
                <c:if test="${sessionInfo.memCategory eq '03' }">
	                <div class="journeyInfoBtnGroup">
	                	<input type="hidden" id="choiceInfoNo" name="choiceInfoNo" />
	                	<button type="button" id="journeyInfoModify">
	                		<i class='fas fa-exchange-alt'></i>
	                	</button>
	                	<button type="button" id="journeyInfoDelete">
	                		<i class='fas fa-ban'></i>
	                	</button>
	                </div>
                </c:if>
            </div>
        </article>
        <article class="infoModalRight">
            <div class="infoModalImgBox">
                <img src="${contextPath }/resources/images/Jeju.jpg" alt="여행 정보 이미지" />
            </div>
        </article>
    </div>
</section>

<!-- 여행 정보 js -->
<script defer src="${contextPath }/resources/js/journeyInfo.js"></script>

<script>
    $(function(){
        
    	// 공통 함수
        $.JourneyInfoModalFn();
        $.journeyRegiPageMoveFn();
        $.makeplanClickEvent();
        $.journeyModifyPageMoveFn();
        $.journeyDeletePageMoveFn();
        $.ajaxJourneyInfoSearchFn();
        
        /* 종횡비 함수 */
        $.eachJourneyInfoImgResizeFn();
        
        var infoModalImgBox = $(".infoModalImgBox");
        var infoModalImg = $(".infoModalImgBox img");
        $.ratioBoxH(infoModalImgBox, infoModalImg);
        
        var jourImgBox = $(".jourImgBox");
        var jourImg = $(".jourImgBox img");
        $.ratioBoxH(jourImgBox, jourImg);
        
    });
</script>
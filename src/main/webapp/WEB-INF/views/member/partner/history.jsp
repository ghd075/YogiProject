<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 마이플랜 이력 css -->
<link href="${contextPath }/resources/css/history.css" rel="stylesheet" />

<!-- 구현할 페이지를 여기에 작성 -->
<section class="historyContainer emptySpace">
    <article class="historyHeadStyle">
        <div class="historyImgBox">
            <img src="${contextPath }/resources/images/planHistory.jpg" alt="마이 플랜 이력 배경 이미지" />
        </div>
        <div>
            <h3>마이 플랜 이력</h3>
            <span>MY PLAN HISTORY</span>
        </div>
    </article>
    <article class="historyListContents cen">
        <h3>플랜 이력 리스트</h3>
        <!-- <div class="meetAreaSearchCont">
            <div>
                <input type="text" class="form-control" id="meetAreaSearchInput" name="meetAreaSearchInput" placeholder="제목(한글) 혹은 인원(숫자)을 입력하세요." />
                <button type="button" id="meetAreaSearchBtn">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div> -->
        <div class="historyListCont">
            <ul>
            	<!-- 반복 구간 -->
            	<c:choose>
            		<c:when test="${empty planerList }">
            			<li id="dontHoverSty" style="display: flex; justify-content: center;">
	            			<div style="background-color: #333; color: white; padding: 20px; width: 50%; margin: 0px auto; text-align: center;">
	            				${sessionInfo.memName }님이 등록/참여한 플래너가 없습니다.
	            			</div>
	            		</li>
	            		<script>
						  $(document).ready(function() {
							// 해당 ID를 가진 li 요소에서 mouseover 이벤트를 무시
						    $("#dontHoverSty").on("mouseover", function() {
						      $(this).css("pointer-events", "none");
						    });
						  });
						</script>	
            		</c:when>
            		<c:otherwise>
            			<c:forEach items="${planerList }" var="planer" varStatus="stat">
                            <li>
                                <div class="historyThumbnailCont">
                                    <c:choose>
                                        <c:when test="${empty planer.plThumburl }">
                                            <img src="/resources/images/testimg/noimg.png" alt="플래너 리스트 썸네일 이미지" />
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${planer.plThumburl }" alt="플래너 리스트 썸네일 이미지" />
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="historyLists">
                                    <a href="/partner/meetsquare.do?plNo=${planer.plNo }">
                                        <span class="meetTitle textDrop">
                                            <span class="badge bg-dark">제목</span>
                                            ${planer.plTitle }
                                        </span>
                                        <span class="meetTheme textDrop">
                                            <span class="badge bg-dark">테마</span>
                                            ${planer.plTheme }
                                        </span>
                                        <span class="meetMsize textDrop">
                                            <span class="badge bg-dark">최종멤버</span>
                                            <!-- ${planer.plMsize }명 -->
                                            ${planer.mategroupCurrentnum}명
                                        </span>
                                        <fmt:parseDate var="impParseData" value="${planer.plRdate }" pattern="yyyy-MM-dd HH:mm:ss" />
                                        <span class="meetRdate textDrop">
                                            <span class="badge bg-dark">등록일자</span>
                                            <fmt:formatDate value="${impParseData }" pattern="yyyy-MM-dd"/>
                                        </span>
                                        <span class="meetName textDrop">
                                            <span class="badge bg-dark">그룹장</span>
                                            ${planer.memName }
                                        </span>
                                    </a>
                                </div>
                                <c:if test="${planer.memId eq sessionInfo.memId }">
                                    <div class="historyListBtnGroup">
                                        <button type="button" class="btn btn-secondary">내 플랜</button>
                                        <button type="button" class="btn btn-warning">여행후기 작성</button>
                                        <button type="button" class="btn btn-success">여행후기 보기</button>
                                        <!-- <form action="/partner/chgStatusPlan.do" method="post" id="chgStatusPlan" name="chgStatusPlan">
                                            <input type="hidden" value="${planer.memId }" id="memIdVal" name="memId" />
                                            <input type="hidden" value="${planer.plNo }" id="plNoVal" name="plNo" />
                                            <input type="hidden" value="${planer.plPrivate }" id="plPrivateVal" name="plPrivate" />
                                        </form> -->
                                    </div>
                                </c:if>
                                <c:if test="${planer.memId ne sessionInfo.memId }">
                                    <div class="historyListBtnGroup">
                                        <button type="button" class="btn btn-secondary">동행참가 플랜</button>
                                        <!-- <form action="/partner/chgStatusJoiner.do" method="post" id="chgStatusJoiner" name="chgStatusJoiner">
                                            <input type="hidden" value="${planer.mategroupId }" id="memIdVal" name="memId" />
                                            <input type="hidden" value="${planer.plNo }" id="plNoVal" name="plNo" />
                                        </form> -->
                                        
                                    </div>
                                </c:if>
                            </li>
            			</c:forEach>
            		</c:otherwise>
            	</c:choose>
            </ul>
        </div>
    </article>
</section>

<!-- 마이 트립 js -->
<!-- <script src="${contextPath }/resources/js/myTrip.js"></script> -->
<script>
    $(function(){
    	/* 공통 함수 */
    	var memId = '${sessionInfo.memId}';
    	// $.ajaxPlannerListSearchFn(memId);
    	
    	var rtAlertPPChgObj = {
    		realsenId: '${sessionInfo.memId}',
    		realsenName: '${sessionInfo.memName}',
    		realsenPfimg: '${sessionInfo.memProfileimg}'
    	};
    	console.log("rtAlertPPChgObj : ", rtAlertPPChgObj);
    	//$.myTripPrivatePublicChgFn(rtAlertPPChgObj);
    	
    	//$.myTripDeleteFn();
    	//$.excludeNonUserFn(memId);
    	//$.myTripCancelFn();
    	
    	/* 종횡비 함수 */
        var historyImgBox = $(".historyImgBox");
        var historyImg = $(".historyImgBox img");
        $.ratioBoxH(historyImgBox, historyImg);

        $.eachPlannerInfoImgResizeFn2 = function(){
            $(".historyListContents li").each(function(i, v){
                var thisIs = $(this);
                var infoThumbnailBox = thisIs.find(".historyThumbnailCont");
                var infoThumbnailImg = thisIs.find(".historyThumbnailCont img");
                $.ratioBoxH(infoThumbnailBox, infoThumbnailImg);
            });
        };
        $.eachPlannerInfoImgResizeFn2();
        // 플래너 정보 각각의 이미지 종횡비 변경 함수
    });
</script>
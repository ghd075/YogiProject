<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 마이 트립 css -->
<link href="${contextPath }/resources/css/myTrip.css" rel="stylesheet" />

<section class="myTripListContainer emptySpace">
    <article class="myTripHeadStyle">
        <div class="myTripImgBox">
            <img src="${contextPath }/resources/images/myTripBgImg.jpg" alt="마이 트립 배경 이미지" />
        </div>
        <div>
            <h3>마이 트립</h3>
            <span>MY TRIP</span>
        </div>
    </article>
    <article class="meetAreaListContents cen">
        <h3>플래너 리스트</h3>
        <div class="meetAreaSearchCont">
            <div>
                <input type="text" class="form-control" id="meetAreaSearchInput" name="meetAreaSearchInput" placeholder="제목(한글) 혹은 인원(숫자)을 입력하세요." />
                <button type="button" id="meetAreaSearchBtn">
                    <i class="fas fa-search"></i>
                </button>
            </div>
        </div>
        <div class="meetAreaListCont">
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
            				<c:if test="${planer.getSType() eq '동행참가' }">
	            				<li>
				                    <div class="meetAreaThumbnailCont">
				                    	<c:choose>
				                    		<c:when test="${empty planer.plThumburl }">
				                    			<img src="/resources/images/testimg/noimg.png" alt="플래너 리스트 썸네일 이미지" />
				                    		</c:when>
				                    		<c:otherwise>
				                    			<img src="${planer.plThumburl }" alt="플래너 리스트 썸네일 이미지" />
				                    		</c:otherwise>
				                    	</c:choose>
				                    </div>
				                    <div class="meetAreaLists">
				                        <a href="javascript:void(0);">
				                            <span class="meetTitle textDrop">
				                                <span class="badge bg-dark">제목</span>
				                                ${planer.plTitle }
				                            </span>
				                            <span class="meetTheme textDrop">
				                                <span class="badge bg-dark">테마</span>
				                                ${planer.plTheme }
				                            </span>
				                            <span class="meetMsize textDrop">
				                                <span class="badge bg-dark">인원</span>
				                                ${planer.plMsize }명
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
					                    <div class="myTripListBtnGroup">
					                        <form action="/partner/chgStatusPlan.do" method="post" id="chgStatusPlan" name="chgStatusPlan">
					                        	<input type="hidden" value="${planer.memId }" id="memIdVal" name="memId" />
					                        	<input type="hidden" value="${planer.plNo }" id="plNoVal" name="plNo" />
					                        	<input type="hidden" value="${planer.plPrivate }" id="plPrivateVal" name="plPrivate" />
					                        </form>
					                        <button type="button" class="btn btn-danger" id="myTripDeleteBtn">일정 삭제</button>
					                        <c:if test="${planer.plPrivate eq 'N' }">
					                        	<button type="button" class="btn btn-primary myTripPrivatePublicBtn">공개</button>
					                        </c:if>
					                        <c:if test="${planer.plPrivate eq 'Y' }">
					                        	<button type="button" class="btn btn-warning myTripPrivatePublicBtn">비공개</button>
					                        </c:if>
					                    </div>
				                    </c:if>
				                </li>
			                </c:if>
            			</c:forEach>
            		</c:otherwise>
            	</c:choose>
            </ul>
        </div>
    </article>
</section>

<!-- 마이 트립 js -->
<script src="${contextPath }/resources/js/myTrip.js"></script>
<script>
    $(function(){
    	/* 공통 함수 */
    	var memId = '${sessionInfo.memId}';
    	$.ajaxPlannerListSearchFn(memId);
    	$.myTripPrivatePublicChgFn();
    	
    	/* 종횡비 함수 */
        var myTripImgBox = $(".myTripImgBox");
        var myTripImg = $(".myTripImgBox img");
        $.ratioBoxH(myTripImgBox, myTripImg);
        $.eachPlannerInfoImgResizeFn();
    });
</script>
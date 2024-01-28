<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     
<!-- 플래너 디테일 페이지 css -->
<link href="${contextPath }/resources/css/userPlanDetail.css" rel="stylesheet" />

<!-- 플래너 디테일 페이지 화면 영역-->
<section class="planDetailContainer emptySpace">
    <article class="planDetailContainer cen">
	    <div class="planDetailTabbtnGroup">
	        <div class="tabbtn tactive">
				여행 요약
	        </div>
	        <div class="tabbtn">
				세부 일정
	        </div>
	    </div>
	    <div class="planDetailTabcontBox">
	    	<div class="tabcont">
			    <div class="planDetailContents">
			    	<div class="planDetailHeaderStyle">
			    		<c:if test="${pvo.plTitle eq ''}">
			    			<h2>제목 없음</h2>
			    		</c:if>
			    		<c:if test="${pvo.plTitle ne ''}">
				    		<h2>${pvo.plTitle}</h2>
			    		</c:if>
						<div><p style="margin-top: 20px; text-align: right">작성자 : ${pvo.memId} | 작성일 : ${pvo.plRdate} | 모집인원 : ${pvo.plMsize} 명 | ${pvo.plTheme}</p></div>
			    	</div>
					<%-- <p>dayCnt : ${dayCnt }</p> --%>
					<div class="tableWrap" style="float:left">
						<table class="table">
							<tr>
								<th scope="col">일자</th>
								<th scope="col">장소</th>
							</tr>
							<c:forEach begin="1" end="${dayCnt}" varStatus="status">
								<c:set value="day${status.index}" var="dayKey"></c:set>
								<c:forEach items="${requestScope[dayKey]}" var="dpForDay" varStatus="status2">
									<tr>
										<c:if test="${status2.index eq 0}">
											<th scope="row" rowspan="${status2.end}">${status.index}일</th>
										</c:if>
										<c:if test="${status2.index ne 0}">
											<th></th>
										</c:if>
										<td>${dpForDay.tourVO.title }</td>
									</tr>
								</c:forEach>
							</c:forEach>
						</table>
					</div>
					<div>
						<div class="mapmap" style="width:50%"></div>
					</div>
 					<%-- <c:forEach begin="1" end="${dayCnt}" varStatus="status">
 						<c:set value="day${status.index}" var="dayKey"></c:set>

						<h3>Day${status.index}</h3>

						<c:forEach items="${requestScope[dayKey]}" var="dpForDay">
					    		<p>장소 이름 : ${dpForDay.tourVO.title }</p>
					    		<!-- <p>순서 : ${dpForDay.spOrder}</p> -->
						</c:forEach>
					</c:forEach> --%>
					
			   	</div>
		    </div>
		    <div class="tabcont">
				<div class="planDetailContents">
					
			    </div>
		    </div>
	    </div>
    </article>
</section>


<!-- js -->
<script src="${contextPath }/resources/js/userPlanDetail.js"></script>
<script>
	
</script>
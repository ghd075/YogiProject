<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<style>
	/* sweetAlert padding-right 이슈 해소 */
	body {
		padding-right: 0 !important;
	}
</style>
     
<!-- 플래너 디테일 페이지 css -->
<link href="${contextPath }/resources/css/userPlanDetail.css" rel="stylesheet" />

<!-- 플래너 디테일 페이지 화면 영역-->
<section class="planDetailContainer emptySpace">
	<article class="planDetailHeadStyle">
		<div class="planDetailHeadOverlay">
			<c:choose>
				<c:when test="${pvo.plThumburl == null or pvo.plThumburl == ''}">
					<img class="planDetailHeadImg" src="${contextPath }/resources/images/testimg/noimg.png" alt="헤더 이미지 없음">
				</c:when>
				<c:otherwise>
					<img class="planDetailHeadImg" src="${pvo.plThumburl}" alt="헤더 이미지">
				</c:otherwise>
			</c:choose>
	
        </div>
        <div class="planDetailHeadContent">
        	<h3 style="color:#fff;">${pvo.plTitle}</h3>
			<span class="headSpans">${pvo.memId} 작성</span><br/>
			<!-- <span class="headSpans">${pvo.plRdate}</span><br/> -->
			<c:set var="sdayValue" value="${pvo.detailList[0].spSday}"/>
			<c:set var="edayValue" value="${pvo.detailList[0].spEday}"/>
			<span class="headSpans">${fn:substring(sdayValue,0,10) } ~ ${fn:substring(edayValue,0,10) } (${dayCnt }일)</span><br/>
			<span class="headSpans">${pvo.plTheme} | 모집멤버 ${pvo.plMsize} 명 | 현재멤버 ${mgCurNum} 명 </span><br/><br/>
			
			<c:set value="${sessionInfo.memId }" var="sesId"></c:set>
			<c:set value="${pvo.memId }" var="memId"></c:set>
			<c:set value="${isJoined }" var="isJoinedCnt"></c:set>
			<c:choose>
				<c:when test="${pvo.plTheme eq '혼자' and sesId != memId}">
					<span class="headSpans groupAttendNoBtn groupDisabled">모집안함</span>
				</c:when>
				<c:otherwise>
					<c:if test="${sesId != memId and isJoinedCnt != 1 and mategroupStep == '1단계'}">
						<span class="headSpans groupAttendBtn groupJoin rtAlertPlanDetail">동행참가</span>
					</c:if>
					<c:if test="${sesId != memId and isJoinedCnt != 1 and mategroupStep == '2단계'}">
						<span class="headSpans groupAttendNoBtn groupDisabled">모집마감</span>
					</c:if>
					<c:if test="${sesId != memId and isJoinedCnt != 1 and mategroupStep == '3단계'}">
						<span class="headSpans groupAttendNoBtn groupDisabled">모집마감</span>
					</c:if>
					<c:if test="${sesId != memId and isJoinedCnt != 1 and mategroupStep == '4단계'}">
						<span class="headSpans groupAttendNoBtn groupDisabled">여행종료</span>
					</c:if>
					<c:if test="${sesId != memId and isJoinedCnt == 1 and joinStatus == 'Y'}">
						<span class="headSpans groupAttendNoBtn groupAttending">참가중</span>
						<span class="headSpans groupAttendNoBtn goToGroup">그룹 페이지로 이동</span>
					</c:if>
					<c:if test="${sesId != memId and isJoinedCnt == 1 and joinStatus == 'N'}">
						<span class="headSpans groupAttendNoBtn groupBanOrDenied">참가불가</span>
					</c:if>
					<c:if test="${sesId != memId and isJoinedCnt == 1 and joinStatus == 'C'}">
						<span class="headSpans groupAttendNoBtn groupCancled">취소됨</span>
					</c:if>
					<c:if test="${sesId != memId and isJoinedCnt == 1 and joinStatus == 'W'}">
						<span class="headSpans groupAttendNoBtn groupDisabled">승인대기</span>
					</c:if>
					<c:if test="${sesId != memId and isJoinedCnt == 1 and joinStatus == 'E'}">
						<span class="headSpans groupAttendNoBtn groupDisabled">모집마감</span>
					</c:if>
					<c:if test="${sesId == memId and isJoinedCnt == 1}">
						<span class="headSpans groupAttendNoBtn groupMyPlan">내 플랜</span>
						<span class="headSpans groupAttendNoBtn goToGroup">그룹 페이지로 이동</span>
					</c:if>
				</c:otherwise>
			</c:choose>
        </div>
	</article>
    <article class="planDetailContainer cen">
		<input id="getDps" type="hidden" value="${pvo.detailList}">
	    <div class="planDetailTabbtnGroup">
	        <div class="tabbtn tactive">
				여행 플랜
	        </div>
<!-- 	        <div class="tabbtn">
				일정표
	        </div> -->
	        <c:if test="${sesId == pvo.memId}">
		        <div class="planDetailBtnGroup">
				    <button id="downloadButton" class="btn btn-outline-danger">PDF 저장</button>
		        </div>
		    </c:if>
	    </div>
	    <div class="planDetailTabcontBox">
	    	<div class="tabcont">
			    <div class="planDetailContents">
					<div class="mainContentsBox row mt-3">
						<div class="mainContentsBoxLeft col-md-4">
							<ul class="list-group">
								<li class="list-group-item border-0 tab">
									<c:forEach begin="0" end="${dayCnt}" varStatus="status0">
										<c:if test="${status0.index == 0 }">
											<span class="customBadge active" data-selday="${status0.index}">전체</span>
										</c:if>
										<c:if test="${status0.index > 0 }">
											<span class="customBadge" data-selday="${status0.index}">${status0.index}일차</span>
										</c:if>
									</c:forEach>
								</li>
								<!-- 전체탭(기본 show) -->
								<c:forEach begin="1" end="${dayCnt}" varStatus="status">
									<c:set value="day${status.index}" var="dayKey"></c:set>
									<li class="list-group-item border-0 dayHeader dayAll">
										<h4>DAY${status.index}</h4>
									</li>
									<c:forEach items="${requestScope[dayKey]}" var="dpForDay" varStatus="status2">
										<li class="list-group-item border-top-0 border-start-0 border-end-0 dayContents dayAll" data-selloc="${dpForDay.tourVO.contentId}">
											<div class="row my-2">
												<div class="col-md-1">${dpForDay.spOrder}</div>
												<div class="col-md-2">
													<img class="thumbImg" src="${dpForDay.tourVO.firstImage}" alt="">
												</div>
												<div class="col-md-7">
													<div class="row">
														<div class="col-md-12 textDrop">${dpForDay.tourVO.title}</div>
													</div>
													<div class="row">
														<div class="col-md-12 textAdress">${dpForDay.tourVO.address}</div>
													</div>
												</div>
												<div class="col-md-2 setDistance" data-spno="${dpForDay.spNo}" style="margin-top: 5px; font-size: 0.9rem;">
													<!-- 테스트용 -->
												</div>
											</div>
										</li>
									</c:forEach>
									<li class="list-group-item border-0 dayAll setDistance totalDistance" data-dayday="${status.index}">

									</li>
								</c:forEach>
								<!-- 일차 선택탭(기본 hide) -->
								<c:forEach begin="1" end="${dayCnt}" varStatus="status3">
									<c:set value="day${status3.index}" var="dayKey2"></c:set>
									<li class="list-group-item border-0 dayHeader ${dayKey2}" style="display:none;">
										<h4>DAY${status3.index}</h4>
									</li>
									<c:forEach items="${requestScope[dayKey2]}" var="dpForDay2" varStatus="status4">
										<li class="list-group-item border-top-0 border-start-0 border-end-0 dayContents ${dayKey2}" data-selloc="${dpForDay2.tourVO.contentId}" style="display:none;">
											<div class="row my-2">
												<div class="col-md-1">${dpForDay2.spOrder}</div>
												<div class="col-md-2">
													<img class="thumbImg" src="${dpForDay2.tourVO.firstImage}" alt="">
												</div>
												<div class="col-md-7">
													<div class="row">
														<div class="col-md-12 textDrop">${dpForDay2.tourVO.title}</div>
													</div>
													<div class="row">
														<div class="col-md-12 textAdress">${dpForDay2.tourVO.address}</div>
													</div>
												</div>
												<div class="col-md-2 setDistance" data-spno="${dpForDay2.spNo}" style="margin-top: 5px; font-size: 0.9rem;">
													<!-- 테스트용 -->
												</div>
											</div>
										</li>
									</c:forEach>
									<li class="list-group-item border-0 ${dayKey2} setDistance totalDistance" data-dayday="${status3.index}" style="display:none;">

									</li>
								</c:forEach>
							</ul>
						</div>
						<div class="mainContentsBoxRight col-md-8">
							<div id="mapDiv"></div>
							<div id="fixedBox">
								<ul style="list-style-type: none; padding-left:0; margin-top:0">
								<c:forEach begin="0" end="${dayCnt}" varStatus="status0">
									<c:if test="${status0.index == 0}">
									</c:if>
									<c:if test="${status0.index == 1}">
										<li>
											<span class="fixedBoxSpans" style="background-color:#FF0000;"></span>
											<span>${status0.index}일차</span>
										</li>
									</c:if>
									<c:if test="${status0.index == 2}">
										<li>
											<span class="fixedBoxSpans" style="background-color:#ff7300;"></span>
											<span>${status0.index}일차</span>
										</li>
									</c:if>
									<c:if test="${status0.index == 3}">
										<li>
											<span class="fixedBoxSpans" style="background-color:#89cf48;"></span>
											<span>${status0.index}일차</span>
										</li>
									</c:if>
									<c:if test="${status0.index == 4}">
										<li>
											<span class="fixedBoxSpans" style="background-color:#797EFC;"></span>
											<span>${status0.index}일차</span>
										</li>
									</c:if>
									<c:if test="${status0.index == 5}">
										<li>
											<span class="fixedBoxSpans" style="background-color:#ffad29;"></span>
											<span>${status0.index}일차</span>
										</li>
									</c:if>
								</c:forEach>
								</ul>
							</div>
							<!-- <div id="fixedBoxForDistance"></div> -->
						</div>
					</div>
					<div class="mt-3" style="position:absolute; right: 30px;">
						<button id="listButton" class="btn btn-outline-danger listBtn" onclick="location.href='/myplan/planMain.do'">목록 페이지로 이동</button>
					</div>
					
			   	</div>
		    </div>
		    <div class="tabcont">
				<div class="planDetailContents">
					<div class="mainContentsBox row mt-3">
						<h3>일정표 추가 예정</h3>
					</div>
			    </div>
		    </div>
	    </div>
    </article>
</section>

<!-- pdf js 관련 -->
<script src="${contextPath }/resources/js/pdf/jspdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/dom-to-image/2.6.0/dom-to-image.min.js"></script>

<!-- js -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5d692983b8638035f4f288e59aea36fe&libraries=services"></script>
<script>
	
	let plNo = '${pvo.plNo}';
	let allDpsAllDays = ${pvoJson};
	let dayCount = ${dayCnt};
	
	// 맵 렌더링
	let mapContainer = document.getElementById('mapDiv'); // 지도를 표시할 div 
	let mapOption = {
		center: new kakao.maps.LatLng(37.56682, 126.97865), // 지도의 중심좌표
		level : 6
	};
	
	let map = new kakao.maps.Map(mapContainer, mapOption);
	
	// 맵위에 일자를 표시할 고정된 상자 생성
	let fixedBox = document.getElementById('fixedBox');

	let boxElTemp = $(".planDetailHeadOverlay");
	let imgElTemp = $(".planDetailHeadImg");

	imgResizing(boxElTemp, imgElTemp);

	function imgResizing(boxEl, imgEl) {
		var boxSel = $(boxEl);
		var boxW = boxSel.width();
		var boxH = boxSel.height();
		var boxRatio = boxH / boxW;
		
		var imgSel = $(imgEl);
		
		var setImgDimensions = function() {
			var imgW = imgSel.width();
			var imgH = imgSel.height();
			var imgRatio = imgH / imgW;
			
			if (boxRatio < imgRatio) {
				//console.log("boxW :", boxW);
				imgSel.width(boxW).height("auto");
			} else {
				//console.log("boxH :", boxH);
				imgSel.height(boxH).width("auto");
			}
		};
		
		// 이미지의 로드 이벤트 핸들러 등록
		imgSel.on("load", setImgDimensions);
		
		// 초기 설정
		setImgDimensions();
	}
	
	
	// 2024.02.07 이건정 커밋 지점
	
	var rtAlertPlanDetail = $(".rtAlertPlanDetail");
	rtAlertPlanDetail.click(function(){
		// 실시간 알림 > 동행 참가 요청 > 해당 플래너에게만 전달
		console.log("plNo : ", plNo);
		
		var thisIs = $(this);
		var planTitleTxt = thisIs.parent().find("h3").text().trim();
		console.log("planTitleTxt : ", planTitleTxt);
		
		$.ajax({
			type: "get",
			url: "/planDetailCreateMemId.do",
			data: {plNo : plNo},
			contentType: "application/json",
			dataType: "json",
			success: function(res){
				
				console.log("res : ", res);
				var planerMemId = res.memId;
				console.log("planerMemId : ", planerMemId);
				
				var realsenId = "${sessionInfo.memId}"; // 발신자 아이디
		        var realsenName = "${sessionInfo.memName}"; // 발신자 이름
		        var realsenTitle = "동행 요청"; // 실시간 알림 제목
		        var realsenContent = realsenName+"("+realsenId+")님이 ["+planTitleTxt+"] 플랜에 동행을 요청하였습니다."; // 실시간 알림 내용
		        var realsenType = "plandetail"; // 여행정보 타입 알림
		        var realsenReadyn = "N"; // 안 읽음
		        var realsenUrl = "/partner/meetsquare.do?plNo=" + plNo; // 여행 정보 페이지로 이동
		        
		        var dbSaveFlag = true; // db에 저장
		        var userImgSrc = "${sessionInfo.memProfileimg }"; // 유저 프로파일 이미지 정보
		        var realrecNo = "empty";
		        
		        var rtAlert = {
		        	"realrecIdArr": [planerMemId],
		        	"realsenId": realsenId,
		        	"realsenName": realsenName,
		        	"realsenTitle": realsenTitle,
		        	"realsenContent": realsenContent,
		        	"realsenType": realsenType,
		        	"realsenReadyn": realsenReadyn,
		        	"realsenUrl": realsenUrl,
		        	"realsenPfimg": userImgSrc
		        };
			    console.log("플래너 등록 알림 저장 > rtAlert : ", rtAlert);
			        
			    $.realTimeAlertWebSocketFn(rtAlert, dbSaveFlag, userImgSrc, realrecNo);
				
			}
		});
		
	});
	
	// 2024.02.07 이건정 커밋 지점
	
	
	
	
</script>
<script src="${contextPath }/resources/js/userPlanDetail.js"></script>
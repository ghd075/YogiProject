<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     
<!-- 마이플랜 css -->
<link rel="stylesheet" href="${contextPath }/resources/css/nice-select.css">
<link href="${contextPath }/resources/css/userPlanMain.css" rel="stylesheet" />

<!-- 플래너 메인 페이지 화면 영역-->
<section class="bestContainer emptySpace">
	<article class="bestPlanMainHeadStyle">
		<div class="comImgBox">
            <img src="${contextPath }/resources/images/plannerCreateBgImg.jpg" alt="커뮤니티 배경 이미지" />
        </div>
        <div>
        	<h3>플래너 작성</h3>
        	<span><a href="/myplan/makeplan.do">지금 작성하러가기</a></span>
        </div>
	</article>
    <article class="bestPlansContainer cen">
	    <div class="bestPlansTabbtnGroup">
	        <div class="tabbtn tactive">
				월간 베스트 플랜
	        </div>
	        <div class="tabbtn">
				지역별 플랜
	        </div>
	    </div>
	    <div class="bestPlansTabcontBox">
	    	<div class="tabcont">
			    <div class="bestContents forLikes">
			    	<h3>월간 베스트 플랜</h3>
			   	</div>
		    </div>
		    <div class="tabcont">
		    	<div id="areaBoxContainer" style="overflow: auto; text-align: right;">
		    		<select name="areaCode" id=areaCode class="nice-select top-select" style="display:inline-block; float:none;">
						<option value="0">지역 선택</option>
					</select> 
	    		</div>
				<div class="bestContents forArea">
			        <h3>지역별 플랜</h3>

			    </div>
		    </div>
	    </div>
    </article>
</section>


<!-- js -->
<script src="${contextPath }/resources/js/userPlanMain.js"></script>
<script>
	let likeArr = [];
	// 세션 아이디
	let sessionInfo = '${sessionInfo.memId}';
	console.log("sessionInfo", sessionInfo)

	$(function () {
		$('.bestContents').on('click', 'article', function(event) {
			if (!$(event.target).parent().is(".like")) {
			//console.log(event.target);
				var plno = $(this).find('div svg').data('plno');
	      		console.log('data-plno: ' + plno);
				// ajax 가져오는 경우
				// $.ajax({
				// 	type: 'get',
				// 	url: 	'/myplan/planDetail.do',
				// 	data : {"plNo" : plno},
				// 	success : function(data) {
				// 		console.log("체킁:",data);
				// 	}
				// });
				// 상세페이지 이동 경우
				
				location.href="/myplan/planDetail.do?plNo=" + plno;
			}
		});
		// 지역 가져오기
		draw.getAreas();
		// 지역별 사용자 코스
		draw.getSortedByArea({"areaCode" : 0});
		// 월간 베스트 플랜
		draw.getSortedByLikes();
		// 이미 눌러진 좋아요 표시
		draw.alreadyActivatedLike({"memId" : sessionInfo});
		//$.eachBestImgResizeFn
	});

	// 탭버튼 처리
	//$.bestPlansTabbtnFn();
	$.bestPlansTabbtnFn();
	// 이미지 리사이징
	//$.eachBestImgResizeFn();
	// 지역 변경시 이벤트
	$.areaChange();
	// 좋아요 누를 시 버튼 이벤트
	$.likeChange(sessionInfo);
	
/*     $(".bestContents article").each(function(i, v){
        var thisIs = $(this);

    }); */

    // 종횡비 함수
    var comImgBox = $(".comImgBox");
    var comImg = $(".comImgBox img");
    $.ratioBoxH(comImgBox, comImg);
</script>
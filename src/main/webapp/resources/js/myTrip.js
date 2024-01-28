// ajax > 플래너 리스트 실시간 검색 기능
$.ajaxPlannerListSearchFn = function(memId){
	var meetAreaSearchInput = $("#meetAreaSearchInput");
	meetAreaSearchInput.keyup(function(){
	
		var thisIs = $(this);
		var thisVal = thisIs.val();
		console.log("thisVal : ", thisVal);
		
		var languageType = detectLanguage(thisVal);
		console.log("languageType : ", languageType);
		
		var planerVO = {};
		planerVO.memId = memId;
		
		if(languageType == "korean") { // 제목을 검색할 거얌
			planerVO.plTitle = thisVal;
			planerVO.plMsize = "";
		}else if(languageType == "number") { // 인원이얌
			planerVO.plTitle = "";
			planerVO.plMsize = thisVal;
		}else { // 검색어 값을 넘기면 안되요!
			planerVO.plTitle = "";
			planerVO.plMsize = "";
		}
		
		$.ajax({
			type: "get",
			url: "/partner/ajaxSearch.do",
			data: planerVO,
			dataType: "json",
			success: function(res){
				console.log("res : ", res);
				var searchHtml = "";
				if(res.length == 0){
					searchHtml = `
					<article style="text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; border-radius: 4px;">
						검색된 플래너 정보가 없습니다.
					</article>
					`;
				} 
				for(var i=0; i<res.length; i++) {
					if(res[i].stype == "동행참가"){
						console.log("memId : ", memId);
						var dateRes = convertToYYYYMMDD(res[i].plRdate);

						searchHtml += `<li>
											<div class="meetAreaThumbnailCont">`;
						
						if(!res[i].plThumburl) {
							searchHtml += `<img src="/resources/images/testimg/noimg.png" alt="플래너 리스트 썸네일 이미지" />`;
						}else {
							searchHtml += `<img src="${res[i].plThumburl}" alt="플래너 리스트 썸네일 이미지" />`;
						}

						searchHtml += `		</div>
											<div class="meetAreaLists">
												<a href="javascript:void(0);">
													<span class="meetTitle textDrop">
														<span class="badge bg-dark">제목</span>
														${res[i].plTitle}
													</span>
													<span class="meetTheme textDrop">
														<span class="badge bg-dark">테마</span>
														${res[i].plTheme}
													</span>
													<span class="meetMsize textDrop">
														<span class="badge bg-dark">인원</span>
														${res[i].plMsize}명
													</span>
													<span class="meetRdate textDrop">
														<span class="badge bg-dark">등록일자</span>
														${dateRes}
													</span>
													<span class="meetName textDrop">
														<span class="badge bg-dark">그룹장</span>
														${res[i].memName}
													</span>
												</a>
											</div>`;
						if(res[i].memId == memId) {
							searchHtml += `
								<div class="myTripListBtnGroup">
									<form action="/partner/chgStatusPlan.do" method="post" id="chgStatusPlan" name="chgStatusPlan">
										<input type="hidden" value="${res[i].memId }" id="memIdVal" name="memId" />
										<input type="hidden" value="${res[i].plNo }" id="plNoVal" name="plNo" />
										<input type="hidden" value="${res[i].plPrivate }" id="plPrivateVal" name="plPrivate" />
									</form>
									<button type="button" class="btn btn-danger" id="myTripDeleteBtn">일정 삭제</button>`;

							if(res[i].plPrivate == 'N') {
								searchHtml += `<button type="button" class="btn btn-primary myTripPrivatePublicBtn">공개</button>`;
							}else if(res[i].plPrivate == 'Y') {
								searchHtml += `<button type="button" class="btn btn-warning myTripPrivatePublicBtn">비공개</button>`;
							}

							searchHtml += `</div>`;
						}

						searchHtml += `</li>`;
					}
				}

				// 최종 결과 출력
				var plannerInfoContents = $(".meetAreaListCont>ul");
				plannerInfoContents.html(searchHtml);

				// 종횡비 맞추기 함수
				$.eachPlannerInfoImgResizeFn();
				
				// 공개/비공개 함수
				$.myTripPrivatePublicChgFn();
			}
		});
		
	});
};

function detectLanguage(inputValue) {
    // 정규표현식을 사용하여 문자열이 한글인지 영어인지, 숫자인지 판별
    var koreanRegex = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
    var englishRegex = /^[a-zA-Z]*$/;
    var numberRegex = /^[0-9]*$/;

    if (koreanRegex.test(inputValue)) {
        return "korean";
    } else if (englishRegex.test(inputValue)) {
        return "english";
    } else if (numberRegex.test(inputValue)) {
        return "number";
    } else {
        return "etc";
    }
}

function convertToYYYYMMDD(inputDateString) {
	// 입력된 문자열을 Date 객체로 변환
	var inputDate = new Date(inputDateString);
  
	// 날짜 부분만 추출
	var yyyy = inputDate.getFullYear();
	var mm = String(inputDate.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 1을 더하고 2자리로 만듭니다.
	var dd = String(inputDate.getDate()).padStart(2, '0'); // 일자를 2자리로 만듭니다.
  
	// yyyy-MM-dd 형식으로 조합
	var outputDateString = `${yyyy}-${mm}-${dd}`;
  
	return outputDateString;
  }

// 플래너 정보 각각의 이미지 종횡비 변경 함수
$.eachPlannerInfoImgResizeFn = function(){
    $(".meetAreaListCont li").each(function(i, v){
        var thisIs = $(this);
        var infoThumbnailBox = thisIs.find(".meetAreaThumbnailCont");
        var infoThumbnailImg = thisIs.find(".meetAreaThumbnailCont img");
        $.ratioBoxH(infoThumbnailBox, infoThumbnailImg);
    });
};

// 공개/비공개 처리 함수
$.myTripPrivatePublicChgFn = function(){
	var myTripPrivatePublicBtn = $(".myTripPrivatePublicBtn");
	myTripPrivatePublicBtn.click(function(){
		var thisIs = $(this);
		var btnTxtVal = thisIs.text();
		var changeYN = confirm(`플래너를 ${btnTxtVal}하시겠습니까?`);
		if(changeYN) {
			thisIs.parent().find("#chgStatusPlan").submit();
		}
	});
};
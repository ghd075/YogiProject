// 2024.01.26 이건정 커밋점 지정 

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
												<a href="/partner/meetsquare.do?plNo=${res[i].plNo }">
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
									<button type="button" class="btn btn-danger myTripDeleteBtn">일정 삭제</button>`;

							if(res[i].plPrivate == 'N') {
								searchHtml += `<button type="button" class="btn btn-primary myTripPrivatePublicBtn">공개</button>`;
							}else if(res[i].plPrivate == 'Y') {
								searchHtml += `<button type="button" class="btn btn-warning myTripPrivatePublicBtn">비공개</button>`;
							}

							searchHtml += `</div>`;
						}

						if(res[i].memId != memId) {
							searchHtml += `
								<div class="myTripListBtnGroup">
									<form action="/partner/chgStatusJoiner.do" method="post" id="chgStatusJoiner" name="chgStatusJoiner">
										<input type="hidden" value="${res[i].mategroupId}" id="memIdVal" name="memId" />
										<input type="hidden" value="${res[i].plNo}" id="plNoVal" name="plNo" />
									</form>`;

							if(res[i].mategroupApply != 'C'){
								searchHtml += `<button type="button" class="btn btn-info myTripCancelBtn">일정 취소</button>`;
							}
							if(res[i].mategroupApply == 'Y') {
								searchHtml += `<button type="button" class="btn btn-success myTripStatusJoinerBtn">승인</button>`;
							}
							if(res[i].mategroupApply == 'N') {
								searchHtml += `<button type="button" class="btn btn-danger myTripStatusJoinerBtn">거절</button>`;
							}
							if(res[i].mategroupApply == 'W') {
								searchHtml += `<button type="button" class="btn btn-warning myTripStatusJoinerBtn">대기</button>`;
							}
							if(res[i].mategroupApply == 'C') {
								searchHtml += `<button type="button" class="btn btn-secondary myTripStatusJoinerBtn">취소</button>`;
							}

							searchHtml += `
								</div>
							`;
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
				
				// 삭제 처리 함수
				$.myTripDeleteFn();
				
				// 취소 처리 함수
				$.myTripCancelFn();

				// 대기 상태가 W, N, C인 녀석은 못들어오게 막아!
				$.excludeNonUserFn(memId);
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

// 만남의 광장 > 현재 멤버/신청 멤버 각각의 이미지 종횡비 변경 함수
$.eachStartingMemberImgResizeFn = function(){
	var currentMemList = $(".currentMemList");
	var waitMemList = $(".waitMemList");
	currentMemList.each(function(){
		var thisIs = $(this);
		var curChatProfileImgBox = thisIs.find(".chatProfileImgBox");
        var curChatProfileImgBoxImg = thisIs.find(".chatProfileImgBox img");
        $.ratioBoxH(curChatProfileImgBox, curChatProfileImgBoxImg);
	});
	waitMemList.each(function(){
		var thisIs = $(this);
		var waitChatProfileImgBox = thisIs.find(".chatProfileImgBox");
        var waitChatProfileImgBoxImg = thisIs.find(".chatProfileImgBox img");
        $.ratioBoxH(waitChatProfileImgBox, waitChatProfileImgBoxImg);
	});
};

// 만남의 광장 > 채팅 참여 멤버 각각의 이미지 종횡비 변경 함수
$.eachChatingMemberImgResizeFn = function(){
	var outerTalker = $(".outerTalker");
	var innerTalker = $(".innerTalker");
	outerTalker.each(function(){
		var thisIs = $(this);
		var outerTalkerImgBox = thisIs.find(".talkerImgBox");
		var outerTalkerImgBoxImg = thisIs.find(".talkerImgBox img");
		$.ratioBoxH(outerTalkerImgBox, outerTalkerImgBoxImg);
	});
	innerTalker.each(function(){
		var thisIs = $(this);
		var innerTalkerImgBox = thisIs.find(".talkerImgBox");
		var innerTalkerImgBoxImg = thisIs.find(".talkerImgBox img");
		$.ratioBoxH(innerTalkerImgBox, innerTalkerImgBoxImg);
	});
};

// 공개/비공개 처리 함수
$.myTripPrivatePublicChgFn = function(){
	var myTripPrivatePublicBtn = $(".myTripPrivatePublicBtn");
	myTripPrivatePublicBtn.click(function(){

		var thisIs = $(this);
		var btnTxtVal = thisIs.text();
		
		// var changeYN = confirm(`플래너를 ${btnTxtVal}하시겠습니까?`);
		// if(changeYN) {
		// 	thisIs.parent().find("#chgStatusPlan").submit();
		// }
		
		Swal.fire({
			title: "플래너 공개/비공개",
		    text: `플래너를 ${btnTxtVal}하시겠습니까?`,
			icon: "question",
		    showDenyButton: true,
		    confirmButtonText: "예",
		    denyButtonText: "아니오"
		}).then((result) => {
		    if (result.isConfirmed) {
		    	thisIs.parent().find("#chgStatusPlan").submit();
		    } else if (result.isDenied) {
		        Swal.fire({
					title: "플래너 공개/비공개",
					text: "플래너 공개/비공개를 취소합니다.",
					icon: "error"
				});
		    }
		});

	});
};

// 플래너 삭제 처리 함수
$.myTripDeleteFn = function(){
	var myTripDeleteBtn = $(".myTripDeleteBtn");
	myTripDeleteBtn.click(function(){

		var thisIs = $(this);

		// var delYN = confirm("일정을 삭제하시겠습니까?");
		// if(delYN) {
		// 	thisIs.parent().find("#chgStatusPlan").attr("action", "/partner/deletePlan.do");
		// 	thisIs.parent().find("#chgStatusPlan").submit();
		// }

		Swal.fire({
			title: "일정 삭제",
		    text: "일정을 삭제하시겠습니까?",
			icon: "question",
		    showDenyButton: true,
		    confirmButtonText: "예",
		    denyButtonText: "아니오"
		}).then((result) => {
		    if (result.isConfirmed) {
		    	thisIs.parent().find("#chgStatusPlan").attr("action", "/partner/deletePlan.do");
				thisIs.parent().find("#chgStatusPlan").submit();
		    } else if (result.isDenied) {
		        Swal.fire({
					title: "일정 삭제",
					text: "일정 삭제를 취소합니다.",
					icon: "error"
				});
		    }
		});

	});
};

// 탭 버튼 기능
$.myTripChatroomTabbtnFn = function(){
    var chatRoomTabbtnBox = $(".chatRoomTabbtnBox .tabbtn");
    var chatRoomTabcontBox = $(".chatRoomTabcontBox .tabcont");
    chatRoomTabbtnBox.click(function(){
        var thisIs = $(this);
        chatRoomTabbtnBox.removeClass("tactive");
        thisIs.addClass("tactive");
        var idx = thisIs.index();
        chatRoomTabcontBox.hide();
        chatRoomTabcontBox.eq(idx).show();
    });
};

// 모임이름 클릭 > 플래너 상세 페이지 이동
$.meetNameClickEvent = function(plNo){
    var meetName = $("#meetName");
    meetName.click(function(){
        // var thisIs = $(this);
        // var moveYN = confirm("해당 모임의 플래너 상세 페이지로 이동하시겠습니까?");
        // if(moveYN) {
		// 	alert("플래너 상세 페이지로 이동합니다.");
	    // }
        
		Swal.fire({
			title: "페이지 이동",
		    text: "해당 모임의 플래너 상세 페이지로 이동하시겠습니까?",
			icon: "question",
		    showDenyButton: true,
		    confirmButtonText: "예",
		    denyButtonText: "아니오"
		}).then((result) => {
		    if (result.isConfirmed) {
		    	Swal.fire({
					title: "페이지 이동",
					text: "플래너 상세 페이지로 이동합니다.",
					icon: "info"
				}).then((result) => {
				    // 모달이 닫힌 후에 실행될 코드
				    if (result.isConfirmed) {
				        // 확인 버튼이 클릭되었을 때
				        location.href = "/myplan/planDetail.do?plNo=" + plNo;
				    }
				});
		    } else if (result.isDenied) {
		        Swal.fire({
					title: "페이지 이동",
					text: "플래너 상세 페이지 이동을 취소합니다.",
					icon: "error"
				});
		    }
		});
		
    });
};

// 그룹 포인트 > 구매계획 페이지 이동
$.shoppingPlanFn = function(plNo){
    var groupPoint = $("#groupPoint");
    groupPoint.click(function(){
        // var thisIs = $(this);
        // var shoppingYN = confirm("해당 모임의 구매계획 페이지로 이동하시겠습니까?");
        // if(shoppingYN) {
        //    alert("구매계획 페이지로 이동합니다.");
        //    location.href = "/partner/buyPlan.do?plNo=" + plNo;
        // }
        
        Swal.fire({
			title: "페이지 이동",
		    text: "해당 모임의 구매계획 페이지로 이동하시겠습니까?",
			icon: "question",
		    showDenyButton: true,
		    confirmButtonText: "예",
		    denyButtonText: "아니오"
		}).then((result) => {
		    if (result.isConfirmed) {
		    	Swal.fire({
				    title: "페이지 이동",
				    text: "구매계획 페이지로 이동합니다.",
				    icon: "info"
				}).then((result) => {
				    // 모달이 닫힌 후에 실행될 코드
				    if (result.isConfirmed) {
				        // 확인 버튼이 클릭되었을 때
				        location.href = "/partner/buyPlan.do?plNo=" + plNo;
				    }
				});
		    } else if (result.isDenied) {
		        Swal.fire({
					title: "페이지 이동",
					text: "구매계획 페이지 이동을 취소합니다.",
					icon: "error"
				});
		    }
		});
    });
};

// 모집상태 > 모집중 -> 마감 처리 기능
$.groupRecruitEndedFn = function(){
	var meetStatus = $("#meetStatus");
    meetStatus.click(function(){
		var thisIs = $(this);
		var endedStat = thisIs.val();
		console.log("endedStat : ", endedStat);
        // var changeYN = confirm("현재 모집을 마감하시겠습니까?");
        // if(changeYN) {
        //    alert("모집이 마감되었습니다.");
        // }
        
        Swal.fire({
			title: "페이지 이동",
		    text: "현재 모집을 마감하시겠습니까?",
			icon: "question",
		    showDenyButton: true,
		    confirmButtonText: "예",
		    denyButtonText: "아니오"
		}).then((result) => {
		    if (result.isConfirmed) {
		    	if(endedStat == "모집마감") {
		    		Swal.fire({
						title: "모집 마감",
						text: "해당 플랜은 이미 모집 마감되었습니다.",
						icon: "info"
					});
		    	}else if(endedStat == "결제완료"){
		    		Swal.fire({
						title: "결제 완료",
						text: "해당 플랜은 결제가 완료되었습니다. 환불이 불가능합니다.",
						icon: "info"
					});
		    	}else {
					var groupRecruitEnded = $("#groupRecruitEnded");
					groupRecruitEnded.submit();
		    	}
		    } else if (result.isDenied) {
		        Swal.fire({
					title: "모집 마감",
					text: "모집 마감을 취소합니다.",
					icon: "error"
				});
		    }
		});
    });
};

// 채팅방, 멤버 박스 높이 맞추기
$.memBoxEqualChatBoxH = function(){
    var chatRoomLeft = $(".chatRoomLeft");
    var chatRoomRight = $(".chatRoomRight");
    var chatRoomLeftH = chatRoomLeft.outerHeight();
    console.log("chatRoomLeftH : ", chatRoomLeftH);
    var chatRoomRightH = chatRoomRight.outerHeight();
    console.log("chatRoomRightH : ", chatRoomRightH);
    if(chatRoomLeftH < chatRoomRightH) {
        chatRoomLeft.outerHeight(chatRoomRightH);
    }else {
        chatRoomRight.outerHeight(chatRoomLeftH);
    }
};

// 나이 계산 함수
function calculateAge(birthdate) {
  var today = new Date();
  var birthdate = new Date(birthdate);
  var age = today.getFullYear() - birthdate.getFullYear();

  // 생일이 지났는지 체크
  if (today.getMonth() < birthdate.getMonth() || (today.getMonth() == birthdate.getMonth() && today.getDate() < birthdate.getDate())) {
	age--;
  }

  return age;
}

// 나이 계산 함수 실행부
$.ageCalculateFn = function(birth){
	// 나이 계산 및 결과 출력
    var age = calculateAge(birth);
    //console.log("나이: " + age);
    return age;
};

// 대기 상태가 W, N, C인 녀석은 못들어오게 막아!
$.excludeNonUserFn = function(userId){
	var meetAreaListCont = $(".meetAreaLists a");
	meetAreaListCont.click(function(event){
		event.preventDefault();
		var thisIs = $(this);
		var hrefTxt = thisIs.attr("href");
		var splitHrefTxt = hrefTxt.split("=");
		var plNo = splitHrefTxt[1];
		console.log("대기자 id : ", userId);
		console.log("플랜 번호 : ", plNo);
		var planerVO = {
			"memId": userId,
			"plNo": plNo
		};
		$.ajax({
			type: "get",
			url: "/partner/excludeNonUser.do",
			data: planerVO,
			dataType: "json",
			success: function(res){
				console.log("res : ", res);
				console.log("res.mategroupApply : ", res.mategroupApply);
				if(res.mategroupApply == 'W'){
					//alert("현재 플래너 일정 참여 대기중입니다.");
					Swal.fire({
						title: "대기중",
						text: "현재 플래너 일정 참여 대기중입니다.",
						icon: "info"
					});
					return false;
				}
				if(res.mategroupApply == 'N'){
					//alert("현재 플래너 일정에 참가하실 수 없습니다.");
					Swal.fire({
						title: "참가 거절",
						text: "현재 플래너 일정에 참가하실 수 없습니다.",
						icon: "error"
					});
					return false;
				}
				if(res.mategroupApply == "C"){
					//alert("현재 플래너 일정을 취소하셨습니다. 재참여가 불가능합니다.");
					Swal.fire({
						title: "참가 취소",
						text: "현재 플래너 일정을 취소하셨습니다. 재참여가 불가능합니다.",
						icon: "warning"
					});
					return false;
				}
				if(res.mategroupApply == "E"){
					Swal.fire({
						title: "모집 마감",
						text: "현재 플래너 일정이 마감되었습니다. 다른 플랜에 참여를 부탁드립니다.",
						icon: "info"
					});
					return false;
				}
				location.href = hrefTxt;
			}
		});
	});
};

// 채팅방 > 목록으로 돌아가기 기능
$.moveBackListBtnClickFn = function(){
	var moveBackList = $(".moveBackList");
	moveBackList.click(function(){
		location.href = "/partner/mygroup.do";
	});
};

// 신청멤버 > 멤버 승인 기능
$.acceptMemBtnClickFn = function(plNo){
	var acceptMemBtn = $(".acceptMemBtn");
	acceptMemBtn.click(function(){
		var thisIs = $(this);
		var memId = thisIs.parent().prev().text();
		console.log("memId : ", memId);
		console.log("plNo : ", plNo);

		var rejectObj = {
			"url" : "/partner/acceptMem.do",
			"message" : "해당 멤버의 신청이 승인되었습니다."
		};

		var planerVO = {
			"memId": memId,
			"plNo": plNo
		};
		
		$.ajaxMemBtnClickFn(planerVO, rejectObj);
	});
};

// 신청멤버 > 멤버 거절 기능
$.rejectMemBtnClickFn = function(plNo){
	var rejectMemBtn = $(".rejectMemBtn");
	rejectMemBtn.click(function(){
		var thisIs = $(this);
		var memId = thisIs.parent().prev().text();
		console.log("memId : ", memId);
		console.log("plNo : ", plNo);

		var rejectObj = {
			"url" : "/partner/rejectMem.do",
			"message" : "해당 멤버의 신청이 거절되었습니다."
		};

		var planerVO = {
			"memId": memId,
			"plNo": plNo
		};
		
		$.ajaxMemBtnClickFn(planerVO, rejectObj);
	});
};

// 강퇴 기능
$.kickOutFn = function(plNo){
    var kickoutEl = $(".currentMemList li:not(:first-of-type):not(:nth-of-type(2))");
    kickoutEl.click(function(){
        var thisIs = $(this);
        var kickOutId = thisIs.find("span:nth-of-type(4)").text();
        console.log("kickOutId : " + kickOutId);
        var kickOutName = thisIs.find("span:first-of-type").text().trim();
        console.log("kickOutName : " + kickOutName);
        
        // var kickYN = confirm(kickOutName + "님을 강퇴하시겠습니까?");
        // if(kickYN) {
		// 	var memId = thisIs.children().eq(3).text();
		// 	console.log("memId : ", memId);
		// 	console.log("plNo : ", plNo);

		// 	var rejectObj = {
		// 		"url" : "/partner/rejectMem.do",
		// 		"message" : kickOutName + "님이 강퇴되었습니다."
		// 	};
	
		// 	var planerVO = {
		// 		"memId": memId,
		// 		"plNo": plNo
		// 	};
			
		// 	$.ajaxMemBtnClickFn(planerVO, rejectObj);
        // }
        
        Swal.fire({
		    title: kickOutName + "님을 강퇴하시겠습니까?",
		    showDenyButton: true,
		    confirmButtonText: "예",
		    denyButtonText: "아니오"
		}).then((result) => {
		    if (result.isConfirmed) {

				var memId = thisIs.children().eq(3).text();
				console.log("memId : ", memId);
				console.log("plNo : ", plNo);

				var rejectObj = {
					"url" : "/partner/rejectMem.do",
					"message" : kickOutName + "님이 강퇴되었습니다."
				};
		
				var planerVO = {
					"memId": memId,
					"plNo": plNo
				};
				
				$.ajaxMemBtnClickFn(planerVO, rejectObj);

		    } else if (result.isDenied) {

		        Swal.fire({
					title: "채팅방 강퇴",
					text: kickOutName + "님이 강퇴를 취소합니다.",
					icon: "error"
				});

		    }
		});

    });
};

// ajax > 멤버 승인/거절 공통 함수
$.ajaxMemBtnClickFn = function(planerVO, {url, message}){
	$.ajax({
		type: "get",
		url: url,
		data: planerVO,
		dataType: "json",
		success: function(res){
			console.log("res : ", res);

			// var recruiter = res.recruiter;
			// var mateList = res.mateList;
			var mateCnt = res.mateCnt;

			// // 현재 멤버 리스트 시작
			// var currentMemListHtmlTxt = `
			// 	<li>
			// 		<span>이름</span>
			// 		<span>성별</span>
			// 		<span>나이</span>
			// 		<span>ID</span>
			// 		<span>결제여부</span>
			// 	</li>
			// `;

			// if(Object.keys(recruiter).length === 0){ // 플래너가 없는 경우
			// 	currentMemListHtmlTxt += `
			// 		<div style="text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; border-radius: 4px;">
			// 			현재 플래너가 없습니다.
			// 		</div>
			// 	`;
			// }else {
			// 	// 플래너 리스트
			// 	var recruiterHtmlTxt = `
			// 		<li>
			// 			<span class="textDrop">
			// 				<i class="fas fa-crown"></i>
			// 				<span class="chatProfileImgBox">
			// 					<img src="${recruiter.memProfileimg }" alt="프로필 이미지" />
			// 				</span>
			// 				${recruiter.memName }(플래너)
			// 				<i class="fas fa-circle"></i>
			// 			</span>
			// 			<span>`;

			// 			if(recruiter.memGender == "M") {
			// 				recruiterHtmlTxt += `남자`;
			// 			}else if(recruiter.memGender == "F") {
			// 				recruiterHtmlTxt += `여자`;
			// 			}

			// 	recruiterHtmlTxt += `
			// 			</span>
			// 			<span class="recruitAge">00세</span>
			// 			<span class="textDrop">${recruiter.memId }</span>
			// 			<span>`;

			// 			if(recruiter.mategroupAgree == 0) {
			// 				recruiterHtmlTxt += `차감 전`;
			// 			}else if(recruiter.mategroupAgree == 1) {
			// 				recruiterHtmlTxt += `차감 완료`;
			// 			}else if(recruiter.mategroupAgree == 2) {
			// 				recruiterHtmlTxt += `결제 완료`;
			// 			}

			// 	recruiterHtmlTxt += `
			// 			</span>
			// 		</li>
			// 	`;

			// 	// 현재 리스트에 플래너 리스트를 먼저 붙이고 시작한다.
			// 	currentMemListHtmlTxt += recruiterHtmlTxt;
			// }

			// if(mateList.length == 0) {
			// 	currentMemListHtmlTxt += `
			// 		<div style="text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; border-radius: 4px;">
			// 			현재 멤버가 없습니다.
			// 		</div>
			// 	`;
			// }

			// for(var i=0; i<mateList.length; i++) {
			// 	if(mateList[i].mategroupApply == 'Y') { // 현재 멤버로 업데이트 된 녀석만 가져와서 반복문 돌릴거임
			// 		currentMemListHtmlTxt += `
			// 			<li class="textDropVerticalAlign">
			// 				<span class="textDrop">
			// 					<span class="chatProfileImgBox">
			// 						<img src="${mateList[i].memProfileimg }" alt="프로필 이미지" />
			// 					</span>
			// 					${mateList[i].memName }
			// 					<i class="fas fa-circle"></i>
			// 				</span>
			// 				<span>`;

			// 			if(mateList[i].memGender == 'M') {
			// 				currentMemListHtmlTxt += `남자`;
			// 			}else if(mateList[i].memGender == 'F') {
			// 				currentMemListHtmlTxt += `여자`;
			// 			}

			// 		currentMemListHtmlTxt +=`
			// 				</span>
			// 				<span id="lgj${i}">00세</span>
			// 				<span class="textDrop">${mateList[i].memId }</span>
			// 				<span>`;
							
			// 			if(mateList[i].mategroupAgree == 0) {
			// 				currentMemListHtmlTxt += `차감 전`;
			// 			}else if(mateList[i].mategroupAgree == 1) {
			// 				currentMemListHtmlTxt += `차감 완료`;
			// 			}else if(mateList[i].mategroupAgree == 2) {
			// 				currentMemListHtmlTxt += `결제 완료`;
			// 			}

			// 		currentMemListHtmlTxt +=`
			// 				</span>
			// 			</li>
			// 		`;
			// 	}
			// }

			// // 신청 멤버 리스트 시작
			// var waitMemListHtmlTxt = `
			// 	<li>
			// 		<span>이름</span>
			// 		<span>성별</span>
			// 		<span>나이</span>
			// 		<span>ID</span>
			// 		<span>승인/거절</span>
			// 	</li>
			// `;

			// for(var i=0; i<mateList.length; i++) {
			// 	if(mateList[i].mategroupApply == 'W'){ // 대기 중인 멤버만 가져와서 반복문 돌릴거임
			// 		waitMemListHtmlTxt += `
			// 			<li class="textDropVerticalAlign memChk">
			// 				<span class="textDrop">
			// 					<span class="chatProfileImgBox">
			// 						<img src="${mateList[i].memProfileimg }" alt="프로필 이미지" />
			// 					</span>
			// 					${mateList[i].memName }
			// 					<i class="fas fa-circle"></i>
			// 				</span>
			// 				<span>`;

			// 			if(mateList[i].memGender == 'M') {
			// 				waitMemListHtmlTxt += `남자`;
			// 			}else if(mateList[i].memGender == 'F') {
			// 				waitMemListHtmlTxt += `여자`;
			// 			}

			// 		waitMemListHtmlTxt +=`
			// 				</span>
			// 				<span id="lgj${i}">00세</span>
			// 				<span class="textDrop findId">${mateList[i].memId }</span>
			// 				<span>
			// 					<button class="btn btn-success acceptMemBtn" type="button">승인</button>
			// 					<button class="btn btn-danger rejectMemBtn" type="button">거절</button>
			// 				</span>
			// 			</li>
			// 		`;
			// 	}
			// }

			// // 현재 멤버 리스트 갱신
			// var currentMemList = $(".currentMemList");
			// currentMemList.html(currentMemListHtmlTxt);

			// // 신청 멤버 리스트 갱신
			// var waitMemList = $(".waitMemList");
			// waitMemList.html(waitMemListHtmlTxt);

			// // 플래너 나이 계산
			// var recruiterAgeDate = recruiter.memAgedate;
			// var recruiterCalcAgeTxt = $.ageCalculateFn(recruiterAgeDate);
			// console.log("ajax > recruiterCalcAgeTxt : ", recruiterCalcAgeTxt);
			// $(".recruitAge").html(recruiterCalcAgeTxt + "세");

			// // 참여자 나이 계산(현재멤버)
			// for(var i=0; i<mateList.length; i++) {
			// 	if(mateList[i].mategroupApply == 'Y') {
			// 		console.log("mateList[i].memAgedate : ", mateList[i].memAgedate);
			// 		$("#lgj" + i).html(`${$.ageCalculateFn(mateList[i].memAgedate)}세`);
			// 	}
			// }

			// // 참여자 나이 계산(신청멤버)
			// for(var i=0; i<mateList.length; i++) {
			// 	if(mateList[i].mategroupApply == 'W') {
			// 		console.log("mateList[i].memAgedate : ", mateList[i].memAgedate);
			// 		$("#lgj" + i).html(`${$.ageCalculateFn(mateList[i].memAgedate)}세`);
			// 	}
			// }
			
			// // 신청멤버 > 멤버 승인 기능
			// $.acceptMemBtnClickFn();

			// // 신청멤버 > 멤버 거절 기능
			// $.rejectMemBtnClickFn();

			// 화면 재 갱신
			var encodedMessage = encodeURIComponent(message);
			location.href = "/partner/meetsquare.do?plNo=" + planerVO.plNo + "&message=" + encodedMessage + "&mateCnt=" + mateCnt;
		}
	});
};

// 플래너 리스트 > 일정 취소 처리 함수
$.myTripCancelFn = function(){
	var myTripCancelBtn = $(".myTripCancelBtn");
	myTripCancelBtn.click(function(){

		// var thisIs = $(this);
		// var cancleYN = confirm("플래너 일정을 취소하시겠습니까?");
		// if(cancleYN) {
		// 	thisIs.parent().find("#chgStatusJoiner").submit();
		// }

		var thisIs = $(this);
		Swal.fire({
		    title: "플래너 일정을 취소하시겠습니까?",
		    showDenyButton: true,
		    confirmButtonText: "예",
		    denyButtonText: "아니오"
		}).then((result) => {
		    if (result.isConfirmed) {
				thisIs.parent().find("#chgStatusJoiner").submit();
		    } else if (result.isDenied) {
		        Swal.fire({
					title: "일정 유지",
					text: kickOutName + "님이 일정을 유지합니다.",
					icon: "info"
				});
		    }
		});

	});
};

// 채팅 기능
$.chatingFn = function(roomNo, {chatMemId, chatMemName, chatMemProfileimg}){
	var webSocket; // 페이지가 바뀌지 않도록 주의!
	var chatRoomContents = $(".chatRoomContents"); // 채팅방 > 채팅 표출 영역 EL
	var chatInputMsg = $(".chatInputMsg"); // 채팅입력 EL
	var sendChatMessage = $(".sendChatMessage"); // 전송버튼 EL
	var moveBackList = $(".moveBackList"); // 목록으로 돌아가기 버튼 EL
	
	var endpoint = "/chat";
	
	// 공통 함수 선언
	function connect(){
		webSocket = new SockJS(endpoint); // 엔드 포인트
		
		webSocket.onopen = function(event) {
			console.log("WebSocket connection opened:", event);
			var enterUser = `
				<div class="memberInLog">
					<p style="display: inline-block;">
						${chatMemName} 님이 입장하셨습니다.
						</p>
					<span class="inFlag" style="display: none;">in</span>
				</div>
				,0
			`;
			webSocket.send(enterUser); // 기존 chatOpen 함수와 합침
		};
		
		webSocket.onmessage = function(event) {
			console.log("WebSocket message received:", event.data);
			chatMessage(event, chatMemId); // event 매개변수를 chatMessage 함수에 전달
		};
		
		webSocket.onclose = function(event) {
			console.log("WebSocket connection closed:", event);
		};
		
		webSocket.onerror = function(event) {
			console.error("WebSocket error:", event);
		};
	}

	// 연결시 실행되는 함수
	var parseHtmlConvert;
	function chatMessage(event, id){ // event 매개변수 추가
		var data = event.data;
		var chatRoomContentsTxt = chatRoomContents.html();
		chatRoomContents.html(chatRoomContentsTxt + "" + data);
		
		// 채팅방 채팅 내역, 날짜 박스 크기 같게 조절하기
		$.chatBoxEqualDateBoxFn();
		
		// 채팅사진 종횡비
		$.eachChatingMemberImgResizeFn();

		/*
			받아야 하는 파라미터 값 정리
			1. memId (0)
			2. roomNo (0)
			3. chatFile : null 허용, empty 텍스트 넣기
			4. chatContent (0)
			4. chatYmd (0)
			5. chatHms (0)
			6. chatCnt (0)
		*/

		// html 객체로 변환
		parseHtmlConvert = $.parseHTML(data);
		console.log("parseHtmlConvert : ", parseHtmlConvert);

		// dataHtmlConvert는 배열이므로 첫 번째 요소에 대해 jQuery 객체로 변환
		var dataHtmlConvert = $(parseHtmlConvert[0]);
		console.log("dataHtmlConvert : ", dataHtmlConvert);
		var memberInLog = dataHtmlConvert.find(".inFlag").text();
		console.log("memberInLog : ", memberInLog);
		var memberOutLog = dataHtmlConvert.find(".outFlag").text();
		console.log("memberOutLog : ", memberOutLog);

		// 객체 안에 담긴 요소를 뽑아서 변수에 담기
		var chatMemId = dataHtmlConvert.find(".sendMemId").text();
		console.log("chatMemId : ", chatMemId);
		var chatMsgTxt = dataHtmlConvert.find(".chatMsgTxt").text();
		console.log("chatMsgTxt : ", chatMsgTxt);
		var yymmdd = dataHtmlConvert.find(".yymmdd").text();
		console.log("yymmdd : ", yymmdd);
		var hhmmss = dataHtmlConvert.find(".hhmmss").text();
		console.log("hhmmss : ", hhmmss);
		var myChatCnt = dataHtmlConvert.find(".myChatCnt").text();
		console.log("myChatCnt : ", myChatCnt);
		
		// 메시지 전송할 때 안에 들어 있는 값을 객체로 말아서 파라미터 값 전달
		var chatroomVO = {
			"memId" : chatMemId,
			"roomNo" : roomNo,
			"chatFile" : "empty",
			"chatContent" : chatMsgTxt,
			"chatYmd" : yymmdd,
			"chatHms" : hhmmss,
			"chatCnt" : myChatCnt
		};

		// 현재 로그인한 멤버와 채팅 멤버가 다르다면 1번만 쳐라!
		if(id == chatMemId){
			// 채팅방 입장, 퇴장시에는 예외 처리
			if (!memberInLog && !memberOutLog) {
				// ajax > 채팅 내역 저장
				$.ajaxChatContSaveFn(chatroomVO);
			}
		}
	}

	// ajax > 채팅 내역 저장
	$.ajaxChatContSaveFn = function(chatroomVO){
		$.ajax({
			type : "post",
			url : "/partner/ajaxChatInsert.do",
			data : chatroomVO,
			dataType : "text",
			success : function(res){
				console.log("res : ", res);
			}
		});
	};

	// 채팅 입력시 실행되는 함수
	var cnt = 0; // 현재 내가 채팅을 날린 '총 횟수'
	function send({senderMemId, senderMemName, senderMemProfileimg}){
		cnt++;
		var msg = chatInputMsg.val().trim();
		console.log("msg : ", msg);
		
		if(msg == "") {
			alert("채팅 메시지를 입력 후 전송해 주세요.");
			chatInputMsg.val("");
			return false;
		}
		
		console.log("senderMemId : ", senderMemId);
		console.log("senderMemName : ", senderMemName);
		console.log("senderMemProfileimg : ", senderMemProfileimg);

		if(!senderMemId) {
			senderMemId = "empty";
		}
		if(!senderMemName) {
			senderMemName = "empty";
		}
		if(!senderMemProfileimg) {
			senderMemProfileimg = "empty";
		}
		
		var innerTalkerMsgTxt = `${msg},${cnt},${senderMemId},${senderMemName},${senderMemProfileimg}`;
		webSocket.send(innerTalkerMsgTxt);
		chatInputMsg.val("");
		
		// 메시지 전송 후 채팅 영역 최하단으로 스크롤
    	scrollToBottom();
	}
	
	// 스크롤을 최하단으로 이동하는 함수
	function scrollToBottom(){
	    // .chatRoomContents 요소의 스크롤을 최하단으로 이동
		var scrollHeight = chatRoomContents.prop("scrollHeight");
		console.log("chatRoomContents/scrollHeight : ", scrollHeight);
		chatRoomContents.scrollTop(scrollHeight);
	}
	
	// 채팅방을 나갈 시 실행되는 함수
	function disconnect(){
		var leaveUser = `
				<div class="memberOutLog">
					<p style="display: inline-block;">
						${chatMemName} 님이 퇴장하셨습니다.
					</p>
					<span class="outFlag" style="display: none;">out</span>
				</div>
				,0
			`;
		webSocket.send(leaveUser);
		webSocket.close();
	}

	// 연결
	connect();

	// 전역 변수 선언
	var senderObj = {
		senderMemId: chatMemId,
		senderMemName: chatMemName,
		senderMemProfileimg: chatMemProfileimg
	};

	// 이벤트 핸들러 선언
	sendChatMessage.click(function(){
		send(senderObj);
	});
	
	// 뒤로 돌아가기 버튼 클릭 시 채팅 웹 소켓 종료
	moveBackList.click(function(){
		disconnect();
	});
	
	// 페이지를 떠날 때 웹 소켓 종료
	$(window).on('unload', function() {
	    disconnect();
	});
	
	// 다른 페이지로 이동할 때 웹 소켓 종료
	$(window).on('beforeunload', function() {
	    disconnect();
	});
	
	// 엔터키 입력시 채팅 전송
	$(".chatInputMsg").keyup(function(e){
	    // 엔터키 : 13
	    if(e.keyCode == 13) {
	        if (e.shiftKey) {
	            // 만약 Shift 키와 함께 Enter 키가 눌렸다면, 새로운 줄 문자를 입력값에 추가합니다.
	            $(this).val(function(i, val) {
	                return val;
	            });
	        } else {
	            // 만약 Enter 키만 눌렸다면, click 이벤트를 트리거합니다.
	            sendChatMessage.trigger("click");
	        }
	    }
	});
	
	// 시작하자 마자 스크롤 하단으로 이동
	scrollToBottom();
	
};

// 채팅방, 멤버 박스 높이 맞추기
$.memBoxEqualChatBoxH = function(){
    var chatRoomLeft = $(".chatRoomLeft");
    var chatRoomRight = $(".chatRoomRight");
    var chatRoomLeftH = chatRoomLeft.outerHeight();
    var chatRoomRightH = chatRoomRight.outerHeight();
    if(chatRoomLeftH < chatRoomRightH) {
        chatRoomLeft.outerHeight(chatRoomRightH);
    }else {
        chatRoomRight.outerHeight(chatRoomLeftH);
    }
};

// 채팅방 채팅 내역, 날짜 박스 크기 같게 조절하기
function eachCompareBoxHFn(eachEl){
    eachEl.each(function(){
        var thisIs = $(this);
        var thisCompareEl1 = thisIs.find("p");
        var thisCompareEl2 = thisIs.find(".chatDateInfo");
        var thisCompareElOutH1 = thisCompareEl1.outerHeight();
        var thisCompareElOutH2 = thisCompareEl2.outerHeight();
        if(thisCompareElOutH1 > thisCompareElOutH2) {
            thisCompareEl2.outerHeight(thisCompareElOutH1);
        }else {
            thisCompareEl1.outerHeight(thisCompareElOutH2);
        }
    });
}

$.chatBoxEqualDateBoxFn = function(){
    var outerStartDialog = $(".outerStartDialog");
    eachCompareBoxHFn(outerStartDialog);
    
    var outerLongtakeDialog = $(".outerLongtakeDialog");
    eachCompareBoxHFn(outerLongtakeDialog);
    
    var innerStartDialog = $(".innerStartDialog");
    eachCompareBoxHFn(innerStartDialog);
    
    var innerLongtakeDialog = $(".innerLongtakeDialog");
    eachCompareBoxHFn(innerLongtakeDialog);
};




// 찬섭 채팅 저장 추가

/* sweetAlert 유틸  */
$.sweetAlertFn = function(title, text, icon) {
	return Swal.fire({
		title: title,
		text: text,
		icon: icon,
		confirmButtonText : "확인"
	})
}

$.sweetAlertConfirmFn = function(title, html, icon) {
	return Swal.fire({
		title: title,
		html: html,
		icon: icon,
		showDenyButton: true,
		confirmButtonText: "예",
		denyButtonText: "아니오",
	})
}


/* 사용할 ajax 함수 정의 */
// 채팅 다운로드 ajax
$.chatContTxtDownAjax = function(plNo) {
	return new Promise((resolve) => {
		$.ajax({
			type: "GET",
			url: "/partner/chatContTxtDown.do",
			data: { plNo: plNo },
			success: function(data) {
				// console.log("data", data);
				if(data == null || data == "") {
					$.sweetAlertFn("채팅내역 저장", "저장할 채팅 내역이 없습니다.", "error");
				} else {
					// 다운로드 링크 생성 및 클릭
					var blob = new Blob([data], { type: 'text/plain' });
					var link = document.createElement('a');
					link.href = window.URL.createObjectURL(blob);
					link.download = "Chat_Log_" + new Date().toISOString().replace(/[:.]/g, "_") + ".txt";
					document.body.appendChild(link);
					link.click();
					document.body.removeChild(link);
				}
				resolve(data);
			}
		});
	});
};

// 채팅 삭제 ajax
$.chatContDeleteAjax = function(plNo) {
	return new Promise((resolve) => {
		$.ajax({
			type: "GET",
			url: "/partner/chatContDelete.do",
			data: { plNo: plNo },
			success: function(data) {
				
				if(data.delRes === "success") {
					$.sweetAlertFn("이전 채팅 삭제", "이전 날짜의 채팅을 삭제하였습니다.", "success").then((result) => {
						if(result.isConfirmed) {
							location.href = "/partner/meetsquare.do?plNo=" + plNo;
						}
					});
				} else {
					$.sweetAlertFn("이전 채팅 삭제", "오늘 날짜 이전의 채팅내역이 존재하지 않아 삭제에 실패하였습니다.", "error")
				}
				resolve(data);
			}
		});
	});
};

/* 실제 로직 */

// 채팅내역 버튼을 클릭해서 채팅 다운로드
$.chatContTxtDownFn = function(plNo) {
	let chatContTxtDownEl = $(".chatContTxtDown");
	chatContTxtDownEl.on("click", function() {
		$.chatContTxtDownAjax(plNo)
	});
};

// 이전 채팅 삭제 버튼을 클릭해서 채팅 삭제
$.chatContDeleteFn = function(plNo) {
	let chatContDeleteEl = $(".chatContDelete");
	
	chatContDeleteEl.on("click", function() {
		$.sweetAlertConfirmFn("이전 채팅 삭제", "오늘 날짜보다 이전의 채팅을 삭제하시겠습니까?", "question")
			.then((result) => {

			// 위의 sweetAlertConfirmFn 결과가 '예'라면 채팅을 저장할지를 다시 묻는다. (아니오라면 아무일도 안 일어남)
			if (result.isConfirmed) {
				$.sweetAlertConfirmFn("채팅내역 저장", "지금까지의 채팅을 저장하시겠습니까?", "question")
					.then((result) => {

					// 위의 sweetAlertConfirmFn 결과가 '예'라면
					if(result.isConfirmed) {

						// 채팅을 저장하고,
						$.chatContTxtDownAjax(plNo).then((result) => {

							// 채팅을 삭제한다
							$.chatContDeleteAjax(plNo);
						});

					// sweetAlertConfirmFn 결과가 '아니오'라면 그냥 삭제
					} else if (result.isDenied) {
						$.chatContDeleteAjax(plNo);
					}
				});
			} 
		});
	});
}

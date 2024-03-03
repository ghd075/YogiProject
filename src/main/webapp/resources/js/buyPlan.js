let yesAllGmDeducted = false;       // 모든 그룹멤버들이 차감을 했는가
let isPurchasingConfirmed = false;  // 구매가 확정되었는지에 대한 플래그
let appendFlg = false;              // 모달창이 열렸을때 포인트 충전버튼을 append로 처리했으므로 한번 append 되었으면 또다시 append되지 못하게 함
let curMemList = [];
let pointDeductingCompletedFlg = false;
$.getAllMemAjaxFn = function() {
  $.ajax({
    url: '/partner/getAllMembers.do',
    data: {"plNo" : plNo},
    type:"get",
    success: function(result) {
      console.log("curMem", result);
      for(let i = 0; i < result.length; i++) {
        curMemList.push(result[i].memId);
      }
      curMemList.push(pMem);
      console.log("curMemList", curMemList);
    }
  });
}

// 알림 저장 컴포넌트
$.ajaxBpRtAlertSaveFn = function(rtAlert) {
  console.log("어떻게 가길래??", rtAlert);

  $.ajax({
    type : "post",
    url : "/partner/alertSaveForBuyPlanPage.do",
    data : rtAlert,
    dataType : "text",
    success : function(res){
        //console.log("ajaxAllMemberRtAlertSaveFn > res : ", res);
    }
  });
}

/* 플래그 체크 */
// 그룹원 전원 포인트 차감 여부
// 멤버들의 mategroup_agree상태가 모두 1인지를 체크하는 과정
$.isAllGmdeductedFn = function() {
  
  // 모든 그룹회원들이 차감했는가
  let isAllGmDeducted = parseInt($(".isAllGmDeductedHidden").val());  // mategroup_agree == 1?
  let curNum = parseInt($(".curNum").text());                         // 현재원

  if(isAllGmDeducted == curNum) { // 모든 그룹원들이 포인트 차감을 완료함
    yesAllGmDeducted = true;
  }

}

// 결제확정을 이미 했는가? 여부
$.isConfirmedPurchasingFn = function() {
  let confirmPurchasingStep = $(".confirmPurchasingStepHidden").val();
  if(confirmPurchasingStep === "3단계") {
    // console.log("3단계야", confirmPurchasingStep);
    isPurchasingConfirmed = true;
    $(".purchaseConfirmedBtn").removeClass("right").addClass("left");
    $(".purchaseConfirmedBtn").text("결제확정 완료");
  } else {
    // console.log("3단계가 아니야", confirmPurchasingStep);
    isPurchasingConfirmed = false;
  }
}


/* 버튼 이벤트 */
// 그룹 페이지로 이동 버튼 이벤트
$("#goToGroupPageBtn").on("click", function() {
  Swal.fire({
      title: "페이지 이동",
      text: "그룹 페이지로 이동하시겠습니까?",
      icon: "question",
      showDenyButton: true,
      confirmButtonText: "예",
      denyButtonText: "아니오"
  }).then((result) => {
      // yes
      if (result.isConfirmed) {
          Swal.fire({
            title: "페이지 이동",
            text: "그룹 페이지로 이동합니다.",
            icon: "info"
        }).then((result) => {
            if (result.isConfirmed) {
                location.href = "/partner/meetsquare.do?plNo=" + plNo;
            }
        });
      // no
      } else if (result.isDenied) {
          Swal.fire({
            title: "페이지 이동",
            text: "페이지 이동을 취소합니다.",
            icon: "error"
        });
      }
  });
});


// 그룹플랜 일자 변경 이벤트
$(".customBadge").on("click", function() {
    let thisIs = $(this);
    console.log("thisIs", thisIs);
    let selectedDay = thisIs.data("selday");
    
    console.log("selectedDay" + selectedDay);
  
    thisIs.addClass('active').siblings().removeClass('active');
  
    if(selectedDay != 0) {
      $(".dayAll").hide();
    }

    for(let i = 0; i < 5; i++) {
      $(".day"+(i+1)).hide();
    }
    
    if(selectedDay == 0) {
      $(".dayAll").show();
    }
  
    if(selectedDay > 0) {
      $(".day"+selectedDay).show();
    }

});
	
// 포인트 차감 콜백함수
function resultDeducting(obj) {
  console.log(typeof obj.groupPoint);
  $.ajax({
    data : {"quota": obj.quota,
            "plNo" : plNo,
            "groupPoint" : obj.groupPoint},
    type : "post",
    url : "/partner/deductPoint.do",
    success : function(result) {
      console.log("resultresultresult", result);
      if(result.serviceResult === "OK" && result.allCompleted === "N") {
        $.gmDeductedAlarmFn("N");
        sweetAlertFn("포인트 차감", "포인트 차감이 완료되었습니다.", "success").then((result) => {
          pointDeductingCompletedFlg = true;
          $(".deductProcessingModalContents").hide();
          // location.href="/partner/buyPlan.do?plNo=" + plNo;
        });
      } else if(result.serviceResult === "OK" && result.allCompleted === "Y") {
        $.gmDeductedAlarmFn("Y");
        sweetAlertFn("포인트 차감", "포인트 차감이 완료되었습니다.", "success").then((result) => {
          pointDeductingCompletedFlg = true;
          $(".deductProcessingModalContents").hide();
          //location.href="/partner/buyPlan.do?plNo=" + plNo;
        });
      } else {
        sweetAlertFn("포인트 차감", "다시 시도해주세요", "error");
      }
    }
  })
  
}

// 포인트 차감 알림 함수
$.gmDeductedAlarmFn = function(result) {  // result ? 모두 포인트 차감했는지 여부. Y면 다 차감했으므로 마지막으로 차감하는 사람이 된다. 따라서 메세지를 다르게 준다.
    // 실시간 알림 기능
    var realrecIdArr; // 모든 유저를 대상으로 알림
    
    realrecIdArr = [];
    realrecIdArr.push(pMem); 
  
    var realsenId = memObj.memId; // 발신자 아이디
    var realsenName = memObj.memName; // 발신자 이름
    var realsenTitle = "차감요청"; // 실시간 알림 제목
    var realsenContent = "";
    if(result === "N") {
      realsenContent = realsenName + "님이 '"+pTitle+"' 플랜에 대해 포인트 차감을 완료하셨습니다."; // 실시간 알림 내용
    } else {
      realsenContent = realsenName + "님이 '"+pTitle+"' 플랜에 대해 포인트 차감을 완료하여 모든 회원들이 포인트 차감을 완료했습니다."; // 실시간 알림 내용
    }
    var realsenType = "buyPlan"; // 그룹 장바구니 타입 알림
    var realsenReadyn = "N"; // 안 읽음
    var realsenUrl = "/partner/buyPlan.do?plNo=" + plNo + "&stay=true"; // 그룹 장바구니 페이지로 이동
    
    var dbSaveFlag = false; // db에 저장
    var userImgSrc = memObj.memProfileimg; // 유저 프로파일 이미지 정보
    var realrecNo = "empty";
    
    var rtAlert = {
      "realrecIdArr": realrecIdArr,
      "realsenId": realsenId,
      "realsenName": realsenName,
      "realsenTitle": realsenTitle,
      "realsenContent": realsenContent,
      "realsenType": realsenType,
      "realsenReadyn": realsenReadyn,
      "realsenUrl": realsenUrl,
      "realsenPfimg": userImgSrc
    };
    console.log("알림 저장 > rtAlert : ", rtAlert);
    
    //$.realTimeAlertWebSocketFn(rtAlert, dbSaveFlag, userImgSrc, realrecNo);
    if(ws){
      let socketMsg = `${realrecIdArr},${realsenId},${realsenName},${realsenTitle},${realsenContent},${realsenType},${realsenReadyn},${realsenUrl},${userImgSrc}`;
      console.log(socketMsg);
      console.log("보낼게요");
      ws.send(socketMsg);
    }
    $.ajaxBpRtAlertSaveFn(rtAlert);
}


/* 유틸 */
/* sweetAlert */
function sweetAlertFn(msg, text, icon){
  return Swal.fire({
    title: msg,
    text: text,
    icon: icon
  });
}

function sweetConfirmFn(msg, text, callbackFn, args){
  return Swal.fire({
    title: msg,
    text: text,
    showCancelButton: true,
    confirmButtonText: "예",
    cancelButtonText: "아니오"
  }).then((result) => {
    if (result.isConfirmed) {
      callbackFn(args);
    }
  });
}

// 숫자 표기 방식 변경 함수(#,###)
function numberWithCommas(x) {
  if(!x) return 0;
  return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}



/* 모달창 관련 */
// 모달창 이벤트
$.dedeuctModalFn = function () {
  var deductProcessingModalContents = $(".deductProcessingModalContents");
  deductProcessingModalContents.hide();

  // 그룹장이 그룹원들에게 포인트 차감을 요청하는 모달창
  let requestDeductingModal = $(".requestDeductingModal");

  // 그룹장 + 그룹원이 포인트를 차감하는 모달창
  let deductPointModal = $(".deductPointModal");

  // 처음에는 둘다 가려요
  requestDeductingModal.hide();
  deductPointModal.hide();

  // 모달창 열기
  var deductBtnForGm = $(".deductBtnForGm");
  deductBtnForGm.click(function () {
    
    // 상품이 없으면 모달창이 안 열려요
    if($(".noItems").val() === "true") {
      Swal.fire({
        text: "상품이 없습니다.",
        icon: "info"
      }).then((result) => {
        return;
      });
    }

    requestDeductingModal.hide();
    deductPointModal.show();

    // 모달창이 열리면 포인트 차감 프로세스가 시작
    $.deductPointFn();
  });


  /* 차감 요청 */

  // 차감요청버튼 이벤트
  var deductBtn = $(".deductBtn");
  deductBtn.click(function () {
    // 상품이 등록되지 않았으면 차감 요청이 불가능
    if($(".noItems").val() === "true") {
      Swal.fire({
        text: "상품이 없습니다.",
        icon: "info"
      }).then((result) => {
        return;
      });
    // 상품이 등록되었으면 차감요청을 시작
    } else {
      deductPointModal.hide();

      // 그룹장인 나빼고 다른 회원들 리스트
      $.ajax({
        url:"/partner/getAllMembers.do",
        data:{"plNo": plNo},
        type:"get",
        success: function(result) {
          if(result == null || result == "") {
            Swal.fire({
              title: "페이지 이동",
              text: "회원이 존재하지 않습니다.",
              icon: "info"
            }).then((result) => {
              return;
            });
          }

          // 멤버리스트 결과를 가지고 모달창에 뿌려주는 함수 호출
          requestDeductList(result);

          // 모달 안의 그룹원용 포인트 차감을 위한 버튼들은 숨겨준다.
          $(".deductPointBtn").hide();
          $(".goToPointStore").hide();

          // 일괄 차감요청 버튼을 보여준다.
          $(".requestDeductingToAllMemsBtn").show();

          // 차감요청을 위한 모달창
          requestDeductingModal.show();

          // 모달창 sectio show
          deductProcessingModalContents.show();
          // console.log("resultgetAllMembers", result);

          // 모달창이 열리면 차감요청 프로세스가 시작
        }
      })
    }
  });
};

// 차감 요청 멤버리스트 출력부
function requestDeductList(result) {
  let requestDeductListHereEl = $(".requestDeductListHere");
  let quotaPointElForReq = $(".quotaPoint").text();
  let htmlTemp = "";
  htmlTemp += `<li class="list-group-item border-0">
                <div class="row">
                  <div class="col-md-1"><input class="checkAll" type="checkbox"/></div>
                  <div class="col-md-11 liHeader">전체선택</div>
                </div>
              </li>`
  for(let i = 0; i < result.length; i++){
    let tempMem = result[i];
    htmlTemp += `<li class="list-group-item border-0">
                  <div class="row my-2 ">`
    if(tempMem.mategroupAgree === 1) {
      htmlTemp += `<div class="col-md-1"><input class="checkMems mgree${tempMem.mategroupAgree}" disabled type="checkbox"/></div>`;
    } else {
      htmlTemp += `<div class="col-md-1"><input class="checkMems mgree${tempMem.mategroupAgree}" type="checkbox"/>
                    <input type="hidden" class="reqMemIdHidden" value="${tempMem.memId}"/>
                    <input type="hidden" class="reqMemNameHidden" value="${tempMem.memName}"/>
                  </div>`;
    }
    htmlTemp += `<div class="col-md-1">${i+1}</div>
                    <div class="col-md-2">
                      <img class="thumbImg" src="${tempMem.memProfileimg}" alt="회원사진">
                    </div>
                    <div class="col-md-2">
                      ${tempMem.memName}
                    </div>
                    <div class="col-md-3 pointAlign">
                      ${quotaPointElForReq}P
                    </div>
                    <div class="col-md-3">`
    if(tempMem.mategroupAgree === 1) {
      htmlTemp +=       `<button class="btn btn btn-dark btn-sm">차감완료</button>`
    } else {
      htmlTemp +=       `<button class="btn btn btn-dark btn-sm requestToSingleBtn">차감요청</button>`
    }

    htmlTemp +=     `</div>
                  </div>
                </li>`
  }

  requestDeductListHereEl.html(htmlTemp);

}

// 차감요청 모달창 회원 전체선택 이벤트
$(document).on("click", ".checkAll", function() {
  if($(".checkAll").prop("checked")) {
    $(".checkMems:not(.mgree1)").prop("checked",true);
  } else {
    $(".checkMems:not(.mgree1)").prop("checked",false);
  }
});

// 차감요청 일괄 전송 이벤트
$(".requestDeductingToAllMemsBtn").on("click", function() {
  // 체크된 회원들만 뽑아서 ajax
  let memArr = [];

  $('.checkMems:checked').each(function(){
    memArr.push($(this).parent().find(".reqMemIdHidden").val());
  });
  // console.log("mememememem", memArr);

  if(memArr.length == 0) {
    Swal.fire({
      title: "일괄 차감 요청",
      text: "차감요청을 보낼 회원을 선택해주세요.",
      icon: "info"
    }).then((result) => {
      return;
    });
  } else {
    Swal.fire({
      title: "일괄 차감 요청",
      text: "체크된 그룹원들에게 차감요청을 보내시겠습니까?",
      icon: "question",
      showCancelButton: true,
      confirmButtonText: "예",
      cancelButtonText: "아니오"
    }).then((result) => {
      if(result.isConfirmed) {
        Swal.fire({
          title: "일괄 차감 요청",
          text: "그룹원들에게 차감요청이 전송되었습니다.",
          icon: "success"
        }).then((result) => {
          /* 알림으로 쏘기 memArr, plNo */
          let idArr = [];
          idArr = memArr;
          $.requestDeductingSingleAlert(idArr);
          $(".deductProcessingModalContents").hide();
          //location.href="/partner/buyPlan.do?plNo=" + plNo;
        });
      }
    });
    
  }

});

// 차감요청 개별 전송 이벤트
$(document).on("click", ".requestToSingleBtn", function() {
  let findId = $(this).parent().parent().parent().find('.reqMemIdHidden').val();
  let findName = $(this).parent().parent().parent().find('.reqMemNameHidden').val();
  // console.log("찾은 아이디", findId);
  Swal.fire({
    title: "차감 요청",
    text: findName + "님에게 차감요청을 보내시겠습니까?",
    icon: "question",
    showCancelButton: true,
    confirmButtonText: "예",
    cancelButtonText: "아니오"
  }).then((result) => {
    if (result.isConfirmed) {
      Swal.fire({
        title: "차감 요청",
        text: "차감요청이 전송되었습니다.",
        icon: "success"
      }).then((result) => {
        /* 차감 요청 알림 보내기 plNo, findId or Name */
        let idArr = [];
        idArr.push(findId);
        $.requestDeductingSingleAlert(idArr);
        // location.href="/partner/buyPlan.do?plNo=" + plNo;
      });
    }
  });
});


// 개별전송 실시간 알림
$.requestDeductingSingleAlert = function(idArr) {
  var realrecIdArr;   // 알림을 받을 ID
    
  // console.log("idArr", idArr);
  let idArrStr = idArr.join(";");
  console.log("idArrStr", idArrStr);
  realrecIdArr = idArrStr; // 멤버들 전원에게 전송

  var realsenId = memObj.memId;     // 발신자 아이디
  var realsenName = memObj.memName; // 발신자 이름
  var realsenTitle = "차감요청";    // 실시간 알림 제목
  var realsenContent = realsenName + "님이 '"+pTitle+"' 플랜에 대해 차감 요청을 보내셨습니다."; // 실시간 알림 내용
  var realsenType = "buyPlan";      // 그룹 장바구니 타입 알림
  var realsenReadyn = "N";          // 안 읽음
  var realsenUrl = "/partner/buyPlan.do?plNo=" + plNo + "&stay=true"; // 그룹 장바구니 페이지로 이동
  
  var dbSaveFlag = false; // db에 저장
  var userImgSrc = memObj.memProfileimg; // 유저 프로필 이미지 정보
  // var realrecNo = "empty";
  
  var rtAlert = {
    "realrecIdArr": idArrStr,
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
  
  if(ws){
    let socketMsg = `${realrecIdArr},${realsenId},${realsenName},${realsenTitle},${realsenContent},${realsenType},${realsenReadyn},${realsenUrl},${userImgSrc}`;
    console.log("전송합니다. : " + socketMsg);
    ws.send(socketMsg);
  }
  console.log("에엘ㄴ에ㅑ러멩랴ㅐㅓ", idArr);
  console.log("에엘ㄴ에ㅑ러멩랴ㅐㅓ길이", idArr.length);
  if(idArr.length > 1) {
    for(let i = 0; i < idArr.length; i++) {
      let idTempArr = [];
      idTempArr.push(idArr[i]);
      console.log("에엘ㄴ에ㅑ러멩랴ㅐㅓ", idTempArr);
      let rtAlertTemp = {
        "realrecIdArr": idTempArr,
        "realsenId": rtAlert.realsenId,
        "realsenName": rtAlert.realsenName,
        "realsenTitle": rtAlert.realsenTitle,
        "realsenContent": rtAlert.realsenContent,
        "realsenType": rtAlert.realsenType,
        "realsenReadyn": rtAlert.realsenReadyn,
        "realsenUrl": rtAlert.realsenUrl,
        "realsenPfimg": rtAlert.realsenPfimg
      }
      $.ajaxBpRtAlertSaveFn(rtAlertTemp);
    }
  } else {
    $.ajaxBpRtAlertSaveFn(rtAlert);
  }
}


/* 포인트 차감 프로세스 */
// 그룹장 + 그룹원 모두가 포인트 차감을 하는 프로세스 입니다
$.deductPointFn = function() {
  $(".requestDeductingToAllMemsBtn").hide();
  $(".deductPointBtn").show();
  
  // 모달창 닫을 경우 이벤트
  var deductProcessingModalContents = $(".deductProcessingModalContents");
  var deductProcessingModalClose = $(".deductProcessingModalClose");
  deductProcessingModalClose.click(function () {
    deductProcessingModalContents.hide();
  });

  // 포인트 계산 시작

  // 그룹 포인트 잔액
  let groupPoint = $(".groupPointHidden").val();
  let groupPointEl = $(".groupPoint");

  console.log("groupPoint", groupPoint);

  groupPoint = parseInt(groupPoint);  // 그룹 포인트

  let reformedGroupPoint = numberWithCommas(groupPoint);  // 출력용
  groupPointEl.text(reformedGroupPoint);

  // 항공 총가격 구하기
	let airTotalPriceEl = $(".airTotalPrice");
  let totalPrice = 0;
  airTotalPriceEl.each(function() {
    var value = $(this).val();
    value = parseInt(value);
    totalPrice = totalPrice + value;    // 총 가격
  });

  let reformedTotalPrice = numberWithCommas(totalPrice);  // 출력용
  $(".totalPrice").text(reformedTotalPrice);

  // 현재 인원수
  let curNumEl = $(".curNum");
  let curNum = parseInt(curNumEl.text())

  // 필요 그룹포인트
  // 총가격이 그룹포인트보다 클때에만 계산
  let needPointEl = $(".needPoint"); 
  let calcNeedPoint = 0;
  if(totalPrice > groupPoint) {
    calcNeedPoint = totalPrice - groupPoint;      // 필요 그룹포인트
    let reformedCalcNeedPoint = numberWithCommas(calcNeedPoint);  // 출력용
    needPointEl.text(reformedCalcNeedPoint);
  } else {
    // 총가격이 그룹포인트보다 작거나 같으면 차감할 필요가 없지요
    needPointEl.text(0);
  }

  // 1인당 분할결제 포인트
  // 총 가격이 0 이상일때에만 계산
  let quotaPointEl = $(".quotaPoint");
  
  if(totalPrice > 0) {
    let quotaPoint =  Math.ceil(totalPrice / curNum);    // 할당량
    console.log("quotaPoint", quotaPoint);
    if((totalPrice - groupPoint) === 0) {
      quotaPointEl.text(0);
    } else {
      let reformedQuotaPoint = numberWithCommas(quotaPoint);  // 출력용
      quotaPointEl.text(reformedQuotaPoint);
    }
  } else {
    // 총가격이 0이면 할당포인트도 당연히 0
    quotaPointEl.text(0);
  }

  // 그룹원으로서 포인트 차감 버튼 눌렀을 경우
  // mategroupAgree 0 -> 차감 필요
  // mategroupAgree 1 -> 차감 요청을 받은 상태
  let deductBtnForGmEl = $(".deductBtnForGm");
  deductBtnForGmEl.on("click", function() {

    // 아무 상품도 없으면 차감이 되어선 안됨
    if($(".noItems").val() === "true") {
      return;
    }

    let mategroupAgree = $(".mategroupAgreeHidden").val();  // 차감 단계. ajax로 불러올게 아니라면 페이지를 새로고침해야함
    console.log("mategroupAgree", mategroupAgree);
    let myCurPEl = $(".myCurP");  // 현재 내 포인트가 들어갈 요소
    let myDedEl = $(".myDedP");   // 내 할당량이 들어갈 요소
    let myPointAfterDeductEl = $(".myPointAfterDeduct");  // 차감 이후 내 포인트가 들어갈 요소
    let groupPointAfterDeductEl = $(".groupPointAfterDeduct");  // 차감 이후 그룹포인트가 들어갈 요소
    let memPoint = parseInt($(".memPointHidden").val());  // 현재 내 개인포인트
    
    if(pointDeductingCompletedFlg == true) {
      sweetAlertFn("포인트 차감", "이미 차감 완료하셨습니다.", "error").then((result) => {
        return;
      });
    } else {
      // 차감단계가 0이라면...
      if(mategroupAgree === "0") {
        $(".deductProcessingModalContents").show();
        let quota = Math.ceil(totalPrice / curNum);
        
        if(memPoint < quota) {
          $(".isPointEnough").text(" (포인트 부족)");
          $(".resultSummary").text("");
          let tempHtml = `<button class="btn btn btn-dark btn-lg modalBtn goToPointStore">포인트 충전</button>`;
          if(appendFlg == false) {
            $(".modalBtnsWrap > div").append(tempHtml);
            appendFlg = true;
          }

          if(appendFlg == true) {
            $(".goToPointStore").show();
          }
        }

        myCurPEl.text(numberWithCommas(memPoint));
        myDedEl.text(numberWithCommas(quota));
        let calcDif = memPoint - quota; 
        myPointAfterDeductEl.text(numberWithCommas(calcDif));
        let groupPointAfterDeduct = groupPoint + quota;
        groupPointAfterDeductEl.text(numberWithCommas(groupPointAfterDeduct));

          
        var deductPointBtn = $(".deductPointBtn");
        deductPointBtn.click(function () {
          // 포인트가 할당량보다 많거나 같으면 포인트 차감 가능
          if(memPoint >= quota) {
            console.log("groupPointgroupPointgroupPoint", groupPoint);
            // 포인트 차감 진행
            sweetConfirmFn("포인트 차감", "포인트를 차감하시겠습니까?", resultDeducting, {quota, groupPoint});
            
          } else {
            //부족하면 충전 알림
            sweetAlertFn("포인트 차감", "포인트가 부족합니다. 포인트 충전 후에 진행해주세요.", "error").then((result) => {
            });
          }
        });

      } else {
        // 차감단계가 0 이상 이라면...
        // 이미 차감완료했으므로 차감 진행 불가
        sweetAlertFn("포인트 차감", "이미 차감 완료하셨습니다.", "error").then((result) => {
          return;
        });
      }
    }
  });
}

// 포인트 부족시 포인트 충전
$(document).on("click", ".goToPointStore", function() {
  location.href="/mypage/paymentinfo.do?plNo=" + plNo;
});


// 결제 확정 버튼 (그룹장) 이벤트
let purchaseConfirmedBtnEl = $(".purchaseConfirmedBtn");
purchaseConfirmedBtnEl.on("click", function() {

  // 이미 결제를 확정했는가?
  // 예라면 결제확정 버튼을 비활성화
  if(isPurchasingConfirmed == true) {
    purchaseConfirmedBtnEl.removeClass("right").addClass("left");
    purchaseConfirmedBtnEl.text("결제확정 완료");

  } else {

    // 결제를 확정하지 않았고...
    // 모든 그룹원들이 포인트 차감을 완료했는가?

    //아니오...
    if(yesAllGmDeducted == false) {
      sweetAlertFn("결제확정", "모든 팀원들이 포인트 차감을 완료해야 결제를 확정하실 수 있습니다.", "error").then((result) => {
        return;
      });

    // 예!
    // 그렇다면 결제확정을 할지 다시 한번 묻는다.
    } else {
        Swal.fire({
        title: "결제확정",
        text: "결제를 확정하시겠습니까?",
        icon: "question",
        showCancelButton: true,
        confirmButtonText: "예",
        cancelButtonText: "아니오"
      }).then((result) => {
        if (result.isConfirmed) {
          $.ajax({
            url:"/partner/confirmPurchasing.do",
            data:{"plNo" : plNo},
            type:"get",
            success: function(result) {
              $.confirmPurchasingAlertToAll(curMemList);
              if(result === "OK") {
                
                setTimeout(function() {
                  sweetAlertFn("결제확정", "결제를 확정하셨습니다. 이제 그룹 포인트로 상품을 구매하실 수 있습니다.", "success").then((result) => {
                    // let idArr = [];
                    // idArr = memArr; // 그룹원들 불러오기
                    // $.confirmPurchasingAlertToAll(curMemList);
                    //isPurchasingConfirmed = true;
                    location.href="/partner/buyPlan.do?plNo=" + plNo + "&stay=true";
                  });
                }, 1000);
                
              } else {
                sweetAlertFn("결제확정", "결제확정에 실패했습니다!", "error").then((result) => {
                  return;
                });
              }
            }
          });
        }
      });
    }
  }
});

$.confirmPurchasingAlertToAll = function(idArr) {
  var realrecIdArr; // 모든 유저를 대상으로 알림
    
  let idArrStr = idArr.join(";");
  console.log("idArrStr", idArrStr);
  realrecIdArr = idArrStr; // 멤버들 전원에게 전송

  var realsenId = pMem; // 발신자 아이디
  var realsenName = pMem; // 발신자 이름
  var realsenTitle = "차감요청"; // 실시간 알림 제목
  var realsenContent = realsenName + "님이 '"+pTitle+"' 플랜의 결제를 확정하였습니다."; // 실시간 알림 내용
  var realsenType = "buyPlan"; // 그룹 장바구니 타입 알림
  var realsenReadyn = "N"; // 안 읽음
  var realsenUrl = "/partner/buyPlan.do?plNo=" + plNo + "&stay=true"; // 그룹 장바구니 페이지로 이동
  
  var dbSaveFlag = false; // db에 저장
  var userImgSrc = memObj.memProfileimg; // 유저 프로파일 이미지 정보
  var realrecNo = "empty";
  
  var rtAlert = {
    "realrecIdArr": idArr,
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
  
  if(ws){
    let socketMsg = `${realrecIdArr},${realsenId},${realsenName},${realsenTitle},${realsenContent},${realsenType},${realsenReadyn},${realsenUrl},${userImgSrc}`;
    console.log(socketMsg);
    console.log("보낼게요");
    ws.send(socketMsg);
  }

  if(idArr.length > 1) {
    for(let i = 0; i < idArr.length; i++) {
      let idTempArr = [];
      idTempArr.push(idArr[i]);
      let rtAlertTemp = {
        "realrecIdArr": idTempArr,
        "realsenId": rtAlert.realsenId,
        "realsenName": rtAlert.realsenName,
        "realsenTitle": rtAlert.realsenTitle,
        "realsenContent": rtAlert.realsenContent,
        "realsenType": rtAlert.realsenType,
        "realsenReadyn": rtAlert.realsenReadyn,
        "realsenUrl": rtAlert.realsenUrl,
        "realsenPfimg": rtAlert.realsenPfimg
      }
      $.ajaxBpRtAlertSaveFn(rtAlertTemp);
    }
  } else {
    $.ajaxBpRtAlertSaveFn(rtAlert);
  }
}


  /* 장바구니(항공) 삭제 처리 시 이벤트 */ 
  $('.deleteAirBtn').on('click', function(){
    var thisIs = $(this);
    Swal.fire({
      text: '해당 상품을 장바구니에서 제외하겠습니까?',
      showCancelButton: true,
      confirmButtonText: "예",
      cancelButtonText: "아니오"
    }).then((result) => {
      if (result.isConfirmed) {
        var depFlightCode = thisIs.next().val();
        var retFlightCode = thisIs.next().next().val();
        var cartNo = thisIs.next().next().next().val();
        var depFlightElem = thisIs.parent().parent();
        var retFlightElem = thisIs.parent().parent().next();
        var delData = {
          depFlightCode : depFlightCode,
          retFlightCode : retFlightCode,
          cartNo : cartNo
        };

        $.ajax({
          url : '/partner/deleteAirCart.do',
          type : 'post',
          contentType : 'application/json',
          data : JSON.stringify(delData),
          success : function(res){
            if(res === 'SUCCESS') {
              console.log('삭제성공!');
              depFlightElem.remove();
              retFlightElem.remove();
              $.deductPointFn();
            }else if(res === 'FAIL'){
              console.log('삭제실패!');
            }
          }
        });
      }
  });
});

/* 구매하기 버튼 클릭 시 이벤트 */
$('.buyAir').on('click', function(){
  // console.log("isPurchasingConfirmed", isPurchasingConfirmed);
  
  if(isPurchasingConfirmed == true) {
    var thisIs = $(this);
    Swal.fire({
      text: '상품을 구매하러 가시겠습니까?',
      showCancelButton: true,
      confirmButtonText: "예",
      cancelButtonText: "아니오"
    }).then((result) => {
      if (result.isConfirmed) {
        var depFlightCode = thisIs.parent().next().find('input[name="depFlightCode"]').val();
        var retFlightCode = thisIs.parent().next().find('input[name="retFlightCode"]').val();
        console.log('depFlightCode : ', depFlightCode);
        console.log('retFlightCode : ', retFlightCode);
        location.href = '/reserve/air/reserve/reserve.do?depFlightCode='+depFlightCode+'&arrFlightCode='+retFlightCode;
      }
    });
  } else {
    sweetAlertFn("", "결제확정 후에 구매하러 가실 수 있습니다.", "error").then((result) => {
      return;
    });
  }
});


$("#returnBtn").on("click", function() {
  Swal.fire({
      title: "페이지 이동",
      text: "그룹 페이지로 이동하시겠습니까?",
      icon: "question",
      showDenyButton: true,
      confirmButtonText: "예",
      denyButtonText: "아니오"
  }).then((result) => {
      if (result.isConfirmed) {
          Swal.fire({
            title: "페이지 이동",
            text: "그룹 페이지로 이동합니다.",
            icon: "info"
        }).then((result) => {
            // 모달이 닫힌 후에 실행될 코드
            if (result.isConfirmed) {
                // 확인 버튼이 클릭되었을 때
                location.href = "/partner/meetsquare.do?plNo=" + plNo;
            }
        });
      } else if (result.isDenied) {
          Swal.fire({
            title: "페이지 이동",
            text: "페이지 이동을 취소합니다.",
            icon: "error"
        });
      }
  });
});

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
	
$(".deductBtn").on("click", function(e) {
  e.preventDefault();
  sweetConfirmFn("포인트 차감", "포인트를 차감하시겠습니까?", resultDeducting, "test1")
});

$(".confirmPurchase").on("click", function(e) {
  e.preventDefault();
  sweetConfirmFn("구매 확정", "구매를 확정하시겠습니까?", resultConfirmPurchase, "test2")
});

function resultDeducting(arg) {
  sweetAlertFn("포인트 차감", arg + "님의 포인트 차감이 완료되었습니다.", "success");
}

function resultConfirmPurchase(arg) {
  sweetAlertFn("구매 확정", arg + "님의 구매가 확정되었습니다.", "success");
}


/* sweetAlert */
function sweetAlertFn(msg, text, icon){
  Swal.fire({
    title: msg,
    text: text,
    icon: icon
  });
}

function sweetConfirmFn(msg, text, callbackFn, args){
  Swal.fire({
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
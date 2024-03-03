// 높이 조절 함수
$.lnbHequalContHFn = function(){
    var myPageLnbContents = $(".myPageLnbContents");
    var mypageContainer = $(".mypageContainer");
    
    mypageContainer.outerHeight("auto");
    myPageLnbContents.outerHeight("auto");
    
    var myPageLnbContentsH = myPageLnbContents.outerHeight();
    console.log("myPageLnbContentsH : " + myPageLnbContentsH);
    var mypageContainerH = mypageContainer.outerHeight();
    console.log("mypageContainerH : " + mypageContainerH);
    
    if(myPageLnbContentsH > mypageContainerH) {
        mypageContainer.outerHeight(myPageLnbContentsH);
    }else if(myPageLnbContentsH < mypageContainerH) {
        myPageLnbContents.outerHeight(mypageContainerH);
    }
};

// 탭 버튼 함수
$.myPageTabbtnFn = function(){
    var myPageTabbtn = $(".myPageTabbtnGroup .tabbtn");
    var myPageTabcontBox = $(".myPageTabcontBox .tabcont");
    myPageTabbtn.click(function(){
        var thisIs = $(this);
        myPageTabbtn.removeClass("tactive");
        thisIs.addClass("tactive");
        var idx = thisIs.index();
        myPageTabcontBox.hide();
        myPageTabcontBox.eq(idx).show();
        $.lnbHequalContHFn();
        
        //구매상품 리스트 요청
        if(thisIs.attr('id') === 'product'){
            payListAjax(''); 
        }
    });
};

 /*구매상품 리스트 요청*/
function payListAjax(pageNo){
      var number;
      if(pageNo == ''){   //페이지 번호 전달
        number = 1;
      }else{
        number = pageNo;
      }
        $.ajax({
          url : '/mypage/payHistoryList.do?page='+number,
          type : 'get',
          dataType : 'json',
          success : function(res){
            var payList = res.pageVO.dataList;
            var pagingHTML = res.pageVO.pagingHTML;
            var tbody = $('.taleair tbody');
            tbody.empty();   //모든 리스트 지우기
            
            var listHtml = '';
            var cnt  = 0;
            $.each(payList, function(i, pay){
             cnt++;
             listHtml += '<tr style="height: 80px;">';
             listHtml += '   <td>'+cnt+'</td>';
             listHtml += '   <td>';
             listHtml += '      <span>'+pay.airlineName+'</span><br>';
             listHtml += '      <img src="'+pay.airlineLogo+'" style="width: 100px; height: 80px;">';
             listHtml += '   </td>';
             listHtml += '   <td>동행<br>(그룹명 : '+pay.plTitle+')</td>';
             listHtml += '   <td>왕복<br>('+typeFormatter(pay.ticketType)+')</td>';
             listHtml += '   <td>'+pay.flightDepairport+'<br>';
             listHtml += '   ('+timeFormatter(pay.flightDeptime)+')</td>';
             listHtml += '   <td>'+pay.flightArrairport+'<br>('+timeFormatter(pay.flightArrtime)+')</td>';
             listHtml += '   <td>'+pay.airPersonnum+'명</td>';
             listHtml += '   <td>'+numberFormatter2(pay.ticketTotalprice)+'</td>';
             listHtml += '   <td>'+pay.airPayday+'</td>';
             listHtml += '   <td>'+pay.memId+'</td>';
             listHtml += '   <td>';
             listHtml += '     <button class="btn btn-primary ticketBtn" id="'+pay.airReserveno+'_'+pay.ticketType+'" data-bs-toggle="modal" data-bs-target="#myModal" style="margin-left: 10px; width: 80px;">항공권 확인</button>';
             listHtml += '   </td>';
             listHtml += '</tr>';
            });
            tbody.append(listHtml);
            var paging = $('#paging').find('div').eq(1);
            paging.empty();
            paging.append(pagingHTML);
          }
        })
}


/* 페이지 버튼 클릭 시 이벤트 */
$(document).on('click', '#pagingArea a', function(e){
   e.preventDefault();
   var pageNo = $(this).data('page');

   payListAjax(pageNo);
});



/* 항공권 확인 버튼 클릭 시 이벤트*/
$(document).on('click', '.ticketBtn', function(e){
   var arr = $(this).attr('id').split('_');
   var reNo = arr[0].trim();
   var tType = arr[1].trim();
   
   $.ajax({
     url : '/mypage/ticketView.do?airReserveno='+reNo+'&ticketType='+tType,
     type : 'get',
     dataType : 'json',
     success : function(res){
        if(res.msg == 'FAILED'){
            Swal.fire({
                title: "실패",
                text: "조회된 항공권이 없습니다!",
                icon: "error"
            });
            return false;
        }else if(res.msg == 'SUCCESS'){
            var first = res.receiptList[0];
            var ticketHTML = '<div class="row passengerModal">';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>탑승객 성명</p>';
            ticketHTML += '     <p></p>';
            ticketHTML += '     <p>예약번호</p>';
            ticketHTML += '     <p>항공권 코드</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>Passenger</p>';
            ticketHTML += '     <p></p>';
            ticketHTML += '     <p>Booking Reference</p>';
            ticketHTML += '     <p>Ticket Number</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-7">';
            $.each(res.receiptList, function(i, value){
                if((i+1) % 2 == 0){
                    ticketHTML += '<span style="margin-top: 12px;">'+value.ticketFirstname+' '+value.ticketName+'</span>, <br>';  
                }
                if((i+1) % 2 != 0){
                    ticketHTML += '<span style="margin-top: 12px;">'+value.ticketFirstname+' '+value.ticketName+'</span>, ';  
                }
            });
            ticketHTML += '     <p>'+first.airReserveno+'</p>';
            ticketHTML += '     <p>'+first.ticketCode+'</p>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row title">';
            ticketHTML += '   <div class="col-sm-12">';
            ticketHTML += '      <h6 style="padding-top: 12px; padding-left: 10px;">여정 (Itinerary)</h6>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row flight-header">';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '       <p>편명 Flight</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-6">';
            ticketHTML += '       <p>'+first.flightCode+' Operated by '+first.airlineName+'('+first.airlineCode+')</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '       <p>경유 Via : -직항</p>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row flight-content1">';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>출발 Departure</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>'+first.flightDepairport+' ('+first.flightDepportcode+')</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-4">';
            ticketHTML += '    <p>'+first.flightDeptime+' Local Time</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>Terminal No : T1</p>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row flight-content2">';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>도착 Arrival</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>'+first.flightArrairport+' ('+first.flightArrportcode+')</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-4">';
            ticketHTML += '     <p>'+first.flightArrtime+' Local Time</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>Terminal No : C2</p>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row flight-content3">';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>예약등급 Class</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            var grade;
            if(first.ticketClass.toLowerCase() == 'economy'){
               grade = '일반석 등급';
            }else if(first.ticketClass.toLowerCase() == 'business'){
               grade = '비즈니스 등급';
            }else if(first.ticketClass.toLowerCase() == 'first'){
               grade = '일등석 등급';
            }
            ticketHTML += '     <p>'+first.ticketClass+'('+grade+')</p>';
            
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>항공권 유효기간</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>Not Valid Before - </p>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row flight-content4">';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>예약상태 Status</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>OK(확 약)</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p></p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '    <p>Not Valid After 94MAY11</p>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row flight-content5">';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>수하물</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>Baggage</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '     <p>20K</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-3">';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row title">';
            ticketHTML += '   <div class="col-sm-12">';
            ticketHTML += '        <h6 style="padding-top: 12px; padding-left: 10px;">운임 (Fare Basis) - SLXP15</h6>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            ticketHTML += '<div class="row flight-fare1">';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>탑승객</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>항공운임</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '    <p>유류할증료</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>제세공과금</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>발권수수료</p>';
            ticketHTML += '   </div>';
            ticketHTML += '   <div class="col-sm-2">';
            ticketHTML += '     <p>총액</p>';
            ticketHTML += '   </div>';
            ticketHTML += '</div>';
            $.each(res.receiptList, function(i, receipt){
                ticketHTML += '<div class="row flight-fare2">';
                ticketHTML += '   <div class="col-sm-2">';
                ticketHTML += '    <p>'+receipt.ticketFirstname+' '+receipt.ticketName+'</p>';
                ticketHTML += '  </div>';
                ticketHTML += '   <div class="col-sm-2">';
                ticketHTML += '    <p>'+numberFormatter2(receipt.ticketAircharge)+'</p>';
                ticketHTML += '  </div>';
                ticketHTML += '  <div class="col-sm-2">';
                ticketHTML += '    <p>'+numberFormatter2(receipt.ticketFuelsurcharge)+'</p>';
                ticketHTML += '  </div>';
                ticketHTML += '  <div class="col-sm-2">';
                ticketHTML += '    <p>'+numberFormatter2(receipt.ticketTax)+'</p>';
                ticketHTML += '  </div>';
                ticketHTML += '  <div class="col-sm-2">';
                ticketHTML += '     <p>'+numberFormatter2(receipt.ticketCommission)+'</p>';
                ticketHTML += '  </div>';
                ticketHTML += '  <div class="col-sm-2">';
                ticketHTML += '     <p>'+numberFormatter2(receipt.ticketTotalprice)+'</p>';
                ticketHTML += '  </div>';
                ticketHTML += '</div>';
            });
        } 
        var modalbody = $('.modal-body').empty();
        modalbody.append(basicHTML);
        $('.headerModal').after(ticketHTML);
     }  //success끝
   }); //ajax끝
});


//시간형태를 변환하는 함수
function timeFormatter(date){
    var time = date.substr(8);
    var hourStr = time.substr(0, 2);
    var minute = time.substr(2);
    
    var hour = parseInt(hourStr, 10) % 12;
    var ampm = parseInt(hourStr, 10) >= 12 ? '오후' : '오전';
    
    return ampm+' '+hour+':'+minute;
}

//숫자의 형태를 변환하는 함수
function numberFormatter2(number){
    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',')+'원';
}



//가는편,오는편 구분하는 함수
function typeFormatter(type){
  var str;
  if(type == 'DAPARTURE'){
     str = '가는편';
  }
  if(type == 'RETURN'){
     str = '오는편';
  }
   return str;
}




// 이미지 업로드 트리거 함수
$.profileImgClickTriggerFn = function(){
    var profileIcon = $(".profileIcon");
    profileIcon.click(function(){
        $("#imgFile").trigger("click");
    });
};

// 회원정보수정 활성화 함수
$.myInfoActivationFn = function(){
    var updBlockBtn = $("#updBlockBtn");
    updBlockBtn.click(function(){
        $(".updBlockLayer").hide();
    });
};

// 이메일 검증 함수
$.matchKeyupEvent = function({el, msgEl, msg, col, url}, callback){
    el.keyup(function(){
        var valTxt = $(this).val();
        //console.log("valTxt : ",valTxt);
        if(!valTxt) {
        	$(msgEl).html("<span class='badge bg-danger'>"+msg+" 사용불가</span>");
        	callback(false);
        }else {
            var data = {
                [col] : valTxt
            };
            //console.log("data : ", data);
            $.ajax({
                type: "post",
                url: url,
                data: JSON.stringify(data),
                contentType: "application/json;charset=utf-8",
                success: function(res){
                    if(res === "NOTEXIST") {
                        $(msgEl).html("<span class='badge bg-success'>"+msg+" 사용가능</span>");
                        callback(true);
                    }else {
                        $(msgEl).html("<span class='badge bg-danger'>"+msg+" 사용불가</span>");
                        callback(false);
                    }
                }
            });
        }
    });
};

// daum 주소 API(주소 찾기)
function DaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById("memPostcode").value = data.zonecode;
            document.getElementById("memAddress1").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("memAddress2").focus();
        }
    }).open();
}

var basicHTML = '<div class="row headerModal"><div class="col-sm-1"><img src="/resources/images/logo.png" width="80px;" height="80px;" style="padding-top: 13px;"></div><div class="col-sm-2">&nbsp;&nbsp;<h4 style="padding-top: 10px; padding-left: 10px;">여기갈래</h4></div><div class="col-sm-5"><h4 style="padding-top: 30px;">e-Ticket Intinerary & Receipt</h4></div><div class="col-sm-4" style="padding-top: 35px;"></div></div>';


// 문의사항 답변등록 모달 창
$.questionModalFn = function() {

      // 모달창(답변등록) 닫기
      var questionAnswerModalClose = $(".questionAnswerModalClose");
      var questionAnswerModalContents = $(".questionAnswerModalContents");
      questionAnswerModalClose.click(function () {
        questionAnswerModalContents.hide();
        questionAnswerModalContents.css("opacity","0");
      });
  }

function modalOn(idx) {
var questionAnswerModalContents = $(".questionAnswerModalContents");
questionAnswerModalContents.show();
questionAnswerModalContents.animate({opacity:"1"},200);

$.ajax({
    type: "post",
    url: "/question/questionInfoPost.do",
    data: {
    idx:idx
    },
    success: function(data) {
    console.log("data 값 : ", data);
    let boTitle = data.boTitle;
    let boContent = data.boContent;
    
    $("#title").val(boTitle);
    $("#content").val(boContent.replaceAll('<br/>','\n'));
    
    if(data.answer == '' || data.answer == null) {
        $("#answer").val('');
        $("#questionAnswerBtn").attr("onclick","questionAnswerComplete("+idx+")");
        document.getElementById("answer").disabled = false;
        return;
    }
    else {
        $("#answer").val(data.answer.replaceAll('<br/>','\n'));
        document.getElementById("answer").disabled = true;
    }
    
    },
    error: function() {
    alert("전송 오류");
    }
});

}



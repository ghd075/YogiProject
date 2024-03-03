var startIndex = 1;	// 인덱스 초기값
var searchStep = 5;	// 5개씩 로딩
// 현재 필터링 상태를 저장하는 변수
var currentFilter = 'all';

// 포인트 충전 함수
$.myPaymentPointChgFn = function(index){
	var pointPaymentBtn = $("#pointPaymentBtn");
	pointPaymentBtn.click(function(){
		var selectedPayValue = $("input[name='pay']:checked").val(); // 라디오에 있는 value 값을 들고옴
		var memPoint = $("#memPointSpan").text(); // 현재 보유하고 있는 값의 정보
		if(!selectedPayValue) { // 라디오 버튼을 선택하지 않아서 value값이 비어 있는 falsy한 값.
			//alert("금액을 선택해 주세요.");
			Swal.fire({
				title: "안내",
				text: "금액을 선택해 주세요.",
				icon: "info"
			});
			return false;
		}
		
		console.log("선택한 pay 값: ", selectedPayValue);
		console.log("memPoint 값: ", memPoint);
		console.log("index 값: ", index);
		payment(index);
	});
};

// 더보기 함수
$.searchMoreClickFn = function(index, searchStep) {
	var searchMorePointBtn = $("#searchMorePointBtn");
	searchMorePointBtn.click(function(){
		startIndex += searchStep;	// 더보기 버튼 클릭시 페이지 증가
		console.log("startIndex 값: ", startIndex);
		console.log("searchStep 값: ", searchStep);
		$.readOldPointInfo(startIndex, currentFilter);
	}); 
}

// select 박스 필터링 함수
function filterResults(filter) {
	console.log("필터링 조건 : " + filter);
	startIndex = 1;	// 인덱스 초기값

	console.log("현재 페이지 : " + startIndex);

	// 필터링을 적용하기 전에 이전 필터링 결과를 삭제합니다.
	var paymentResTbl = $(".paymentResTbl tbody");
	paymentResTbl.empty();

  $.readOldPointInfo(startIndex, filter);  // 첫 페이지부터 필터링된 결과를 보여줍니다
}

// 화면 로딩 시 뿌려주는 함수
$.readOldPointInfo = function(index, filter = 'all') {
	var memId = $('#memId').val();

	let _endIndex = index+searchStep-1;	// endIndex설정

	console.log("이름 값 : " + memName);
	console.log("마지막 페이지 : " + _endIndex);

	// 데이터를 json으로 보내기 위해 바꿔준다.
	data = JSON.stringify({
		"memId" : memId,
		"startIndex": index, // 현재 페이지 정보도 전달
		"endIndex": _endIndex,
		"filter": filter  	// 필터링 옵션 추가 
	});

	console.log("넘기려고 하는 데이터 값 : ", data);

	$.ajax({
    type: "POST",
    url: '/mypage/payInfo',
    contentType: 'application/json',
    data: data,
    success: function(response) {
      console.log("체킁:", response);
			var paymentResTbl = $(".paymentResTbl tbody");

			var userPointList = response.userPointList; // 응답 데이터에서 목록 정보를 가져옵니다.
			var htmlTxt = "";

			if (userPointList.length === 0) {
				htmlTxt += `
					<tr class="text-center">
						<td colspan="5">포인트 결제 내역이 존재하지 않습니다.</td>
					</tr>
				`;
			} else {
				for (var i = 0; i < userPointList.length; i++) {
					htmlTxt += `
						<tr>
							<td>${userPointList[i].pointNo}</td>
							<td>${formatDate(userPointList[i].pointDate)}</td>
							<td>${userPointList[i].pointType}</td>
							<td>${numberFormatter(userPointList[i].pointAccount)}</td>
							<td>${numberFormatter(userPointList[i].remainingPoint)}</td>
						</tr>
					`;
				}
			}

			if (index == 0) {
				paymentResTbl.html(htmlTxt);  // 기존 데이터를 제거하고 새로운 데이터를 불러옵니다.
			} else {
					paymentResTbl.append(htmlTxt);  // 새로운 데이터를 기존 데이터 뒤에 추가합니다.
			}

			console.log("총 게시글 수 : " + response.totalRecord);
			console.log("startIndex : " + startIndex);
			console.log("searcchStep : " + searchStep);
			console.log("startIndex + searchStep : " + (parseInt(startIndex) + parseInt(searchStep)));
			var searchResult = parseInt(index) + parseInt(searchStep);
			console.log("조건 : " + (searchResult > response.totalRecord));
			// "더보기" 버튼 표시 여부 결정
			if(searchResult >= response.totalRecord) {
				$('#searchMorePointBtn').hide();
			} else {
				$('#searchMorePointBtn').show();
			} 
			
			// memPointSpan의 값을 변경
			if (userPointList.length > 0) {
				var memPoint = userPointList[0].memPoint;
				console.log("현재 회원 포인트: " + memPoint);
				$("#memPointSpan").text(numberFormatter(memPoint));
			}
    }
	});
}


// 카카오 페이 결제 모듈
function payment(index) {
	//라디오버튼 체크 value변수	
	var radioVal = $('input[name="pay"]:checked').val();
	var memName = $('#memName').val();
	var memId = $('#memId').val();
	var currentPage = 1; // 초기 페이지 번호
	
	console.log("값 : " + radioVal);
	console.log("이름 값 : " + memName);
	console.log("아이디 값 : " + memId);
	
	IMP.init('imp83255565'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용

	//결제 api
	IMP.request_pay({
		pg: "kakaopay", 			// 	pg사
					amount: radioVal,  			//	가격 
					name : '주문명:결제테스트',
					buyer_name: memName,		// 	구매자 이름
	}, function(rsp) {
		if (rsp.success) {			// 	결제 성공
			uid = rsp.imp_uid;
			console.log('uid 값 : ' + uid);
			$.ajax({
				url : '/mypage/verify_iamport/' + uid,
				type : 'post'
			}).done(function(data){
				console.log('넘겨왔던 값 : ', data);
				console.log('결제금액 : ', data.response.amount);
				console.log('선택한 결제금액 : ', radioVal);
				// 결제를 요청했던 금액과 실제 결제된 금액이 같으면 해당 주문건의 결제가 정상적으로 완료된 것으로 간주한다.
				if(radioVal == data.response.amount) {
					console.log("동작하니??");
					
					let _endIndex = index+searchStep-1;	// endIndex설정
					console.log("마지막 페이지 : " + _endIndex);

					// 데이터를 json으로 보내기 위해 바꿔준다.
					data = JSON.stringify({
						"impUid" : rsp.imp_uid,
						"memId" : memId,
						"memName" : memName,
						"pointAccount" : rsp.paid_amount,
						"startIndex": index, // 현재 페이지 정보도 전달
						"endIndex": _endIndex 
					});

					console.log("넘기려고 하는 데이터 값 : ", data);
					processPayment(data, index);
				}
			});
			var msg = '결제가 완료되었습니다.';
		} else {					// 	결제 실패
			var msg = '결제에 실패하였습니다.';
			msg += '에러내용 : ' + rsp.error_msg;
		}
		//alert(radioVal + "원 " + msg);
		// Swal.fire({
		// 	title: "결제",
		// 	showDenyButton: true,
		// 	text: radioVal + "원 " + msg,
		// 	icon: "info"
		// }).then((result) => {
		// 	if (result.isConfirmed) {
		// 		location.reload();
		// 	}
		// });
		let timerInterval;
		Swal.fire({
			title: "결제",
			html: "로딩 중입니다.",
			timer: 1000,
			timerProgressBar: true,
			didOpen: () => {
				Swal.showLoading();
				const timer = Swal.getPopup().querySelector("b");
				timerInterval = setInterval(() => {
					timer.textContent = `${Swal.getTimerLeft()}`;
				}, 100);
			},
			willClose: () => {
				clearInterval(timerInterval);
			}
		}).then((result) => {
			if (result.dismiss === Swal.DismissReason.timer) {
				console.log("타이머에 의해 닫혔습니다.");
				location.reload();
			}
		});
	});
};


// 라디오 버튼 요소 선택
var radioButtons = document.querySelectorAll('input[type="radio"]');

// 선택된 라디오 버튼 변경 시 이벤트 처리
radioButtons.forEach(function(radioButton) {
    radioButton.addEventListener('change', function() {
        // 선택된 라디오 버튼의 레이블 요소에 active 클래스 추가
        var label = this.nextElementSibling;
        console.log("label 값 : ", label);
        label.classList.add('active');
        
        // 선택되지 않은 라디오 버튼의 레이블 요소에서 active 클래스 제거
        var otherLabels = document.querySelectorAll('label.btn');
        otherLabels.forEach(function(otherLabel) {
            if (otherLabel !== label) {
                otherLabel.classList.remove('active');
            }
        });
    });
});

//숫자의 형태를 변환하는 함수
function numberFormatter(number) {
	var formattedNumber = number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',') + 'P';
	return formattedNumber;
}

// 결제가 완료되었을 때 발동
function processPayment(data, index) {
  $.ajax({
    type: "POST",
    url: '/mypage/complete',
    contentType: 'application/json',
    data: data,
    success: function(data) {
      console.log("체킁:", data);
      var res = data.res;

      if (res > 0) {
        //alert('포인트 결제 내역 저장 성공');
				// Swal.fire({
				// 	title: "안내",
				// 	text: '포인트 결제 내역 저장 성공',
				// 	icon: "info"
				// });
			} else {
				console.log(res);
				//alert('포인트 결제 내역 저장 실패');
				// Swal.fire({
				// title: "안내",
				// text: '포인트 결제 내역 저장 실패',
				// icon: "info"
				// });
      }
    }
  });
}

// 날짜의 형태를 변환하는 함수
function formatDate(dateString) {
  var dateObj = new Date(dateString);
  
  var year = dateObj.getFullYear();
  var month = dateObj.getMonth() + 1;
  var day = dateObj.getDate();
  
  var dayOfWeek = dateObj.getDay();
  var dayOfWeekString = "";
  switch (dayOfWeek) {
    case 0:
      dayOfWeekString = "일";
      break;
    case 1:
      dayOfWeekString = "월";
      break;
    case 2:
      dayOfWeekString = "화";
      break;
    case 3:
      dayOfWeekString = "수";
      break;
    case 4:
      dayOfWeekString = "목";
      break;
    case 5:
      dayOfWeekString = "금";
      break;
    case 6:
      dayOfWeekString = "토";
      break;
  }
  
  var formattedDate = year + "년 " + month + "월 " + day + "일(" + dayOfWeekString + ")";
  
  return formattedDate;
}


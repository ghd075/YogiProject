// 문의사항 등록 모달 창
$.questionInputModalFn = function() {

  // 모달창(등록) 닫기
  var questionModalClose = $(".questionModalClose");
  var questionModalContents = $(".questionModalContents");
  questionModalClose.click(function () {
    questionModalContents.hide();
    questionModalContents.css("opacity","0");
  });

  // 모달창(등록) 열기
	var questionAddBtn = $("#questionAddBtn");
    // 문의사항 등록
    questionAddBtn.click(function(){
      var questionModalContents = $(".questionModalContents");
      questionModalContents.show();
      questionModalContents.animate({opacity:"1"},200);
	}); 

    // 모달창(답변등록) 닫기
    var questionAnswerModalClose = $(".questionAnswerModalClose");
    var questionAnswerModalContents = $(".questionAnswerModalContents");
    questionAnswerModalClose.click(function () {
      questionAnswerModalContents.hide();
      questionAnswerModalContents.css("opacity","0");
    });
}

$.questionInputValidationChkFn = function(){
	var questionRegBtn = $("#questionRegBtn");
  questionRegBtn.on("click", function(){
    let boTitle = $("#boTitle").val();
    let boContent = $("#boContent").val();
    if(boTitle.length > 50){
      Swal.fire({
				title: "안내",
				text: "제목의 길이는 최대 50자까지 가능합니다",
				icon: "info"
			});
      return;
    }
    else if(boTitle.trim() == '') {
      Swal.fire({
				title: "안내",
				text: "제목을 작성해야 합니다.",
				icon: "info"
			});
      return;
    }

    if(!boContent) {
      Swal.fire({
				title: "안내",
				text: "내용을 작성해야 합니다.",
				icon: "info"
			});
      return;
    }

    let query = {
      boTitle: boTitle.trim(),
      boContent: boContent
    }
  
  $.ajax({
    type: "post",
    url : "/question/questionInputPost.do",
    data: query,
    success: function(res) {
      if(res == '1') {
        alert("문의 내용이 정상적으로 전달 되었습니다.");
        location.reload();
      }
      else {
        alert("서버 오류로 인해 문의 작성에 실패했습니다.");
      }
    },
    error: function() {
      alert("전송오류");
    }
  });

  });
};

$.questionBoardShowFn = function(){
  var textDropVerticalAlign = $(".textDropVerticalAlign");
  textDropVerticalAlign.click(function(){
      var thisIs = $(this);
      var questionTblCenter = thisIs.find(".plusMinus");
      var visibleDiv = thisIs.parent().find(".visibleDiv").is(":visible");
      console.log("visibleDiv : ", visibleDiv);
      if(visibleDiv) { // 게시글이 눈에 보임
          thisIs.parent().find(".visibleDiv").stop().slideUp(300);
          questionTblCenter.html("<i class='fas fa-plus'></i>");
      }else { // 게시글이 눈에 보이지 않음
          thisIs.parent().find(".visibleDiv").stop().slideDown(300);
          questionTblCenter.html("<i class='fas fa-minus'></i>");
      }
      // 방금 누른 것을 제외한 나머지 div는 싹 닫는다.
      thisIs.parent().siblings(".userQuestionList").children(".visibleDiv").slideUp(300);
      thisIs.parent().siblings(".userQuestionList").find(".plusMinus").html("<i class='fas fa-plus'></i>");
  });
};

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
        document.getElementById("helpBtn").disabled = true;
      }
      
    },
    error: function() {
      alert("전송 오류");
    }
  });
  
}


function questionAnswerComplete(idx) {
  let ans = confirm("문의 답변을 완료 하시겠습니까?");
  if(!ans) return;
  
  let answer = $("#answer").val();
  let query = {
      boNo : idx,
      answer : answer
  }
  
  $.ajax({
    type: "post",
    url: "/question/questionAnswer.do",
    data: query,
    success: function(res) {
      if(res == '1'){
        alert("답변 완료");
        location.reload();
      }
      else alert("수정 실패");
    },
    error: function() {
      alert("전송 오류");
    }
  });
}

window.onload = function() {
	let perPage = '<span id="perPage"></span>';
	$(".datatable-top .datatable-dropdown label:not(select)").css("color","#fff");
	$(".datatable-top .datatable-dropdown label").append(perPage);
	$(".datatable-top .datatable-dropdown label select").append("<option value='50'>50</option>");
	$(".datatable-top .datatable-dropdown label select").append("<option value='100'>100</option>");
	$(".datatable-top .datatable-dropdown label select").append("<option value='200'>200</option>");
	$(".datatable-top .datatable-dropdown label select").attr("onchange","changeView();");
	$(".datatable-pagination-list-item").attr("onclick","changeViewLive();");
	let search = '<input class="datatable-input" placeholder="내용 검색"'
	search +='type="search" title="Search within table" aria-controls="datatablesSimple">'
	$(".datatable-search").html(search);
	changeView();
};

function changeView() {
	let viewText = $(".datatable-info").html();
	viewText = viewText.replace("Showing ","");
	let firstCnt = viewText.split(' to ')[0];
	let lastCnt = viewText.split(' to ')[1].split(' of ')[0];
	let totCnt = viewText.split(' to ')[1].split(' of ')[1].replace(" entries","");
	$(".datatable-info").html(firstCnt + "번 ~ " + lastCnt + "번 자료 조회중 - 총 자료수 : " + totCnt + "개");
	$(".datatable-pagination-list-item-link").attr("onclick","changeViewLive();");
	$(".datatable-pagination-list-item-link").attr("onclick","changeViewLive();");
	if(view != null) clearTimeout(view);
}
function changeViewLive() {
	view = setTimeout(changeView,10);
}



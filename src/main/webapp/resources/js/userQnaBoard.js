// 높이 조절 함수
$.qnaLnbHequalContHFn = function(){
    var qnaLnb = $(".qnaLnb");
    var qnaListSet = $(".qnaListSet");
    
    qnaLnb.outerHeight("auto");
    qnaListSet.outerHeight("auto");
    
    var qnaLnbH = qnaLnb.outerHeight();
    console.log("qnaLnbH : " + qnaLnbH);
    var qnaListSetH = qnaListSet.outerHeight();
    console.log("qnaListSetH : " + qnaListSetH);
    
    if(qnaLnbH > qnaListSetH) {
        qnaListSet.outerHeight(qnaLnbH);
    }else if(qnaLnbH < qnaListSetH) {
        qnaLnb.outerHeight(qnaListSetH);
    }
};

// qnaLnb 아코디언 메뉴 기능
$.qnaLnbAccordianMenuFn = function(){
    var qnaLnbSubA = $(".qnaLnb .qmain>a");
    qnaLnbSubA.click(function(){
        var thisIs = $(this);
        var visibleSub = thisIs.next().is(":visible");
        console.log("visibleSub : ", visibleSub);
        if(visibleSub) { // 소 메뉴가 눈에 보임
            thisIs.next().stop().slideUp(300);
        }else { // 소 메뉴가 눈에 보이지 않음
            thisIs.next().stop().slideDown(300);
        }
        // 방금 누른 것을 제외한 나머지 .sub는 싹 닫는다.
        thisIs.parent().siblings(".qmain").children(".qsub").stop().slideUp(300);
        
        $.qnaLnbHequalContHFn();
    });
};

// qnaListSet 아코디언 게시판 기능
$.qnaListSetAccordianBoardFn = function(){
    var qnaListSet = $(".qnaListSet");
    qnaListSet.on('click', '.accordBoardList', function(){
        var thisIs = $(this);
        var visibleDiv = thisIs.parent().find(".visibleDiv").is(":visible");
        console.log("visibleDiv : ", visibleDiv);
        if(visibleDiv) { // 게시글이 눈에 보임
            thisIs.parent().find(".visibleDiv").stop().slideUp(300);
        }else { // 게시글이 눈에 보이지 않음
            thisIs.parent().find(".visibleDiv").stop().slideDown(300);
        }
        // 방금 누른 것을 제외한 나머지 div는 싹 닫는다.
        thisIs.parent().siblings(".accordBoardListCont").children(".visibleDiv").stop().slideUp(300);
        
        $.qnaLnbHequalContHFn();
    });
};

// QNA 등록 모달 창
$.qnaMenuAddClickFn = function() {
	var qnaAddBtn = $("#qnaAddBtn");
    // QNA 등록
	qnaAddBtn.click(function(){
        $("#popup").fadeIn();		// 모달창 보이기
        $('#excelFile').val('');    // 파일 입력 필드 초기화
	}); 
}

// QNA 등록 모달 창 닫기
$.popdownClickFn = function() {
	var popdown = $("#popdown");
    // QNA 등록 닫기
	popdown.click(function(){
        $("#popup").fadeOut();		// 모달창 감추기
	}); 
}

// 엑셀 다운로드 기능
$.downloadExcelClickFn = function() {
    var downloadExcelBtn = $("#downloadExcelBtn");
    downloadExcelBtn.click(function(){
       
        // 다운로드 요청
        window.location.href = "/qna/downloadExcel.do";
        
        // 모달 창 닫기
        $('#popup').hide();
    }); 
}
// 엑셀 업로드 기능
$.uploadExcelClickFn = function() {
    var uploadExcelBtn = $("#uploadExcelBtn");
    var form = $('#form1')[0];

    uploadExcelBtn.click(function(){

		var excelFile = $("#excelFile").val();
		
		if(!excelFile){
			alert("선택된 파일이 없습니다.");
			return false;
		}
		
        var file = document.getElementById("excelFile").files[0];
		
		if(!isExcelFile(file)){
			alert(".xlsx 형식만 지원합니다");
			return false;
		}

        var formData = new FormData(form); // 클릭 이벤트 발생 시 FormData 객체 생성

        console.log('form 값 : ', form);
        console.log('formData 값 : ', formData);

        $.ajax({
            type: "POST",
            enctype: 'multipart/form-data',
            url: "/qna/excelUpload.do",
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                console.log("data 전송 성공");
                console.log("data 전송 성공", data);
                alert("업로드 완료");

                // 모달 창 닫기
                $('#popup').hide();
            },
            error: function (e) {
                alert("업로드 중 오류 발생: " + e.responseText);
            }
        });
    })
}

// 엑셀 파일 확장자 체크
function isExcelFile(file) {
    console.log('file값 ', file);
    var ext = file.name.split(".").pop().toLowerCase();		//파일명의 확장자를 가져온다
    //확장자중 이미지에 해당하는 확장자가 아닌경우 -1 리턴 (false)
    return ($.inArray(ext, ["xlsx"]) === -1) ? false : true
}


// qna 카테고리 선택 시 qna 목록 동적으로 가져오기
$.qnaMenuChageFn = function() {
    // 페이지 로딩 시 전체 목록 가져오기
    fetchQnaList('');

    var qnaSelect = $("#qna_select");

    qnaSelect.change(function(){

        var menuName = $(this).val();

        console.log("menuName 값 : " + menuName);
        fetchQnaList(menuName);
    });
}

function fetchQnaList(menuName) {
    $.ajax({
        type: "GET",
        url: "/qna/getQnaMenuList.do",
        data : {
            menuName : menuName
        },
        dataType: "json",
        success: function (data) {
            console.log("data 전송 성공", data);

            var html = '<ul>';
            $.each(data, function(index, item){
                html += `
                <li class="accordBoardListCont">
                    <div class="accordBoardList">${item.boTitle}</div>
                    <div class="visibleDiv">${item.boContent}</div>
                </li>
                `;
            });
            html += '</ul>';

            $('.qnaListSet').html(html);
        }
    });
}
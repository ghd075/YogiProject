// 공지사항 > 중요공지 > 아코디언 게시판 기능
$.importantNoticeBoardShowFn = function(){
    var textDropVerticalAlign = $(".textDropVerticalAlign");
    textDropVerticalAlign.click(function(){
        var thisIs = $(this);
        var impNoticeTblCenter = thisIs.find(".plusMinus");
        var visibleDiv = thisIs.parent().find(".visibleDiv").is(":visible");
        console.log("visibleDiv : ", visibleDiv);
        if(visibleDiv) { // 게시글이 눈에 보임
            thisIs.parent().find(".visibleDiv").stop().slideUp(300);
            impNoticeTblCenter.html("<i class='fas fa-plus'></i>");
        }else { // 게시글이 눈에 보이지 않음
            thisIs.parent().find(".visibleDiv").stop().slideDown(300);
            impNoticeTblCenter.html("<i class='fas fa-minus'></i>");
        }
        // 방금 누른 것을 제외한 나머지 div는 싹 닫는다.
        thisIs.parent().siblings(".impNoticeList").children(".visibleDiv").slideUp(300);
        thisIs.parent().siblings(".impNoticeList").find(".plusMinus").html("<i class='fas fa-plus'></i>");
    });
};

$.noticeBoardPagingFn = function(event){
	var pagingArea = $("#pagingArea");
	var searchForm = $("#searchForm");
	pagingArea.on("click", "a", function(event){
		event.preventDefault(); // a태그의 이벤트를 block
		var pageNo = $(this).attr("data-page");
		console.log("pageNo : ", pageNo);
		searchForm.find("#page").val(pageNo);
		searchForm.submit();
	});
};

$.noticeFormCKED = function(){
    CKEDITOR.replace("boContent", {
		filebrowserUploadUrl: '/imageUpload.do'
	});
    CKEDITOR.config.height = "500px"; // CKEDITOR 높이 설정
};

$.noticeRegisterValidationChkFn = function(){
	var noticeRegBtn = $("#noticeRegBtn");
	var noticeForm = $("#noticeForm");
	var boTitle = $("#boTitle");
    noticeRegBtn.on("click", function(){
    
        var titleFlag = $.falsyCheckFn(boTitle, "제목");
		var boContent = CKEDITOR.instances.boContent.getData();
        
        if(!titleFlag) return;
        if(!boContent) {
            alert("내용을 입력해 주세요.");
            return false;
        }
        
        if($(this).text() == "공지사항 수정"){
        	noticeForm.attr("action", "/notice/admin/modify.do");
        }
        
        noticeForm.submit();
    });
};

// 다운로드 박스 높이를  같게 조절하는 함수
$.fileDownBoxHeightFn = function(){
    var fileDownCont = $(".fileDownCont");
    var topBoxH = 0;
    fileDownCont.each(function(i, v){
        var thisIs = $(this);
        var boxH = thisIs.find(".plexHeight").height();
        //console.log("boxH : " + boxH);
        if(topBoxH < boxH) {
            topBoxH = boxH;
        }
        //console.log("topBoxH : " + topBoxH);
    });
    fileDownCont.siblings().find(".plexHeight").height(topBoxH);
};

// 다운로드 미리보기 이미지 각각의 종횡비 변경 함수
$.eachPreviewImgBoxResizeFn = function(){
    $(".fileDownCont").each(function(i, v){
        var thisIs = $(this);
        var previewImgBox = thisIs.find(".previewImgBox");
        var previewImg = thisIs.find("img");
        $.ratioBoxH(previewImgBox, previewImg);
    });
};

// 이미지 파일 삭제 처리 함수
$.removeFileFn = function(){
	var noticeFileDelBtn = $(".noticeFileDownBtn");
	noticeFileDelBtn.click(function(){
		var thisIs = $(this);
		var fileDelCont = $(".fileDownCont");
		var delFileNo = thisIs.attr("dataFileNo");
		//console.log("delFileNo : " + delFileNo);
		$("#noticeForm").append("<input type='hidden' name='delNoticeNo' value='"+ delFileNo +"' />");
		thisIs.parents(".fileDownCont").hide();
		console.log("파일이 누네 보이니? : " + fileDelCont.is(":visible"));
		var delFileVisible = fileDelCont.is(":visible");
		if(!delFileVisible) {
			thisIs.parents(".card-footer").hide();
		}
	});
};
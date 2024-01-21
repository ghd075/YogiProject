// 공통 함수

// falsy한 값들 체크
$.falsyCheckFn = function(value, msg){
    var value = value.val();
    if(!value) {
        alert(msg + "을(를) 입력해주세요.");
        return false;
    }
    return true;
};

// 이미지 종횡비 계산 기능
$.ratioBoxH = function(boxEl, imgEl) {
    var boxSel = $(boxEl);
    var boxW = boxSel.width();
    var boxH = boxSel.height();
    var boxRatio = boxH / boxW;

    var imgSel = $(imgEl);
    
    var setImgDimensions = function() {
        var imgW = imgSel.width();
        var imgH = imgSel.height();
        var imgRatio = imgH / imgW;

        if (boxRatio < imgRatio) {
            //console.log("boxW :", boxW);
            imgSel.width(boxW).height("auto");
        } else {
            //console.log("boxH :", boxH);
            imgSel.height(boxH).width("auto");
        }
    };

    // 이미지의 로드 이벤트 핸들러 등록
    imgSel.on("load", setImgDimensions);

    // 초기 설정
    setImgDimensions();
};

// 이미지 미리보기 함수
$.imgPreviewFn = function(imgEl, profileImg){
    imgEl.on("change", function(e){
        var file = event.target.files[0];

        if(isImageFile(file)) {
            var reader = new FileReader();
            reader.onload = function(e){
                profileImg.attr("src", e.target.result);
            }
            reader.readAsDataURL(file);
        }else { // 이미지 파일이 아닐 때
            alert("이미지 파일을 선택해주세요!");
            imgEl.val("");
        }
        
        console.log(imgEl.val());
    });
};

// 이미지 파일인지 체크
function isImageFile(file){
    var ext = file.name.split(".").pop().toLowerCase(); // 파일명에서 확장자를 가져옵니다.
    return ($.inArray(ext, ["jpg", "jpeg", "gif", "png"]) === -1) ? false : true;
}

$.dateFickerNorFn = function(dateElement, callback){
    flatpickr(dateElement, {
      dateFormat: "Y-m-d",
      enableTime: false,
      minDate: "today",
      defaultDate: "today",
      locale: "ko",
    });
};
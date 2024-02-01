const AJAX_TYPE_POST = "POST";
const AJAX_TYPE_GET = "GET";

// 종횡비
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
   
$.eachBestImgResizeFn = function(){
    $(".bestContents article").each(function(i, v){
        var thisIs = $(this);
        var infoThumbnailBox = thisIs.find(".infoThumbnailBox");
        var infoThumbnailImg = thisIs.find("img:not(.planRank)");
        
        $.ratioBoxH(infoThumbnailBox, infoThumbnailImg);
    });
};
    
/* 탭버튼 처리 */
$.bestPlansTabbtnFn = function(){
  var bestPlansTabbtn = $(".bestPlansTabbtnGroup .tabbtn");
  var bestPlansTabcontBox = $(".bestPlansTabcontBox .tabcont");
  bestPlansTabcontBox.hide();
  bestPlansTabcontBox.eq(0).show();
  // 탭버튼 클릭 이벤트
  bestPlansTabbtn.click(function(){
    var thisIs = $(this);
    bestPlansTabbtn.removeClass("tactive");
    thisIs.addClass("tactive");
    var idx = thisIs.index();
    bestPlansTabcontBox.hide();
    bestPlansTabcontBox.eq(idx).find('.forArea').empty().append("<h3>지역별 플랜</h3>");
    // 탭이동시 지역초기화
    $("#areaCode").val("0").prop("selected", true);
    // 월간 베스트 플랜, 지역별 플랜 ajax 실행
    draw.getSortedByArea({"areaCode" : 0})
    draw.getSortedByLikes();
    bestPlansTabcontBox.eq(idx).show();
  });
};

//공통 함수
var common =  {
	getInfo : function (method, url, type, data, callbackFunction) {
		$.ajax({
			type: method,
			url: 	url,
			data : (AJAX_TYPE_POST === type ? JSON.stringify ( data ) : data),
			contentType: (AJAX_TYPE_POST === type ? "application/json; charset=utf-8" : undefined),
			success : function(data) {
				// console.log("체킁:",data);
				// callbackFunction(data);
			}
		});
  },
	getInfoSimple : function (method, url, callbackFunction) {
		$.ajax({
			type: method,
			url: 	url,
			success : function(data) {
				//console.log("체킁:",data);
				callbackFunction(data);
			}
		});
	},
  getList : function (method, url, data, callbackFunction) {
    $.ajax({
			type: method,
			url: 	url,
      data: data,
			success : function(data) {
				// console.log("체킁:",data);
        callbackFunction(data);
			}
		});
  },
  noParsingAjax : function (method, url, data) {
		$.ajax({
			type: method,
			url: 	url,
      data: data,
			success : function(data) {
				// console.log("체킁:",data);
				//callbackFunction(data);
			}
		});
  }
}

// 데이터 렌더링
var draw = {
  getAreas : function(data) {
    common.getInfoSimple('GET', '/myplan/selectAreaLIst.json', parsing.areaListParsing);
  },
  getSortedByLikes : function(data) {
    common.getList('GET', '/myplan/getSortedByLikes.do', data, parsing.getSortedByLikesParsing);
  },
  getSortedByArea : function(data) {
    common.getList('GET', '/myplan/getSortedByArea.do', data, parsing.getSortedByAreaParsing);
  },
  addLike : function(data) {
    common.noParsingAjax('GET', '/myplan/addLike.do', data);
  },
  delLike : function(data) {
    common.noParsingAjax('GET', '/myplan/delLike.do', data);
  },
  alreadyActivatedLike : function(data) {
    common.getList('GET', '/myplan/alreadyActivatedLike.do', data, parsing.likeParsing);
  }
}

// 데이터 파싱
var parsing = {
	test : function(data) {
		console.log(data);
	},
	dataParsing  : function(data) {
		var html = "";
		var html1 = "";
		var list = data.lists;
		var count = data.count;
		if (count > 0) {
			html1 += `<p>${count} 개의 검색결과가 있습니다.</p>`;
		} else {
			html1 += `<tr><td colspan='4' align='center'>검색 결과가 없습니다.</td></tr>`;
		}
		if (Array.isArray(list)) {
			// console.log("배열입니다.");
			$.each(list, function (i, item) {
				html += `
						<div class="card mb-2">
								<img onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstimage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude});" class="card-img-top fixed1" src="${item.firstimage}" alt="Card image cap">
								<div class="movie-item-body" style="text-align: center;padding-top: 2%;">
										<h6 onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstimage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude});" style="margin-bottom: 2%;font-weight: bold;">${item.title}</h6>
								</div>
								<div style="padding: .1rem 0 .1rem 0.3rem;background-color: rgba(0, 0, 0, .03); border-top: 1px solid rgba(0, 0, 0, .125);text-align: right;margin-right: 3%;">
										<button style="border-radius: 7%;" onclick="markerm(${item.latitude}, ${item.longitude}, '${item.title}', '${item.firstimage}', '${item.address}', '${item.zipcode}'); panTo(${item.latitude}, ${item.longitude}); showMovie(${item.contentid})" class="btn-primary btn-show-movie fixed2" data-toggle="modal" data-target="#show-movie-modal" data-id="${item.contentid}">More</button>
										<button style="border-radius: 7%;margin-left: 2%;" class="btn-info btn-add-favorite" data-id="${item.contentid}" onclick="addS_plan(${item.contentid})">+</button>
								</div>
						</div>`;
			});
		}
		$("#result").html(html1);
		$("#data-panel").html(html);
	},
  areaListParsing : function(data) {
    var areaCode = $('#areaCode');
    var areaCd;
    var areaNm;
    if (Array.isArray(data)) {
      $.each(data, function (i, item) {
        areaCd = item.areaCode;
        areaNm = item.areaName;
        areaCode.append($('<option>', {
          value: areaCd,
          text: areaNm,
          'data-latitude': item.latitude,
          'data-longitude': item.longitude
        }));
      });
    }
  },
  sigunguListParsing : function(data) {
    var areaCode = $('#areaCode').val();
    var sigunguCode = $('#sigunguCode');
    var sigunguCd;
    var sigunguNm;
    if (Array.isArray(data)) {
      $.each(data, function (i, item) {
        sigunguCd = item.sigunguCode;
        sigunguNm = item.sigunguName;
        sigunguCode.append($('<option>', {
          value: sigunguCd,
          text: sigunguNm,
          'data-latitude': item.latitude,
          'data-longitude': item.longitude
        }));
      });
    }
  },
  getSortedByAreaParsing : function(data) {
    let besConEl = $('.forArea');
		$('.forArea > article').remove();

    // 지역별 플랜 선택시 h3 변경 부분
    let locName = $("select[name=areaCode] option:selected").text();
    console.log(locName);
    let tempStr = "";
    if(locName == '지역 선택') {
      tempStr = '전체 플랜';
    } else {
      tempStr = locName + " 플랜";
    }
    $(".forArea h3:first").text(tempStr);

    // 
    if (Array.isArray(data)) {
      if(data.length == 0) {
        let html = "";
        html += `<article style="text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; margin-top:30px; border-radius: 4px;">
        해당 지역에 등록된 플랜이 없습니다.
      </article>`;
      besConEl.append(html);
      } else {
        $.each(data, function (i, item) {
          let html = "";
          html += `<article data-plnor="${item.plNo}">`;
          html += `<div class="infoThumbnailBox">`;
          if(item.plThumburl == "" || item.plThumburl == null) {
            html += `<img src="/resources/images/testimg/noimg.png" alt="이미지 미등록" />`;
          } else {
            html += `<img src="${item.plThumburl}" alt="플랜 썸네일 이미지" />`;
          }
          html += `<svg class="like" data-plno="${item.plNo}" xmlns="http://www.w3.org/2000/svg" height="30" width="30" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg>
                  </div>
                  <div>
                    <h4 class="textDrop">${item.plTitle}</h4>
                    <span class="infoCont">${item.memId}</span><br/>
                    <span class="infoCont">만든날짜 ${item.plRdate}</span><br/>
                    <span class="infoCont2">${item.plMsize} 명</span>
                    <span class="infoCont2">${item.plTheme}</span>
                    <span class="infocont2"><svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M225.8 468.2l-2.5-2.3L48.1 303.2C17.4 274.7 0 234.7 0 192.8v-3.3c0-70.4 50-130.8 119.2-144C158.6 37.9 198.9 47 231 69.6c9 6.4 17.4 13.8 25 22.3c4.2-4.8 8.7-9.2 13.5-13.3c3.7-3.2 7.5-6.2 11.5-9c0 0 0 0 0 0C313.1 47 353.4 37.9 392.8 45.4C462 58.6 512 119.1 512 189.5v3.3c0 41.9-17.4 81.9-48.1 110.4L288.7 465.9l-2.5 2.3c-8.2 7.6-19 11.9-30.2 11.9s-22-4.2-30.2-11.9zM239.1 145c-.4-.3-.7-.7-1-1.1l-17.8-20c0 0-.1-.1-.1-.1c0 0 0 0 0 0c-23.1-25.9-58-37.7-92-31.2C81.6 101.5 48 142.1 48 189.5v3.3c0 28.5 11.9 55.8 32.8 75.2L256 430.7 431.2 268c20.9-19.4 32.8-46.7 32.8-75.2v-3.3c0-47.3-33.6-88-80.1-96.9c-34-6.5-69 5.4-92 31.2c0 0 0 0-.1 .1s0 0-.1 .1l-17.8 20c-.3 .4-.7 .7-1 1.1c-4.5 4.5-10.6 7-16.9 7s-12.4-2.5-16.9-7z"/></svg></span>
                    <span class="infoCont">${item.likeCount}</span>
                  </div>`;      
                  html += `</article>`;
                  besConEl.append(html);
          });
        }
      }
      draw.alreadyActivatedLike({"memId" : sessionInfo});
      $.eachBestImgResizeFn();
  },
  getSortedByLikesParsing : function(data) {
    let besConEl = $('.forLikes');
		$('.forLikes > article').remove();
    if (Array.isArray(data)) {
      $.each(data, function (i, item) {
        let html = "";
        html += `<article data-plnor="${item.plNo}">`;
        html += `<div class="infoThumbnailBox">`;
        if(item.plThumburl == "" || item.plThumburl == null) {
          html += `<img src="/resources/images/testimg/noimg.png" alt="이미지 미등록" />`;
        } else {
          html += `<img src="${item.plThumburl}" alt="플랜 썸네일 이미지" />`;
        }

        if(i < 3) {
          html += `<img class="planRank" src="/resources/images/planner/rank${i+1}.png">`
        }
        html += `<svg class="like" data-plno="${item.plNo}" xmlns="http://www.w3.org/2000/svg" height="30" width="30" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M47.6 300.4L228.3 469.1c7.5 7 17.4 10.9 27.7 10.9s20.2-3.9 27.7-10.9L464.4 300.4c30.4-28.3 47.6-68 47.6-109.5v-5.8c0-69.9-50.5-129.5-119.4-141C347 36.5 300.6 51.4 268 84L256 96 244 84c-32.6-32.6-79-47.5-124.6-39.9C50.5 55.6 0 115.2 0 185.1v5.8c0 41.5 17.2 81.2 47.6 109.5z"/></svg>
                </div>
                <div>
                  <h4 class="textDrop">${item.plTitle}</h4>
                  <span class="infoCont">${item.memId}</span><br/>
                  <span class="infoCont">만든날짜 ${item.plRdate}</span><br/>
                  <span class="infoCont2">${item.plMsize} 명</span>
                  <span class="infoCont2">${item.plTheme}</span>
                  <span class="infocont2"><svg xmlns="http://www.w3.org/2000/svg" height="16" width="16" viewBox="0 0 512 512"><!--!Font Awesome Free 6.5.1 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M225.8 468.2l-2.5-2.3L48.1 303.2C17.4 274.7 0 234.7 0 192.8v-3.3c0-70.4 50-130.8 119.2-144C158.6 37.9 198.9 47 231 69.6c9 6.4 17.4 13.8 25 22.3c4.2-4.8 8.7-9.2 13.5-13.3c3.7-3.2 7.5-6.2 11.5-9c0 0 0 0 0 0C313.1 47 353.4 37.9 392.8 45.4C462 58.6 512 119.1 512 189.5v3.3c0 41.9-17.4 81.9-48.1 110.4L288.7 465.9l-2.5 2.3c-8.2 7.6-19 11.9-30.2 11.9s-22-4.2-30.2-11.9zM239.1 145c-.4-.3-.7-.7-1-1.1l-17.8-20c0 0-.1-.1-.1-.1c0 0 0 0 0 0c-23.1-25.9-58-37.7-92-31.2C81.6 101.5 48 142.1 48 189.5v3.3c0 28.5 11.9 55.8 32.8 75.2L256 430.7 431.2 268c20.9-19.4 32.8-46.7 32.8-75.2v-3.3c0-47.3-33.6-88-80.1-96.9c-34-6.5-69 5.4-92 31.2c0 0 0 0-.1 .1s0 0-.1 .1l-17.8 20c-.3 .4-.7 .7-1 1.1c-4.5 4.5-10.6 7-16.9 7s-12.4-2.5-16.9-7z"/></svg></span>
                  <span class="infoCont">${item.likeCount}</span>
                </div>`;      
                html += `</article>`;
                besConEl.append(html);
        });
      }
      draw.alreadyActivatedLike({"memId" : sessionInfo});
      $.eachBestImgResizeFn();
  },
  likeParsing : function(data) {
  	likeArr.length = 0;
    $.each(data, function(i, item) {
      likeArr.push(data[i]);
    });
    console.log("likeArr", likeArr);
    if(likeArr.length == 0) {
      return;
    } 

    $(".like").each(function(i, item){
      let thisIs = $(this);
      for(let i = 0; i<likeArr.length; i++) {
        if(parseInt(thisIs.data('plno')) == likeArr[i].plNo){
          thisIs.addClass('active');
        }
      }
    });
  }
}

// 액션 호출 함수

/* 지역 변경시 */
$.areaChange = function(){
	$("select[name=areaCode]").change(function(){
		let selArea = $(this).val();
		console.log($(this).val()); //value값 가져오기
		console.log($("select[name=areaCode] option:selected").text()); //text값 가져오기
		draw.getSortedByArea({"areaCode" : selArea});
		
	});
};

/* 좋아요 누르고 다시누르는 부분 */
$.likeChange = function(sessionInfo){
  $(document).on("click",".like",function(event){
  event.stopPropagation();
  
  
    let thisIs = $(this);
    let likeEl = $(this).parent().siblings().children('span:nth-last-child(1)');
  
    if(sessionInfo == null || sessionInfo == '' || sessionInfo.length == 0) {
      Swal.fire({
          text: "좋아요는 로그인시에만 누르실 수 있습니다.",
          icon: "info"
      });
      return;
    }
    
    if(!thisIs.hasClass("active")) {
      thisIs.addClass('active');
      let likeCnt = likeEl.text();
      let likeCntInt = parseInt(likeCnt) + 1;
      likeEl.empty();
      likeEl.text(likeCntInt);
      let data = {
        "plNo" : thisIs.data('plno'),
        "memId" : sessionInfo
      };

      draw.addLike(data);
      draw.alreadyActivatedLike({"memId" : sessionInfo});
      
    } else {
      thisIs.removeClass('active');
      let likeCnt = likeEl.text();
      let likeCntInt = parseInt(likeCnt) - 1;
      likeEl.empty();
      likeEl.text(likeCntInt);
      let data = {
        "plNo" : thisIs.data('plno'),
        "memId" : sessionInfo
      };

      draw.delLike(data);
    }
  });
}
/*
  [정렬기준 탭 버튼, 더보기 버튼 클릭 시 이벤트]
*/
$.sortBtnFn = function(){
  //정렬기준 탭 버튼
  var lowestPriceTab = $('#lowestPrice');
  var shortDurationTab = $('#shortDuration');
  var recommendationTab = $('#recommendation');
  var moreBtn = $('#moreBtn');
  var selectSort = $('#selectSort');

  //렌더링할 위치
  var contentSet = $('.contentSet');
  var mainContent = $('.mainContent');
  
  var recoPrice = $('#recoPrice');
  var recoDuration = $('#recoDuration');
  
  var moreRendering = '';
  var priceRendering = '';
  var durRendering = '';
  var recoRendering = '';

  
  //최초 탭버튼 색
  lowestPriceTab.css('background-color', 'rgb(5, 32, 60)').css('color', 'white');
  
    //select박스 클릭 시 tab에 강제 이벤트 발생시키기
   selectSort.on('change', function(e){
	 var select = selectSort.find(':selected').val();
	 if(select === 'priceSelect'){
	   lowestPriceTab.trigger('click');
	 }
	 if(select === 'durationSelect'){
	   shortDurationTab.trigger('click');
	 }
	 if(select === 'recoSelect'){
	   recommendationTab.trigger('click');
	 }
   });
	
	 //더보기 버튼 클릭 시
	 moreBtn.on('click', function(){
	   var select = selectSort.find(':selected').val();
	   var type = '';
	   if(select === 'priceSelect'){
	      type = 'price';
	   }
	   if(select === 'durationSelect'){
	      type = 'duration';
	   }
	   if(select === 'recoSelect'){
	      type = 'recommendation';
	   }
		 
	   $.ajax({
		type : 'get',
		url : '/reserve/air/search/moreList.do?type='+type,
		dataType : 'json',
		success : function(res){
		   console.log('더보기 버튼 클릭 후 응답 : '+res.pageList);
		   if(res.msg === 'NO'){
			   alert('전송실패!');
			   return false;
		   }
		    if(type == 'recoSelect'){
		       recoPrice.text(numberFormatter(res.sortVO.recoPrice));
			   recoDuration.text(res.sortVO.recoDuration+'평균');
		    }
		    moreRendering = getRenderingPage(res.pageList);
		    mainContent.remove();   //기존 컨텐츠 내용 삭제
		    contentSet.html(moreRendering);    
		 }  
	   });  
	  
	});
	 
	 
	 //최저가 탭 버튼 클릭 시
	 lowestPriceTab.on('click', function(){
	   shortDurationTab.css('background-color', 'white').css('color', 'black'); 
	   recommendationTab.css('background-color', 'white').css('color', 'black'); 
	   lowestPriceTab.css('background-color', 'rgb(5, 32, 60)').css('color', 'white');
	   $('#priceSelect').prop('selected', true);
	   
	   if(priceRendering != ''){
	     mainContent.remove();   
		 contentSet.html(priceRendering);  
	   }else{
	   $.ajax({
		type : 'get',
		url : '/reserve/air/search/sort.do?type=price',
		dataType : 'json',
		success : function(res){
		   console.log('최저가 버튼 클릭 후 응답 : '+res.pageList);
		   if(res.msg === 'NO'){
			   alert('전송실패!');
			   return false;
		   }
		   priceRendering = getRenderingPage(res.pageList);
		   mainContent.remove();   //기존 컨텐츠 내용 삭제
		   contentSet.html(priceRendering);
		 }  
	   });  
	  }
	});

     
     //최단시간 탭 버튼 클릭 시
     shortDurationTab.on('click', function(){
    	lowestPriceTab.css('background-color', 'white').css('color', 'black'); 
    	recommendationTab.css('background-color', 'white').css('color', 'black'); 
    	shortDurationTab.css('background-color', 'rgb(5, 32, 60)').css('color', 'white');
    	$('#durationSelect').prop('selected', true);
    	
    	if(durRendering != ''){
	     mainContent.remove();   
		 contentSet.html(durRendering);  
	   }else{
    	$.ajax({
    	  type : 'get',
    	  url : '/reserve/air/search/sort.do?type=duration',
    	  dataType : 'json',
    	  success : function(res){
             console.log('최단시간 버튼 클릭 후 응답 : '+res.pageList);
             if(res.msg === 'NO'){
                 alert('전송실패!');
                 return false;
             }
			 durRendering = getRenderingPage(res.pageList);
			 mainContent.remove();   //기존 컨텐츠 내용 삭제
			 contentSet.html(durRendering);
    	  }  
    	 }); 
       } 
     });  

     
     //추천 탭 버튼 클릭 시
     recommendationTab.on('click', function(){
    	lowestPriceTab.css('background-color', 'white').css('color', 'black'); 
    	shortDurationTab.css('background-color', 'white').css('color', 'black'); 
    	recommendationTab.css('background-color', 'rgb(5, 32, 60)').css('color', 'white');
    	$('#recoSelect').prop('selected', true);
    	
       if(recoRendering != ''){
	     mainContent.remove();   
		 contentSet.html(recoRendering);  
	   }else{
		$.ajax({
			type : 'get',
			url : '/reserve/air/search/sort.do?type=recommendation',
			dataType : 'json',
			success : function(res){
			   console.log('추천순 버튼 클릭 후 응답 : '+res.pageList);
			   if(res.msg === 'NO'){
				   alert('전송실패!');
				   return false;
			   }
			   recoPrice.text(numberFormatter(res.sortVO.recoPrice));
			   recoDuration.text(res.sortVO.recoDuration+'평균');

			   recoRendering = getRenderingPage(res.pageList); //렌더링 페이지
			   mainContent.remove();   //기존 컨텐츠 내용 삭제
			   contentSet.html(recoRendering);
			}  
		 });
		}  
     });

	/*
	[가는날,오늘날,소요시간 조회 관련]
	*/
	 var searchForm = $('#searchForm');
	 var depRange = $('#depRange');
	 var arrRange = $('#arrRange');
	 var durRange = $('#durRange');
	 var arrTime = '';
	 var depTime = '';
	 var durTime = '';
	 var hours;
	 var mins;
	 var errorPage = '';
	 
	 var recoPrice = $('#recoPrice');
	 var recoDuration = $('#recoDuration');
	 var shortestPrice = $('#shortestPrice');
	 var shortestDuration = $('#shortestDuration');
	 var lowPrice = $('#lowPrice');
	 var lowDuration = $('#lowDuration');
	 var resultCnt = $('#resultCnt');

	//가는날 설정 시 이벤트
	depRange.on('change', function(){
		var depVal = parseInt($(this).val());
		depTime = rangeFormatter(depVal);  
 
		$('#depRangeVal').text(ampmFormatter(hours));
 
		 var select = selectSort.find(':selected').val();
		 var type = '';
		 if(select === 'priceSelect'){
			type = 'price';
		 }
		 if(select === 'durationSelect'){
			type = 'duration';
		 }
		 if(select === 'recoSelect'){
			type = 'recommendation';
		 }
		 $.ajax({
			 type : 'get',
			 url : '/reserve/air/subsearch/timeSearch.do?type='+type+'&depTime='+depTime+'&arrTime='+arrTime+'&durTime='+durTime,
			 dataType : 'json',
			 success : function(res){
				console.log('출발시간 설정 후 응답 : '+res.pageList);
				if(res.msg === 'NO'){
					mainContent.remove();   //기존 컨텐츠 내용 삭제
					contentSet.html(errorPage);
					resultCnt.text('0개의 검색결과...');
					
				    recoPrice.text('₩0');
				   recoDuration.text('0분');
				   shortestPrice.text('₩0');
				   shortestDuration.text('0분');
				   lowPrice.text('₩0');
				   lowDuration.text('0분');
					return false;
				}
				resultCnt.text(res.searchInfo.totalRecord+'개의 검색결과...');
				
				recoPrice.text(numberFormatter(res.sortVO.recoPrice));
			    recoDuration.text(res.sortVO.recoDuration+'(평균)');
				shortestPrice.text(numberFormatter(res.sortVO.shortestPrice));
				shortestDuration.text(res.sortVO.shortestDuration+'(평균)');
				lowPrice.text(numberFormatter(res.sortVO.lowestPrice));
				lowDuration.text(res.sortVO.lowestDuration+'(평균)');

				mainContent.remove();   //기존 컨텐츠 내용 삭제
				contentSet.html(getRenderingPage(res.pageList));
			 }  
		  });
	 });
 
 
	 //오늘날 설정 시 이벤트
	 arrRange.on('change', function(){
		 var arrVal = parseInt($(this).val());
		arrTime = rangeFormatter(arrVal);
		 $('#arrRangeVal').text(ampmFormatter(hours));
 
		 var select = selectSort.find(':selected').val();
		 var type = '';
		 if(select === 'priceSelect'){
			type = 'price';
		 }
		 if(select === 'durationSelect'){
			type = 'duration';
		 }
		 if(select === 'recoSelect'){
			type = 'recommendation';
		 }

		 $.ajax({
			type : 'get',
			url : '/reserve/air/subsearch/timeSearch.do?type='+type+'&arrTime='+arrTime+'&depTime='+depTime+'&durTime='+durTime,
			dataType : 'json',
			success : function(res){
			   console.log('도착시간 설정 후 응답 : '+res.pageList);
			   if(res.msg === 'NO'){
				   mainContent.remove();   //기존 컨텐츠 내용 삭제
				   contentSet.html(errorPage);
				   resultCnt.text('0개의 검색결과...');
				   
				   recoPrice.text('₩0');
				   recoDuration.text('0분');
				   shortestPrice.text('₩0');
				   shortestDuration.text('0분');
				   lowPrice.text('₩0');
				   lowDuration.text('0분');
				   return false;
			   }
			   resultCnt.text(res.searchInfo.totalRecord+'개의 검색결과...');
			     
			   recoPrice.text(numberFormatter(res.sortVO.recoPrice));
			   recoDuration.text(res.sortVO.recoDuration+'(평균)');
			   shortestPrice.text(numberFormatter(res.sortVO.shortestPrice));
			   shortestDuration.text(res.sortVO.shortestDuration+'(평균)');
			   lowPrice.text(numberFormatter(res.sortVO.lowestPrice));
			   lowDuration.text(res.sortVO.lowestDuration+'(평균)');
			   
			   mainContent.remove();   //기존 컨텐츠 내용 삭제
			   contentSet.html(getRenderingPage(res.pageList));
			}  
		 });
	 });
	 
	 //운항시간 설정 시 이벤트
	 durRange.on('change', function(){
		 durTime = parseInt($(this).val());
		 $('#durRangeVal').text(durTime+'분');
		 var select = selectSort.find(':selected').val();
		 var type = '';
		 if(select === 'priceSelect'){
			type = 'price';
		 }
		 if(select === 'durationSelect'){
			type = 'duration';
		 }
		 if(select === 'recoSelect'){
			type = 'recommendation';
		 }

		 $.ajax({
			type : 'get',
			url : '/reserve/air/subsearch/timeSearch.do?type='+type+'&arrTime='+arrTime+'&depTime='+depTime+'&durTime='+durTime,
			dataType : 'json',
			success : function(res){
			   console.log('운항시간 설정 후 응답 : '+res.pageList);
			   if(res.msg === 'NO'){
				   mainContent.remove();   //기존 컨텐츠 내용 삭제
				   contentSet.html(errorPage);
				   resultCnt.text('0개의 검색결과...');
				   
				   recoPrice.text('₩0');
				   recoDuration.text('0분');
				   shortestPrice.text('₩0');
				   shortestDuration.text('0분');
				   lowPrice.text('₩0');
				   lowDuration.text('0분');
				   return false;
			   }
			   resultCnt.text(res.searchInfo.totalRecord+'개의 검색결과...');
			     
			   recoPrice.text(numberFormatter(res.sortVO.recoPrice));
			   recoDuration.text(res.sortVO.recoDuration+'(평균)');
			   shortestPrice.text(numberFormatter(res.sortVO.shortestPrice));
			   shortestDuration.text(res.sortVO.shortestDuration+'(평균)');
			   lowPrice.text(numberFormatter(res.sortVO.lowestPrice));
			   lowDuration.text(res.sortVO.lowestDuration+'(평균)');
			   
			   mainContent.remove();   //기존 컨텐츠 내용 삭제
			   contentSet.html(getRenderingPage(res.pageList));
			}  
		 });
	 });
	 
  //가는날,오는날range의 값을 받아 시간형태 변환
  function rangeFormatter(minutes){
	 hours = Math.floor(minutes / 60)+'';
	 hours = (hours < 10) ? '0' + hours : hours;
	 mins = minutes % 60+'';
	 mins = (mins < 10) ? '0' + mins : mins;
 
	 //form에 적용하여 전송할 데이터
	 // var html = '<input type="hidden" name="'+type+'" value="'+(hours+mins)+'">'; 
	 // if(type == 'departRange'){
	 // 	$('input[name=departRange]').remove();
	 // 	searchForm.append(html);
	 // }else if(type == 'arrivalRange'){
	 // 	$('input[name=arrivalRange]').remove();
	 // 	searchForm.append(html);
	 // }
	 return hours+mins;
   }
 
   function ampmFormatter(hours){
	   var ampm = (hours >= 12) ? '오후' : '오전';
	   hours = (hours % 12 === 0) ? 12 : hours % 12;
	   return ampm+' '+hours+':'+mins;
   }


     //페이지 생성 함수
	 function getRenderingPage(pageList){
		var rendering = '';
		   $.each(pageList, function(i, flight){
			//이미지 경로 예외처리
			var depPath = flight.departure.airlineLogo;
            if(depPath == null || depPath == ''){
				depPath = '/resources/images/air/list/basic.PNG';
			}
			var arrPath = flight.arrival.airlineLogo;
            if(arrPath == null || arrPath == ''){
				arrPath = '/resources/images/air/list/basic.PNG';
			}

			rendering += '<form action="/reserve/air/reserve/reserve.do" method="get">';
			rendering += ' <div class="mainContent">';
			rendering += '   <div class="row">';
			rendering += '      <input type="hidden" value="'+flight.departure.flightCode+'" name="depFlightCode">';
			rendering += '      <div class="col-sm-2">';
			rendering += '          <img src="'+depPath+'">';
			rendering += '      </div>';
			rendering += '      <div class="col-sm-2 middle">';
			rendering += '         <span>'+timeFormatter(flight.departure.flightDeptime)+'</span><br>';
			rendering += '         <span style="font-weight: normal; font-size: 16px;">'+flight.departure.flightDepairport+'('+flight.departure.flightDepportcode+')</span>';
			rendering += '      </div>';
			rendering += '      <div class="col-sm-3 middle">';
			rendering += '         <span style="font-size: 15px;">'+flight.departure.flightDuration+' (편도)</span>';
			rendering += '         <img src="/resources/images/air/list/경로.PNG">';
			rendering += '      </div>';
			rendering += '      <div class="col-sm-2 middle third">';
			rendering += '         <span>'+timeFormatter(flight.departure.flightArrtime)+'</span><br>';
			rendering += '         <span style="font-weight: normal; font-size: 16px;">'+flight.departure.flightArrairport+'('+flight.departure.flightArrportcode+')</span>';
			rendering += '      </div>';
			rendering += '      <div class="col-sm-3 end" style="border-left: 2px solid rgb(239, 241, 242);">';
			rendering += '        <span style="font-size: 22px;" id="roundTripPrice">'+numberFormatter(flight.roundTripPrice)+'</span>';
			rendering += '        <svg xmlns="http://www.w3.org/2000/svg" height="30" width="30" viewBox="0 0 512 512">';
			rendering += '          <path d="M225.8 468.2l-2.5-2.3L48.1 303.2C17.4 274.7 0 234.7 0 192.8v-3.3c0-70.4 50-130.8 119.2-144C158.6 37.9 198.9 47 231 69.6c9 6.4 17.4 13.8 25 22.3c4.2-4.8 8.7-9.2 13.5-13.3c3.7-3.2 7.5-6.2 11.5-9c0 0 0 0 0 0C313.1 47 353.4 37.9 392.8 45.4C462 58.6 512 119.1 512 189.5v3.3c0 41.9-17.4 81.9-48.1 110.4L288.7 465.9l-2.5 2.3c-8.2 7.6-19 11.9-30.2 11.9s-22-4.2-30.2-11.9zM239.1 145c-.4-.3-.7-.7-1-1.1l-17.8-20c0 0-.1-.1-.1-.1c0 0 0 0 0 0c-23.1-25.9-58-37.7-92-31.2C81.6 101.5 48 142.1 48 189.5v3.3c0 28.5 11.9 55.8 32.8 75.2L256 430.7 431.2 268c20.9-19.4 32.8-46.7 32.8-75.2v-3.3c0-47.3-33.6-88-80.1-96.9c-34-6.5-69 5.4-92 31.2c0 0 0 0-.1 .1s0 0-.1 .1l-17.8 20c-.3 .4-.7 .7-1 1.1c-4.5 4.5-10.6 7-16.9 7s-12.4-2.5-16.9-7z"/>';
			rendering += '        </svg><br><br>';
			rendering += '        <span id="totalPrice">(총가격 : '+numberFormatter(flight.totalPrice)+')</span><br>';
			rendering += '      </div>';
			rendering += '   </div>';
			rendering += '   <div class="row">';
			rendering += '       <input type="hidden" value="'+flight.arrival.flightCode+'" name="arrFlightCode">';
			rendering += '       <div class="col-sm-2">';
			rendering += '           <img src="'+arrPath+'">';
			rendering += '       </div>';
			rendering += '       <div class="col-sm-2 middle">';
			rendering += '         <span>'+timeFormatter(flight.arrival.flightDeptime)+'</span><br>';
			rendering += '         <span style="font-weight: normal; font-size: 16px;" id="flightDepairport2">'+flight.arrival.flightDepairport+'('+flight.arrival.flightDepportcode+')</span>';
			rendering += '       </div>';
			rendering += '       <div class="col-sm-3 middle">';
			rendering += '          <span style="font-size: 15px;">'+flight.arrival.flightDuration+' (편도)</span>';
			rendering += '          <img src="/resources/images/air/list/경로.PNG">';
			rendering += '       </div>';
			rendering += '       <div class="col-sm-2 middle">';
			rendering += '         <span id="flightArrtime2">'+timeFormatter(flight.arrival.flightArrtime)+'</span><br>';
			rendering += '         <span style="font-weight: normal; font-size: 16px;">'+flight.arrival.flightArrairport+'('+flight.arrival.flightArrportcode+')</span>';
			rendering += '       </div>';
			rendering += '       <div class="col-sm-3 end" style="border-left: 2px solid rgb(239, 241, 242);">';
			rendering += '         <button type="submit" class="btn btn-primary">선택하기</button> ';
			rendering += '       </div>';
			rendering += '   </div>';
			rendering += ' </div>';
			rendering += '</form>';
		   });  //each문 끝
		 return rendering;
	 }
	 errorPage += '<div class="mainContent">';
	 errorPage += '  <div class="row">';
	 errorPage += '	<div class="col-sm-12" style="padding-left: 280px;">';
	 errorPage += '	  <br>&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;';
	 errorPage += '	  <img src="/resources/images/air/list/nothing.PNG"><br><br>';
	 errorPage += '	  <p style="font-size: 20px; font-weight: bolder;">죄송합니다. 검색조건에 일치하는 항공권이 없습니다.</p>';
	 errorPage += '	</div>';
	 errorPage += '  </div>';
	 errorPage += '</div>';
}



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
	function numberFormatter(number){
		return '₩'+number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}




















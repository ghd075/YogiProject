
$.tabBtnFn = function(){
   var tabBtn = $('.tabBtn');
   tabBtn.click(function(){
     var selectTab = $(this);
     
     if(selectTab.attr('class') == 'col-sm-4 left-tab tabBtn tactive' || selectTab.attr('class') == 'col-sm-8 right-tab tabBtn tactive'){
       return false;
     }
     
     selectTab.css('background-color', 'white').css('color', 'black');  //클릭한 탭 색상 변경
     $('.tactive').css('background-color', 'gray').css('color', 'white'); //클릭하지않은 탭 색상 변경
     tabBtn.removeClass('tactive');
     selectTab.addClass('tactive');
     
     var index = selectTab.index();
     
     $('.content-top').hide();  //상단정보숨김
     $('.content-middle2').hide();  //좌석정보숨김
     
     $('.content-top').eq(index).show(); //클릭한 탭영역의 상단 표출
     $('.content-middle2').eq(index).show(); //클릭한 탭영역의 좌석 표출
   });
   
}
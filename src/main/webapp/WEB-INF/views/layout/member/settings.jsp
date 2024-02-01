<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
    $(function(){
        // 공통 함수
        $.mLnbClickEvent();
        $.footerRelatedSiteFn();
        $.mmainClickEvent700();
        
     	// 로그인/로그아웃 감지 기능
     	var memId = "${sessionInfo.memId}";
        $.loginDetectWebSocketFn(memId);
        
        // 종횡비 함수
        var pcgnbMainProfileImgCont = $(".pcgnb .mainProfileImgCont");
        var pcgnbMainProfileImg = $(".pcgnb .mainProfileImgCont img")
        $.ratioBoxH(pcgnbMainProfileImgCont, pcgnbMainProfileImg);
        
        var mgnbMainProfileImgCont = $(".mgnb .mainProfileImgCont");
        var mgnbMainProfileImg = $(".mgnb .mainProfileImgCont img");
        $.ratioBoxH(mgnbMainProfileImgCont, mgnbMainProfileImg);
    });
</script>
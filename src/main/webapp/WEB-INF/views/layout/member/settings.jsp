<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
    $(function(){
        // 공통 함수
        $.mLnbClickEvent();
        $.footerRelatedSiteFn();
        $.mmainClickEvent700();
        
        // 종횡비 함수
        var pcgnbMainProfileImgCont = $(".pcgnb .mainProfileImgCont");
        var pcgnbMainProfileImg = $(".pcgnb .mainProfileImgCont img")
        $.ratioBoxH(pcgnbMainProfileImgCont, pcgnbMainProfileImg);
        
        var mgnbMainProfileImgCont = $(".mgnb .mainProfileImgCont");
        var mgnbMainProfileImg = $(".mgnb .mainProfileImgCont img");
        $.ratioBoxH(mgnbMainProfileImgCont, mgnbMainProfileImg);
    });
</script>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set value="${pageContext.request.contextPath }" var="contextPath" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="author" content="부루마불" />
  <meta name="description" content="대덕인재개발원 7월반 4조 부루마불의 여기갈래 프로젝트입니다." />
  <meta name="keywords" content="부루마불, 여기갈래, 여행, 통합, 플랫폼" />
  <meta name="copyright" content="대덕인재개발원" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />  
  <title>에러페이지</title>
  <link href="${contextPath }/resources/images/favicon.ico" rel="shoutcut icon" /> 
  <!-- 제이쿼리 -->
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <!-- 부트스트랩 모듈 -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
  <!-- 폰트어썸, 구글 아이콘 디자인 -->
  <script src="https://kit.fontawesome.com/368f95b037.js" crossorigin="anonymous"></script> 
  <!-- 에러페이지 디자인 --> 
  <link href="${contextPath }/resources/css/error/error.css" rel="stylesheet" />    
</head>
<body oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>
	<div id="loading_Bar"></div>
	<div class="width" style="padding-top: 250px">
		<div class="text-center">
			<div style="font-size: 8em;">${errorCode}</div>
			<div class="mt-2 " style="font-size: 2.7em;"><i class="fa-solid fa-triangle-exclamation"></i> ${errorMsg}</div>
			<div class="mt-2 mb-4" style="font-size: 1.5em">${adviceMsg}</div>
		</div>
		<div class="text-center">
			<span class="text-center"><button type="button" onclick="location.href='${contextPath}/'" class="btn btn-success" ><i class="fa-solid fa-house-chimney"></i> 홈으로 이동</button></span>
			<span class="text-center"><button type="button" onclick="history.back();" class="btn btn-info" ><i class="fa-solid fa-rotate-right"></i> 이전페이지로</button></span>
		</div>
	</div>
</body>
<script>
	$(function(){
	  $("#loading_Bar").css("width","0px");
	  $("#loading_Bar").animate({width:"4000px"},500);
	  $("#loading_Bar").fadeOut("slow");
	});

</script>
</html>


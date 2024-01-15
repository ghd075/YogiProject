<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<c:set value="${pageContext.request.contextPath }" var="contextPath" />
<!DOCTYPE html>
<html lang="ko">
    <head>
        <meta charset="UTF-8" />
        <meta name="author" content="부루마불" />
        <meta name="description" content="대덕인재개발원 7월반 4조 부루마불의 여기갈래 프로젝트입니다." />
        <meta name="keywords" content="부루마불, 여기갈래, 여행, 통합, 플랫폼" />
        <meta name="copyright" content="대덕인재개발원" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>여기갈래 &gt; 랜딩 페이지</title>
        <link href="${contextPath }/resources/images/favicon.ico" rel="shoutcut icon" />
        <!-- 공통 css -->
        <link href="${contextPath }/resources/css/userCommon.css" rel="stylesheet" />
        <!-- 제이쿼리 -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <!-- 공통 js -->
        <script defer src="${contextPath }/resources/js/util.js"></script>
        <script defer src="${contextPath }/resources/js/userCommon.js"></script>
        <!-- 부트스트랩 모듈 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- 폰트어썸, 구글 아이콘 디자인 -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    	
        <%-- <c:remove var="message" scope="page" />
        <c:remove var="message" scope="session" />
        <c:remove var="message" scope="request" />
        <c:remove var="message" scope="application" /> --%>
        
    	<c:if test="${not empty message }">
		    <script type="text/javascript">
		        alert("${message}");
		        <c:remove var="message" scope="request" />
			    <c:remove var="message" scope="session" />
		    </script>
		</c:if>
		
	</head>
    <body class="scroll">
        
        <!-- 사용자 페이지 > 헤더 영역 -->
        <tiles:insertAttribute name="header" />
        
        <!-- 사용자 페이지 > 랜딩 페이지 구현 영역 -->
        <tiles:insertAttribute name="userMainContainer" />
        
        <!-- 사용자 페이지 > 푸터 영역 -->
		<tiles:insertAttribute name="footer" />
		
		<!-- 사용자 페이지 > 자바스크립트 세팅 영역 -->
		<tiles:insertAttribute name="settings" />

    </body>
</html>
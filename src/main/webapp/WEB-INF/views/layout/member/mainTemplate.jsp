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
        
        <!-- 사용자 페이지 > 헤더세팅 영역 -->
        <tiles:insertAttribute name="headerSettings" />
    	
        <%-- <c:remove var="message" scope="page" />
        <c:remove var="message" scope="session" />
        <c:remove var="message" scope="request" />
        <c:remove var="message" scope="application" /> --%>
        
    	<c:if test="${not empty message }">
		    <script type="text/javascript">
		        //alert("${message}");
		        $(function(){
		        	// 성공시
		        	<c:if test="${msgflag eq 'su'}">
		        		Swal.fire({
		                    title: "성공",
		                    text: "${message}",
		                    icon: "success"
		                });
		        	</c:if>
		        	// 실패시
		        	<c:if test="${msgflag eq 'fa'}">
			        	Swal.fire({
		                    title: "실패",
		                    text: "${message}",
		                    icon: "error"
		                });
		        	</c:if>
		        	// 정보성 메시지
		        	<c:if test="${msgflag eq 'in'}">
			        	Swal.fire({
		                    title: "안내",
		                    text: "${message}",
		                    icon: "info"
		                });
		        	</c:if>
		        });
		        <c:remove var="message" scope="request" />
			    <c:remove var="message" scope="session" />
		    </script>
		</c:if>
		
		<!-- 
    		내부 CSS 
    		- 내부 CSS는 외부 CSS의 스타일링을 건드리지 않기 위해서
    		개별적인 페이지에다 스타일을 적용할 때 종종 쓴다.
    		- 보통 프로토타이핑 테스트용이나, FE Leader의 판단에 따라 여기에
    		추가적인 스타일을 작성한다.
    	-->
    	<style>
    		.msub a {
    			color: #333;
    		}
    	</style>
		
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
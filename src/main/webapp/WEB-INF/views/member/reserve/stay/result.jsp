<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:choose>
  <c:when test="${not empty msg}">
   <script>
    $(function(){
    	  Swal.fire({
	          title: "성공",
	          text: "${msg}",
	          icon: "info"
	      }); 
     	  Swal.fire({   
  	  	    title: '결제가 완료되었습니다!',
  	  	    showDenyButton: true,
  	  	    showCancelButton: false,
  	  	    confirmButtonText: "결제내역 이동",
  	  	    denyButtonText: "장바구니 이동"
  	  	  }).then((result) => {
  	  	    if (result.isConfirmed) {
  	  	       location.href = '/mypage/paymentinfo.do';
  	  	    } else if (result.isDenied) {
  	  	       location.href = '/partner/buyPlan.do?plNo='+${plNo};
  	  	    }
  	  	  });
    })
   </script>
  </c:when>
  <c:otherwise>
  <script>
    $(function(){
    	  Swal.fire({
	          title: "실패",
	          text: "숙박권 결제 실패",
	          icon: "error"
	      }); 	
    })
    </script>
  </c:otherwise>
</c:choose>
    
  

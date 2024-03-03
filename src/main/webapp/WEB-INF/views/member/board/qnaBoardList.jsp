<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- F&Q css -->
<link href="${contextPath }/resources/css/userQnaBoard.css" rel="stylesheet" />
    
<!-- 구현할 페이지를 여기에 작성 -->
<section class="qnaListContainer emptySpace">
    <article class="communityHeadStyle">
        <div class="comImgBox">
            <img src="${contextPath }/resources/images/communityBgImg.jpg" alt="커뮤니티 배경 이미지" />
        </div>
        <div>
            <h3>커뮤니티</h3>
            <span>COMMUNITY</span>
        </div>
    </article>
    <article class="qnaListContents cen">
        <div class="head_aticle">
            <h2 class="tit_a">
            	Q&amp;A
 				<span class="tit_sub"> 고객님들이 자주 찾으시는 질문을 모았습니다 </span>
            </h2>
			<select name="qna_select" id="qna_select" class="form-control">
			    <c:choose>
			        <c:when test="${empty menuList}">
			            <option value="">선택</option>
			        </c:when>
			        <c:otherwise>
			            <option value="">선택</option>
			            <c:forEach var="menu" items="${menuList}">
			                <option value="${menu}">${menu}</option>
			            </c:forEach>
			        </c:otherwise>
			    </c:choose>
			</select>
        </div>
        <c:if test="${sessionInfo.memCategory eq '03' }">
	        <div class="qnaBtnGroup">
	            <button type="button" class="btn btn-outline-primary" id="qnaAddBtn">Q&A등록</button>
	        </div>
        </c:if>
        <div class="qnaListCont">
            <div class="qnaListSet">
            </div>
        </div>
    </article>        
</section>

<!-- QNA 등록 모달창 -->
<section class="menuInfoModalContents" id="popup">
  <div class="menuInfoModalBox cen">
    <!-- 팝업창 header 부분 -->
    <div class="menu-popheadbox">
      <button class="menu-popheadbox__button--big" id="popdown">닫기</button>
    </div>
    <article class="infoModalCenter">
   		<div class="panel">
   			<div class="panel-body">
	    		<h5 class="mt-2" style="margin-top: 20px; margin-bottom: 20px;"><i class="fa fa-cube" aria-hidden="true" style="padding-right: 10px;"></i>Q&amp;A 등록</h5>
                <div class="table-responsive">
                	<p> 양식파일을 다운로드 하시고 파일내에 있는 모든 항목들을 채워서 업로드하셔야 정상적으로 등록됩니다.</p>
                	<form id="form1" name="form1" method="post" enctype="multipart/form-data">
	                	<table id="datatable-scroller" class="table table-bordered tbl_Form">
	                        <colgroup>
	                            <col width="250px" />
	                            <col />
	                        </colgroup>
	                        <tbody>
	                            <tr>
	                                <th class="active" style="text-align:right"><label class="control-label" for="excelFile">파일 업로드</label></th>
	                                <td>
	                                    <input class="form-control" type="file" name="excelFile" id="excelFile" accept=".xlsx, .xls"/>
	                                </td>
	                            </tr>
	                        </tbody>
	                    </table>
					</form>
                </div>
   			</div>
   		</div>
		<div class="float-end">
		  <button class="btn btn-outline-primary mt-2" type="button" id="uploadExcelBtn" >엑셀 업로드</button>
		  <a class="btn btn-outline-success mt-2" id="downloadExcelBtn" >엑셀 양식 다운로드</a>
		</div>
    </article>
  </div>
</section>


<!-- QNA js -->
<script src="${contextPath }/resources/js/userQnaBoard.js"></script>
<script>
    $(function(){
        // 공통 함수
        $.qnaLnbHequalContHFn();
        $.qnaLnbAccordianMenuFn();
        $.qnaListSetAccordianBoardFn();
        
        // 종횡비 함수
        var comImgBox = $(".comImgBox");
        var comImg = $(".comImgBox img");
        $.ratioBoxH(comImgBox, comImg);

        // 모달창 관련 함수
        $.qnaMenuAddClickFn();
        $.popdownClickFn();
        $.downloadExcelClickFn();
        $.uploadExcelClickFn();
        
        // QNA 카테고리 함수
        $.qnaMenuChageFn();
        
    });
</script>

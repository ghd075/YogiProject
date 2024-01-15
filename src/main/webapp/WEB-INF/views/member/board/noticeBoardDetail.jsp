<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 공지사항 css -->
<link href="${contextPath }/resources/css/userNoticeBoard.css" rel="stylesheet" />

<!-- 공지사항 게시판 상세 영역 -->
<section class="noticeDetailContainer emptySpace">
    <article class="communityHeadStyle">
        <div class="comImgBox">
            <img src="${contextPath }/resources/images/communityBgImg.jpg" alt="커뮤니티 배경 이미지" />
        </div>
        <div>
            <h3>커뮤니티</h3>
            <span>COMMUNITY</span>
        </div>
    </article>
    <article class="noticeDetailContents cen">
        <div>
            <h4>공지사항</h4>
        </div>
        <div class="card card-dark">
            <div class="card-body">
                <div class="form-group">
                    <ul class="noticeDetailTbl">
                        <li>
                            <div class="textDropVerticalAlign">
                                <span class="textDrop">
                                    ${noticeDetail.boTitle }
                                </span>
                                <span>${noticeDetail.boWriter }</span>
                                <fmt:parseDate var="detailParseData" value="${noticeDetail.boDate }" pattern="yyyy-MM-dd HH:mm:ss" />
                                <span><fmt:formatDate value="${detailParseData }" pattern="yyyy-MM-dd"/></span>
                                <span>조회 ${noticeDetail.boHit }</span>
                                <span>
                                    <a href="javascript:window.print()">
                                        <i class="fas fa-print"></i>
                                    </a>
                                </span>
                            </div>
                        </li>
                        <li>
                            <div class="form-control" style="overflow: auto; position: relative;">${noticeDetail.boContent }</div>
                        </li>
                        
                       	<c:if test="${not empty prevNextInfo }">
	                        <li class="prevNextBtnGroup">
	                        	<c:forEach items="${prevNextInfo }" var="btnInfo" varStatus="stat">
	                        		<c:if test="${btnInfo.prevnextFlag eq 'prev' }">
			                            <div>
			                                <a href="/notice/user/detail.do?boNo=${btnInfo.boNo }" class="textDropVerticalAlign">
			                                    <span>
			                                        <i class="fas fa-long-arrow-alt-left"></i>
			                                    </span>
			                                    <span>
			                                        <i class="badge bg-secondary">
														이전글
			                                        </i>
			                                    </span>
			                                    <span class="textDrop">
			                                    	${btnInfo.boTitle }
			                                    </span>
			                                </a>
			                            </div>
			                            <c:if test="${fn:length(prevNextInfo) eq 1 }">
				                            <div style="text-align: right; line-height: 100px; padding: 0px 20px;">
				                            	다음 글이 없습니다.
				                            </div>
			                            </c:if>
			                         </c:if>
	                        		 <c:if test="${btnInfo.prevnextFlag eq 'next' }">
	                        			<c:if test="${fn:length(prevNextInfo) eq 1 }">
				                            <div style="text-align: left; line-height: 100px; padding: 0px 20px;">
				                            	이전 글이 없습니다.
				                            </div>
			                            </c:if>
			                            <div>
			                                <a href="/notice/user/detail.do?boNo=${btnInfo.boNo }" class="textDropVerticalAlign">
			                                    <span>
			                                        <i class="fas fa-long-arrow-alt-right"></i>
			                                    </span>
			                                    <span>
			                                        <i class="badge bg-secondary">
														다음글
			                                        </i>
			                                    </span>
			                                    <span class="textDrop">
			                                    	${btnInfo.boTitle }
			                                    </span>
			                                </a>
			                            </div>
			                         </c:if>
	                            </c:forEach>
	                        </li>
                        </c:if>
                        
                    </ul>
                </div>
                
                <form action="/notice/admin/delete.do" method="post" id="deleteForm">
                	<input type="hidden" name="boNo" value="${noticeDetail.boNo }" />
                </form>
                
                <div class="form-group">
                    <button id="noticeDeleteBtn" type="button" class="btn btn-outline-danger">삭제</button>
                    <button id="noticeModifyBtn" type="button" class="btn btn-outline-warning">수정</button>
                    <button id="userListGoBtn" type="button" class="btn btn-outline-success">목록</button>
                </div>
            </div>
            <c:if test="${not empty noticeDetail.noticeFileList }">
	            <div class="card-footer bg-white">
	                <div>
	                    <span class="badge bg-dark">파일 다운로드</span>
	                </div>
	                <div class="row">
	                	<!-- 반복 구간 -->
                		<c:forEach items="${noticeDetail.noticeFileList }" var="noticeFile">
                			<div class="col-md-2 fileDownCont">
		                        <div style="height: 140px;">
		                            <c:choose>
		                            	<c:when test="${fn:split(noticeFile.fileMime, '/')[0] eq 'image' }">
		                            		<div class="previewImgBox">
		                            			<img src="/resources/notice/${noticeDetail.boNo }/${fn:split(noticeFile.fileSavepath, '/')[1] }" alt="파일 다운로드 이미지" />
		                            		</div>
		                            	</c:when>
		                            	<c:otherwise>
		                            		<i class="fas fa-file-download"></i>
		                            	</c:otherwise>
		                            </c:choose>
		                        </div>
		                        <div class="plexHeight">
		                            <h6>${noticeFile.fileName } (${noticeFile.fileFancysize })</h6>
		                        </div>
		                        <div>
		                            <button type="button" class="btn btn-secondary btn-sm noticeFileDownBtn" dataFileNo="${noticeFile.fileNo }">DOWNLOAD</button>
		                        </div>
		                    </div>
                		</c:forEach>
	                </div>
	            </div>
            </c:if>
        </div>
    </article>
</section>

<!-- 공지사항 js -->
<script src="${contextPath }/resources/js/userNoticeBoard.js"></script>
<script src="${contextPath }/resources/ckeditor/ckeditor.js"></script>
<script>
    $(function(){
        // 공통 함수
        $.fileDownBoxHeightFn();
        
        // 파일 다운로드 함수
        var noticeFileDownBtn = $(".noticeFileDownBtn");
        noticeFileDownBtn.on("click", function(){
        	var fileNo = $(this).attr("dataFileNo");
        	location.href = "/notice/user/download.do?fileNo=" + fileNo;
        });
        
        // 목록으로 이동
        var userListGoBtn = $("#userListGoBtn");
        userListGoBtn.click(function(){
        	location.href = "/notice/list.do";
        });
        
        // 수정 이동
        var noticeModifyBtn = $("#noticeModifyBtn");
        noticeModifyBtn.click(function(){
        	location.href = "/notice/admin/modify.do?boNo=${noticeDetail.boNo }";
        });
        
        // 삭제 이동
        var noticeDeleteBtn = $("#noticeDeleteBtn");
        var deleteForm = $("#deleteForm");
        noticeDeleteBtn.click(function(){
        	var agreeFlag = confirm("정말로 삭제하시겠습니까?");
        	if(agreeFlag) {
        		deleteForm.submit();
        	}
        });
        
        // 종횡비 함수
        var comImgBox = $(".comImgBox");
        var comImg = $(".comImgBox img");
        $.ratioBoxH(comImgBox, comImg);
        $.eachPreviewImgBoxResizeFn();
    });
</script>
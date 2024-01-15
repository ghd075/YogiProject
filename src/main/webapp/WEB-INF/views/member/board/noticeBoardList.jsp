<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!-- 공지사항 css -->
<link href="${contextPath }/resources/css/userNoticeBoard.css" rel="stylesheet" />

<!-- 공지사항 게시판 리스트 영역 -->
<section class="noticeListContainer emptySpace">
    <article class="communityHeadStyle">
        <div class="comImgBox">
            <img src="${contextPath }/resources/images/communityBgImg.jpg" alt="커뮤니티 배경 이미지" />
        </div>
        <div>
            <h3>커뮤니티</h3>
            <span>COMMUNITY</span>
        </div>
    </article>
    <article class="noticeListContents cen">
        <div>
            <h4>공지사항</h4>
        </div>
        <div class="searchBoardCont">
            <form action="" id="searchForm" name="searchForm">
            	<input type="hidden" id="page" name="page" />
                <div class="btn-group">
                	<button type="button" class="btn btn-primary btn-sm">총 ${pagingVO.totalRecord } 개 게시물</button>
                	<button type="button" class="btn btn-secondary btn-sm">${pagingVO.currentPage } / ${pagingVO.totalPage } 페이지</button>
                </div>
                <div>
                    <div>
                        <select class="form-control" id="searchType" name="searchType">
                            <option value="title" <c:if test="${searchType eq 'title' }">selected</c:if>>제목</option>
                            <option value="writer" <c:if test="${searchType eq 'writer' }">selected</c:if>>작성자</option>
                            <option value="both" <c:if test="${searchType eq 'both' }">selected</c:if>>제목+작성자</option>
                        </select>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div>
                        <input class="form-control" type="text" id="searchWord" name="searchWord" placeholder="검색어 입력" value="${searchWord }" />
                        <button type="submit" id="searchBtn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>
        <div class="imporNoticeListCont">
        	<c:set value="${importantNoticeList }" var="impList" />
            <ul>
            	<c:choose>
            		<c:when test="${empty impList }">
            			<li class="impNoticeList">
                            <div style="text-align: center;">
								등록된 중요공지 게시글이 존재하지 않습니다.
                            </div>
                        </li>
            		</c:when>
            		<c:otherwise>
            			<c:forEach items="${impList }" var="imp" varStatus="vs">
            				<li class="impNoticeList">
			                    <div class="textDropVerticalAlign">
			                        <span>중요공지</span>
			                        <span class="textDrop">${imp.boTitle }</span>
			                        <fmt:parseDate var="impParseData" value="${imp.boDate }" pattern="yyyy-MM-dd HH:mm:ss" />
			                    	<span><fmt:formatDate value="${impParseData }" pattern="yyyy-MM-dd"/></span>
			                        <span class="plusMinus">
			                            <i class="fas fa-plus"></i>
			                        </span>
			                    </div>
			                    <div class="visibleDiv">
			                    
			                        <p style="white-space: pre-wrap;">${imp.boContent }</p>
			                        
			                        <!-- 반복 구간 -->
			                        <%-- <c:out value="${imp.noticeFileList}"/>
			                        <c:forEach items="${imp.noticeFileList}" var="noticeFile">
			                        	<p>fileNos == ${noticeFile.fileNos }</p>
			                        	<p>fileNames == ${noticeFile.fileNames }</p>
			                        	<p>fileSizes == ${noticeFile.fileSizes }</p>
			                        	<p>fileMimes == ${noticeFile.fileMimes }</p>			                        
			                        </c:forEach> --%>
			                        
			                        <c:if test="${not empty imp.noticeFileList }">
			                        	<c:forEach items="${imp.noticeFileList}" var="noticeFile">
			                        		<c:set value="${fn:split(noticeFile.fileNames, ',') }" var="fnamearr" />
				                        	<c:set value="${fn:split(noticeFile.fileNos, ',') }" var="filenoarr" />
				                            <c:forEach items="${fnamearr }" var="fname" varStatus="status">
							                        <div class="imporNoticeFileDown">
							                            <span class="badge bg-primary">파일 다운로드</span>
								                            <a class="fileDownload" dataFileNo="${filenoarr[status.index] }" href="#">${fname }</a>
							                            <i class="fas fa-file-download"></i>
							                        </div>
				                            </c:forEach>
				                        </c:forEach>
			                        </c:if>
			                        
			                    </div>
			                </li>
            			</c:forEach>
            		</c:otherwise>
            	</c:choose>
            </ul>
        </div>
        <div class="noticeListCont">
            <ul>
                <li class="noticeListHead">
                    <span>번호</span>
                    <span>제목</span>
                    <span>등록일</span>
                    <span>작성자</span>
                    <span>조회수</span>
                </li>
                <c:set value="${pagingVO.dataList }" var="noticeList" />
                <c:choose>
                	<c:when test="${empty noticeList }">
                		<li class="noticeList textDropVerticalAlign">
                            <div style="text-align: center;">
								등록된 공지사항 게시글이 존재하지 않습니다.
                            </div>
                        </li>
                	</c:when>
                	<c:otherwise>
                		<c:forEach items="${noticeList }" var="notice">
                			<li class="noticeList textDropVerticalAlign">
			                    <span>${notice.boNo }</span>
			                    <span class="textDrop">
			                        <a href="/notice/user/detail.do?boNo=${notice.boNo }">
			                            ${notice.boTitle }
			                        </a>
			                        <c:if test="${notice.boImpor eq 'y' }">
			                        	<u style="text-decoration: none;" class="badge bg-danger">중요공지</u>
			                        </c:if>
			                        <i class="fas fa-paperclip"></i>
			                    </span>
			                    <fmt:parseDate var="parseData" value="${notice.boDate }" pattern="yyyy-MM-dd HH:mm:ss" />
			                    <span><fmt:formatDate value="${parseData }" pattern="yyyy-MM-dd"/></span>
			                    <span>${notice.boWriter }</span>
			                    <span>${notice.boHit }</span>
			                </li>
                		</c:forEach>
                	</c:otherwise>
                </c:choose>
            </ul>
        </div>
        <div id="pagingArea">
            ${pagingVO.pagingHTML }
        </div>
        <div class="noticeBtnGroup">
            <button type="button" class="btn btn-primary" id="noticeAddBtn">등록</button>
        </div>
    </article>
</section>

<!-- 공지사항 js -->
<script src="${contextPath }/resources/js/userNoticeBoard.js"></script>
<script>
    $(function(){
        // 공통 함수
        $.importantNoticeBoardShowFn();
        $.noticeBoardPagingFn();
        
        var noticeAddBtn = $("#noticeAddBtn");
        noticeAddBtn.click(function(){
            location.href = "/notice/admin/register.do";
        });
        
        var fileDownload = $(".fileDownload");
        fileDownload.on("click", function(event){
        	event.preventDefault();
        	var fileNo = $(this).attr("dataFileNo");
        	location.href = "/notice/user/download.do?fileNo=" + fileNo;
        });
        
        // 종횡비 함수
        var comImgBox = $(".comImgBox");
        var comImg = $(".comImgBox img");
        $.ratioBoxH(comImgBox, comImg);
    });
</script>
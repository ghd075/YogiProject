<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
    
<!-- 공지사항 css -->
<link href="${contextPath }/resources/css/userNoticeBoard.css" rel="stylesheet" />

<c:set value="등록" var="name" />
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="name" />
</c:if>

<!-- 공지사항 게시판 등록 영역 -->
<section class="noticeRegisterContainer emptySpace">
    <article class="communityHeadStyle">
        <div class="comImgBox">
            <img src="${contextPath }/resources/images/communityBgImg.jpg" alt="커뮤니티 배경 이미지" />
        </div>
        <div>
            <h3>커뮤니티</h3>
            <span>COMMUNITY</span>
        </div>
    </article>
    <article class="noticeRegisterContents cen">
        <div>
            <h4>공지사항 ${name }</h4>
        </div>
        <div class="card card-dark">
            <form action="/notice/${sessionInfo.memId }/register.do" method="post" enctype="multipart/form-data" id="noticeForm" name="noticeForm">
                
                <c:if test="${status eq 'u' }">
                	<input type="hidden" name="boNo" value="${notice.boNo }" />
                </c:if>
                
                <div class="card-body">
                    <div class="form-group">
                        <label for="boTitle">제목을 입력해주세요</label>
                        <%-- <input type="text" id="boTitle" name="boTitle" class="form-control" placeholder="제목 입력" value="<c:out value="${notice.boTitle }" escapeXml="true" />" /> --%>
                        <input type="text" id="boTitle" name="boTitle" class="form-control" placeholder="제목 입력" value="${notice.boTitle }" />
                    </div>
                    <div class="form-group">
                        <label for="boContent">내용을 입력해주세요</label>
                        <%-- <textarea id="boContent" name="boContent" class="form-control" rows="14"><c:out value="${notice.boContent }" escapeXml="true" /></textarea> --%>
                        <textarea id="boContent" name="boContent" class="form-control" rows="14">${notice.boContent }</textarea>
                    </div>
                    <div class="form-group">
                        <label for="boContent">파일 업로드</label>
                        <input type="file" class="form-control" id="boFile" name="boFile" multiple="multiple">
                    </div>
                    <div class="form-group">
                        <div>
                            <input class="form-check-input" type="checkbox" id="boImpor" name="boImpor" value="y" <c:if test="${notice.boImpor eq 'y' }">checked</c:if> />
                            <label class="form-check-label" for="boImpor">중요 공지 등록</label>
                        </div>
                        <div>
                            <button id="noticeRegBtn" type="button" class="btn btn-outline-primary">공지사항 ${name }</button>
                            <c:if test="${status ne 'u' }">
	                            <button id="noticeListBtn" type="button" class="btn btn-outline-info" onclick="javascript:location.href='/notice/list.do'">목록으로 돌아가기</button>
                            </c:if>
                            <c:if test="${status eq 'u' }">
                            	<button id="noticeListBtn" type="button" class="btn btn-outline-danger" onclick="javascript:location.href='/notice/user/detail.do?boNo=${notice.boNo }'">취소</button>
                            </c:if>
                        </div>
                    </div>
                </div>
                
                <c:if test="${not empty notice.noticeFileList }">
                	<div class="card-footer bg-white">
						<div>
							<span class="badge bg-danger">파일 삭제</span>
						</div>
						<div class="row">
							<c:forEach items="${notice.noticeFileList }" var="noticeFile">
								<div class="col-md-2 fileDownCont">
									<div style="height: 140px;">
										<c:choose>
											<c:when test="${fn:split(noticeFile.fileMime, '/')[0] eq 'image' }">
												<div class="previewImgBox">
			                            			<img src="/resources/notice/${notice.boNo }/${fn:split(noticeFile.fileSavepath, '/')[1] }" alt="파일 다운로드 이미지" />
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
			                            <button type="button" class="btn btn-danger btn-sm noticeFileDownBtn" dataFileNo="${noticeFile.fileNo }">DELETE</button>
			                        </div>
								</div>
							</c:forEach>
						</div>
                	</div>
                </c:if>
                
            </form>
        </div>
    </article>
</section>

<!-- 공지사항 js -->
<script src="${contextPath }/resources/js/userNoticeBoard.js"></script>
<script src="${contextPath }/resources/ckeditor/ckeditor.js"></script>
<script>
    $(function(){
        // 공통 함수
        $.noticeFormCKED();
        $.noticeRegisterValidationChkFn();
        $.fileDownBoxHeightFn();
        $.removeFileFn();
        
        // 종횡비 함수
        var comImgBox = $(".comImgBox");
        var comImg = $(".comImgBox img");
        $.ratioBoxH(comImgBox, comImg);
        $.eachPreviewImgBoxResizeFn();
    });
</script>
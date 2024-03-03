<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<!-- 공지사항 css -->
<link href="${contextPath }/resources/css/userQuestionBoard.css" rel="stylesheet" />    

<!-- 구현할 페이지를 여기에 작성 -->
<section class="questionContainer emptySpace">
    <article class="communityHeadStyle">
        <div class="comImgBox">
            <img src="${contextPath }/resources/images/communityBgImg.jpg" alt="커뮤니티 배경 이미지" />
        </div>
        <div>
            <h3>커뮤니티</h3>
            <span>COMMUNITY</span>
        </div>
    </article>
    <article class="questionListContents cen">
		<div class="head_aticle">
			<c:if test="${sessionInfo.memCategory eq '01' }">
				<h2 class="tit_a">
					묻고 답하기 <span class="tit_sub"> 묻고 답할 수 있는 공간입니다. </span>
				</h2>
			</c:if>
			<c:if test="${sessionInfo.memCategory eq '03' }">
				<h2 class="tit_a">
					문의내역 관리 <span class="tit_sub"> 묻고 답할 수 있는 공간입니다. </span>
				</h2>
			</c:if>
		</div>
        <c:if test="${sessionInfo.memCategory eq '01' }">
			<div class="questionBtnGroup">
	   			<button type="button" class="btn btn-outline-primary" id="questionAddBtn">문의 등록</button>
	   		</div>
        	<div class="userQuestionListCont">
        		<ul>
        			<li class="userQuestionListHead">
	                    <span></span>
	                    <span>문의 제목</span>
	                    <span>답변 상태</span>
	                    <span>작성일</span>
                	</li>
        		</ul>
        		<ul>
                	<c:choose>
                		<c:when test="${empty queList}">
		                	<li class="userQuestionList">
		                		<div style="text-align: center;">
									등록된 문의사항 게시글이 존재하지 않습니다.
		                       	</div>
		                	</li>
                		</c:when>
                		<c:otherwise>
                			<c:forEach var="que" items="${queList}">
                				<li class="userQuestionList">
                					<div class="textDropVerticalAlign">
				             			<span style="font-size: 32px;"><i class="fa-solid fa-circle-info"></i></span>
					                    <span>${que.boTitle}</span>
					                    <span>${que.cont == 'off' ? '답변준비중' : '답변완료' }</span>
			                    		<span>
			                    			<fmt:formatDate value="${que.boDate}" pattern="yyyy.MM.dd"/><br/>
											<fmt:formatDate value="${que.boDate}" pattern="HH : mm"/>
			                    		</span>
					                    <span class="plusMinus">
			                            	<i class="fas fa-plus"></i>
			                        	</span>
                					</div>
                					<div class="visibleDiv">
	                					<span style="font-size: 32px;"><i class="fa-solid fa-question"></i></span>
										<span style="white-space: pre-wrap;">${que.boContent}</span>
										<div style="border-bottom: 2px solid #ddd; padding: 12px 0;"></div>
										<div class="answerDiv">
											<span style="font-size: 32px;"><i class="fa-solid fa-circle-exclamation"></i></span>
											<c:if test="${empty que.answer}"><span>답변대기중</span></c:if>
											<c:if test="${not empty que.answer}"><span>${que.answer}</span></c:if>
											<c:if test="${not empty que.answer}">
												<span>
													답변일<br/>
													<fmt:formatDate value="${que.boAnswerDay}" pattern="yyyy.MM.dd HH:mm"/>
												</span>
											</c:if>
											<c:if test="${empty que.answer}">
												<span></span>
											</c:if>
										</div>
                					</div>
                				</li>
                			</c:forEach>
                		</c:otherwise>
                	</c:choose>
        		</ul>
        	</div>
        </c:if>
       	<c:if test="${sessionInfo.memCategory eq '03' }">
	        <div class="questionListCont">
				<table class="board-listheader" id="questiondatables">
					<thead>	
						<tr>
		                    <th><div>문의 번호</div></th>
		                    <th><div>제목</div></th>
		                    <th><div>아이디</div></th>
		                    <th><div>문의일</div></th>
		                    <th><div>답변 상태</div></th>
		                    <th><div>답변일</div></th>
		                    <th><div>상세보기</div></th>
						</tr>
					</thead>
					<tbody>
						<c:choose>
							<c:when test="${empty getAllQueList}">
								<tr>
									<td colspan="7">등록된 문의 게시글이 존재하지 않습니다.</td>
								</tr>
							</c:when>
							<c:otherwise>
								<c:forEach var="vo" items="${getAllQueList}">
			                		<tr>
			                			<td>${vo.boNo}</td>
			                			<td>${vo.boTitle}</td>
			                			<td>${vo.boWriter}</td>
			                			<td><fmt:formatDate value="${vo.boDate}" pattern="yyyy/MM/hh"/></td>
			                			<td>${vo.cont == 'off' ? '대기중' : '답변 완료'}</td>
			                			<td><c:if test="${not empty vo.boAnswerDay}"><fmt:formatDate value="${vo.boAnswerDay}" pattern="yyyy/MM/hh"/></c:if></td>
			                			<td><input type="button" value="답변" onclick="modalOn(${vo.boNo});" class="btn btn-sm btn-warning"/></td>
			                		</tr>
			                	</c:forEach>							
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>	        
	        </div>
        </c:if>
    </article>
</section>

<!-- 모달창(문의사항 등록창) -->
<section class="questionModalContents">
	<div class="questionModalBox cen">
		<div class="questionModalClose">
            <div></div>
            <div></div>
        </div>
        <article>
        	<div>
				<div class="text-center mb-3" style="font-size: 1.8em; font-weight: 500;">문의</div>
				<div class="p-4 ml-auto mr-auto" style="font-size: 1.1em; width: 100%;">
					<form>
						<div>문의 제목</div>
						<input type="text" name="boTitle" id="boTitle" class="form-control mt-2 mb-3" autocomplete='off'/>
						<div>건의 내용</div>
						<textarea rows="9" name="boContent" id="boContent" class="form-control mt-2 mb-1" autocomplete='off' style="resize: none;"></textarea>
						<input type="button" id="questionRegBtn" value="작성 완료" class="btn btn-warning mb-2 form-control"/>
					</form>
				</div>
        	</div>
        </article>
	</div>
</section>

<!-- 모달창(문의사항 답변) -->
<section class="questionAnswerModalContents">
	<div class="questionAnswerModalBox cen">
		<div class="questionAnswerModalClose">
            <div></div>
            <div></div>
        </div>
        <article>
        	<div>
				<div class="p-4 ml-auto mr-auto" style="font-size: 1.1em; width: 100%;">
					<div class="mb-2">
						<div>
							<span class="ml-2 mb-2">문의 제목</span>
							<input id="title" type="text" class="form-control mb-2" disabled/>
							<span class="ml-2 mb-2">내용</span>
							<textarea id="content" class="form-control mb-2" disabled></textarea>
							<span class="ml-2 mb-2">답변</span>
							<textarea id="answer" class="form-control mb-2"></textarea>
						</div>
					</div>
					<div>
						<input type="button" id="questionAnswerBtn" value="답변 완료" class="btn btn-warning form-control mt-5"/>
					</div>
				</div>
        	</div>
        </article>
	</div>
</section>
<!-- DataTables js -->
<link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
<script src="${contextPath }/resources/js/datatables.js"></script>

<!-- 문의사항 js -->
<script src="https://kit.fontawesome.com/368f95b037.js" crossorigin="anonymous"></script>
<script src="${contextPath }/resources/js/userQuestionBoard.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$.questionBoardShowFn();
		$.questionInputModalFn();
		$.questionInputValidationChkFn();
	});

</script>
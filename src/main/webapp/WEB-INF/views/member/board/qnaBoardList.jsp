<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 공지사항 css -->
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
        <div>
            <h4>Q&amp;A</h4>
        </div>
        <div class="qnaBtnGroup">
            <button type="button" class="btn btn-outline-primary" id="qnaMenuAddBtn">메뉴등록</button>
            <button type="button" class="btn btn-outline-success" id="qnaAddBtn">F&A등록</button>
        </div>
        <c:if test="${sessionInfo.memCategory eq '03' }">
        </c:if>
        <div class="qnaListCont">
            <nav class="qnaLnb">
                <ul>
                    <li class="qmain">
                        <a href="javascript:void(0)">메뉴 1</a>
                        <ul class="qsub">
                            <li><a href="javascript:void(0)">서브 1</a></li>
                            <li><a href="javascript:void(0)">서브 2</a></li>
                            <li><a href="javascript:void(0)">서브 3</a></li>
                        </ul>
                    </li>
                    <li class="qmain">
                        <a href="javascript:void(0)">메뉴 2</a>
                        <ul class="qsub">
                            <li><a href="javascript:void(0)">서브 1</a></li>
                            <li><a href="javascript:void(0)">서브 2</a></li>
                            <li><a href="javascript:void(0)">서브 3</a></li>
                        </ul>
                    </li>
                    <li class="qmain">
                        <a href="javascript:void(0)">메뉴 3</a>
                        <ul class="qsub">
                            <li><a href="javascript:void(0)">서브 1</a></li>
                            <li><a href="javascript:void(0)">서브 2</a></li>
                            <li><a href="javascript:void(0)">서브 3</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
            <div class="qnaListSet">
                <ul>
                    <li class="accordBoardListCont">
                        <div class="accordBoardList">제목 1</div>
                        <div class="visibleDiv">내용 1</div>
                    </li>
                    <li class="accordBoardListCont">
                        <div class="accordBoardList">제목 2</div>
                        <div class="visibleDiv">내용 2</div>
                    </li>
                    <li class="accordBoardListCont">
                        <div class="accordBoardList">제목 3</div>
                        <div class="visibleDiv">내용 3</div>
                    </li>
                </ul>
            </div>
        </div>
    </article>        
</section>

<section class="menuInfoModalContents" id="popup">
    <div class="menuInfoModalBox cen">
		<!-- 메뉴작성 팝업창 header 부분 -->
        <div class="menu-popheadbox">
            <span class="menu-popheadbox__span--big">메뉴 만들기</span>
            <button class="menu-popheadbox__button--big" id="popdown">닫기</button>
        </div>
		<article class="infoModalCenter">
		    <form id="menuForm">
		        <div class="form-group">
		            <label for="menuName">메뉴 이름</label>
		            <input type="text" class="form-control" id="menuName" name="menuName" required>
		        </div>
		        <!-- 추가적인 입력 필드 등 -->
		        <div class="form-group">
		            <label for="menuLink">링크</label>
		            <input type="text" class="form-control" id="menuLink" name="menuLink" required>
		        </div>
		        <div class="form-group">
		            <label for="displayOrder">표시 순서</label>
		            <input type="number" class="form-control" id="displayOrder" name="displayOrder" required>
		        </div>
		        <button type="button" class="btn btn-primary" onclick="saveMenu()">메뉴 저장</button>
		    </form>		
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
        
        $("#qnaMenuAddBtn").click(function () {
            $("#popup").fadeIn();		// 모달창 보이기
        });

        $("#popdown").click(function () {
            $("#popup").fadeOut();		// 모달창 감추기
        });
    });
</script>
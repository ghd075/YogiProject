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
            <span class="menu-popheadbox__span--big">메뉴 분류 관리</span>
            <button class="menu-popheadbox__button--big" id="popdown">닫기</button>
        </div>
        <article class="infoModalCenter">
            <div class="container">
              <div class="row">
                <div class="col-md-6">
                  <div class="card">
                    <div class="card-body">
                      <h2>대분류</h2>
						<div class="input-group mb-4">
						  <input type="text" class="form-control" placeholder="대분류명" id="mainMenuNameInput">
						  <input type="number" class="form-control" placeholder="메뉴 순서" id="mainMenuOrderInput">
						  <select class="form-select" id="mainMenuYnInput">
						    <option value="Y">사용</option>
						    <option value="N">사용 안함</option>
						  </select>
						  <button class="btn btn-outline-secondary" type="button" onclick="addMainMenu()">대분류 등록</button>
						</div>
                      <ul id="mainMenu" class="list-group">
                        <!-- 대분류 메뉴 아이템들 -->
                      </ul>
                    </div>
                  </div>
                </div>
                <div class="col-md-6">
                  <div class="card">
                    <div class="card-body">
                      <h2 id="subMenuTitle">[대분류명]의 하위분류</h2>
                      <div class="input-group mb-3">
                        <input type="text" class="form-control" placeholder="하위분류명" id="subMenuInput">
                        <button class="btn btn-outline-secondary" type="button" onclick="addSubMenu()">하위분류 등록</button>
                      </div>
                      <ul id="subMenu" class="list-group">
                        <!-- 하위분류 메뉴 아이템들 -->
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
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
        $.addMenuClickFn();
        
        // 페이지 로드 시 상위 메뉴 목록 불러오기
        $.ajax({
            type: "GET",
            url: "/qna/getTopMenus",
            success: function(menus) {
            	console.log("menus 값들 : ", menus);
                var $parentMenu = $('#parentMenu');
                $parentMenu.empty(); // select 박스 초기화
                
       			if (menus.length === 0) {
                    $('#addMenuButton').removeClass('visually-hidden'); // 상위 메뉴가 있으면 버튼 표시
                } 
                
                $.each(menus, function(index, menu) {
                    $parentMenu.append($('<option>', {
                        value: menu.menuId,
                        text: menu.menuName
                    }));
                });
                $parentMenu.prepend($('<option>', { // 기본 옵션 추가
                    value: '',
                    text: '상위 메뉴 선택'
                }));
                $parentMenu.val(''); // 기본 옵션 선택
            }
        });
        
    });
</script>
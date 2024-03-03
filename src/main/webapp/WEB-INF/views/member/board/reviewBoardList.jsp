<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!-- 여행 정보 css -->
<link href="${contextPath }/resources/css/reviewBoard.css" rel="stylesheet" />    
    
<!-- 구현할 페이지를 여기에 작성 -->
<section class="reviewContainer emptySpace1">
	<article class="communityHeadStyle">
        <div class="comImgBox">
            <img src="${contextPath }/resources/images/communityBgImg.jpg" alt="커뮤니티 배경 이미지" />
        </div>
        <div>
            <h3>커뮤니티</h3>
            <span>COMMUNITY</span>
        </div>
    </article>
    <article class="reviewListContents cen">
    	<div>
            <h4>여행후기</h4>
        </div>
        <div class="searchBoardCont">
            <form action="" id="searchForm" name="searchForm">
            	<input type="hidden" id="page" name="page" />
                <div class="btn-group">
                </div>
                <div>
                    <div>
                        <select class="form-control" id="searchType" name="searchType">
                            <option value="both">전체</option>
                            <option value="title">제목</option>
                            <option value="writer">작성자</option>
                        </select>
                        <i class="fas fa-chevron-down"></i>
                    </div>
                    <div>
                        <input class="form-control" type="text" id="searchWord" name="searchWord" placeholder="검색어 입력" value="" />
                        <button type="submit" id="searchBtn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </form>
        </div>        
        <div style="border-bottom: 2px solid #d0d0d0;"></div>
    </article>
</section>

<section class="airplaneInfoContainer cen">
    <article class="airInfoContents">
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg03.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>전주 2박 3일 여행</div>
            <div>
				전라북도 전주시
            </div>
            <div>작성일 | 2024.2.13</div>
            <div>만든이 | user4</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg04.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>제주도 여행코스</div>
            <div>
            	제주
            </div>
            <div>작성일 | 2024.2.13</div>
            <div>만든이 | a001</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg05.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
           	<div>강원 평창군 여행코스</div>
            <div>
            	강원특별자치도 평창군
            </div>
            <div>작성일 | 2024.2.13</div>
            <div>만든이 | user1</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg06.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>충북 단양군 여행코스</div>
            <div>
            	충청북도 단양군
            </div>
            <div>작성일 | 2024.2.13</div>
            <div>만든이 | a002</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg07.JPG" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>전남 구례군 여행코스</div>
            <div>
				전라남도 구례군
            </div>
            <div>작성일 | 2024.2.13</div>
            <div>만든이 | user4</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg08.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>남원 1박2일</div>
            <div>
            	전라북도 남원시
            </div>
            <div>작성일 | 2024.1.29</div>
            <div>만든이 | user4</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg09.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>용인 1박2일 코스</div>
            <div>
            	경기도 용인시
            </div>
            <div>작성일 | 2024.1.29</div>
            <div>만든이 | user4</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg04.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>시흥 여행코스</div>
            <div>
            	경기도 시흥시
            </div>
            <div>작성일 | 2024.1.29</div>
            <div>만든이 | user4</div>
        </div>
                <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg01.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>제주도 4박 5일 여행</div>
            <div>
				제주도
            </div>
            <div>작성일 | 2023.12.29</div>
            <div>만든이 | user4</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/air/search/airBg02.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>서울 송파구 여행</div>
            <div>
            	서울
            </div>
            <div>작성일 | 2023.12.29</div>
            <div>만든이 | user4</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg11.JPG" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>대전 1박2일 여행</div>
            <div>
            	대전광역시
            </div>
            <div>작성일 | 2023.12.29</div>
            <div>만든이 | user4</div>
        </div>
        <div class="airInfoCont">
            <div class="airImgBox">
                <img src="${contextPath }/resources/images/review/reviewBg10.jpg" alt="여행 후기 썸네일 이미지" />
            </div>
            <div>대구 1박2일 여행</div>
            <div>
            	대구광역시
            </div>
            <div>작성일 | 2023.12.29</div>
            <div>만든이 | user4</div>
        </div>        
    </article>
</section>

<!-- 팝업을 표시할 모달 -->
<div class="modal fade" id="airInfoModal" tabindex="-1" aria-labelledby="airInfoModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="airInfoModalLabel">여행 정보</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div id="popupContent" class="popup-content">
                    <!-- 여기에 JavaScript에서 동적으로 생성된 내용이 들어갈 것입니다. -->
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 항공 예약 js -->
<script src="${contextPath }/resources/js/air/airplane.js"></script>

<script>
     $(function(){
         // 종횡비 함수
         $.eachAirImgResizeFn();
         $.eachAirInfoImgResizeFn();
     });
</script>
<script>
	var searchForm = document.getElementById('searchForm');
	searchForm.addEventListener('submit', function(e) {
	    e.preventDefault(); // submit 이벤트 방지
	    var searchType = document.getElementById('searchType').value;
	    var searchWord = document.getElementById('searchWord').value.toLowerCase();
	    var containers = document.querySelectorAll('.airInfoCont');
	    var resultCount = 0;
	    containers.forEach(function(container) {
	        var textToSearch;
	        switch (searchType) {
	            case 'title':
	                textToSearch = container.children[1].innerText; // 제목이 두 번째 자식 요소에 있다고 가정
	                break;
	            case 'writer':
	                textToSearch = container.children[4].innerText; // 작성자가 다섯 번째 자식 요소에 있다고 가정
	                break;
	            case 'both':
	            default:
	                textToSearch = container.innerText;
	                break;
	        }
	        if (textToSearch.toLowerCase().includes(searchWord)) {
	            container.style.display = '';
	            resultCount++;
	        } else {
	            container.style.display = 'none';
	        }
	    });
	    var contentsContainer = document.querySelector('.airInfoContents');
	    var noResultElement = document.getElementById('noResult');
	    if (noResultElement) {
	        contentsContainer.removeChild(noResultElement);
	    }
	    if(resultCount === 0) {
	        var newElement = document.createElement('div');
	        newElement.setAttribute('id', 'noResult');
	        newElement.setAttribute('style', 'text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; border-radius: 4px;');
	        newElement.textContent = '검색된 여행 후기 정보가 없습니다.';
	        contentsContainer.appendChild(newElement);
	    }
	});
</script>
 

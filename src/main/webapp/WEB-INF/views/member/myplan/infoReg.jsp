<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<!-- 여행 정보 css -->
<link href="${contextPath }/resources/css/journeyInfo.css" rel="stylesheet" />

<c:set value="등록" var="name" />
<c:if test="${status eq 'u' }">
	<c:set value="수정" var="name" />
</c:if>

<section class="placeinfoRegContainer emptySpace cen">
    <article class="placeinfoRegContents">
        <div class="card card-dark">
        	<!-- 여행 정보 수정일 경우 미리 보기 구현 -->
        	<c:choose>
        		<c:when test="${status eq 'u' }">
        			<div class="previewSty card-header bg-white">
		                <h3>여행 정보 미리보기</h3>
		                <div>
		                    <div class="journeyInfoThumbnailPreview">
		                        <div class="previewThumbBox">
		                            <img id="previewImg1" src="${journey.infoPreviewimg }" alt="여행정보 미리보기 썸네일 이미지" />
		                        </div>
		                        <div>
		                            <h4>${journey.infoEngname }</h4>
		                            <span>${journey.infoName }</span>
		                        </div>
		                    </div>
		                    <div class="journeyInfoModalPreview scroll">
		                        <div class="previewinfoModal">
		                            <div class="previewModalLeft">
		                                <div>
		                                    <div class="previewModalInfoSetting">
		                                        <span>${journey.infoEngname }</span>
		                                        <h5>${journey.infoName }</h5>
		                                        <p>${journey.infoDescription }</p>
		                                    </div>
		                                    <div class="previewModalFourSection">
		                                        <div>
		                                            <div>
		                                                <i class="fas fa-plane"></i>
														항공
		                                            </div>
		                                            <div>
		                                            	<c:if test="${journey.infoFlightyn eq 'y' }">
		                                            		<span>
		                                            			<c:if test="${journey.infoFlight eq 'str' }">
										                    		직항
										                    	</c:if>
										                    	<c:if test="${journey.infoFlight eq 'round' }">
										                    		왕복
										                    	</c:if>
		                                            		</span>
			                                                <span>${journey.infoFlighttime }</span>
		                                            	</c:if>
		                                            	<c:if test="${journey.infoFlightyn eq 'n' }">
			                                                <span>없음</span>
			                                                <span>-</span>
		                                            	</c:if>
		                                            </div>
		                                        </div>
		                                        <div>
		                                            <div>
		                                                <i class="fas fa-passport"></i>
														비자
		                                            </div>
		                                            <div>
		                                            	<c:if test="${journey.infoVisayn eq 'y' }">
			                                                <span>
			                                                	<c:if test="${journey.infoVisaexp eq 'visa' }">
										                    		비자
										                    	</c:if>
										                    	<c:if test="${journey.infoVisaexp eq 'none' }">
										                    		무비자
										                    	</c:if>
			                                                </span>
			                                                <span>${journey.infoVisatime }</span>
		                                            	</c:if>
		                                            	<c:if test="${journey.infoVisayn eq 'n' }">
			                                                <span>없음</span>
			                                                <span>-</span>
		                                            	</c:if>
		                                            </div>
		                                        </div>
		                                        <div>
		                                            <div>
		                                                <i class="fas fa-plug"></i>
														전압
		                                            </div>
		                                            <div>
		                                                <span>콘센트</span>
		                                                <span>${journey.infoVoltage }</span>
		                                            </div>
		                                        </div>
		                                        <div>
		                                            <div>
		                                                <i class="fas fa-clock"></i>
														시차
		                                            </div>
		                                            <div>
		                                                <span>한국대비</span>
		                                                <span>${journey.infoTimedifer }</span>
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <a href="javascript:void(0)" class="btn btn-info previewMakePlanSty" style="color: white;">
												일정만들기 
		                                        <i class="fas fa-chevron-right"></i>
		                                    </a>
		                                </div>
		                            </div>
		                            <div class="previewModalRight">
		                                <div class="previewModalImgBox">
		                                    <img id="previewImg2" src="${journey.infoPreviewimg }" alt="여행 정보 이미지" />
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
        		</c:when>
        		<c:otherwise>
        			<div class="previewSty card-header bg-white">
		                <h3>여행 정보 미리보기</h3>
		                <div>
		                    <div class="journeyInfoThumbnailPreview">
		                        <div class="previewThumbBox">
		                            <img id="previewImg1" src="${contextPath }/resources/images/journeyBgImg.jpg" alt="여행정보 미리보기 썸네일 이미지" />
		                        </div>
		                        <div>
		                            <h4>여행 장소(영어)</h4>
		                            <span>여행 장소</span>
		                        </div>
		                    </div>
		                    <div class="journeyInfoModalPreview scroll">
		                        <div class="previewinfoModal">
		                            <div class="previewModalLeft">
		                                <div>
		                                    <div class="previewModalInfoSetting">
		                                        <span>여행 장소(영어)</span>
		                                        <h5>여행 장소</h5>
		                                        <p>여행 내용</p>
		                                    </div>
		                                    <div class="previewModalFourSection">
		                                        <div>
		                                            <div>
		                                                <i class="fas fa-plane"></i>
														항공
		                                            </div>
		                                            <div>
		                                                <span>없음</span>
		                                                <span>-</span>
		                                            </div>
		                                        </div>
		                                        <div>
		                                            <div>
		                                                <i class="fas fa-passport"></i>
														비자
		                                            </div>
		                                            <div>
		                                                <span>없음</span>
		                                                <span>-</span>
		                                            </div>
		                                        </div>
		                                        <div>
		                                            <div>
		                                                <i class="fas fa-plug"></i>
														전압
		                                            </div>
		                                            <div>
		                                                <span>콘센트</span>
		                                                <span>-</span>
		                                            </div>
		                                        </div>
		                                        <div>
		                                            <div>
		                                                <i class="fas fa-clock"></i>
														시차
		                                            </div>
		                                            <div>
		                                                <span>한국대비</span>
		                                                <span>-</span>
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <a href="javascript:void(0)" class="btn btn-info previewMakePlanSty" style="color: white;">
												일정만들기 
		                                        <i class="fas fa-chevron-right"></i>
		                                    </a>
		                                </div>
		                            </div>
		                            <div class="previewModalRight">
		                                <div class="previewModalImgBox">
		                                    <img id="previewImg2" src="${contextPath }/resources/images/journeyBgImg.jpg" alt="여행 정보 이미지" />
		                                </div>
		                            </div>
		                        </div>
		                    </div>
		                </div>
		            </div>
        		</c:otherwise>
        	</c:choose>
            <form id="jourInfoRegForm" name="jourInfoRegForm" action="/myplan/inforeg.do" method="post" enctype="multipart/form-data">
                
                <c:if test="${status eq 'u' }">
                	<input type="hidden" name="infoNo" value="${journey.infoNo }" />
                </c:if>
                
                <div class="card-footer">
                    <h3>여행 정보 ${name }</h3>
                    <div class="form-group">
                        <label for="infoName">지역명&#40;한글&#41;</label>
                        <input type="text" id="infoName" name="infoName" class="form-control" placeholder="예) 대한민국 서울" value="${journey.infoName }" />
                    </div>
                    <div class="form-group">
                        <label for="infoEngname">지역명&#40;영어&#41;</label>
                        <input type="text" id="infoEngname" name="infoEngname" class="form-control" placeholder="예) SEOUL" value="${journey.infoEngname }" />
                    </div>
                    <div class="form-group">
                        <label for="infoDescription">지역 설명</label>
                        <textarea id="infoDescription" name="infoDescription" class="form-control" placeholder="해당 지역에 대한 간단한 소개글을 작성해 주세요.">${journey.infoDescription }</textarea>
                    </div>
                    <div class="form-group">
                        <label for="infoFlightyn">항공 여부</label>
                        <label style="margin-right: 10px;">
                            <input type="radio" id="infoFlightyn1" name="infoFlightyn" value="y" <c:if test="${journey.infoFlightyn eq 'y' }">checked</c:if> />
							예 
                        </label>
                        <label>
                            <input type="radio" id="infoFlightyn2" name="infoFlightyn" value="n" <c:if test="${journey.infoFlightyn eq 'n' }">checked</c:if> />
							아니오
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="infoFlight">직항/왕복</label>
                        <label style="margin-right: 10px;">
                            <input type="radio" id="infoFlight1" name="infoFlight" value="str" <c:if test="${journey.infoFlight eq 'str' }">checked</c:if> />
							직항
                        </label>
                        <label>
                            <input type="radio" id="infoFlight2" name="infoFlight" value="round" <c:if test="${journey.infoFlight eq 'round' }">checked</c:if> />
							왕복
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="infoFlighttime">항공 소요 시간</label>
                        <input type="text" id="infoFlighttime" name="infoFlighttime" class="form-control" placeholder="예) 30분, 2시간 40분 etc." value="${journey.infoFlighttime }" />
                    </div>
                    <div class="form-group">
                        <label for="infoVisayn">비자 여부</label>
                        <label style="margin-right: 10px;">
                            <input type="radio" id="infoVisayn1" name="infoVisayn" value="y" <c:if test="${journey.infoVisayn eq 'y' }">checked</c:if> />
							예 
                        </label>
                        <label>
                            <input type="radio" id="infoVisayn2" name="infoVisayn" value="n" <c:if test="${journey.infoVisayn eq 'n' }">checked</c:if> />
							아니오
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="infoVisaexp">비자/무비자</label>
                        <label style="margin-right: 10px;">
                            <input type="radio" id="infoVisaexp1" name="infoVisaexp" value="visa" <c:if test="${journey.infoVisaexp eq 'visa' }">checked</c:if> />
							비자
                        </label>
                        <label>
                            <input type="radio" id="infoVisaexp2" name="infoVisaexp" value="none" <c:if test="${journey.infoVisaexp eq 'none' }">checked</c:if> />
							무비자
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="infoVisatime">비자 유효 기간</label>
                        <input type="text" id="infoVisatime" name="infoVisatime" class="form-control" placeholder="예) 90일, 2년 etc." value="${journey.infoVisatime }" />
                    </div>
                    <div class="form-group">
                        <label for="infoVoltage">전압</label>
                        <label style="margin-right: 10px;">
                            <input type="radio" id="infoVoltage1" name="infoVoltage" value="110V" <c:if test="${journey.infoVoltage eq '110V' }">checked</c:if> />
                            110V
                        </label>
                        <label>
                            <input type="radio" id="infoVoltage2" name="infoVoltage" value="220V" <c:if test="${journey.infoVoltage eq '220V' }">checked</c:if> />
                            220V
                        </label>
                    </div>
                    <div class="form-group">
                        <label for="infoTimedifer">한국 대비 시차 기록</label>
                        <input type="text" id="infoTimedifer" name="infoTimedifer" class="form-control" placeholder="예) UTC -8시간, UTC +2시간 etc." value="${journey.infoTimedifer }" />
                    </div>
                    <div class="form-group">
                        <label for="infoPreviewimg">여행 정보 이미지 업로드</label>
                        <input type="file" class="form-control" id="imgFile" name="imgFile">
                    </div>
                    <div class="form-group">
                        <div>
                            <button id="tripInfoRegBtn" type="button" class="btn btn-outline-primary">여행 정보 ${name }</button>
                            <c:if test="${status ne 'u' }">
	                            <button id="tripInfoChoiceBtn" type="button" class="btn btn-outline-info" onclick="javascript:location.href='/myplan/info.do'">목록으로 돌아가기</button>
                            </c:if>
                            <c:if test="${status eq 'u' }">
	                            <button id="tripInfoChoiceBtn" type="button" class="btn btn-outline-danger" onclick="javascript:location.href='/myplan/info.do'">취소</button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </article>
</section>

<!-- 여행 정보 js -->
<script defer src="${contextPath }/resources/js/journeyInfo.js"></script>

<script>
    $(function(){
        
    	var infoName = $("#infoName");
        var infoEngname = $("#infoEngname");
        var infoDescription = $("#infoDescription");
        
        var imgFile = $("#imgFile");
        var previewImg1 = $("#previewImg1");
        var previewImg2 = $("#previewImg2");
        
        // 공통 함수
        $.journeyInfoPreviewFn(infoName);
        $.journeyInfoPreviewFn2(infoEngname);
        $.journeyInfoPreviewFn3(infoDescription);
        $.flightPreviewFn();
        $.visaPreviewFn();
        $.voltagePreviewFn();
        $.timeDifferPreviewFn();
        
     	// 이미지 미리보기 함수
        $.imgPreviewFn(imgFile, previewImg1);
        $.imgPreviewFn(imgFile, previewImg2);
        
        // validation 체크
        var tripInfoRegBtn = $("#tripInfoRegBtn");
        var jourInfoRegForm = $("#jourInfoRegForm");
        
        var infoName = $("#infoName");
        var infoEngname = $("#infoEngname");
        var infoDescription = $("#infoDescription");
        var infoTimedifer = $("#infoTimedifer");
        
        tripInfoRegBtn.click(function(){
        	var infoNameFlag = $.falsyCheckFn(infoName, "지역명(한글)");
        	if(!infoNameFlag) return;
        	var infoEngnameFlag = $.falsyCheckFn(infoEngname, "지역명(영어)");
        	if(!infoEngnameFlag) return;
        	var infoDescriptionFlag = $.falsyCheckFn(infoDescription, "지역 설명");
        	if(!infoDescriptionFlag) return;
        	var infoTimediferFlag = $.falsyCheckFn(infoTimedifer, "한국 대비 시차 기록");
        	if(!infoTimediferFlag) return;
        	
        	if($(this).text() == "여행 정보 수정"){
        		jourInfoRegForm.attr("action", "/myplan/modify.do");
            }
        	
        	jourInfoRegForm.submit();
        });
        
        // 종횡비 함수
        var previewThumbBox = $(".previewThumbBox");
        var previewThumb = $(".previewThumbBox img");
        $.ratioBoxH(previewThumbBox, previewThumb);
        var previewModalImgBox = $(".previewModalImgBox");
        var previewModalImg = $(".previewModalImgBox img");
        $.ratioBoxH(previewModalImgBox, previewModalImg);
        
    });
</script>
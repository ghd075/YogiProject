<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 마이 트립 css -->
<link href="${contextPath }/resources/css/myTrip.css" rel="stylesheet" />

<section class="myTripChatRoomContainer emptySpace">
    <article class="myTripHeadStyle">
        <div class="myTripImgBox">
            <img src="${contextPath }/resources/images/myTripBgImg.jpg" alt="마이 트립 배경 이미지" />
        </div>
        <div>
            <h3>마이 트립</h3>
            <span>MY TRIP</span>
        </div>
    </article>
    <article class="myTripChatRoomContents cen">
        <div class="chatRoomLeft">
            <div class="chatRoomTabbtnBox">
                <div class="tabbtn tactive">현재멤버</div>
                <c:if test="${recruiter.mategroupRecruiter eq sessionInfo.memId }">
		            <div class="tabbtn">신청멤버</div>
                </c:if>
            </div>
            <div class="chatRoomTabcontBox scroll">
                <div class="tabcont">
                    <ul class="currentMemList">
                        <li>
                            <span>이름</span>
                            <span>성별</span>
                            <span>나이</span>
                            <span>ID</span>
                            <span>결제여부</span>
                        </li>
                        <!-- 반복 구간 -->
                        <c:choose>
                        	<c:when test="${not empty recruiter or not empty mateList }">
                        		<li>
                        			<span class="textDrop">
                        				<i class="fas fa-crown"></i>
	                                	<span class="chatProfileImgBox">
	                                    	<img src="${recruiter.memProfileimg }" alt="프로필 이미지" />
	                                	</span>
										${recruiter.memName }(플래너)
										<i class="fas fa-circle"></i>
		                            </span>
		                            <span>
		                            	<c:if test="${recruiter.memGender eq 'M' }">
		                            		남자
		                            	</c:if>
		                            	<c:if test="${recruiter.memGender eq 'F' }">
		                            		여자
		                            	</c:if>
		                            </span>
		                            <span class="recruitAge">00세</span>
		                            <span class="textDrop detectMemId">${recruiter.memId }</span>
		                            <span>
		                            	<c:if test="${recruiter.mategroupAgree eq '0' }">
		                            		차감 전
		                            	</c:if>
		                            	<c:if test="${recruiter.mategroupAgree eq '1' }">
		                            		차감 완료
		                            	</c:if>
		                            	<c:if test="${recruiter.mategroupAgree eq '2' }">
		                            		결제 완료
		                            	</c:if>
		                            </span>
		                            <script>
		                            	$(function(){
		                            		var ageDate = '${recruiter.memAgedate }';
			                            	var calcAgeTxt = $.ageCalculateFn(ageDate);
			                            	//console.log("calcAgeTxt : ", calcAgeTxt);
			                            	$(".recruitAge").html(calcAgeTxt + "세");
		                            	});
		                            </script>
                        		</li>
                        		<c:forEach items="${mateList }" var="mate" varStatus="stat">
                       				<c:if test="${mate.mategroupApply eq 'Y' }">
								    	<li class="textDropVerticalAlign">
				                            <span class="textDrop">
				                                <span class="chatProfileImgBox">
				                                    <img src="${mate.memProfileimg }" alt="프로필 이미지" />
				                                </span>
												${mate.memName }
				                                <i class="fas fa-circle"></i>
				                            </span>
				                            <span>
					                            <c:if test="${mate.memGender eq 'M' }">
			                            			남자
				                            	</c:if>
				                            	<c:if test="${mate.memGender eq 'F' }">
				                            		여자
				                            	</c:if>
				                            </span>
				                            <span id="lgj${stat.index}">00세</span>
				                            <span class="textDrop detectMemId">${mate.memId }</span>
				                            <span>
					                            <c:if test="${mate.mategroupAgree eq '0' }">
			                            			차감 전
				                            	</c:if>
				                            	<c:if test="${mate.mategroupAgree eq '1' }">
				                            		차감 완료
				                            	</c:if>
				                            	<c:if test="${mate.mategroupAgree eq '2' }">
				                            		결제 완료
				                            	</c:if>
				                            </span>
				                            <script>
				                            	$(function(){
				                            		var ageDate = '${mate.memAgedate }';
				                            		var calcAgeTxt = $.ageCalculateFn(ageDate);
					                            	//console.log("calcAgeTxt : ", calcAgeTxt);
                                                    $("#lgj${stat.index}").html(calcAgeTxt + "세");
				                            	});
				                            </script>
				                        </li>
                       				</c:if>
							    </c:forEach>
                        	</c:when>
                        	<c:otherwise>
                        		<li>
		                        	<div style="text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; border-radius: 4px;">
					    				현재 멤버가 없습니다.
					    			</div>
		                        </li>
                        	</c:otherwise>
                        </c:choose>
                    </ul>
                </div>
                <c:if test="${recruiter.mategroupRecruiter eq sessionInfo.memId }">
	                <div class="tabcont">
	                    <ul class="waitMemList">
	                        <li>
	                            <span>이름</span>
	                            <span>성별</span>
	                            <span>나이</span>
	                            <span>ID</span>
	                            <span>승인/거절</span>
	                        </li>
	                        <!-- 반복 구간 -->
	                        <c:choose>
	                        	<c:when test="${not empty mateList }">
	                        		<c:forEach items="${mateList }" var="mate" varStatus="stat">
	                       				<c:if test="${mate.mategroupApply eq 'W' or mate.mategroupApply eq 'E' }">
									    	<li class="textDropVerticalAlign memChk">
					                            <span class="textDrop">
					                                <span class="chatProfileImgBox">
					                                    <img src="${mate.memProfileimg }" alt="프로필 이미지" />
					                                </span>
													${mate.memName }
					                                <i class="fas fa-circle"></i>
					                            </span>
					                            <span>
						                            <c:if test="${mate.memGender eq 'M' }">
				                            			남자
					                            	</c:if>
					                            	<c:if test="${mate.memGender eq 'F' }">
					                            		여자
					                            	</c:if>
					                            </span>
					                            <span id="lgj${stat.index}">00세</span>
					                            <span class="textDrop findId detectMemId">${mate.memId }</span>
					                            <span>
						                            <button class="btn btn-success acceptMemBtn" type="button">승인</button>
	                                				<button class="btn btn-danger rejectMemBtn" type="button">거절</button>
					                            </span>
					                            <script>
					                            	$(function(){
					                            		var ageDate = '${mate.memAgedate }';
					                            		var calcAgeTxt = $.ageCalculateFn(ageDate);
						                            	//console.log("calcAgeTxt : ", calcAgeTxt);
	                                                    $("#lgj${stat.index}").html(calcAgeTxt + "세");
					                            	});
					                            </script>
					                        </li>
	                       				</c:if>
								    </c:forEach>
	                        	</c:when>
	                        	<c:otherwise>
	                        		<li>
			                        	<div style="text-align: center; width: 50%; margin: 0px auto; float: none; cursor: auto; background-color: #333; color: white; padding: 20px; border-radius: 4px;">
						    				현재 멤버가 없습니다.
						    			</div>
			                        </li>
	                        	</c:otherwise>
	                        </c:choose>
	                    </ul>
	                </div>
                </c:if>
            </div>
            <div class="chatRoomInfoBox">
                <label for="meetName">1. 모임이름</label>
                <input class="form-control" type="text" id="meetName" name="meetName" readonly value="${recruiter.plTitle }" />
                <label for="groupPoint">2. 그룹포인트</label>
                <input class="form-control" type="text" id="groupPoint" name="groupPoint" readonly value="${recruiter.mategroupPoint } 포인트" />
                <label for="meetStatus">3. 모집상태</label>
                <form action="/partner/groupRecruitEnded.do" method="post" id="groupRecruitEnded" name="groupRecruitEnded">
                	<input type="hidden" id="plNo" name="plNo" value="${recruiter.plNo }" />
                </form>
                <c:choose>
                	<c:when test="${recruiter.mategroupStatus eq '1단계' }">
                		<input class="form-control" type="text" id="meetStatus" name="meetStatus" readonly value="모집중" />
                	</c:when>
                	<c:when test="${recruiter.mategroupStatus eq '2단계' }">
                		<input class="form-control" type="text" id="meetStatus" name="meetStatus" readonly value="모집마감" />
                	</c:when>
                	<c:otherwise>
                		<input class="form-control" type="text" id="meetStatus" name="meetStatus" readonly value="결제완료" />
                	</c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <c:if test="${not empty chatRoomInfo }">
			<c:set value="${chatRoomInfo[0].roomNo }" var="roomNo" />
		</c:if>
        
        <div class="chatRoomRight">
            <div class="yogiChatRoomContBox">
                <div class="chatRoomName">
					${recruiter.plTitle } (${mateCnt }명)
                </div>
                <div class="chatRoomContents scroll">
                	<c:if test="${not empty chatInfoList }">
                		<c:forEach items="${chatInfoList }" var="chatInfo">
                			<c:choose>
                				<%-- 내가 쓴 글임 --%>
                				<c:when test="${chatInfo.memId eq sessionInfo.memId }">
                					<c:choose>
                						<%-- 처음 쓴 글임 --%>
                						<c:when test="${chatInfo.chatCnt eq '1' }">
                							<div class="innerTalker">
                								<div class="innerstartDialogContBox">
                									<div class="talkerImgBox">
                										<img src="${chatInfo.memProfileimg }" alt="상대방 프로필 사진" />
                									</div>
                									<div class="boxLeftRight">
											            <div class="innerName"> 
											            	<span class="chatMemName">${chatInfo.memName }</span> 
											            	<span class="chatMemId" style="display: none;">${chatInfo.memId }</span> 
											            </div>
											            <div class="innerStartDialog">
											                <p class="chatMsgTxt" style="display: inline-block; white-space: pre-wrap;">${chatInfo.chatContent }</p>
											                <div class="chatDateInfo" style="height: 34px;">
											                    <div> 
											                    	<span class="yymmdd">${chatInfo.chatYmd }</span> 
											                    	<br> 
											                    	<span class="hhmmss">${chatInfo.chatHms }</span> 
											                    </div>
											                </div>
											            </div>
											        </div>
                								</div>
               									<span class="myChatCnt" style="display: none;">${chatInfo.chatCnt }</span>
               									<span class="sendMemId" style="display: none;">${chatInfo.memId }</span>
                							</div>
                						</c:when>
                						<%-- 나중에 쓴 글임 --%>
                						<c:otherwise>
              							    <div class="innerTalker">
									            <div class="innerLongtakeDialog">
									                <div>
									                    <p class="chatMsgTxt" style="display: inline-block; white-space: pre-wrap;">${chatInfo.chatContent }</p>
									                    <div class="chatDateInfo" style="height: 34px;">
									                        <div> 
									                            <span class="yymmdd">${chatInfo.chatYmd }</span> 
									                            <br> 
									                            <span class="hhmmss">${chatInfo.chatHms }</span> 
									                        </div>
									                    </div>
									                </div>
									            </div>
									            <span class="myChatCnt" style="display: none;">${chatInfo.chatCnt }</span>
									            <span class="sendMemId" style="display: none;">${chatInfo.memId }</span>
									        </div>
                						</c:otherwise>
                					</c:choose>
                				</c:when>
                				<%-- 다른 사람이 쓴 글임 --%>
                				<c:otherwise>
                					<c:choose>
                						<%-- 처음 쓴 글임 --%>
                						<c:when test="${chatInfo.chatCnt eq '1' }">
              							        <div class="outerTalker">
									            <div class="outerstartDialogContBox">
									                <div class="talkerImgBox"> 
									                    <img src="${chatInfo.memProfileimg }" alt="상대방 프로필 사진" /> 
									                </div>
									                <div class="boxLeftRight">
									                    <div class="outerName"> 
									                        <span class="chatMemName">${chatInfo.memName }</span> 
									                        <span class="chatMemId" style="display: none;">${chatInfo.memId }</span> 
									                    </div>
									                    <div class="outerStartDialog">
									                        <p class="chatMsgTxt" style="display: inline-block; white-space: pre-wrap;">${chatInfo.chatContent }</p>
									                        <div class="chatDateInfo" style="height: 34px;">
									                            <div> 
									                                <span class="yymmdd">${chatInfo.chatYmd }</span> 
									                                <br> 
									                                <span class="hhmmss">${chatInfo.chatHms }</span> 
									                            </div>
									                        </div>
									                    </div>
									                </div>
									            </div>
									            <span class="myChatCnt" style="display: none;">${chatInfo.chatCnt }</span>
									            <span class="sendMemId" style="display: none;">${chatInfo.memId }</span>
									        </div>
                						</c:when>
                						<%-- 나중에 쓴 글임 --%>
                						<c:otherwise>
                							<div class="outerTalker">
											    <div class="outerLongtakeDialog">
											        <div>
											            <p class="chatMsgTxt" style="display: inline-block; white-space: pre-wrap;">${chatInfo.chatContent }</p>
											            <div class="chatDateInfo" style="height: 34px;">
											                <div> 
											                    <span class="yymmdd">${chatInfo.chatYmd }</span> 
											                    <br> 
											                    <span class="hhmmss">${chatInfo.chatHms }</span> 
											                </div>
											            </div>
											        </div>
											    </div>
											    <span class="myChatCnt" style="display: none;">${chatInfo.chatCnt }</span>
											    <span class="sendMemId" style="display: none;">${chatInfo.memId }</span>
											</div>
                						</c:otherwise>
                					</c:choose>
                				</c:otherwise>
                			</c:choose>
                		</c:forEach>
                	</c:if>
                	
                </div>
                <div class="chatRoomBtnGroup">
                    <button class="badge bg-primary chatFileUpload" type="button">파일 업로드</button>
                    <button class="badge bg-warning chatPointPush" type="button">차감 요청</button>
                    <button class="badge bg-info chatContTxtDown" type="button">채팅 내역</button>
                    <button class="badge bg-danger chatContDelete" type="button">이전 채팅 삭제</button>
                </div>
                <div class="chatRoomInputArea">
                    <textarea class="form-control chatInputMsg"></textarea>
                    <div>
                        <button class="sendChatMessage" type="button">
                            <i class="fas fa-arrow-up"></i>
                        </button>
                    </div>
                </div>
            </div>
            <div class="moveBackBtnBox">
            	<button type="button" class="btn btn-primary moveBackList">목록으로 돌아가기</button>
            </div>
        </div>
    </article>
</section>

<!-- 마이 트립 js -->
<script src="${contextPath }/resources/js/myTrip.js"></script>
<script>
    $(function(){
        // 공통 함수
        var plNo = '${recruiter.plNo}';
        var roomNo = '${roomNo}';
        
        $.myTripChatroomTabbtnFn();
        $.meetNameClickEvent(plNo);
        $.shoppingPlanFn(plNo);
		$.chatContTxtDownFn(plNo);
		$.chatContDeleteFn(plNo);
        
        // 모집 마감은 관리자만 허용해야 함.
        <c:if test="${recruiter.mategroupRecruiter eq sessionInfo.memId }">
        	$.groupRecruitEndedFn();
        </c:if>
        
        $.memBoxEqualChatBoxH();
        $.moveBackListBtnClickFn();
        $.acceptMemBtnClickFn(plNo);
        $.rejectMemBtnClickFn(plNo);
        $.kickOutFn(plNo);
        
        // 채팅 기능
        var chatMemId = '${sessionInfo.memId}';
        var chatMemName = '${sessionInfo.memName}';
        var chatMemProfileimg = '${sessionInfo.memProfileimg}';
        var chatMemObj = {
        	chatMemId : chatMemId,
        	chatMemName : chatMemName,
        	chatMemProfileimg : chatMemProfileimg
        };
        $.chatingFn(roomNo, chatMemObj);
        
		// get 기능
        var currentURL = window.location.href;
        
        // get 파라미터값 판정
        var queryStringYN = window.location.search !== '' ? true : false;
        console.log('현재 URL:', currentURL);
        console.log('쿼리스트링 존재 여부:', queryStringYN);
        
        // 승인/거절 메시지 alert 기능
		try {
		    var messageUrlTxt = currentURL.split("message=");
		    if (messageUrlTxt.length > 1) {
		        messageUrlTxt = messageUrlTxt[1].split("&mateCnt=");
		        messageTxt = messageUrlTxt[0];
		        var decodedMessage = decodeURIComponent(messageTxt);
		        //alert(decodedMessage);
		        Swal.fire({
		        	title: "승인/거절",
		        	text: decodedMessage,
		        	icon: "info"
		        }).then((result) => {
		        	location.href = "/partner/meetsquare.do?plNo=" + plNo;
		        });
		    } else {
		        throw new Error('No "message" parameter in the query string');
		    }
		} catch (error) {
		    console.error('Error:', error.message);
		}
		
		// 현재 채팅방 참여자 수 갱신 기능
		var mateCntTxt;
		try {
		    var mateCntUrlTxt = currentURL.split("mateCnt=");
		    if (mateCntUrlTxt.length > 1) {
		        mateCntTxt = mateCntUrlTxt[1];
		        var decodedmateCnt = decodeURIComponent(mateCntTxt);
		        var plTitleTxt = '${recruiter.plTitle}';
		        var insertplTitleTxt = plTitleTxt + " (" + decodedmateCnt + "명)";
		        $(".chatRoomName").html(insertplTitleTxt);
		    } else {
		        throw new Error('No "mateCnt" parameter in the query string');
		    }
		} catch (error) {
		    console.error('Error:', error.message);
		}
        
        // 종횡비 함수
        var myTripImgBox = $(".myTripImgBox");
        var myTripImg = $(".myTripImgBox img");
        $.ratioBoxH(myTripImgBox, myTripImg);
        
        $.eachStartingMemberImgResizeFn();
        
        $.eachChatingMemberImgResizeFn();
    });
</script>
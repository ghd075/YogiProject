<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
     
<!-- 마이플랜 css -->
<link href="${contextPath }/resources/css/userPlanChatting.css" rel="stylesheet" />

<!-- 플래너 메인 페이지 화면 영역-->
<section class="bestContainer emptySpace cen">
	<article class="chattingContainer">
		<div class="container">
			<div class="row clearfix">
			    <div class="col-lg-12">
			        <div class="card chat-app">
			            <div id="plist" class="people-list">
			                <div class="input-group">
		                        <input class="form-control" type="text" id="searchWord" name="searchWord" placeholder="검색어 입력" value="${searchWord }" />
								<button type="submit" id="searchBtn">
								    <i class="fas fa-search"></i>
								</button>
			                </div>
			                <ul class="list-unstyled chat-list mt-2 mb-0">
			                    <li class="clearfix">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar1.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">유한라</div>
			                            <div class="status"> <i class="fa fa-circle offline"></i> 7분 전 퇴장 </div>                                            
			                        </div>
			                    </li>
			                    <li class="clearfix active">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">백신우</div>
			                            <div class="status"> <i class="fa fa-circle online"></i> online </div>
			                        </div>
			                    </li>
			                    <li class="clearfix">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">강우진</div>
			                            <div class="status"> <i class="fa fa-circle online"></i> online </div>
			                        </div>
			                    </li>                                    
			                    <li class="clearfix">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">이지운</div>
			                            <div class="status"> <i class="fa fa-circle offline"></i> 10시간 전 퇴장 </div>
			                        </div>
			                    </li>
			                    <li class="clearfix">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar8.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">창리엔</div>
			                            <div class="status"> <i class="fa fa-circle online"></i> online </div>
			                        </div>
			                    </li>
			                    <li class="clearfix">
			                        <img src="https://bootdey.com/img/Content/avatar/avatar3.png" alt="avatar">
			                        <div class="about">
			                            <div class="name">백산</div>
			                            <div class="status"> <i class="fa fa-circle offline"></i> 1월 28일 이후 오프라인 </div>
			                        </div>
			                    </li>
			                </ul>
			            </div>
			            <div class="chat">
			                <div class="chat-header clearfix">
			                    <div class="row">
			                        <div class="col-lg-6">
			                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
			                                <img src="https://images.unsplash.com/photo-1609766418204-94aae0ecfdfc?q=80&w=1032&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D" alt="avatar">
			                            </a>
			                            <div class="chat-about">
			                                <h6 class="m-b-0">2박 3일 제주도 여행 동행구합니다.</h6>
			                                <small>마지막 접속: 2시간 전</small>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                <div class="chat-history">
			                    <ul class="m-b-0">
			                        <li class="clearfix">
			                            <div class="message-data text-right" style="text-align: right;">
			                                <span class="message-data-time">10:10 AM, Today</span>
			                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
			                            </div>
			                            <div class="message other-message float-right">안녕하세요. </div>
			                        </li>
			                        <li class="clearfix">
			                            <div class="message-data">
			                                <span class="message-data-time">10:12 AM, Today</span>
			                                <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar">
			                            </div>
			                            <div class="message my-message">하이하이??</div>                                    
			                        </li>                               
			                        <li class="clearfix">
			                            <div class="message-data">
			                                <span class="message-data-time">10:15 AM, Today</span>
			                                <img src="https://bootdey.com/img/Content/avatar/avatar8.png" alt="avatar">
			                            </div>
			                            <div class="message my-message">안녕세요.</div>
			                        </li>
			                       	<li class="clearfix">
			                            <div class="message-data text-right" style="text-align: right;">
			                                <span class="message-data-time">10:20 AM, Today</span>
			                                <img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar">
			                            </div>
			                            <div class="message other-message float-right">공지합니다. </div>
			                        </li>
			                    </ul>
			                </div>
			                <div class="chat-message clearfix">
			                    <div class="input-group mb-0">
			                    	<button class="btn btn-link bg-white">
							       		<i class="fa fa-paperclip"></i>
							        </button>
			                        <input type="text" id="chat" placeholder="메세지를 입력하세요." class="form-control rounded-0 border-0 py-4 bg-light">
						          	<div class="input-group-append">
						            	<button type="button" class="btn btn-link bg-white" id="sendBtn" onclick="send('message');">
						            		<i class="fa fa-paper-plane"></i>
						            	</button>
						          	</div>                                    
			                    </div>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
		</div>
	</article>
</section>

<!-- 소켓관련 JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<script type="text/javascript">
	// 웹소켓 생성
	var sock = new SockJS("http://localhost/echo");
</script>




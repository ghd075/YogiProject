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
			                    	<input type="hidden" id="sessionId" value="">
			                    	<input type="hidden" id="memName" value="${sessionInfo.memName }" />
			                    	<button class="btn btn-link bg-white">
							       		<i class="fa fa-paperclip"></i>
							        </button>
			                        <input type="text" id="txtMessage" placeholder="메세지를 입력하세요." class="form-control rounded-0 border-0 py-4 bg-light">
						          	<div class="input-group-append">
						            	<button type="button" class="btn btn-link bg-white" id="sendBtn">
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
<!-- 소켓 관련 JS -->
<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
<script>
	// websocket을 지정한 URL로 연결
	// var sock = new SockJS("/echo");
	//websocket 서버에서 메시지를 보내면 자동으로 실행된다.
	
	$("#txtMessage").on("keypress", function(e) {
		if (e.keyCode == 13 && !e.shiftKey) {
			e.preventDefault();
			var message = $("#txtMessage").val();
			if (message == "") {
				alert("메시지를 입력하세요.");
				$("#txtMessage").focus();
				return;
			}
			
			// 서버로 메시지 보내기
			//sock.send(uid + "|" + message);
			//$("#txtMessage").val("");
			
			send();
		}
	})

	// 웹소캣 생성
	var sock = new SockJS("/echo");  // SockJS는 예전 WebSocket을 일부 브라우져가 지원하지 않을 때 사용했던 것!
	// var sock = new WebSocket("ws://localhost/echo");
	sock.onmessage = onMessage;
	//sock.onclose = onClose;
	//sock.onopen = onOpen;

	// 서버로부터 메시지 받기
	function onMessage(e) {
		// e 파라미터는 websocket이 보내준 데이터
		var msg = e.data;		// 전달 받은 데이터
		console.log("받은 값 들 : ", msg);
		if(msg != null && msg.trim() != '') {
			var d = JSON.parse(msg);

			console.log("서버로부터 받은 메시지 : ", d);
			
			//socket 연결시 sessionId 셋팅
			if(d.type == "getId"){
				var si = d.sessionId != null ? d.sessionId : "";
				if(si != ''){
					$("#sessionId").val(si); 
					
					var obj ={
						type: "open",
						sessionId : $("#sessionId").val(),
						userName : $("#memName").val()
					}
					//서버에 데이터 전송
					sock.send(JSON.stringify(obj))
				}
			}
			//채팅 메시지를 전달받은 경우
			else if(d.type == "message"){
			    if(d.sessionId == $("#sessionId").val()){
			        var str = '<li class="clearfix"><div class="message-data text-right" style="text-align: right;"><span class="message-data-time">' + getFormattedDateTime() + '</span><img src="https://bootdey.com/img/Content/avatar/avatar2.png" alt="avatar"></div><div class="message other-message float-right">' + d.msg + '</div></li>';
			        $(".chat-history ul").append(str);	
			    }else{
			        var str = '<li class="clearfix"><div class="message-data"><span class="message-data-time">' + getFormattedDateTime() + '</span><img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="avatar"></div><div class="message my-message">' + d.userName + ' : ' + d.msg + '</div></li>';
			        $(".chat-history ul").append(str);
			    }
			}

			//새로운 유저가 입장하였을 경우
			else if(d.type == "open"){
				if(d.sessionId == $("#sessionId").val()){
					var str = '<li class="clearfix"><div class="text-center text-muted"><strong>[채팅에 참가하였습니다.]</strong></div></li>';
					$(".chat-history ul").append(str);
				}else{
					var str = '<li class="clearfix"><div class="text-center text-muted"><strong>[' + d.userName + '] 님이 입장하였습니다.</strong></div></li>';
					$(".chat-history ul").append(str);
				}
			}
			//유저가 퇴장하였을 경우
			else if(d.type == "close"){
				var str = '<li class="clearfix"><div class="text-center text-muted"><strong>[' + d.userName + '] 님이 퇴장하셨습니다.</strong></div></li>';
				$(".chat-history ul").append(str);
				
			}
			else{
				console.warn("unknown type!")
			}
		}
	}
	
	// 채팅창에서 나갔을 때
	function onClose(evt) {
	    var memName = $("#memName").val();
	    console.log("memName : " +  memName);
	    var str = '<li class="clearfix"><div class="text-center text-muted"><strong>' + memName + ' 님이 나가셨습니다.</strong></div></li>';
	    $(".chat-history ul").append(str);
	}

	// 채팅창에 들어왔을 때
	function onOpen(evt) {
	    var memName = $("#memName").val();
	    console.log("memName : " +  memName);
	    var str = '<li class="clearfix"><div class="text-center text-muted"><strong>' + memName + ' 님이 들어오셨습니다.</strong></div></li>';
	    $(".chat-history ul").append(str);
	}

	// 현재 날짜와 시간을 '년-월-일(요일) AM/PM 시:분' 형식으로 반환
	function getFormattedDateTime() {
	    var date = new Date();
	    var year = date.getFullYear();
	    var month = date.getMonth() + 1;
	    var day = date.getDate();
	    var weekday = ["일", "월", "화", "수", "목", "금", "토"][date.getDay()];
	    var hours = date.getHours();
	    var minutes = date.getMinutes();
	    var ampm = hours >= 12 ? 'PM' : 'AM';
	    hours = hours % 12;
	    hours = hours ? hours : 12; // the hour '0' should be '12'
	    minutes = minutes < 10 ? '0' + minutes : minutes;
	    var strTime = year + "-" + month + "-" + day + "(" + weekday + ") " + ampm + " " + hours + ':' + minutes;
	    return strTime;
	}	
	
	function send() {
		var obj ={
			type: "message",
			sessionId : $("#sessionId").val(),
			userName : $("#memName").val(),
			msg : $("#txtMessage").val()
		}
		//서버에 데이터 전송
		sock.send(JSON.stringify(obj))
		$('#txtMessage').val("");
	}

</script>


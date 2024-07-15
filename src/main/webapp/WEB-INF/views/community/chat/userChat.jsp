<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>userChat.jsp</title>
  <%-- <link href="${ctp}/css/admin/style.min.css" rel="stylesheet"> --%>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
  <style>
/* 		#list {
			height: 390px;
			padding: 15px;
			overflow: auto;
		} */
  </style>
  <script>
	  $(document).ready(function(){
		  
			//채팅 서버 주소
		  //let url = "ws://192.168.50.57:9090/javaclassS14/chat";
		  let url = "ws://localhost:9090/${ctp}/chat";
		     		
		  // 웹 소켓
		  let ws;
		
		  // 연결버튼을 클릭하면 수행처리한다.
		  $('#btnConnect').click(function() {
		  	// 처음 접속시에 유저명 확인
	     	if ($('#user').val().trim() != '') {  // 유저명이 공백이 아니면
	  	   	ws = new WebSocket(url);  // 접속유저라면, 웹소켓에 연결(접속)한다.
	  	   			
	  	   	// 소켓 이벤트 매핑처리(웹소켓에 연결되면 onopen 메소드 수행처리된다.)
	  	   	ws.onopen = function (evt) {
	  	   		//console.log($('#user').val(), '서버 연결 성공');
	  	   		print($('#user').val(), '입장했습니다.');  // print 아래에 만든 메소드명
	  	   				
	  	   		
		  			ws.send('1#' + $('#user').val() + '#');
		  			
		  			$('#chatStatus').html('${sNickName}님 접속중');
	  	   		
		  			$('#user').attr('readonly', true);					
		  			$('#btnConnect').attr('disabled', true);		
		  			$('#btnDisconnect').attr('disabled', false);
		  			$('#msg').attr('disabled', false);	
		  			$('#msg').focus();
		  		};
	        
		  		// 메시지를 보내면 서버에 다녀온 후 getBasicRemote().sendText()에서 가져온 메시지 처리.
	  			ws.onmessage = function (evt) {  // 서버에 넘어온 값이 '2#user명: 메시지'...  '2#user명: 메시지#__@__'
		  			let index = evt.data.indexOf("#", 2);  // 메시지와 색상코드가 있는지 찾고있다. // #을 찾음
		  			let no = evt.data.substring(0, 1);  // 접속자가 1(처음접속자), 2(기존접속자), 3(종료접속자) 인지 판별
		  			let user = evt.data.substring(2, index);  // 로그인 사용자의 유저명을 가져온다.
		  			
		  			if(index == -1) user = evt.data.substring(evt.data.indexOf("#")+1, evt.data.indexOf(":"));  // 색상코드없이 바로 넘어온 경우...	
		  			let txt = evt.data.substring(evt.data.indexOf(":")+1);  // 메시지 발췌
		  	   				
		  			if (no == '1') {	// 최초 접속자는 print2()메소드 호출
		  				print2(user);
		  			} else if (no == '2') {	 // 기존 접속자들은 채팅중이기에 print()에 '유저명','메시지'를 보낸다.
		  				if (txt != '') print(user, txt);
		  			} else if (no == '3') {	 // 종료 사용자는 print3()로 보낸다.
		  				print3(user);
		  			}
		  			$('#list').scrollTop($('#list').prop('scrollHeight'));	// 스크롤바를 가장 아래쪽으로 내린다.
		  		};
	  	   	
		  		// 웹소켓 접속 종료될때 실행 메소드
		  		ws.onclose = function (evt) {
		  			console.log('소켓이 닫힙니다.');
		  		};
	
		  		// 웹소켓 에러 발생 시 실행 메소드
		  		ws.onerror = function (evt) {
		  			console.log(evt.data);
		  		};
		  	} else {
		  		alert('유저명을 입력하세요.');
		  		$('#user').focus();
		  	}
		  });
		
		  // 로그인 사용자가 메시지 전송시 처리(유저명, 메시지)
		  function print(user, txt) {
		  	let temp = '';
		  	
		  	if('${sNickName}'!=user) {	
		  		temp += '<div style="margin-top:15px;margin-bottom:3px;margin-right:100px">';
			  	temp += '<font size="2em" style="margin-top:5px;margin-bottom:5px;padding:5px;">' + user + '</font> ';
		  	}
		  	else {	
		  		temp += '<div style="margin-bottom:3px;margin-left:100px" class="text-right">';
			  	temp += '<font size="1em">' + user + '</font> ';
		  	}
		  	temp += '<span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span><br/>';
		  	if('${sNickName}'!=user) {
		  		temp += '<div style="background-color:#CEF6EC;border:1px solid #fff; border-radius:4px; padding:5px; text-align:left;width:auto;">'+txt+'</div>';
		  	}
		  	else {
		  		if(txt.indexOf("입장했습니다.") != -1) {
		  		  temp += '<div style="background-color:#ff0;border:1px solid #ccc;border-radius:4px;padding:5px;text-align:left;width:auto;">'+user+"님이 " + txt+'</div>';
		  		}
		  		else {
		  		  temp += '<div style="background-color:#ff0;border:1px solid #ccc;border-radius:4px;padding:5px;text-align:left;width:auto;">'+txt+'</div>';		  			
		  		}
		  	}
		  	temp += '</div>';
			  temp = temp.replace(/\n/gi,"<br/>");	
		  			
		  	$('#list').append(temp);	
		  }
		  		
		  // 다른 클라이언트 사용자가 처음 접속할때 처리.
		  function print2(user) {
		  	let temp = '';
		  	temp += '<div style="margin-bottom:3px;">';
		  	temp += "<font color='red'>'" + user + "'</font> 이(가) <font color='blue'>접속</font>했습니다." ;
		  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		  	temp += '</div>';
		  			
		  	$('#list').append(temp);
		  }
		
		  // 클라이언트가 접속 종료시 처리
		  function print3(user) {
		  	let temp = '';
		  	temp += '<div style="margin-bottom:3px;">';
		  	temp += "<font color='red'>'" + user + "'</font> 이(가) <font color='red'>종료</font>했습니다." ;
		  	temp += ' <span style="font-size:11px;color:#777;">' + new Date().toLocaleTimeString() + '</span>';
		  	temp += '</div>';
		  			
		  	$('#list').append(temp);  // list는 밑에 메시지 출력하는 부분
		  }
	
		  
		  $('#user').keydown(function() {
		  	if (event.keyCode == 13) {
		  		$('#btnConnect').click();
		  	}
		  });
		  
		  
		  $('#msg').keydown(function() {
		  	if (event.keyCode == 13) {
		  		if(!event.shiftKey) {
			  		if($('#msg').val().trim() == '') return false;
			  		let chatColor = $("#chatColor").val();
			  		
			  		ws.send('2#' + $('#user').val() + '#' + $(this).val() + '@' + chatColor);
			  		print($('#user').val(), '<font color="'+chatColor+'">'+$(this).val()+'</font>');
			  		
			  		event.preventDefault();	
			      $('#msg').val('');  		
			  		$('#msg').focus();
			  		$('#list').scrollTop($('#list').prop('scrollHeight'));	
		  		}
		  	}
		  });
		  		
		  
		  $('#btnDisconnect').click(function() {
		  	ws.send('3#' + $('#user').val() + '#');
		  	ws.close();
		  			
		  	$('#user').attr('readonly', false);
		  	
		    $('#user').val('${sNickName}');
		  	$('#user').attr('disabled', true);
		  	$('#chatStatus').html('${sNickName}님 <font color="red">접속대기</font>상태');
		  	$('#list').append('<font color="red">${sNickName}</font>님 접속종료');
		  			
		  	$('#btnConnect').attr('disabled', false);
		  	$('#btnDisconnect').attr('disabled', true);
		  			
		  	$('#msg').val('');
		  	$('#msg').attr('disabled', true);
		  });
		  
	  });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="userMain" style="padding-top: 245.125px;">
<div class="container">
	<h2 class="page-header">유저채팅방<font size="3" color="blue">(<span id="chatStatus">${sNickName}님 <font color="red">접속대기</font>상태</span>)</font></h2>		
	
	<div class="row">
		<div class="col-7">
		  <input type="text" name="user" value="${sNickName}" id="user" class="form-control m-0" readonly />
		</div>
		<div class="col-5">
		  <input type="button" value="연결" id="btnConnect" class="btn btn-success btn-sm m-0"/>
		  <input type="button" value="종료" id="btnDisconnect" class="btn btn-warning btn-sm m-0" disabled />
		  <input type="color" name="chatColor" id="chatColor" title="글자색 변경" style="width:40px;" class="p-0"/>
		</div>
	</div>
	<div style="height:400px;border:1px solid #fff;border-radius:4px;margin:2px 0;background-color:#F5ECCE">
		<div id="list"></div>
	</div>
	<div>
		<div>
		  <textarea name="msg" id="msg" rows="3" placeholder="대화 내용을 입력하세요." class="form-control mb-2" disabled></textarea>
		</div>
	</div>
        <div class="page-wrapper">
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-7 align-self-center">
                        <h4 class="page-title text-truncate text-dark font-weight-medium mb-1">Chat</h4>
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 p-0">
                                    <li class="breadcrumb-item text-muted active" aria-current="page">Apps</li>
                                    <li class="breadcrumb-item text-muted" aria-current="page">Chat</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="row no-gutters">
                                <div class="col-lg-3 col-xl-2 border-right">
                                    <div class="card-body border-bottom">
                                        <form>
                                            <input class="form-control" type="text" placeholder="Search Contact">
                                        </form>
                                    </div>
                                    <div class="scrollable position-relative" style="height: calc(100vh - 111px);">
                                        <ul class="mailbox list-style-none">
                                            <li>
                                                <div class="message-center">
                                                    <!-- Message -->
                                                    <a href="javascript:void(0)"
                                                        class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                        <div class="user-img"><img src="assets/images/users/1.jpg"
                                                                alt="user" class="img-fluid rounded-circle"
                                                                width="40px"> <span
                                                                class="profile-status online float-right"></span>
                                                        </div>
                                                        <div class="w-75 d-inline-block v-middle pl-2">
                                                            <h6 class="message-title mb-0 mt-1">Pavan kumar</h6>
                                                            <span
                                                                class="font-12 text-nowrap d-block text-muted text-truncate">Just
                                                                see
                                                                the my new
                                                                admin!</span>
                                                            <span class="font-12 text-nowrap d-block text-muted">9:30
                                                                AM</span>
                                                        </div>
                                                    </a>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                                <div class="col-lg-9  col-xl-10">
                                    <div class="chat-box scrollable position-relative"
                                        style="height: 500px;">
                                        
                                        <!--chat Row -->
                                        <ul class="chat-list list-style-none px-3 pt-3">
                                            <!--chat Row -->
                                            
                                            <li class="chat-item list-style-none mt-3">
                                                <div class="chat-img d-inline-block"><img
                                                        src="assets/images/users/1.jpg" alt="user"
                                                        class="rounded-circle" width="45">
                                                </div>
                                                <div class="chat-content d-inline-block pl-3">
                                                    <h6 class="font-weight-medium">James Anderson</h6>
                                                    <div class="msg p-2 d-inline-block mb-1">Lorem
                                                        Ipsum is simply
                                                        dummy text of the
                                                        printing &amp; type setting industry.</div>
                                                </div>
                                                <div class="chat-time d-block font-10 mt-1 mr-0 mb-3">10:56 am
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    
                                    <div class="card-body border-top">
                                        <div class="row">
                                            <div class="col-9">
                                                <div class="input-field mt-0 mb-0">
                                                    <input id="textarea1" placeholder="Type and enter"
                                                        class="form-control border-0" type="text">
                                                </div>
                                            </div>
                                            <div class="col-3">
                                                <a class="btn-circle btn-lg btn-cyan float-right text-white"
                                                    href="javascript:void(0)"><i class="fas fa-paper-plane"></i></a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
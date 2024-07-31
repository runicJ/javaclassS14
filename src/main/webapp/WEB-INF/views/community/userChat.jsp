<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>유저 채팅방</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<link href="${ctp}/css/admin/style.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #f8f9fa;
    }
    .chat-container {
      background-color: #fff;
      border-radius: 8px;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
      margin-top: 20px;
      padding: 20px;
    }
    .chat-header {
      border-bottom: 1px solid #dee2e6;
      margin-bottom: 20px;
      padding-bottom: 10px;
    }
    .chat-header h2 {
      margin: 0;
    }
    .chat-messages {
      background-color: #f5f5f5;
      border-radius: 8px;
      height: 400px;
      overflow-y: auto;
      padding: 20px;
    }
    .chat-message {
      margin-bottom: 15px;
    }
    .chat-message .user {
      font-weight: bold;
    }
    .chat-message .time {
      color: #888;
      font-size: 0.8em;
    }
    .chat-input {
      margin-top: 20px;
    }
  </style>
  <script>
    $(document).ready(function() {
      let url = "ws://localhost:9090/${ctp}/chat";
      let ws;

      $('#btnConnect').click(function() {
        if ($('#user').val().trim() != '') {
          ws = new WebSocket(url);
          ws.onopen = function(evt) {
            print($('#user').val(), '입장했습니다.');
            ws.send('1#' + $('#user').val() + '#');
            $('#chatStatus').html('${sNickName}님 접속중');
            $('#user').attr('readonly', true);
            $('#btnConnect').attr('disabled', true);
            $('#btnDisconnect').attr('disabled', false);
            $('#msg').attr('disabled', false);
            $('#msg').focus();
          };
          ws.onmessage = function(evt) {
            let index = evt.data.indexOf("#", 2);
            let no = evt.data.substring(0, 1);
            let user = evt.data.substring(2, index);
            if (index == -1) user = evt.data.substring(evt.data.indexOf("#")+1, evt.data.indexOf(":"));
            let txt = evt.data.substring(evt.data.indexOf(":")+1);
            if (no == '1') {
              print2(user);
            } else if (no == '2') {
              if (txt != '') print(user, txt);
            } else if (no == '3') {
              print3(user);
            }
            $('#list').scrollTop($('#list').prop('scrollHeight'));
          };
          ws.onclose = function(evt) {
            console.log('소켓이 닫힙니다.');
          };
          ws.onerror = function(evt) {
            console.log(evt.data);
          };
        } else {
          alert('유저명을 입력하세요.');
          $('#user').focus();
        }
      });

      function print(user, txt) {
        let temp = '<div class="chat-message">';
        if ('${sNickName}' != user) {
          temp += '<div class="user">' + user + '</div>';
        } else {
          temp += '<div class="user text-right">' + user + '</div>';
        }
        temp += '<div class="time">' + new Date().toLocaleTimeString() + '</div>';
        temp += '<div class="message">' + txt + '</div></div>';
        $('#list').append(temp);
      }

      function print2(user) {
        let temp = '<div class="chat-message">';
        temp += "<div class='user' style='color: red;'>" + user + "님이 접속했습니다.</div>";
        temp += '<div class="time">' + new Date().toLocaleTimeString() + '</div></div>';
        $('#list').append(temp);
      }

      function print3(user) {
        let temp = '<div class="chat-message">';
        temp += "<div class='user' style='color: red;'>" + user + "님이 종료했습니다.</div>";
        temp += '<div class="time">' + new Date().toLocaleTimeString() + '</div></div>';
        $('#list').append(temp);
      }

      $('#user').keydown(function(event) {
        if (event.keyCode == 13) {
          $('#btnConnect').click();
        }
      });

      $('#msg').keydown(function(event) {
        if (event.keyCode == 13 && !event.shiftKey) {
          if ($('#msg').val().trim() == '') return false;
          let chatColor = $("#chatColor").val();
          ws.send('2#' + $('#user').val() + '#' + $(this).val() + '@' + chatColor);
          print($('#user').val(), '<font color="' + chatColor + '">' + $(this).val() + '</font>');
          event.preventDefault();
          $('#msg').val('');
          $('#msg').focus();
          $('#list').scrollTop($('#list').prop('scrollHeight'));
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
<section class="container chat-container">
  <div class="chat-header">
    <h2>유저 채팅방 <span id="chatStatus">(${sNickName}님 <font color="red">접속대기</font>상태)</span></h2>
  </div>
  <div class="row">
    <div class="col-7">
    	<img src="${ctp}/user/${sUserImage}" alt="userImage" />
		<input type="text" name="user" value="${sNickName}" id="user" class="form-control m-0" readonly />
    </div>
    <div class="col-5">
      <input type="button" value="연결" id="btnConnect" class="btn btn-success btn-sm m-0"/>
      <input type="button" value="종료" id="btnDisconnect" class="btn btn-warning btn-sm m-0" disabled />
      <input type="color" name="chatColor" id="chatColor" title="글자색 변경" class="p-0"/>
    </div>
  </div>
  <div class="chat-messages" id="list"></div>
  <div class="chat-input">
    <textarea name="msg" id="msg" rows="3" placeholder="대화 내용을 입력하세요." class="form-control" disabled></textarea>
  </div>
</section>

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
                                                    <!-- Message -->
                                                    <a href="javascript:void(0)"
                                                        class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                        <div class="user-img"><img src="assets/images/users/2.jpg"
                                                                alt="user" class="img-fluid rounded-circle"
                                                                width="40px"> <span
                                                                class="profile-status busy float-right"></span>
                                                        </div>
                                                        <div class="w-75 d-inline-block v-middle pl-2">
                                                            <h6 class="message-title mb-0 mt-1">Sonu Nigam</h6>
                                                            <span
                                                                class="font-12 text-nowrap d-block text-muted text-truncate">I've
                                                                sung a
                                                                song! See you at</span>
                                                            <span class="font-12 text-nowrap d-block text-muted">9:10
                                                                AM</span>
                                                        </div>
                                                    </a>
                                                    <!-- Message -->
                                                    <a href="javascript:void(0)"
                                                        class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                        <div class="user-img"> <img src="assets/images/users/3.jpg"
                                                                alt="user" class="img-fluid rounded-circle"
                                                                width="40px"> <span
                                                                class="profile-status away float-right"></span>
                                                        </div>
                                                        <div class="w-75 d-inline-block v-middle pl-2">
                                                            <h6 class="message-title mb-0 mt-1">Arijit Sinh</h6>
                                                            <span
                                                                class="font-12 text-nowrap d-block text-muted text-truncate">I
                                                                am a
                                                                singer!</span>
                                                            <span class="font-12 text-nowrap d-block text-muted">9:08
                                                                AM</span>
                                                        </div>
                                                    </a>
                                                    <!-- Message -->
                                                    <a href="javascript:void(0)"
                                                        class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                        <div class="user-img"><img src="assets/images/users/4.jpg"
                                                                alt="user" class="img-fluid rounded-circle"
                                                                width="40px"> <span
                                                                class="profile-status offline float-right"></span>
                                                        </div>
                                                        <div class="w-75 d-inline-block v-middle pl-2">
                                                            <h6 class="message-title mb-0 mt-1">Nirav Joshi</h6>
                                                            <span
                                                                class="font-12 text-nowrap d-block text-muted text-truncate">Just
                                                                see the my admin!</span>
                                                            <span class="font-12 text-nowrap d-block text-muted">9:02
                                                                AM</span>
                                                        </div>
                                                    </a>
                                                    <!-- Message -->
                                                    <a href="javascript:void(0)"
                                                        class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                        <div class="user-img"><img src="assets/images/users/5.jpg"
                                                                alt="user" class="img-fluid rounded-circle"
                                                                width="40px"> <span
                                                                class="profile-status offline float-right"></span></span>
                                                        </div>
                                                        <div class="w-75 d-inline-block v-middle pl-2">
                                                            <h6 class="message-title mb-0 mt-1">Sunil Joshi</h6>
                                                            <span
                                                                class="font-12 text-nowrap d-block text-muted text-truncate">Just
                                                                see the my admin!</span>
                                                            <span class="font-12 text-nowrap d-block text-muted">9:02
                                                                AM</span>
                                                        </div>
                                                    </a>
                                                    <!-- Message -->
                                                    <a href="javascript:void(0)"
                                                        class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                        <div class="user-img"><img src="assets/images/users/6.jpg"
                                                                alt="user" class="img-fluid rounded-circle"
                                                                width="40px"> <span
                                                                class="profile-status offline float-right"></span>
                                                        </div>
                                                        <div class="w-75 d-inline-block v-middle pl-2">
                                                            <h6 class="message-title mb-0 mt-1">Akshay Kumar</h6>
                                                            <span
                                                                class="font-12 text-nowrap d-block text-muted text-truncate">Just
                                                                see the my admin!</span>
                                                            <span class="font-12 text-nowrap d-block text-muted">9:02
                                                                AM</span>
                                                        </div>
                                                    </a>
                                                    <!-- Message -->
                                                    <a href="javascript:void(0)"
                                                        class="message-item d-flex align-items-center border-bottom px-3 py-2">
                                                        <div class="user-img"><img src="assets/images/users/7.jpg"
                                                                alt="user" class="img-fluid rounded-circle"
                                                                width="40px"> <span
                                                                class="profile-status offline float-right"></span>
                                                        </div>
                                                        <div class="w-75 d-inline-block v-middle pl-2">
                                                            <h6 class="message-title mb-0 mt-1">Pavan kumar</h6>
                                                            <span
                                                                class="font-12 text-nowrap d-block text-muted text-truncate">Just
                                                                see the my admin!</span>
                                                            <span class="font-12 text-nowrap d-block text-muted">9:02
                                                                AM</span>
                                                        </div>
                                                    </a>
                                                    <!-- Message -->
                                                    <a href="javascript:void(0)"
                                                        class="message-item d-flex align-items-center px-3 py-2">
                                                        <div class="user-img"><img src="assets/images/users/8.jpg"
                                                                alt="user" class="img-fluid rounded-circle"
                                                                width="40px"> <span
                                                                class="profile-status offline float-right"></span>
                                                        </div>
                                                        <div class="w-75 d-inline-block v-middle pl-2">
                                                            <h6 class="message-title mb-0 mt-1">Varun Dhavan</h6>
                                                            <span
                                                                class="font-12 text-nowrap d-block text-muted text-truncate">Just
                                                                see the my admin!</span>
                                                            <span class="font-12 text-nowrap d-block text-muted">9:02
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
                                        style="height: calc(100vh - 111px);">
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
                                            <!--chat Row -->
                                            <li class="chat-item list-style-none mt-3">
                                                <div class="chat-img d-inline-block"><img
                                                        src="assets/images/users/2.jpg" alt="user"
                                                        class="rounded-circle" width="45">
                                                </div>
                                                <div class="chat-content d-inline-block pl-3">
                                                    <h6 class="font-weight-medium">Bianca Doe</h6>
                                                    <div class="msg p-2 d-inline-block mb-1">It’s
                                                        Great opportunity to
                                                        work.</div>
                                                </div>
                                                <div class="chat-time d-block font-10 mt-1 mr-0 mb-3">10:57 am
                                                </div>
                                            </li>
                                            <!--chat Row -->
                                            <li class="chat-item odd list-style-none mt-3">
                                                <div class="chat-content text-right d-inline-block pl-3">
                                                    <div class="box msg p-2 d-inline-block mb-1">I
                                                        would love to
                                                        join the team.</div>
                                                    <br>
                                                </div>
                                            </li>
                                            <!--chat Row -->
                                            <li class="chat-item odd list-style-none mt-3">
                                                <div class="chat-content text-right d-inline-block pl-3">
                                                    <div class="box msg p-2 d-inline-block mb-1 box">
                                                        Whats budget
                                                        of the new project.</div>
                                                    <br>
                                                </div>
                                                <div class="chat-time text-right d-block font-10 mt-1 mr-0 mb-3">
                                                    10:59 am</div>
                                            </li>
                                            <!--chat Row -->
                                            <li class="chat-item list-style-none mt-3">
                                                <div class="chat-img d-inline-block"><img
                                                        src="assets/images/users/3.jpg" alt="user"
                                                        class="rounded-circle" width="45">
                                                </div>
                                                <div class="chat-content d-inline-block pl-3">
                                                    <h6 class="font-weight-medium">Angelina Rhodes</h6>
                                                    <div class="msg p-2 d-inline-block mb-1">Well we
                                                        have good budget
                                                        for the project
                                                    </div>
                                                </div>
                                                <div class="chat-time d-block font-10 mt-1 mr-0 mb-3">11:00 am
                                                </div>
                                            </li>
                                            <!--chat Row -->
                                            <li class="chat-item odd list-style-none mt-3">
                                                <div class="chat-content text-right d-inline-block pl-3">
                                                    <div class="box msg p-2 d-inline-block mb-1">I
                                                        would love to
                                                        join the team.</div>
                                                    <br>
                                                </div>
                                            </li>
                                            <!--chat Row -->
                                            <li class="chat-item odd list-style-none mt-3">
                                                <div class="chat-content text-right d-inline-block pl-3">
                                                    <div class="box msg p-2 d-inline-block mb-1 box">
                                                        Whats budget
                                                        of the new project.</div>
                                                    <br>
                                                </div>
                                                <div class="chat-time text-right d-block font-10 mt-1 mr-0 mb-3">
                                                    10:59 am</div>
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
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
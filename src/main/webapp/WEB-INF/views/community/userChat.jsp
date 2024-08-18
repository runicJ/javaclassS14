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
      /* let url = "ws://49.142.159.251:9090/${ctp}/chat"; */
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
    	<%-- <img src="${ctp}/user/${sUserImage}" alt="userImage" /> --%>
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
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
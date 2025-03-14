<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qnaContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
  <!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
  <!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css"> -->
  <style>
    th { background-color: #eee; text-align: center; }
    td { text-align: left; }
  </style>
  <script>
    'use strict';
    
    function answerCheck() {
        let tempStr = '<br/>';
        tempStr += '<h3 class="text-center">답 변 글 달 기</h3>';
        tempStr += '<table class="table">';
        tempStr += '<tr>';
        tempStr += '  <th class="text-center">글쓴이</th>';
        tempStr += '  <td><input type="text" name="nickName" value="${sNickName}" readonly class="form-control"/></td>';
        tempStr += '</tr>';
        tempStr += '<tr>';
        tempStr += '  <th class="text-center">이메일</th>';
        tempStr += '  <td><input type="text" name="email" value="${email}" size="60" class="form-control" required/></td>';
        tempStr += '</tr>';
        tempStr += '<tr>';
        tempStr += '  <th class="text-center">글내용</th>';
        tempStr += '  <td><textarea rows="6" name="qnaContent" required class="form-control"></textarea></td>';
        tempStr += '</tr>';
        tempStr += '<tr>';
        tempStr += '<th class="text-center">비밀번호</th>';
        tempStr += '  <td>';
        tempStr += '    <input type="checkbox" name="pwdCheck" id="pwdCheck"/>';
        tempStr += '		<label for="pwdCheck">비밀글</label>';
        tempStr += '    <input type="password" name="qnaPwd" id="qnaPwd" class="form-control" readonly/>';
        tempStr += '  </td>';
        tempStr += '</tr>';
        tempStr += '<tr>';
        tempStr += '  <td colspan="2" style="text-align:center">';
        tempStr += '    <input type="button" value="답글올리기" onclick="fCheck()" class="btn btn-success"/> &nbsp;';
        tempStr += '    <input type="button" value="취소" onclick="location.reload();" class="btn btn-secondary"/> &nbsp;';
        tempStr += '  </td>';
        tempStr += '</tr>';
        tempStr += '</table>';
        tempStr += '<input type="hidden" name="answerFlag" value="y"/>';
        tempStr += '<input type="hidden" name="productQnaIdx" value="${vo.productQnaIdx}"/>';
        $("#reply").html(tempStr);
      }

      function delCheck() {
        if (confirm("현재 글을 삭제하시겠습니까?")) {
          location.href = "${ctp}/qna/qnaDelete?productQnaIdx=${vo.productQnaIdx}";
        }
      }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
  <div class="container">
    <p><br/></p>
    <h2 class="text-center">QnA 상세보기</h2>
    <br/>

    <table class="table table-bordered">
      <tr>
        <th class="text-center">글쓴이</th>
        <td>${vo.nickName}</td>
        <th class="text-center">작성 날짜</th>
        <td>${fn:substring(vo.qnaDate, 0, fn:length(vo.qnaDate)-3)}</td>
      </tr>
      <tr>
        <th class="text-center">Email</th>
        <td colspan="3">${vo.email}</td>
      </tr>
      <tr>
        <th class="text-center">공개 여부</th>
        <td colspan="3">${vo.qnaOpenFlag == 'y' ? '공개' : '비공개'}</td>
      </tr>
      <tr>
        <th class="text-center">질문 내용</th>
		<td colspan="3">${fn:replace(vo.qnaContent, newLine, "<br/>")}</td>
      </tr>
      <c:if test="${vo.answerFlag == 'y'}">
        <tr>
          <th class="text-center">답변</th>
          <td colspan="3">${fn:replace(vo.answerContent, newLine, "<br/>")}</td>
        </tr>
        <tr>
          <th class="text-center">답변 날짜</th>
          <td colspan="3">${vo.answerDate}</td>
        </tr>
      </c:if>
      <c:if test="${vo.deleteFlag == 'y'}">
        <tr>
          <td colspan="4" style="text-align:center; color: red;">이 글은 삭제된 상태입니다.</td>
        </tr>
      </c:if>
      <tr>
        <td colspan="4" style="text-align:center;">
          <c:if test="${sLevel == '0' || sNickName eq vo.nickName}">
            <input type="button" value="삭제" onclick="delCheck()" class="btn btn-danger"/> &nbsp;
          </c:if>
          <input type="button" value="목록으로" onclick="location.href='qnaList?pag=${pag}&pageSize=${pageSize}';" class="btn btn-warning"/>
        </td>
      </tr>
    </table>

    <form name="myform" method="post" action="qnaInput">
      <div id="reply"></div>
      <input type="hidden" name="pag" value="${pag}"/>
      <input type="hidden" name="pageSize" value="${pageSize}"/>
      <input type="hidden" name="productQnaIdx" value="${vo.productQnaIdx}"/>
      <input type="hidden" name="userId" value="${vo.userId}"/>
    </form>
  </div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>
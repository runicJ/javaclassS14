<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>qnaUpdate.jsp</title>
  <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
  <style>
    th {
      text-align: center;
      background-color: #eee;
    }
  </style>
  <script>
		'use strict';
		
	    function fCheck() {
	        CKupdate();
	        
	        let nickName = myform.nickName.value;
	        let content = myform.qnaContent.value;
	        let pwdCheck = document.getElementById("pwdCheck");
	        let qnaPwd = myform.qnaPwd.value;
	        
	        if (nickName == "") {
	          alert("글쓴이 닉네임을 입력하세요");
	          myform.nickName.focus();
	          return false;
	        }
	        else if (content == "") {
	          alert("글 내용을 입력하세요");
	          myform.qnaContent.focus();
	          return false;
	        }
	        else {
	          if ($("#pwdCheck").is(":checked") && qnaPwd == "") {
	            alert("비밀번호를 입력하세요");
	            myform.qnaPwd.focus();
	            return false;
	          }
	          myform.submit();
	        }
	      }

	      function CKupdate() {
	        for (let instance in CKEDITOR.instances) {
	          CKEDITOR.instances[instance].updateElement();
	        }
	      }

	      $(document).ready(function() {
	        $("#pwdCheck").click(function() {
	          if ($("#pwdCheck").is(":checked")) {
	            $("#qnaPwd").removeAttr("readonly").focus();
	          } else {
	            $("#qnaPwd").attr("readonly", true);
	          }
	        });
	      });
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
  <div class="container">
    <p><br/></p>
    <h2 class="text-center">QnA 수정하기</h2>
    <br/>

    <form name="myform" method="post" action="${ctp}/qna/qnaUpdate">
      <table class="table table-borderless">
        <tr>
          <td><h2>QnA 수정하기</h2></td>
        </tr>
      </table>

      <table class="table">
        <tr>
          <th>글쓴이</th>
          <td><input type="text" name="nickName" value="${vo.nickName}" readonly class="form-control"/></td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><input type="text" name="email" value="${vo.email}" size="60" class="form-control" required/></td>
        </tr>
        <tr>
          <th>글내용</th>
          <td>
            <textarea rows="6" name="qnaContent" id="CKEDITOR" class="form-control" required>${vo.qnaContent}</textarea>
          </td>
        </tr>
        <script>
          CKEDITOR.replace("CKEDITOR", {
            height: 500,
            filebrowserUploadUrl: "${ctp}/imageUpload",
            uploadUrl: "${ctp}/imageUpload"
          });
        </script>
        <tr>
          <th>비밀번호</th>
          <td>
            <input type="checkbox" name="pwdCheck" id="pwdCheck"/>
            <label for="pwdCheck">비밀글</label>
            <font size="1">(비밀글로 등록 시 처음 입력한 비밀번호를 입력해야 수정할 수 있습니다.)</font>
            <input type="password" name="qnaPwd" id="qnaPwd" class="form-control" />
          </td>
        </tr>
        <tr>
          <th>공개 여부</th>
          <td>
            <input type="radio" name="qnaOpenFlag" value="y" ${vo.qnaOpenFlag == 'y' ? 'checked' : ''}/> 공개
            <input type="radio" name="qnaOpenFlag" value="n" ${vo.qnaOpenFlag == 'n' ? 'checked' : ''}/> 비공개
          </td>
        </tr>
        <tr>
          <td colspan="2" style="text-align:center">
            <input type="button" value="글수정하기" onclick="fCheck()" class="btn btn-success"/> &nbsp;
            <input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
            <input type="button" value="돌아가기" onclick="location.href='qnaList';" class="btn btn-secondary"/>
          </td>
        </tr>
      </table>

      <input type="hidden" name="userId" value="${sUid}"/>
      <input type="hidden" name="productQnaIdx" value="${vo.productQnaIdx}"/>
    </form>
  </div>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>
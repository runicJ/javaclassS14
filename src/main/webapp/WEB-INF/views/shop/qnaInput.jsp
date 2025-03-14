<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>qnaInput</title>
 	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
	<script src="${ctp}/ckeditor/ckeditor.js"></script>
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
    <div id="preloder">
      <div class="loader"></div>
    </div>
    
    <section class="shop-details">
      <div class="product__details__pic">
        <form name="myform" method="post" action="${ctp}/qna/qnaInsert">
          <table class="table table-borderless">
            <tr>
              <td><h2>QnA 글쓰기</h2></td>
            </tr>
          </table>

          <table class="table">
            <tr>
              <th>글쓴이</th>
              <td><input type="text" name="nickName" value="${sNickName}" readonly class="form-control"/></td>
            </tr>
            <tr>
              <th>이메일</th>
              <td><input type="text" name="email" value="${email}" size="60" class="form-control" required/></td>
            </tr>
            <tr>
              <th>글내용</th>
              <td>
                <textarea rows="5" name="qnaContent" id="CKEDITOR" class="form-control" required></textarea>
              </td>
            </tr>
            <script>
              $(document).ready(function() {
                CKEDITOR.replace("CKEDITOR", {
                  uploadUrl: "${ctp}/imageUpload",
                  filebrowserUploadUrl: "${ctp}/imageUpload",
                  height: 460
                });
              });
            </script>
            <tr>
              <th>비밀번호</th>
              <td>
                <input type="checkbox" name="pwdCheck" id="pwdCheck"/>
                <label for="pwdCheck">비밀글</label>
                <input type="password" name="qnaPwd" id="qnaPwd" class="form-control" readonly/>
              </td>
            </tr>
            <tr>
              <th>공개 여부</th>
              <td>
                <input type="radio" name="qnaOpenFlag" value="y" checked> 공개
                <input type="radio" name="qnaOpenFlag" value="n"> 비공개
              </td>
            </tr>
            <tr>
              <td colspan="2" style="text-align:center">
                <input type="button" value="글올리기" onclick="fCheck()" class="btn btn-success"/> &nbsp;
                <input type="reset" value="다시쓰기" class="btn btn-warning"/> &nbsp;
                <input type="button" value="돌아가기" onclick="location.href='qnaList';" class="btn btn-secondary"/>
              </td>
            </tr>
          </table>

          <input type="hidden" name="productQnaIdx" value="${vo.productQnaIdx}"/>
          <input type="hidden" name="productIdx" value="${vo.productIdx}"/>
          <input type="hidden" name="userId" value="${sUid}"/>
          <input type="hidden" name="answerFlag" value="n"/>
        </form>
      </div>
    </section>
  </div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>
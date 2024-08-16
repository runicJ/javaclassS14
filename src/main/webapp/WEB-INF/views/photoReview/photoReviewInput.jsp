<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
  <title>photoReview Input</title>
<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
     <script src="${ctp}/ckeditor/ckeditor.js"></script>
  <script>
    'use strict';
    /*
    function fCheck() {
    	let title = document.getElementById("title").value;
    	// ckeditor 입력 내용 받기 = CKEDITOR.instances.textarea태그의id.getData();
    	if(CKEDITOR.instances.CKEDITOR.getData() == '' || CKEDITOR.instances.CKEDITOR.getData().length == 0) {
  	    alert("사진을 등록해주세요.");
  	    $("#content").focus();
    	}
    	else if(title.trim() == "") {
    		alert('제목을 입력하세요');
    		$("#title").focus();
    	}
    	else {
    		myform.submit();
    	}
    }
    */

  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="page">
<div class="container">
  <h2>포토리뷰 등록</h2>
  <hr/>
  <form name="myform" method="post">
    <div class="form-group mb-2">
      <div class="input-group-prepend input-group-text">분 류</div>
      <select name="part" id="part" class="form-control">
          <option value="침구류">침구류</option>
          <option value="유기농 제품">유기농 제품</option>
          <option value="알레르기 완화 제품">알레르기 완화 제품</option>
          <option value="기타">기타</option>
      </select>
    </div>
    <div class="form-group mb-2">
      <div class="input-group-prepend input-group-text">제 목</div>
      <input type="text" name="title" id="title" class="form-control"/>
    </div>
        <div class="form-group mb-2">
          <label for="content">사진파일 업로드</label>
    				<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      			</div>
     			<script>
				    CKEDITOR.replace("content",{
				    	uploadUrl:"${ctp}/imageUpload",
				    	filebrowserUploadUrl: "${ctp}/imageUpload",
				    	height:460
				    });
		  		</script>
        <div class="row">
          <div class="col">
            <input type="button" value="파일전송" onclick="fCheck()" class="btn btn-success"/>
          </div>
          <div class="col text-right">
            <input type="button" value="돌아가기" onclick="location.href='photoReviewList';" class="btn btn-warning"/>
          </div>
        </div>
    <input type="hidden" name="mid" value="${sUid}" />
    <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
  </form>
</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
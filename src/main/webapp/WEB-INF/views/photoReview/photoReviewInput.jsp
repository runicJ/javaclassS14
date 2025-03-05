<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>포토리뷰 등록</title>
  
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />

  <style>
    body {
      background-color: #f5f5f5;
    }
    .domain {
      width: 1000px;
      margin: 20px auto;
      padding: 30px;
      background: #ffffff;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .form-group {
      margin-bottom: 20px;
    }
    .preview-container {
      display: flex;
      flex-wrap: wrap;
      gap: 10px;
      margin-top: 10px;
    }
    .preview-container img {
      width: 150px;
      height: auto;
      border-radius: 5px;
      box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }
    .btn-container {
      display: flex;
      justify-content: space-between;
    }
  </style>

  <script>
    'use strict';

    function fCheck() {
        let title = document.getElementById("title").value;
        let content = document.getElementById("content").value.trim();
        
        if (content == "") {
            alert("내용을 입력하세요.");
            return false;
        }
        if (title.trim() == "") {
            alert("제목을 입력하세요.");
            return false;
        }

        document.myform.submit();
    }

    function previewImages(event) {
        let files = event.target.files;
        let previewContainer = document.getElementById("preview-container");
        previewContainer.innerHTML = ""; // 기존 미리보기 초기화

        for (let i = 0; i < files.length; i++) {
            let fileReader = new FileReader();
            fileReader.onload = function (e) {
                let imgElement = document.createElement("img");
                imgElement.src = e.target.result;
                previewContainer.appendChild(imgElement);
            };
            fileReader.readAsDataURL(files[i]);
        }
    }
  </script>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />

<section class="page">
  <div class="domain">
    <h2 class="text-center">📷 포토리뷰 등록</h2>
    <hr/>

    <form name="myform" method="post" action="photoReviewInput" enctype="multipart/form-data">
      <div class="form-group">
        <label>📌 분류</label>
        <select name="part" id="part" class="form-control">
          <option value="침구류">침구류</option>
          <option value="유기농 제품">유기농 제품</option>
          <option value="알레르기 완화 제품">알레르기 완화 제품</option>
          <option value="기타">기타</option>
        </select>
      </div>

      <div class="form-group">
        <label>📌 제목</label>
        <input type="text" name="title" id="title" class="form-control" placeholder="제목을 입력하세요"/>
      </div>

      <div class="form-group">
        <label>📌 내용</label>
        <textarea name="content" id="content" class="form-control" rows="5" placeholder="내용을 입력하세요"></textarea>
      </div>

      <div class="form-group">
        <label>📌 파일 업로드 (여러 장 가능)</label>
        <input type="file" name="uploadFiles" id="uploadFiles" class="form-control" multiple accept="image/*" onchange="previewImages(event)"/>
        <div id="preview-container" class="preview-container"></div>
      </div>

      <div class="btn-container">
        <input type="button" value="파일 전송" onclick="fCheck()" class="btn btn-success"/>
        <input type="button" value="돌아가기" onclick="location.href='photoReviewList';" class="btn btn-warning"/>
      </div>

      <input type="hidden" name="userId" value="${sUid}" />
      <input type="hidden" name="hostIp" value="${pageContext.request.remoteAddr}" />
    </form>
  </div>
</section>

<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
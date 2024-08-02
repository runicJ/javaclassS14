<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>eventInput</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
  	<script src="${ctp}/ckeditor/ckeditor.js"></script>
  	<script>
  		'use strict';
  		
	    function fCheck() {
	    	let faqTitle = myform.faqTitle.value;
			
			if(faqCategory == "") {
				alert("자주묻는질문 유형을 선택하세요!");
				return false;
			}
			else if(faqTitle == "") {
				alert("자주묻는질문 타이틀을 입력하세요!");
				return false;
			}
			else if(faqContent == "") {
				alert("자주묻는질문 내용을 입력하세요!");
				return false;
			}
			else {
				myform.submit();
			}
	    }
  	</script>
</head>
<body>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
			<div class="card p-5">
                <form name="myform" method="post" action="${ctp}/admin/info/faqInput" enctype="multipart/form-data">
                <div class="card-body">
                    <h2 class="card-title text-center mb-5"><i class="fa-solid fa-triangle-exclamation"></i> 자주묻는질문 등록하기</h2>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-triangle-exclamation"></i> 질의응답 유형</label>
                        <div class="col-md-9">
                            <div class="custom-text">
                           <select name="faqCategory" id="faqCategory">
                                <option value="">유형선택</option>
                                <option>회원/가입</option>
                                <option>주문/결제</option>
                                <option>배송</option>
                                <option>취소</option>
                                <option>반품</option>
                                <option>쿠폰/포인트</option>
                                <option>알레르기 정보</option>
                            </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-triangle-exclamation"></i> 질의응답 제목</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="faqTitle" id="faqTitle" placeholder="질의응답 제목을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-triangle-exclamation"></i> 질의응답 게시 여부</label>
                            <div class="custom-control custom-radio">
                                <input type="radio" id="customRadio4" name="faqStatus" value="y" class="custom-control-input" checked>
                                <label class="custom-control-label" for="customRadio4">게시하기</label>
                            </div> &nbsp;&nbsp;&nbsp;&nbsp;
                            <div class="custom-control custom-radio">
                                <input type="radio" id="customRadio5" name="faqStatus" value="n" class="custom-control-input">
                                <label class="custom-control-label" for="customRadio5">숨기기</label>
                            </div>
                    </div>
                </div>
				<div class="form-group">
      				<label for="content">공지 내용</label>
      				<textarea rows="5" name="content" id="CKEDITOR" class="form-control" required></textarea>
      			</div>
     			<script>
				    CKEDITOR.replace("content",{
				    	uploadUrl:"${ctp}/imageUpload",
				    	filebrowserUploadUrl: "${ctp}/imageUpload",
				    	height:460
				    });
		  		</script>
                <div class="border-top">
                    <div class="card-body text-center">
                        <input type="button" onclick="fCheck()" value="공지 등록하기" class="btn btn-primary mr-3">
                        <a type="button" href="${ctp}/admin/adminMain" class="btn btn-danger">취소하기</a>
                    </div>
                </div>
               </form>
            </div>
		</div>
	</div>
</body>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
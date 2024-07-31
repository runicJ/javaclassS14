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
</head>
<body>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
			<div class="card p-5">
                <form name="myform" method="post" enctype="multipart/form-data">
                <div class="card-body">
                    <h2 class="card-title text-center mb-5"><i class="fa-solid fa-gift"></i> 이벤트 등록하기</h2>
                    <div class="form-group row">
                        <label class="col-md-3 m-t-15"><i class="fa-solid fa-gift"></i> 이벤트 카테고리</label>
                        <div class="col-md-9">
                            <select class="select2 form-control custom-select mr-3" name="productTopIdx" id="productTopIdx" onchange="selectTopOneCk()" style="width: 40%; height:36px;">
                                <option value="">대분류 선택</option>
                            	<c:forEach var="vo" items="${vos}">
                            	<option value="${vo.productTopIdx}">${vo.productTopName}</option>
                            	</c:forEach>
                            </select>
                            <select class="select2 form-control custom-select" name="productMidIdx" id="productMidIdx" style="width: 40%; height:36px;">
                                <option value="">중분류 선택</option>
								<c:forEach var="middleVo" items="${middleVos}">
								  	<option value=""></option>
								</c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-gift"></i> 이벤트 코드</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productCode" id="productCode" placeholder="이벤트코드를 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-gift"></i> 이벤트명</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productName" id="productName" placeholder="이벤트명을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                     <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-gift"></i> 이벤트 설명</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productDetails" id="productDetails" placeholder="간략한 이벤트 설명을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                 	    <label class="col-md-3"><i class="fa-solid fa-gift"></i> 판매가</label>
                        <div class="col-md-9">
                            <div class="input-group">
                            	<div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">￦</span>
                                </div>
                                <input type="number" class="form-control" name="productPrice" id="productPrice" min=0 placeholder="5,000">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-gift"></i> 제조 회사</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productBrand" id="productBrand" placeholder="회사명을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-gift"></i> 제조국</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productCountry" id="productCountry" placeholder="제조국을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                 	    <label class="col-md-3"><i class="fa-solid fa-gift"></i> 이벤트 태그 (3개)</label>
                        <div class="col-lg-9 col-md-12">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">#</span>
                                </div>
                                <input type="text" class="form-control" name="productTags" id="productTags" placeholder="ex) #그린아트#학습#평가">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-gift"></i> 이벤트 대표이미지</label>
                        <div class="col-md-9">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" name="file" id="file" required>
                                <label class="custom-file-label" for="validatedCustomFile">상품이미지 선택</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-gift"></i> 출고지</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="shipAddress" id="shipAddress" value="충청북도 청주시 서원구 사직대로 109, 4층" placeholder="출고지를 입력하세요" required>
                            </div>
                        </div>
                    </div>
                </div>
				<div class="form-group">
      				<label for="content">이벤트 이미지</label>
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
                        <input type="button" onclick="fCheck()" value="이벤트 등록하기" class="btn btn-primary mr-3">
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
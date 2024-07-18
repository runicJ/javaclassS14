<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>productInput</title>
	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <script src="${ctp}/ckeditor/ckeditor.js"></script>
	<script>
		'use strict';
		
		function selectTopOneCk() {
			var productTopIdx = myform.selectTopOne.value;
			$.ajax({
				url  : "${ctp}/admin/shop/productMidName",
				type : "post",
				data : {productTopIdx : productTopIdx},
				success:function(data) {
					var str = "";
					str += "<option value=''>중분류 선택</option>";
					for(var i=0; i<data.length; i++) {
						str += "<option value='"+data[i].productMidIdx+"'>"+data[i].productMidName+"</option>";
					}
					$("#selectMidOne").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});

		}
		
	    // 상품 등록하기전에 체크후 전송...
	    function fCheck() {
	    	let productTopIdx = myform.selectTopOne.value;
	    	let productMidIdx = myform.selectMidOne.value;
	    	let productCode = myform.productCode.value;
	    	let productName = myform.productName.value;
			let productPrice = myform.productPrice.value;
			let productDetails = myform.productDetails.value;
			let file = myform.file.value;	
			let ext = file.substring(file.lastIndexOf(".")+1);
			let uExt = ext.toUpperCase();
			let regExpPrice = /^[0-9|_]*$/;
			
			if(productCode == "") {
				alert("상품코드를 입력하세요!");
				return false;
			}
			else if(productName == "") {
				alert("상품명을 입력하세요!");
				return false;
			}
			else if(file == "") {
				alert("상품 메인 이미지를 등록하세요");
				return false;
			}
			else if(uExt != "JPG" && uExt != "GIF" && uExt != "PNG" && uExt != "JPEG") {
				alert("업로드 가능한 파일이 아닙니다.");
				return false;
			}
			else if(mainPrice == "" || !regExpPrice.test(mainPrice)) {
				alert("상품금액은 숫자로 입력하세요.");
				return false;
			}
			else if(detail == "") {
				alert("상품의 초기 설명을 입력하세요");
				return false;
			}
			else if(document.getElementById("file").value != "") {
				var maxSize = 1024 * 1024 * 10;  // 10MByte까지 허용
				var fileSize = document.getElementById("file").files[0].size;
				if(fileSize > maxSize) {
					alert("첨부파일의 크기는 10MB 이내로 등록하세요");
					return false;
				}
				else {
					myform.submit();
				}
			}
	    }
	</script>
</head>
<body>
	<div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
			<div class="card">
                <form name="myform" method="post" enctype="multipart/form-data">
                <div class="card-body">
                    <h2 class="card-title text-center mb-5"><i class="fa-solid fa-tag"></i> 제품 등록하기</h2>
                    <div class="form-group row">
                        <label class="col-md-3 m-t-15"><i class="fa-solid fa-tag"></i> 제품 카테고리</label>
                        <div class="col-md-9">
                            <select class="select2 form-control custom-select mr-3" name="selectTopOne" id="selectTopOne" onchange="selectTopOneCk()" style="width: 40%; height:36px;">
                                <option value="">대분류 선택</option>
                            	<c:forEach var="vo" items="${vos}">
                            	<option value="${vo.productTopIdx}">${vo.productTopName}</option>
                            	</c:forEach>
                            </select>
                            <select class="select2 form-control custom-select" name="selectMidOne" id="selectMidOne" style="width: 40%; height:36px;">
                                <option value="">중분류 선택</option>
								<c:forEach var="middleVo" items="${middleVos}">
								  	<option value=""></option>
								</c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제품 코드</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productCode" placeholder="제품코드를 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제품명</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productName" placeholder="제품명을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제품 설명</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productDetails" placeholder="간략한 제품 설명을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                 	    <label class="col-md-3"><i class="fa-solid fa-tag"></i> 판매가</label>
                        <div class="col-md-9">
                            <div class="input-group">
                            	<div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">￦</span>
                                </div>
                                <input type="number" class="form-control" name="productPrice" min=0 placeholder="5,000">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제조 회사</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productBrand" placeholder="회사명을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제조국</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productCountry" placeholder="제조국을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="row mb-3 align-items-center">
                 	    <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제품 태그 (3개)</label>
                        <div class="col-lg-9 col-md-12">
                            <div class="input-group">
                                <div class="input-group-prepend">
                                    <span class="input-group-text" id="basic-addon1">#</span>
                                </div>
                                <input type="text" class="form-control" name="productTags" placeholder="ex) #그린아트#학습#평가">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제품 대표이미지</label>
                        <div class="col-md-9">
                            <div class="custom-file">
                                <input type="file" class="custom-file-input" name="file" id="file" required>
                                <label class="custom-file-label" for="validatedCustomFile">상품이미지 선택</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 출고지</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="shipAddress" placeholder="출고지를 입력하세요" required>
                            </div>
                        </div>
                    </div>
                </div>
		        <textarea name="content" id="CKEDITOR" rows="8" cols="80"></textarea>
		        <script>
	  				CKEDITOR.replace("content",{  // 라이브러리에서 지원해주는 코드만 써야함(jsp이런거 안됨)
	  					height:480,
		        	  filebrowserUploadUrl:"${ctp}/imageUpload",  /* 파일(이미지)를 업로드 시키기 위한 매핑여로(메소드) */
		        	  uploadUrl : "${ctp}/imageUpload"  	/* uploadUrl : 여러개의 그림 파일을 드래그&드롭해서 올릴수 있다. */
	  				});
		        </script>
                <div class="border-top">
                    <div class="card-body text-center">
                        <a type="button" href="${ctp}/admin/shop/productInput" class="btn btn-primary mr-3">제품 등록하기</a>
                        <a type="button" href="${ctp}/admin/adminMain" class="btn btn-danger">취소하기</a>
                    </div>
                </div>
               </form>
            </div>
		</div>
	</div>
</body>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
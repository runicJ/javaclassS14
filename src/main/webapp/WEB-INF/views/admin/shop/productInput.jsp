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
			var productTopIdx = myform.productTopIdx.value;
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
					$("#productMidIdx").html(str);
				},
				error : function() {
					alert("전송오류!");
				}
			});

		}
		
	    // 상품 등록하기전에 체크 후 전송...
	    function fCheck() {
	    	let productTopIdx = myform.productTopIdx.value;
	    	let productMidIdx = myform.productMidIdx.value;
	    	let productCode = myform.productCode.value;
	    	let productName = myform.productName.value;
			let productPrice = myform.productPrice.value;
			let productDetails = myform.productDetails.value;
			let regExpPrice = /^[0-9|_]*$/;
			let productBrand = myform.productBrand.value;
			let productCountry = myform.productCountry.value;
			let productTags = myform.productTags.value;
			let shipAddress = myform.shipAddress.value;
			let file = myform.file.value;	
			let ext = file.substring(file.lastIndexOf(".")+1);
			let uExt = ext.toUpperCase();
			
			if(productName == "") {
				alert("상품명을 입력하세요!");
				return false;
			}
			else if(productCode == "") {
				alert("상품코드를 입력하세요!");
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
			else if(productPrice == "" || !regExpPrice.test(productPrice)) {
				alert("상품금액은 숫자로 입력하세요.");
				return false;
			}
			else if(productDetails == "") {
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
			<div class="card p-5">
                <form name="myform" method="post" enctype="multipart/form-data">
                <div class="card-body">
                    <h2 class="card-title text-center mb-5"><i class="fa-solid fa-tag"></i> 제품 등록하기</h2>
                    <div class="form-group row">
                        <label class="col-md-3 m-t-15"><i class="fa-solid fa-tag"></i> 제품 카테고리</label>
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
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제품 코드</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productCode" id="productCode" placeholder="제품코드를 입력하세요" required>
                            </div>
                        </div>
                    </div> 
                    
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제품명</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productName" id="productName" placeholder="제품명을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                     <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제품 설명</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productDetails" id="productDetails" placeholder="간략한 제품 설명을 입력하세요" required>
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
                                <input type="number" class="form-control" name="productPrice" id="productPrice" min=0 placeholder="5,000">
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제조 회사</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productBrand" id="productBrand" placeholder="회사명을 입력하세요" required>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label class="col-md-3"><i class="fa-solid fa-tag"></i> 제조국</label>
                        <div class="col-md-9">
                            <div class="custom-text">
	                            <input type="text" class="form-control" name="productCountry" id="productCountry" placeholder="제조국을 입력하세요" required>
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
                                <input type="text" class="form-control" name="productTags" id="productTags" placeholder="ex) #그린아트#학습#평가">
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
	                            <input type="text" class="form-control" name="shipAddress" id="shipAddress" value="충청북도 청주시 서원구 사직대로 109, 4층" placeholder="출고지를 입력하세요" required>
                            </div>
                        </div>
                    </div>
                </div>
				<div class="form-group">
      				<label for="content">상품상세설명</label>
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
                        <input type="button" onclick="fCheck()" value="제품 등록하기" class="btn btn-primary mr-3">
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
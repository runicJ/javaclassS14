<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>productCategory</title>
  	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
  	<style>
		.switch {
		  position: relative;
		  display: inline-block;
		  width: 60px;
		  height: 34px;
		}
		
		.switch input { 
		  opacity: 0;
		  width: 0;
		  height: 0;
		}
		
		.slider {
		  position: absolute;
		  cursor: pointer;
		  top: 0;
		  left: 0;
		  right: 0;
		  bottom: 0;
		  background-color: #ccc;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		.slider:before {
		  position: absolute;
		  content: "";
		  height: 26px;
		  width: 26px;
		  left: 4px;
		  bottom: 4px;
		  background-color: white;
		  -webkit-transition: .4s;
		  transition: .4s;
		}
		
		input:checked + .slider {
		  background-color: #2196F3;
		}
		
		input:focus + .slider {
		  box-shadow: 0 0 1px #2196F3;
		}
		
		input:checked + .slider:before {
		  -webkit-transform: translateX(26px);
		  -ms-transform: translateX(26px);
		  transform: translateX(26px);
		}
		
		/* Rounded sliders */
		.slider.round {
		  border-radius: 34px;
		}
		
		.slider.round:before {
		  border-radius: 50%;
		}

	</style>
	<script>
		'use strict';
		
		// 대분류 등록하기
	    function categoryTopInput() {
			let productTopName = categoryTopFrom.categoryTopName.value;
			
	    	if(productTopName.trim() == "") {
	    		alert("대분류명을 입력하세요");
	    		categoryTopFrom.categoryTopName.focus();
	    		return false;
	    	}
	    	$.ajax({
	    		url  : "${ctp}/admin/shop/categoryTopInput",
	    		type : "post",
	    		data : {
	    			productTopName : productTopName
	    		},
	    		success:function(res) {
	    			if(res == "0") alert("같은 이름의 대분류 항목이 등록되어 있습니다. 다시 확인해 주세요!");
	    			else {
	    				alert("대분류 항목이 등록되었습니다.");
	    				location.reload();
	    			}
	    		},
	  			error: function() {
	  				alert("전송오류!");
	  			}
	    	});
	    }
	    
	    // 대분류 삭제
	    function categoryTopDelete(productTopIdx) {
	    	let ans = confirm("대분류 항목을 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	$.ajax({
	    		url  : "${ctp}/admin/shop/categoryTopDelete",
	    		type : "post",
	    		data : {productTopIdx : productTopIdx},
	    		success:function(res) {
	    			if(res == "0") alert("관련된 하위항목이 존재합니다. \n하위항목을 먼저 삭제해 주세요.");
	    			else {
	    				alert("대분류 항목이 삭제 되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
	    }
	    
	    // 중분류 등록하기
	    function categoryMidInput() {
	    	let productTopIdx = categoryMidForm.categoryTopIdx.value;
	    	let productMidName = categoryMidForm.categoryMidName.value;
	    	if(productTopIdx.trim() == "" || productMidName.trim() == "") {
	    		alert("중분류 정보를 확인해주세요.");
	    		categoryMidForm.categoryMidName.focus();
	    		return false;
	    	}
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/admin/shop/categoryMidInput",
	    		data : {
	    			productTopIdx : productTopIdx,
	    			productMidName : productMidName
	    		},
	    		success:function(res) {
	    			if(res == "0") alert("중분류 항목에 같은 이름이 등록되어 있습니다.\n확인 후 다시 입력하세요");
	    			else {
	    				alert("중분류 항목이 등록되었습니다.");
	    				location.reload();
	    			}
	    		},
	  			error: function() {
	  				alert("전송오류!");
	  			}
	    	});
	    }
	    
	    // 중분류 삭제
	    function categoryMidDelete(productMidIdx) {
	    	let ans = confirm("중분류 항목을 삭제하시겠습니까?");
	    	if(!ans) return false;
	    	
	    	$.ajax({
	    		type : "post",
	    		url  : "${ctp}/admin/shop/categoryMidDelete",
	    		data : {productMidIdx : productMidIdx},
	    		success:function(res) {
	    			if(res == "0") {
	    				alert("해당 항목에 대한 상품이 있어 삭제가 불가능합니다. \n상품을 먼저 확인해주세요.");
	    			}
	    			else {
	    				alert("중분류 항목이 삭제 되었습니다.");
	    				location.reload();
	    			}
	    		},
	    		error : function() {
	    			alert("전송오류!");
	    		}
	    	});
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
  		    <div class="card text-center p-5">
	        	<div class="card-body">
					<h2 class="card-title mb-4">제품 카테고리 등록</h2>
					<form name="categoryTopFrom" method="post">
						<div class="form-group"> 
							<div class="input-group mb-3">
								<label class="input-group-text">대분류 등록</label>
								<input type="text" name="categoryTopName" class="form-control" />
								<input type="button" onclick="categoryTopInput()" value="등록하기" class="input-group-append btn btn-info btn-sm" />
							</div>
						</div>
					</form>
					<form name="categoryMidForm" method="post">
						<div class="input-group">
							<label class="input-group-text">중분류 등록</label>
							<select name="categoryTopIdx">
							<c:forEach var="topVO" items="${topVOS}" varStatus="st">
								<option value="${topVO.productTopIdx}">${topVO.productTopName}</option>
							</c:forEach>
							</select>
							<input type="text" name="categoryMidName" class="form-control" />
							<input type="button" value="등록하기" onclick="categoryMidInput()" class="input-group-append btn btn-info btn-sm" />
						</div>
					</form>
				</div>	
			</div>

		    <div class="card text-center p-4">
		        <div class="card-body">
		            <h3 class="card-title">제품 대분류 목록</h3>
		            <div class="table-responsive">
		                <table class="table">
		                    <thead class="bg-warning text-white">
		                        <tr>
		                            <th>번호</th>
		                            <th>대분류</th>
		                            <th>사용 여부</th>
		                            <th>중분류 여부</th>
		                            <th>비고</th>
		                        </tr>
		                    </thead>
		                    <tbody>
			                    <c:forEach var="topVO" items="${topVOS}" varStatus="st">
		                        <tr>
		                            <td>${st.count} </td>
		                            <td>${topVO.productTopName}</td>
		                            <td>
		                            	<label class="switch">
											<input type="checkbox" ${topVO.useYn == 'y' ? 'checked' : ''}>
											<span class="slider"></span>
										</label>
		                            </td>
		                            <td>
		                            	<label class="switch">
											<input id="check-5" type="checkbox" ${topVO.hasMid == 'y' ? 'checked' : ''}>
											<span class="slider"></span>
										</label>
		                            </td>
		                            <td>
		                            	<a type="button" class="badge badge-info text-light mr-1">수정하기</a>
		                            	<a type="button" class="badge badge-danger text-light" onclick="categoryTopDelete('${topVO.productTopIdx}')">삭제하기</a>
		                            </td>
		                        </tr>
		                        </c:forEach>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		        <div class="card-body">
		            <h3 class="card-title">제품 중분류 목록</h3>
		            <div class="table-responsive">
		                <table class="table">
		                    <thead class="bg-warning text-white">
		                        <tr>
		                            <th>번호</th>
		                            <th>대분류</th>
		                            <th>중분류명</th>
		                            <th>비고</th>
		                        </tr>
		                    </thead>
		                    <tbody>
			                    <c:forEach var="midVO" items="${midVOS}" varStatus="st">
		                        <tr>
		                            <td>${st.count} </td>
		                            <td>${midVO.productTopName}</td>
		                            <td class="input-group"><input type="text" class="form-control" value="${midVO.productMidName}" readonly style="width:150px;" /><span class="form-group-append"><i class="fa-regular fa-pen-to-square"></i></span></td>
		                            <td>
		                            	<a type="button" class="badge badge-info text-light mr-1">수정하기</a>
		                            	<a type="button" class="badge badge-danger text-light" onclick="categoryMidDelete('${midVO.productMidIdx}')">삭제하기</a>
		                            </td>
		                        </tr>
		                        </c:forEach>
		                    </tbody>
		                </table>
		            </div>
		        </div>
	    	</div>
	    </div>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
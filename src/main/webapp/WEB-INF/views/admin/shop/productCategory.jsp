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
  		    <div class="card text-center">
	        	<div class="card-body">
					<h2 class="card-title mb-4">제품 카테고리 등록</h2>
					<form name="myform" method="post">
						<div class="form-group"> 
							<div class="input-group mb-3">
								<label class="input-group-text">대분류 목록</label>
								<input type="text" name="productTopName" class="form-control" />
								<input type="button" name="" value="입력하기" class="input-group-append btn btn-info btn-sm" />
							</div>	
							<div class="input-group">
								<label class="input-group-text">중분류 목록</label>
								<div class="btn-group">
                                    <button type="button" class="btn btn-outline-info dropdown-toggle"
                                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                        대분류 선택
                                    </button>
                                    <div class="dropdown-menu">
										<a class="dropdown-item">침구류</a>
                                    </div>
                                </div>
								<input type="text" name="productMidName" class="form-control" />
								<input type="button" value="입력하기" class="input-group-append btn btn-info btn-sm" />
							</div>
						</div>	
					</form>
				</div>
			</div>
		    <div class="card text-center">
		        <div class="card-body">
		            <h4 class="card-title">제품 카테고리 목록</h4>
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
			                    <c:forEach var="vo" items="${vos}" varStatus="st">
		                        <tr>
		                            <td>${st.count} </td>
		                            <td>${vo.productTopName}</td>
		                            <td>
		                            	<label class="switch">
											<input type="checkbox" ${vo.useYn == 'y' ? 'checked' : ''}>
											<span class="slider"></span>
										</label>
		                            </td>
		                            <td>
		                            	<label class="switch">
											<input type="checkbox" ${vo.hasMid == 'y' ? 'checked' : ''}>
											<span class="slider"></span>
										</label>
		                            </td>
		                            <td>
		                            	<a type="button" class="badge badge-info text-light mr-1">수정하기</a>
		                            	<a type="button" class="badge badge-danger text-light">삭제하기</a>
		                            </td>
		                        </tr>
		                        </c:forEach>
		                    </tbody>
		                </table>
		            </div>
		        </div>
		        <div class="card-body">
		            <h4 class="card-title">제품 카테고리 목록</h4>
		            <div class="table-responsive">
		                <table class="table">
		                    <thead class="bg-warning text-white">
		                        <tr>
		                            <th>번호</th>
		                            <th>대분류</th>
		                            <th>중분류명</th>
		                            <th>사용 여부</th>
		                            <th>비고</th>
		                        </tr>
		                    </thead>
		                    <tbody>
			                    <c:forEach var="vo" items="${vos}" varStatus="st">
		                        <tr>
		                            <td>${st.count} </td>
		                            <td>${vo.productTopName}</td>
		                            <td class="input-group"><input type="text" class="form-control" value="${vo.productMidName}" readonly style="width:150px;" /><span class="form-group-append"><i class="fa-regular fa-pen-to-square"></i></span></td>
		                            <td>
		                            	<label class="switch">
											<input type="checkbox" ${vo.useYn == 'y' ? 'checked' : ''}>
											<span class="slider"></span>
										</label>
		                            </td>
		                            <td>
		                            	<a type="button" class="badge badge-info text-light mr-1">수정하기</a>
		                            	<a type="button" class="badge badge-danger text-light">삭제하기</a>
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
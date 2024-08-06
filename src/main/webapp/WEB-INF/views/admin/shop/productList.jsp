<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>productList</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <link rel="stylesheet" href="${ctp}/css/shop/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/style.css" type="text/css">
	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
</head>
<body>
<div id="preloder">
    <div class="loader"></div>
</div>
<div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
<jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
	<div class="page-wrapper">
		<div class="card p-5">
	        <div class="shop__product__option">
	            <div class="row">
	                <div class="col-lg-6 col-md-6 col-sm-6">
	                    <div class="shop__product__option__left">
	                        <p>총 126 항목 중 1–12개 제품</p>
	                    </div>
	                </div>
	                <div class="col-lg-6 col-md-6 col-sm-6">
	                    <div class="shop__product__option__right">
	                        <p>정렬기준 </p>
	                        <select>
	                            <option value="productIdx">최신등록순</option>
	                            <option value="">관심도순</option>
	                            <option value="">추천순</option>
	                            <option value="productPrice">가격순</option>
	                        </select>
	                    </div>
	                </div>
	            </div>
	        </div>
	        <div class="row">
	        	<c:forEach var="productVO" items="${productVOS}">
	            <div class="col-lg-4 col-md-6 col-sm-6">
	                <div class="product__item">
	                    <div class="product__item__pic set-bg" data-setbg="${ctp}/product/${productVO.productThumb}" style="width:100%">
	                        <ul class="product__hover">
	                            <li><a href="#"><i class="fa-solid fa-wrench" style="color:red;font-size:25px;"></i><span>수정하기</span></a></li>
	                            <li><a href="#"><i class="fa-solid fa-trash" style="color:red;font-size:25px;"></i></a><span>삭제하기</span></li>
	                        </ul>
	                    </div>
	                    <div class="product__item__text">
	                        <div class="rating">
	                            <i class="fa fa-star-o"></i>
	                            <i class="fa fa-star-o"></i>
	                            <i class="fa fa-star-o"></i>
	                            <i class="fa fa-star-o"></i>
	                            <i class="fa fa-star-o"></i>
	                        </div>
	                        <h5><button class="btn btn-success" onclick="location.href='${ctp}/admin/shop/productDetails?productIdx=${productVO.productIdx}';">${productVO.productName}</button><span class="float-right">￦ <fmt:formatNumber value="${productVO.productPrice}"/></span></h5>
	                        <p>${productVO.productDetails}</p>
	                    </div>
	                </div>
	            </div>
	            </c:forEach>
	        </div>
	        <div class="row">
	            <div class="col-lg-12">
	                <div class="product__pagination">
	                    <a class="active" href="#">1</a>
	                    <a href="#">2</a>
	                    <a href="#">3</a>
	                    <span>...</span>
	                    <a href="#">21</a>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</div>
<p><br></p>
	<script src="${ctp}/js/shop/jquery.nice-select.min.js"></script>
	<script src="${ctp}/js/shop/jquery.slicknav.js"></script>
	<script src="${ctp}/js/shop/jquery-ui.min.js"></script>
	<%-- <script src="${ctp}/js/shop/mixitup.min.js"></script> --%>
    <script src="${ctp}/js/shop/main.js"></script>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
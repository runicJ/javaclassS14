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
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<style>
.price-range-wrap .range-slider {
margin-top: 20px;
}

.price-range-wrap .range-slider .price-input {
	position: relative;
}

.price-range-wrap .range-slider .price-input:after {
	position: absolute;
	left: 38px;
	top: 13px;
	height: 1px;
	width: 5px;
	background: #dd2222;
	content: "";
}

.price-range-wrap .range-slider .price-input input {
	font-size: 16px;
	color: #dd2222;
	font-weight: 700;
	max-width: 20%;
	border: none;
	display: inline-block;
}

.price-range-wrap .price-range {
	border-radius: 0;
}

.price-range-wrap .price-range.ui-widget-content {
	border: none;
	background: #ebebeb;
	height: 5px;
}

.price-range-wrap .price-range.ui-widget-content .ui-slider-handle {
	height: 13px;
	width: 13px;
	border-radius: 50%;
	background: #ffffff;
	border: none;
	-webkit-box-shadow: 0px 1px 10px rgba(0, 0, 0, 0.2);
	box-shadow: 0px 1px 10px rgba(0, 0, 0, 0.2);
	outline: none;
	cursor: pointer;
}

.price-range-wrap .price-range .ui-slider-range {
	background: #dd2222;
	border-radius: 0;
}

.price-range-wrap .price-range .ui-slider-range.ui-corner-all.ui-widget-header:last-child {
	background: #dd2222;
}
	</style>
	<script>
		'use strict';
		
		function productSort() {
			let sort = $("#sort").val();
			
			location.href = "photoGalleryList?sort="+sort;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<div class="container">
<!-- Page Preloder -->
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>판매목록</h4>
                        <div class="breadcrumb__links">
                            <a href="./index.html">메인페이지</a>
                            <span>제품목록</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shop Section Begin -->
    <section class="shop spad">
        <div>
            <div class="row">
                <div class="col-lg-3">
                    <div class="shop__sidebar">
                        <div class="shop__sidebar__search">
                            <form action="#">
                                <input type="text" placeholder="Search...">
                                <button type="submit"><span class="icon_search"></span></button>
                            </form>
                        </div>
                        <div class="shop__sidebar__accordion">
                            <div class="accordion" id="accordionExample">
                            	<c:forEach var="categoryTopVO" items="${categoryTopVOS}" varStatus="st">
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapse${st.index}">${categoryTopVO.productTopName}</a>
                                    </div>
                                    <div id="collapse1" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="shop__sidebar__brand">
                                                <ul class="nice-scroll">
                                                <c:forEach var="productTopMidVO" items="${productTopMidVOS}">
                                                <c:if test="${productTopMidVO.productTopIdx == categoryTopVO.productTopIdx}">
                                                    <li><a href="${ctp}/shop/productList?part=${productTopMidVO.productMidIdx}">${productTopMidVO.productMidName} (${productTopMidVO.productCnt})</a></li>
                                                </c:if>
                                                </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                </c:forEach>
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapseThree">가격</a>
                                    </div>
                                    <div id="collapseThree" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="shop__sidebar__price">
                                                <ul>
                                                    <li><a href="${ctp}/shop/productList">가격 전체</a></li>
                                                    <li><a href="${ctp}/shop/productList?productPrice=100000">~10만원</a></li>
                                                    <li><a href="${ctp}/shop/productList?productPrice=300000">~30만원</a></li>
                                                    <li><a href="${ctp}/shop/productList?productPrice=600000">~60만원</a></li>
                                                    <li><a href="${ctp}/shop/productList?productPrice=1000000">~100만원</a></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                <div class="sidebar__item">
                                    <div class="card-heading">
		                            <h4>가격 상세설정</h4>
		                            </div>
		                            <div class="price-range-wrap">
		                                <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content" data-min="1000" data-max="5000000">
		                                    <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
		                                    <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
		                                    <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
		                                </div>
		                                <div class="range-slider">
		                                    <div class="price-input">
		                                        <input type="text" id="minamount">
		                                        <span> ~ </span>
		                                        <input type="text" id="maxamount">
		                                    </div>
		                                </div>
		                            </div>
		                        </div>
		                        </div>
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapseFour">별점</a>
                                    </div>
                                    <div id="collapseFour" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="shop__sidebar__size">
                                                <label for="xs">별점 전체
                                                    <input type="radio" id="all">
                                                </label>
                                                <label for="sm">☆★★★★ 4점 이상
                                                    <input type="radio" id="fourth">
                                                </label>
                                                <label for="md">☆☆★★★ 3점 이상
                                                    <input type="radio" id="third">
                                                </label>
                                                <label for="xl">☆☆☆★★ 2점 이상
                                                    <input type="radio" id="second">
                                                </label>
                                                <label for="2xl">☆☆☆☆★ 1점 이상
                                                    <input type="radio" id="first">
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapseSix">추천 태그</a>
                                    </div>
                                    <div id="collapseSix" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="shop__sidebar__tags">
                                                <a href="#">#도도새</a>
                                                <a href="#">#알레르기</a>
                                                <a href="#">#알레르망</a>
                                                <a href="#">#아이</a>
                                                <a href="#">#아토피</a>
                                                <a href="#">#비염</a>
                                                <a href="#">#이불</a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="shop__product__option">
                        <div class="row">
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__left">
                                    <p>Showing 1–12 of ${productCntVO.productCnt} results</p>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__right">
                                    <p>정렬순서</p>
                                    <select name="sort" id="sort" onchange="productSort()">
                                        <option value="productIdx desc" ${sort == 'productIdx desc' ? 'selected' : ''}>최신등록순</option>
                                        <option value="likedCnt" ${sort == 'likedCnt' ? 'selected' : ''}>관심등록순</option>
                                        <option value="productPrice" ${sort == 'productPrice' ? 'selected' : ''}>가격낮은순</option>
                                        <option value="productPrice desc" ${sort == 'productPrice desc' ? 'selected' : ''}>가격높은순</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                    	<c:forEach var="productVO" items="${productVOS}">
                        <div class="col-lg-4 col-md-6 col-sm-6">
                            <div class="product__item sale">
                                <div class="product__item__pic set-bg" data-setbg="${ctp}/product/${productVO.productThumb}">
                                    <!-- <span class="label">Sale</span> -->
                                    <ul class="product__hover">
                                        <li><a href="#"><i class="fa-solid fa-heart"></i><span>관심등록</span></a></li>
                                        <li><a href="#"><i class="fa-solid fa-share"></i><span>공유하기</span></a></li>
                                        <li><a href="#"><i class="fa-solid fa-bag-shopping"></i><span>장바구니</span></a></li>
                                    </ul>
                                </div>
                                <div class="product__item__text">
                                    <h5><a href="${ctp}/shop/productDetails?productIdx=${productVO.productIdx}">${productVO.productName}</a></h5>
                                    <p>${productVO.productDetails}</p>
                                    <div class="rating">
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star"></i>
                                        <i class="fa fa-star-o"></i>
                                    </div>
                                    <h6>￦ <fmt:formatNumber value="${productVO.productPrice}"/></h6>
                                    <div class="product__color__select">
                                        <label for="pc-7">
                                            <input type="radio" id="pc-7">
                                        </label>
                                        <label class="active black" for="pc-8">
                                            <input type="radio" id="pc-8">
                                        </label>
                                        <label class="grey" for="pc-9">
                                            <input type="radio" id="pc-9">
                                        </label>
                                    </div>
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
                    <div class="product__pagination">
                    <nav aria-label="...">
                      <ul class="pagination justify-content-center">
                          <c:if test="${pageVO.pag > 1}"><li class="page-item">
                          	<a class="page-link" href="${ctp}/shop/productList?pag=1&pageSize=${pageVO.pageSize}" tabindex="-1">첫페이지</a>
                          </li></c:if>
                          <c:if test="${pageVO.curBlock > 0}"><li class="page-item">
                          	<a class="page-link" href="${ctp}/shop/productList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a>
                          </li></c:if>
                          <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
						    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="${ctp}/shop/productList?pag=${i}&pageSize=${pageVO.pageSize}">${i}<span class="sr-only">(current)</span></a></li></c:if>
						    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="${ctp}/shop/productList?pag=${i}&pageSize=${pageVO.pageSize}">${i}<span class="sr-only">(current)</span></a></li></c:if>
						  </c:forEach>
						  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/shop/productList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
						  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/shop/productList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}">마지막페이지</a></li></c:if>
                      </ul>
                   	</nav>
                 	</div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shop Section End -->

    <!-- Search Begin -->
    <div class="search-model">
        <div class="h-100 d-flex align-items-center justify-content-center">
            <div class="search-close-switch">+</div>
            <form class="search-model-form">
                <input type="text" id="search-input" placeholder="Search here.....">
            </form>
        </div>
    </div>
    <!-- Search End -->
</div>
<p><br></p>
	<script src="${ctp}/js/shop/jquery.nice-select.min.js"></script>
	<script src="${ctp}/js/shop/jquery.slicknav.js"></script>
	<script src="${ctp}/js/shop/jquery-ui.min.js"></script>
	<%-- <script src="${ctp}/js/shop/mixitup.min.js"></script> --%>
    <script src="${ctp}/js/shop/main.js"></script>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
<script>
/*-----------------------
Price Range Slider
------------------------ */
var rangeSlider = $(".price-range"),
minamount = $("#minamount"),
maxamount = $("#maxamount"),
minPrice = rangeSlider.data('min'),
maxPrice = rangeSlider.data('max');
rangeSlider.slider({
range: true,
min: minPrice,
max: maxPrice,
values: [minPrice, maxPrice],
slide: function (event, ui) {
    minamount.val('￦' + ui.values[0]);
    maxamount.val('￦' + ui.values[1]);
}
});
minamount.val('￦' + rangeSlider.slider("values", 0));
maxamount.val('￦' + rangeSlider.slider("values", 1));
</script>
</body>
</html>
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
                        <h4>Shop</h4>
                        <div class="breadcrumb__links">
                            <a href="./index.html">Home</a>
                            <span>Shop</span>
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
                                                    <li><a href="#">가격 전체</a></li>
                                                    <li><a href="#">3만원 이하</a></li>
                                                    <li><a href="#">3만원~6만원</a></li>
                                                    <li><a href="#">6만원~9만원</a></li>
                                                    <li><a href="#">9만원~12만원</a></li>
                                                    <li><a href="#">12만원 이상</a></li>
                                                    <li><p class="input-group">
	                                                    <input type="number" name="limitPrice" class="input-group" />
	                                                    <span> ~ </span>
	                                                    <input type="number" name="maxPrice" class="input-group" />
	                                                    <span> 원 </span>
	                                                    <input type="button" value="검색" class="btn btn-warning btn-sm" onclick="pSearch()" />
                                                    </p></li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="sidebar__item">
		                            <h4>Price</h4>
		                            <div class="price-range-wrap">
		                                <div class="price-range ui-slider ui-corner-all ui-slider-horizontal ui-widget ui-widget-content"
		                                    data-min="10" data-max="540">
		                                    <div class="ui-slider-range ui-corner-all ui-widget-header"></div>
		                                    <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
		                                    <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default"></span>
		                                </div>
		                                <div class="range-slider">
		                                    <div class="price-input">
		                                        <input type="text" id="minamount">
		                                        <input type="text" id="maxamount">
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
                                                    <input type="radio" id="xs">
                                                </label>
                                                <label for="sm">☆★★★★ 4점 이상
                                                    <input type="radio" id="sm">
                                                </label>
                                                <label for="md">☆☆★★★ 3점 이상
                                                    <input type="radio" id="md">
                                                </label>
                                                <label for="xl">☆☆☆★★ 2점 이상
                                                    <input type="radio" id="xl">
                                                </label>
                                                <label for="2xl">☆☆☆☆★ 1점 이상
                                                    <input type="radio" id="2xl">
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="card">
                                    <div class="card-heading">
                                        <a data-toggle="collapse" data-target="#collapseSix">Tags</a>
                                    </div>
                                    <div id="collapseSix" class="collapse show" data-parent="#accordionExample">
                                        <div class="card-body">
                                            <div class="shop__sidebar__tags">
                                                <a href="#">Product</a>
                                                <a href="#">Bags</a>
                                                <a href="#">Shoes</a>
                                                <a href="#">Fashio</a>
                                                <a href="#">Clothing</a>
                                                <a href="#">Hats</a>
                                                <a href="#">Accessories</a>
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
                                    <p>Showing 1–12 of 126 results</p>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__right">
                                    <p>Sort by Price:</p>
                                    <select>
                                        <option value="">최신등록순</option>
                                        <option value="">관심도순</option>
                                        <option value="">추천순</option>
                                        <option value="">가격순</option>
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
</body>
</html>
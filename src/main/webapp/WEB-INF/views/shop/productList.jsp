<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
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
		
		function toggleLiked(productIdx, element) {
		    $.ajax({
		        url: '${ctp}/recent/saveLikedProduct',
		        type: 'POST',
		        data: { productIdx: productIdx },
		        success: function(response) {
		            if (!response.success) {
		                alert(response.message);
		                return;
		            }

		            if (response.isInterested) {
		                $(element).find('i').css('color', 'red');
		            } else {
		                $(element).find('i').css('color', '');
		            }
		            alert(response.message);
		        },
		        error: function(xhr, status, error) {
		            alert("관심등록 처리 중 오류가 발생했습니다.");
		        }
		    });
		}
	    
		function applyFilter() {
		    let averageRating = document.querySelector('input[name="averageRating"]:checked').value;
		    let sort = document.getElementById("sort").value;

		    let minPrice = $("#hiddenMinPrice").val();
		    let maxPrice = $("#hiddenMaxPrice").val();

		    let url = "${ctp}/shop/productList?averageRating=" + averageRating + "&sort=" + sort + "&minPrice=" + minPrice + "&maxPrice=" + maxPrice;

		    window.location.href = url;
		}
		
		function applySort() {
		    let sort = document.getElementById("sort").value;

		    // 현재 필터링된 값들을 가져옴
		    let averageRating = document.querySelector('input[name="averageRating"]:checked').value;
		    let minPrice = $("#hiddenMinPrice").val();
		    let maxPrice = $("#hiddenMaxPrice").val();

		    // 정렬 URL 생성
    		let url = "${ctp}/shop/productList?averageRating=" + averageRating + "&sort=" + sort + "&minPrice=" + minPrice + "&maxPrice=" + maxPrice;
		    window.location.href = url;
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<div class="container">
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <section class="breadcrumb-option">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="breadcrumb__text">
                        <h4>판매목록</h4>
                        <div class="breadcrumb__links">
                            <a href="${ctp}/main">메인페이지</a>
                            <span>제품목록</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="shop spad">
        <div>
            <div class="row">
                <div class="col-lg-3">
                    <div class="shop__sidebar">
                        <div>
                        	<form action="${ctp}/shop/productList">
                            	<button type="submit" class="btn btn-primary">필터 초기화</button>
                            </form>
                        </div>
                        <div class="shop__sidebar__search">
                            <form action="${ctp}/shop/productList">
                                <input type="text" name="keyword" placeholder="검색어 입력" value="${keyword}">
                                <button type="submit"><span><i class="fa-solid fa-magnifying-glass"></i></span></button>
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
								        <a data-toggle="collapse" data-target="#collapseFour">별점</a>
								    </div>
								    <div id="collapseFour" class="collapse show" data-parent="#accordionExample">
								        <div class="card-body">
											<div class="shop__sidebar__size">
											    <label for="all">별점 전체
											        <input type="radio" name="averageRating" value="0" ${averageRating == 0 ? 'checked' : ''} onclick="applyFilter()">
											    </label>
											    <label for="fourth">☆★★★★ 4점 이상
											        <input type="radio" name="averageRating" value="4" ${averageRating == 4 ? 'checked' : ''} onclick="applyFilter()">
											    </label>
											    <label for="third">☆☆★★★ 3점 이상
											        <input type="radio" name="averageRating" value="3" ${averageRating == 3 ? 'checked' : ''} onclick="applyFilter()">
											    </label>
											    <label for="second">☆☆☆★★ 2점 이상
											        <input type="radio" name="averageRating" value="2" ${averageRating == 2 ? 'checked' : ''} onclick="applyFilter()">
											    </label>
											    <label for="first">☆☆☆☆★ 1점 이상
											        <input type="radio" name="averageRating" value="1" ${averageRating == 1 ? 'checked' : ''} onclick="applyFilter()">
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
								                <c:forEach var="tag" items="${topTags}">
								                    <a href="#">#${tag}</a>
								                </c:forEach>
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
			                                    <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default" style="background-color:#000d35;"></span>
			                                    <span tabindex="0" class="ui-slider-handle ui-corner-all ui-state-default" style="background-color:#000d35;"></span>
			                                </div>
			                                <div class="range-slider">
			                                    <div class="price-input">
			                                        <input type="text" id="minamount" style="max-width:40%;">~
			                                        <input type="text" id="maxamount" style="max-width:40%;">
			                                    </div>
			                                </div>
 			                                <form id="priceRangeForm" method="get" action="${ctp}/shop/productList">
											    <input type="hidden" name="minPrice" id="hiddenMinPrice" value="${minPrice}">
											    <input type="hidden" name="maxPrice" id="hiddenMaxPrice" value="${maxPrice}">
										        <button type="submit" class="btn btn-primary">가격 필터 적용</button>
										    </form>
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
                                    <p>총 ${pageVO.startIndexNo + 1}–${pageVO.startIndexNo + pageVO.pageSize > pageVO.totRecCnt ? pageVO.totRecCnt : pageVO.startIndexNo + pageVO.pageSize} of ${pageVO.totRecCnt} (건)</p>
                                </div>
                            </div>
                            <div class="col-lg-6 col-md-6 col-sm-6">
                                <div class="shop__product__option__right">
                                    <p>정렬순서</p>
									<select name="sort" id="sort" onchange="applySort()">
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
			                            <li>
					                        <!-- 관심등록 버튼 클릭 시 JavaScript 함수 호출 -->
					                        <a href="javascript:void(0);" onclick="toggleLiked(${productVO.productIdx}, this)">
					                            <i class="fa-solid fa-heart"></i>
					                            <span>관심등록</span>
					                        </a>
					                    </li>
                                        <li><a href="#"><i class="fa-solid fa-share"></i><span>공유하기</span></a></li>
                                        <li><a href="#"><i class="fa-solid fa-bag-shopping"></i><span>장바구니</span></a></li>
                                    </ul>
                                </div>
                                <div class="product__item__text">
                                    <h5><a href="${ctp}/shop/productDetails?productIdx=${productVO.productIdx}">${productVO.productName}</a></h5>
                                    <p>${fn:substring(productVO.productDetails,0,35)}...</p>
									<div>
									    <c:forEach var="i" begin="1" end="${productVO.averageRating}" varStatus="iSt">
									        <font color="#f7941d"><i class="fa-solid fa-star"></i></font>
									    </c:forEach>
									    <c:forEach var="i" begin="1" end="${5 - productVO.averageRating}" varStatus="iSt">
									        <i class="fa-solid fa-star"></i>
									    </c:forEach>
									</div>
                                    <h6>￦ <fmt:formatNumber value="${productVO.productPrice}"/></h6>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                    </div>
                    <div class="row">
                        <div class="col-lg-12">
		                    <div class="product__pagination">
			                    <nav aria-label="...">
			                      <ul class="pagination justify-content-center">
			                          <c:if test="${pageVO.pag > 1}"><li class="page-item">
			                          	<a class="page-link" href="${ctp}/shop/productList?pag=1&pageSize=${pageVO.pageSize}" tabindex="-1"><i class="fa-solid fa-angles-left"></i></a>
			                          </li></c:if>
			                          <c:if test="${pageVO.curBlock > 0}"><li class="page-item">
			                          	<a class="page-link" href="${ctp}/shop/productList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-left"></i></a>
			                          </li></c:if>
			                          <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
									    <c:if test="${i <= pageVO.totPage && i == pageVO.pag}"><li class="page-item active"><a class="page-link" href="${ctp}/shop/productList?pag=${i}&pageSize=${pageVO.pageSize}">${i}<span class="sr-only">(current)</span></a></li></c:if>
									    <c:if test="${i <= pageVO.totPage && i != pageVO.pag}"><li class="page-item"><a class="page-link" href="${ctp}/shop/productList?pag=${i}&pageSize=${pageVO.pageSize}">${i}<span class="sr-only">(current)</span></a></li></c:if>
									  </c:forEach>
									  <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a class="page-link" href="${ctp}/shop/productList?pag=${(pageVO.curBlock+1)*pageVO.blockSize+1}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angle-right"></i></a></li></c:if>
									  <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a class="page-link" href="${ctp}/shop/productList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}"><i class="fa-solid fa-angles-right"></i></a></li></c:if>
			                      </ul>
			                   	</nav>
		                 	</div>
                        </div>
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
    <script src="${ctp}/js/shop/main.js"></script>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
<script>
	/* Price Range Slider */
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
	        // 숨겨진 입력 필드 업데이트
	        $("#hiddenMinPrice").val(ui.values[0]);
	        $("#hiddenMaxPrice").val(ui.values[1]);
	    }
	});
	minamount.val('￦' + rangeSlider.slider("values", 0));
	maxamount.val('￦' + rangeSlider.slider("values", 1));
</script>
</body>
</html>
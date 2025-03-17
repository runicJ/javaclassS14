<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>productList</title>
    <link rel="stylesheet" href="${ctp}/css/shop/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/style.css" type="text/css">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<style>
        .price-range-wrap .price-range { height: 5px; background: #ebebeb; }
        .price-range-wrap .price-input input { font-size: 16px; font-weight: 700; border: none; margin-top:15px; }
		.price-range-wrap .price-range .ui-slider-range { background: #dd2222; }
	</style>
	<script>
		'use strict';
		
		// URL 파라미터 가져오기
		function getUrlParams() {
		    const params = new URLSearchParams(window.location.search);
		    let paramObj = {};

		    // 기존 URL 파라미터 저장
		    params.forEach((value, key) => {
		    	if (value !== null && value !== '') {
		    		paramObj[key] = value;
		    	}
		    });

		    return paramObj;
		}

		// URL 파라미터 업데이트 (기존 값 유지하면서 변경 가능)
		function updateUrlParams(newParams) {
		    const params = getUrlParams(); // 기존 파라미터 가져오기
		    Object.assign(params, newParams); // 새로운 값 병합

		    // 빈 값이나 null 값 제거 (불필요한 URL 제거)
		    Object.keys(params).forEach(key => {
		        if (!params[key]) {
		            delete params[key];
		        }
		    });

		    const queryString = new URLSearchParams(params).toString();
		    window.history.pushState({}, '', `${window.location.pathname}?${queryString}`);

		    // 필터 변경 시 상품 목록을 비동기로 갱신
		    updateProductList();
		}

		// AJAX로 상품 목록 업데이트
		function updateProductList() {
		    $.ajax({
		        url: window.location.href, // 현재 URL을 기반으로 데이터 요청
		        type: 'GET',
		        dataType: 'html',
		        success: function(response) {
		            let newContent = $(response).find("#productListContainer").html();
		            if (newContent) {
		                $("#productListContainer").html(newContent);
		                
		                // AJAX로 갱신된 이미지에 set-bg 속성 적용
		                $(".set-bg").each(function () {
		                    let bg = $(this).attr("data-setbg");
		                    $(this).css("background-image", "url(" + bg + ")");
		                });
		            } else {
		                alert("상품 목록 업데이트에 실패했습니다. 관리자에게 문의하세요.");
		            }
		        },
		        error: function() {
		            alert("상품 목록을 불러오는 중 오류가 발생했습니다.");
		        }
		    });
		}
		
		// 필터 적용 (공통)
		function applyFilter(type, value) {
		    const params = {};
		    params[type] = value; // 새 필터 값 추가
		    updateUrlParams(params);
		}

		// 가격 필터 적용
		function applyPriceFilter() {
		    const minPrice = $("#hiddenMinPrice").val();
		    const maxPrice = $("#hiddenMaxPrice").val();
		    updateUrlParams({ minPrice, maxPrice });
		}

		// 정렬 적용
		function applySort() {
		    const sort = document.getElementById("sort").value;
		    updateUrlParams({ sort });
		}

		// 별점 필터 적용 함수
		function applyRatingFilter(rating) {
		    updateUrlParams({ averageRating: rating }); // URL 파라미터에 별점 값 추가
		}

		// 검색어 적용 (새로고침 없이 동작)
		function applySearch() {
		    const keyword = document.getElementById('searchKeyword').value.trim();
		    updateUrlParams({ keyword: keyword || null }); // 빈 값이면 URL에서 제거
		}
		
		// 좋아요 토글
		function toggleLiked(productIdx, element) {
		    $.ajax({
		        url: '${ctp}/recent/saveLikedProduct',
		        type: 'POST',
		        data: { productIdx },
		        success: function(response) {
		            if (response.success) {
		            	const icon = $(element).find('i');
		            	icon.css('color', response.isInterested ? 'red' : '');
		            } else {
		            	alert(response.message);
		            }
		        },
		        error: function() {
		            alert("관심등록 처리 중 오류가 발생했습니다.");
		        }
		    });
		}
		
		// 모든 필터 초기화
		function resetFilters() {
		    updateUrlParams({ sort: null, averageRating: null, minPrice: null, maxPrice: null, keyword: null, part: null });
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
							<button type="button" class="btn btn-danger" onclick="resetFilters()">필터 초기화</button>
                        </div>
						<div class="shop__sidebar__search">
						    <form onsubmit="applySearch(); return false;">
						        <input type="text" name="keyword" id="searchKeyword" placeholder="검색어 입력" value="${keyword}">
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
											    <button type="button" class="btn btn-light" onclick="applyRatingFilter(0)">별점 전체</button>
											    <button type="button" class="btn btn-light" onclick="applyRatingFilter(4)">☆★★★★ 4점 이상</button>
											    <button type="button" class="btn btn-light" onclick="applyRatingFilter(3)">☆☆★★★ 3점 이상</button>
											    <button type="button" class="btn btn-light" onclick="applyRatingFilter(2)">☆☆☆★★ 2점 이상</button>
											    <button type="button" class="btn btn-light" onclick="applyRatingFilter(1)">☆☆☆☆★ 1점 이상</button>
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
											        <input type="text" id="minamount" style="max-width:40%;" readonly> ~
											        <input type="text" id="maxamount" style="max-width:40%;" readonly>
										        </div>
										    </div>
									        <!-- 필터 적용할 가격 값 (숨김 필드) -->
									        <input type="hidden" name="minPrice" id="hiddenMinPrice" value="${minPrice}">
											<input type="hidden" name="maxPrice" id="hiddenMaxPrice" value="${maxPrice}">
									        <!-- 필터 적용 버튼 -->
											<button id="applyPriceFilter" class="btn btn-primary">가격 필터 적용</button>
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
                    <div id="productListContainer">
	                    <div class="row">
	                    	<c:if test="${empty productVOS}">
	                    		<div class="col-lg-12 text-center">
	                    			<p>검색 조건에 맞는 제품이 존재하지 않습니다.</p>
	                    		</div>
	                    	</c:if>
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
	$(document).ready(function () {
	    let initialMinPrice = ${minPrice}; // 초기 최소 가격
	    let initialMaxPrice = ${maxPrice}; // 초기 최대 가격
	
	    $(".price-range").slider({
	        range: true,
	        min: 1000,
	        max: 5000000,
	        values: [initialMinPrice, initialMaxPrice],
	        slide: function (event, ui) {
	            let newMinPrice = ui.values[0];
	            let newMaxPrice = ui.values[1];
	
	            $("#minamount").val('￦' + newMinPrice);
	            $("#maxamount").val('￦' + newMaxPrice);
	            $("#hiddenMinPrice").val(newMinPrice);
	            $("#hiddenMaxPrice").val(newMaxPrice);
	
	            // 버튼 활성화 (가격 조정 시)
	            $("#applyPriceFilter").removeClass("btn-secondary disabled").addClass("btn-primary").prop("disabled", false);
	        }
	    });
	
	    // 가격 필터 적용 버튼 클릭 시 실행
	    $("#applyPriceFilter").on("click", function () {
	        if (!$(this).hasClass("disabled")) {
	            let minPrice = $("#hiddenMinPrice").val();
	            let maxPrice = $("#hiddenMaxPrice").val();
	            
	            $.ajax({
	                url: "${ctp}/shop/productList",
	                type: "GET",
	                data: { minPrice: minPrice, maxPrice: maxPrice },
	                success: function (response) {
	                    let newContent = $(response).find("#productListContainer").html();
	                    if (newContent) {
	                        $("#productListContainer").html(newContent);
	
	                        // 🔥 AJAX로 갱신된 이미지에 set-bg 속성 적용
	                        $(".set-bg").each(function () {
	                            let bg = $(this).attr("data-setbg");
	                            $(this).css("background-image", "url(" + bg + ")");
	                        });
	
	                        // 🔥 필터 적용 후에도 버튼을 다시 활성화
	                        $("#applyPriceFilter").removeClass("btn-secondary disabled").addClass("btn-primary").prop("disabled", false);
	                    } else {
	                        alert("상품 목록 업데이트에 실패했습니다. 관리자에게 문의하세요.");
	                    }
	                },
	                error: function () {
	                    alert("가격 필터 적용 중 오류가 발생했습니다.");
	                }
	            });
	        }
	    });
	});
</script>
</body>
</html>
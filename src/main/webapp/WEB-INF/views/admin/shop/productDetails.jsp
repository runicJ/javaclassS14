<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>productDetails</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <link rel="stylesheet" href="${ctp}/css/shop/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/jquery-ui.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/style.css" type="text/css">
  	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
  	
  	<script>
  		'use strict';
  	</script>
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
		
		    <!-- Shop Details Section Begin -->
		    <section class="shop-details">
		    	<div class="product__details__pic">
		    		<div class="product__details__pic__item">
                         <img src="${ctp}/product/${productVO.productThumb}" alt="">
                     </div>
		        </div>
			        <div class="product__details__content">
			            <div class="container">
			                <div class="row d-flex justify-content-center">
			                    <div class="col-lg-8">
			                        <div class="product__details__text">
			                            <h4>${productVO.productName}</h4>
			                            <div class="rating">
			                                <i class="fa fa-star"></i>
			                                <i class="fa fa-star"></i>
			                                <i class="fa fa-star"></i>
			                                <i class="fa fa-star"></i>
			                                <i class="fa fa-star-o"></i>
			                                <span> - 5 Reviews</span>
			                            </div>
			                            <h3><fmt:formatNumber value="${productVO.productPrice}"/> <span>70.00</span></h3>
			                            <p>${productVO.productDetails}</p>
			                            <div class="product__details__option">
			                            	<c:forEach var="optionVO" items="${optionVOS}">
				                                <div class="product__details__option__size">
				                                    <span>${optionVO.optionGroupName}:</span>
				                                    <label for="${optionVO.optionIdx}">${optionVO.optionName}
				                                        <input type="radio" id="${optionVO.optionIdx}">
				                                    </label>
				                                </div>
			                                </c:forEach>
			                                <div class="product__details__option__color">
			                                    <span>Color:</span>
			                                    <label class="c-1" for="sp-1">
			                                        <input type="radio" id="sp-1">
			                                    </label>
			                                    <label class="c-2" for="sp-2">
			                                        <input type="radio" id="sp-2">
			                                    </label>
			                                    <label class="c-3" for="sp-3">
			                                        <input type="radio" id="sp-3">
			                                    </label>
			                                    <label class="c-4" for="sp-4">
			                                        <input type="radio" id="sp-4">
			                                    </label>
			                                    <label class="c-9" for="sp-9">
			                                        <input type="radio" id="sp-9">
			                                    </label>
			                                </div>
			                            </div>
			                            <div class="product__details__cart__option">
			                                <div class="quantity">
			                                    <div class="pro-qty">
			                                        <input type="text" value="1">
			                                    </div>
			                                </div>
			                                <a href="#" class="primary-btn">장바구니 담기</a>
			                            </div>
			                            <div class="product__details__btns__option">
			                                <a href="#"><i class="fa fa-heart"></i> 관심상품</a>
			                                <a href="#"><i class="fa fa-exchange"></i> 공유하기</a>
			                            </div>
                            		    <div>
								    		<input type="button" class="btn btn-primary btn-sm m-2" value="옵션등록" onclick="location.href='${ctp}/admin/shop/productOption?productIdx=${productVO.productIdx}';"/>
								    		<input type="button" class="btn btn-success btn-sm m-2" value="돌아가기" onclick="location.href='${ctp}/admin/shop/productList';" />
								    		<input type="button" class="btn btn-warning btn-sm m-2" value="수정" onclick="location.href='${ctp}/admin/shop/productUpdate';" />
								    		<input type="button" class="btn btn-danger btn-sm" value="삭제" onclick="productDelete(${productVO.productIdx})" />
								    	</div>
			                            <div class="product__details__last__option">
			                                <h5><span>제품 상세정보</span></h5>
			                                <ul>
			                                    <li><span>SKU:</span> 3812912</li>
			                                    <li><span>Categories:</span> Clothes</li>
			                                    <li><span>Tag:</span> Clothes, Skin, Body</li>
			                                </ul>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                <div class="row">
			                    <div class="col-lg-12">
			                        <div class="product__details__tab">
			                            <ul class="nav nav-tabs" role="tablist">
			                                <li class="nav-item">
			                                    <a class="nav-link active" data-toggle="tab" href="#tabs-5"
			                                    role="tab">상세설명</a>
			                                </li>
			                                <li class="nav-item">
			                                    <a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">제품리뷰(0)</a>
			                                </li>
			                                <li class="nav-item">
			                                    <a class="nav-link" data-toggle="tab" href="#tabs-7" role="tab">문의하기</a>
			                                </li>
			                            </ul>
			                            <div class="tab-content">
			                                <div class="tab-pane active" id="tabs-5" role="tabpanel">
			                                    <div class="product__details__tab__content">
			                                    	<div id="content" class="text-center">
			                                        	${productVO.content}
			                                        </div>
			                                    </div>
			                                </div>
			                                <div class="tab-pane" id="tabs-6" role="tabpanel">
			                                    <div class="product__details__tab__content">
			                                        <div class="product__details__tab__content__item">
			                                            <h5>Products Infomation</h5>
			                                            <p>A Pocket PC is a handheld computer, which features many of the same
			                                                capabilities as a modern PC. These handy little devices allow
			                                                individuals to retrieve and store e-mail messages, create a contact
			                                                file, coordinate appointments, surf the internet, exchange text messages
			                                                and more. Every product that is labeled as a Pocket PC must be
			                                                accompanied with specific software to operate the unit and must feature
			                                            a touchscreen and touchpad.</p>
			                                            <p>As is the case with any new technology product, the cost of a Pocket PC
			                                                was substantial during it’s early release. For approximately $700.00,
			                                                consumers could purchase one of top-of-the-line Pocket PCs in 2003.
			                                                These days, customers are finding that prices have become much more
			                                                reasonable now that the newness is wearing off. For approximately
			                                            $350.00, a new Pocket PC can now be purchased.</p>
			                                        </div>
			                                        <div class="product__details__tab__content__item">
			                                            <h5>Material used</h5>
			                                            <p>Polyester is deemed lower quality due to its none natural quality’s. Made
			                                                from synthetic materials, not natural like wool. Polyester suits become
			                                                creased easily and are known for not being breathable. Polyester suits
			                                                tend to have a shine to them compared to wool and cotton suits, this can
			                                                make the suit look cheap. The texture of velvet is luxurious and
			                                                breathable. Velvet is a great choice for dinner party jacket and can be
			                                            worn all year round.</p>
			                                        </div>
			                                    </div>
			                                </div>
			                                <div class="tab-pane" id="tabs-7" role="tabpanel">
			                                    <div class="product__details__tab__content">
			                                        <p class="note">Nam tempus turpis at metus scelerisque placerat nulla deumantos
			                                            solicitud felis. Pellentesque diam dolor, elementum etos lobortis des mollis
			                                            ut risus. Sedcus faucibus an sullamcorper mattis drostique des commodo
			                                        pharetras loremos.</p>
			                                        <div class="product__details__tab__content__item">
			                                            <h5>Products Infomation</h5>
			                                            <p>A Pocket PC is a handheld computer, which features many of the same
			                                                capabilities as a modern PC. These handy little devices allow
			                                                individuals to retrieve and store e-mail messages, create a contact
			                                                file, coordinate appointments, surf the internet, exchange text messages
			                                                and more. Every product that is labeled as a Pocket PC must be
			                                                accompanied with specific software to operate the unit and must feature
			                                            a touchscreen and touchpad.</p>
			                                            <p>As is the case with any new technology product, the cost of a Pocket PC
			                                                was substantial during it’s early release. For approximately $700.00,
			                                                consumers could purchase one of top-of-the-line Pocket PCs in 2003.
			                                                These days, customers are finding that prices have become much more
			                                                reasonable now that the newness is wearing off. For approximately
			                                            $350.00, a new Pocket PC can now be purchased.</p>
			                                        </div>
			                                        <div class="product__details__tab__content__item">
			                                            <h5>Material used</h5>
			                                            <p>Polyester is deemed lower quality due to its none natural quality’s. Made
			                                                from synthetic materials, not natural like wool. Polyester suits become
			                                                creased easily and are known for not being breathable. Polyester suits
			                                                tend to have a shine to them compared to wool and cotton suits, this can
			                                                make the suit look cheap. The texture of velvet is luxurious and
			                                                breathable. Velvet is a great choice for dinner party jacket and can be
			                                            worn all year round.</p>
			                                        </div>
			                                    </div>
			                                </div>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </section>
			    <!-- Shop Details Section End -->
			
			    <!-- Related Section Begin -->
			    <section class="related spad">
			        <div class="container">
			            <div class="row">
			                <div class="col-lg-12">
			                    <h3 class="related-title">Related Product</h3>
			                </div>
			            </div>
			            <div class="row">
			                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
			                    <div class="product__item">
			                        <div class="product__item__pic set-bg" data-setbg="img/product/product-1.jpg">
			                            <span class="label">New</span>
			                            <ul class="product__hover">
			                                <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
			                                <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a></li>
			                                <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
			                            </ul>
			                        </div>
			                        <div class="product__item__text">
			                            <h6>Piqué Biker Jacket</h6>
			                            <a href="#" class="add-cart">+ Add To Cart</a>
			                            <div class="rating">
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                            </div>
			                            <h5>$67.24</h5>
			                            <div class="product__color__select">
			                                <label for="pc-1">
			                                    <input type="radio" id="pc-1">
			                                </label>
			                                <label class="active black" for="pc-2">
			                                    <input type="radio" id="pc-2">
			                                </label>
			                                <label class="grey" for="pc-3">
			                                    <input type="radio" id="pc-3">
			                                </label>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
			                    <div class="product__item">
			                        <div class="product__item__pic set-bg" data-setbg="img/product/product-2.jpg">
			                            <ul class="product__hover">
			                                <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
			                                <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a></li>
			                                <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
			                            </ul>
			                        </div>
			                        <div class="product__item__text">
			                            <h6>Piqué Biker Jacket</h6>
			                            <a href="#" class="add-cart">+ Add To Cart</a>
			                            <div class="rating">
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                            </div>
			                            <h5>$67.24</h5>
			                            <div class="product__color__select">
			                                <label for="pc-4">
			                                    <input type="radio" id="pc-4">
			                                </label>
			                                <label class="active black" for="pc-5">
			                                    <input type="radio" id="pc-5">
			                                </label>
			                                <label class="grey" for="pc-6">
			                                    <input type="radio" id="pc-6">
			                                </label>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
			                    <div class="product__item sale">
			                        <div class="product__item__pic set-bg" data-setbg="img/product/product-3.jpg">
			                            <span class="label">Sale</span>
			                            <ul class="product__hover">
			                                <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
			                                <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a></li>
			                                <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
			                            </ul>
			                        </div>
			                        <div class="product__item__text">
			                            <h6>Multi-pocket Chest Bag</h6>
			                            <a href="#" class="add-cart">+ Add To Cart</a>
			                            <div class="rating">
			                                <i class="fa fa-star"></i>
			                                <i class="fa fa-star"></i>
			                                <i class="fa fa-star"></i>
			                                <i class="fa fa-star"></i>
			                                <i class="fa fa-star-o"></i>
			                            </div>
			                            <h5>$43.48</h5>
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
			                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
			                    <div class="product__item">
			                        <div class="product__item__pic set-bg" data-setbg="img/product/product-4.jpg">
			                            <ul class="product__hover">
			                                <li><a href="#"><img src="img/icon/heart.png" alt=""></a></li>
			                                <li><a href="#"><img src="img/icon/compare.png" alt=""> <span>Compare</span></a></li>
			                                <li><a href="#"><img src="img/icon/search.png" alt=""></a></li>
			                            </ul>
			                        </div>
			                        <div class="product__item__text">
			                            <h6>Diagonal Textured Cap</h6>
			                            <a href="#" class="add-cart">+ Add To Cart</a>
			                            <div class="rating">
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                                <i class="fa fa-star-o"></i>
			                            </div>
			                            <h5>$60.9</h5>
			                            <div class="product__color__select">
			                                <label for="pc-10">
			                                    <input type="radio" id="pc-10">
			                                </label>
			                                <label class="active black" for="pc-11">
			                                    <input type="radio" id="pc-11">
			                                </label>
			                                <label class="grey" for="pc-12">
			                                    <input type="radio" id="pc-12">
			                                </label>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
			        </div>
			    </section>
			    <!-- Related Section End -->
		</div>
	</div>
</div>
<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
<p><br/></p>
	<script src="${ctp}/js/shop/jquery.nice-select.min.js"></script>
	<script src="${ctp}/js/shop/jquery.slicknav.js"></script>
	<script src="${ctp}/js/shop/jquery-ui.min.js"></script>
	<script src="${ctp}/js/shop/mixitup.min.js"></script>
    <script src="${ctp}/js/shop/main.js"></script>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
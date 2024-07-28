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
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
  	<script>
  	'use strict';

    let idxArray = new Array();

    $(function() {
        $(".selectOption").change(function() {
            let selectOption = $(this).val();
            let optionIdx = selectOption.substring(0, selectOption.indexOf(":"));
            let optionName = selectOption.substring(selectOption.indexOf(":") + 1, selectOption.indexOf("_"));
            let addPrice = parseInt(selectOption.substring(selectOption.indexOf("_") + 1));
            let basePrice = parseInt(${productVO.productPrice});
            let totalOptionPrice = basePrice + addPrice;
            let commaPrice = numberWithCommas(totalOptionPrice);
            let quantity = parseInt($("#numBoxMain").val());

            if ($("#layer" + optionIdx).length == 0) {
                idxArray.push(optionIdx);
                let index = idxArray.length - 1;
                let str = '';
                str += '<div class="layer row" id="layer' + optionIdx + '"><div class="col">' + optionName + '</div>';
                str += '<input type="number" class="text-center numBox" id="numBox' + optionIdx + '" name="items[' + index + '].quantity" onchange="numChange(' + optionIdx + ')" value="' + quantity + '" min="1"/> &nbsp;';
                str += '<input type="text" id="imsiPrice' + optionIdx + '" class="price" value="' + commaPrice + '" readonly /><span> 원</span>';
                str += '<input type="hidden" id="price' + optionIdx + '" value="' + totalOptionPrice + '" data-add-price="' + addPrice + '"/> &nbsp;';
                str += '<input type="button" class="btn btn-outline-danger btn-sm" onclick="remove(' + optionIdx + ')" value="X"/>';
                str += '<input type="hidden" name="items[' + index + '].optionIdx" value="' + optionIdx + '"/>';
                str += '<input type="hidden" name="items[' + index + '].productIdx" value="${productVO.productIdx}"/>';
                str += '<input type="hidden" name="items[' + index + '].isSoldOut" value="false"/>';
                str += '</div>';
                $("#product1").append(str);
                onTotal();
            } 
            else {
                alert("이미 선택한 옵션입니다.");
            }
        });
    });

    function remove(optionIdx) {
        $("div").remove("#layer" + optionIdx);

        if ($(".price").length) onTotal();
        else location.reload();
    }

    function onTotal() {
        let total = 0;
        for (let i = 0; i < idxArray.length; i++) {
            if ($("#layer" + idxArray[i]).length != 0) {
                total += parseInt(document.getElementById("price" + idxArray[i]).value);
            }
        }
        document.getElementById("totalPrice").value = numberWithCommas(total);
    }

    function numChange(optionIdx) {
        let basePrice = parseInt(${productVO.productPrice});
        let addPrice = parseInt($("#price" + optionIdx).data("addPrice"));
        let quantity = parseInt(document.getElementById("numBox" + optionIdx).value);
        let totalPrice = (basePrice + addPrice) * quantity;
        document.getElementById("imsiPrice" + optionIdx).value = numberWithCommas(totalPrice);
        document.getElementById("price" + optionIdx).value = totalPrice;
        onTotal();
    }

    function cart() {
        if (document.getElementById("totalPrice").value == 0) {
            alert("옵션을 선택해주세요");
            return false;
        } 
        else {
            myform.action = "${ctp}/shop/addToCart";
            myform.submit();
        }
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    function likedToggle(productIdx) {
        if (sUid == null || sUid == "") {
            alert("로그인 이후에 가능한 메뉴입니다!");
            return false;
        }

        $.ajax({
            url: "${ctp}/shop/productLikedToggle",
            type: "post",
            data: { productIdx: productIdx },
            success: function(res) {
                let icon = document.getElementById("liked-icon-" + productIdx);
                let wishCnt = document.getElementById("likedCnt");
                if (res.trim() == "true") {
                    alert("해당 상품을 위시리스트에서 제거하였습니다.");
                    icon.classList.remove('fa-solid', 'fa-heart');
                    icon.classList.add('fa-regular', 'fa-heart');
                    wishCnt.textContent = parseInt(wishCnt.textContent) - 1;
                } else {
                    alert("해당 상품을 위시리스트에 추가하였습니다.");
                    icon.classList.remove('fa-regular', 'fa-heart');
                    icon.classList.add('fa-solid', 'fa-heart');
                    icon.style.color = 'red';
                    wishCnt.textContent = parseInt(wishCnt.textContent) + 1;
                }
            },
            error: function() {
                alert("전송 오류!");
            }
        });
    }
    </script>
    <style>
       .layer  {
          border:0px;
          width:100%;
          padding:10px;
          margin-left:1px;
          background-color:#eee;
        }
        .numBox {width:40px}
        .price  {
          width:160px;
          background-color:#eee;
          text-align:right;
          font-size:1.2em;
          border:0px;
          outline: none;
        }
        .totalPrice {
          text-align:right;
          margin-right:10px;
          color:#f63;
          font-size:1.5em;
          font-weight: bold;
          border:0px;
          outline: none;
        }
    </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br/></p>
<div class="container">
    <div id="preloder">
        <div class="loader"></div>
    </div>

    <!-- Shop Details Section Begin -->
    <section class="shop-details">
        <div class="product__details__pic">
            <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__breadcrumb text-right">
                            <i class="fa-solid fa-barcode"></i> &nbsp;
                            <a href="${ctp}/">메인페이지</a>
                            <a href="${ctp}/shop/productList">제품판매</a>
                            <span>${productVO.productName}</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-12">
                        <div class="product__details__pic__item">
                            <img src="${ctp}/product/${productVO.productThumb}" alt="product Thumbnail">
                        </div>
                    </div>
                </div>
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
                            
                            <div class="product__details__btns__option">
                                <a href="#"><i class="fa-brands fa-gratipay"></i> 관심상품</a>
                                <a href="#"><i class="fa-solid fa-square-share-nodes"></i> 공유하기</a>
                            </div>
                            
                            <div class="form-group">
                                <form name="optionForm">
                                    <h3>￦ <fmt:formatNumber value="${productVO.productPrice}" /><span>0</span></h3>
                                    <p>${productVO.productDetails}</p>
                                    <div class="product__details__cart__option">
										<div class="quantity mb-2">
                                            <div class="pro-qty">
                                                <input type="number" name="quantity" min="1" value="1" id="numBoxMain">
                                            </div>
                                        </div>
                                        <a type="button" onclick="likedToggle(${productVO.productIdx})" class="btn btn-inline-light">
                                            <c:if test="${productVO.isLiked != 0}">
                                                <i id="liked-icon-${productVO.productIdx}" class="fa-solid fa-heart" style="color:red;"></i>
                                            </c:if>
                                            <c:if test="${productVO.isLiked == 0}">
                                                <i id="liked-icon-${productVO.productIdx}" class="fa-regular fa-heart" style="color:#eee;"></i>
                                            </c:if>
                                            <span>명 관심등록</span>
                                        </a>
                                    </div>
                                    <div class="product__details__option">
                                        <c:if test="${empty optionGroupVOS}">
                                        <div class="product__details__option__size">
                                            <label for="basicIdx"> 기본
                                                <input type="radio" id="basicIdx" class="selectOption" name="selectOption" value="0:기본_0">
                                            </label>
                                        </div>
                                        </c:if>
                                        <c:forEach var="optionGroupVO" items="${optionGroupVOS}">
                                        <div class="product__details__option__size">
                                            <span>${optionGroupVO.optionGroupName}</span>
                                            <c:if test="${optionGroupVO.optionGroupName != '색상'}">
                                            <label for="basicIdx"> 기본
                                                <input type="radio" id="basicIdx" class="selectOption" name="selectOption" value="0:기본_0">
                                            </label>
                                            </c:if>
                                            <c:forEach var="optionVO" items="${optionVOS}">
                                            <c:if test="${optionGroupVO.optionGroupIdx == optionVO.optionGroupIdx}">
                                            <label for="${optionVO.optionIdx}">${optionVO.optionName} 
                                                <c:if test="${optionVO.addPrice != 0}">
                                                    <span> (+</span><fmt:formatNumber value="${optionVO.addPrice}" /><span>원)</span>
                                                </c:if>
                                                <input type="radio" id="${optionVO.optionIdx}" class="selectOption" name="selectOption" value="${optionVO.optionIdx}:${optionVO.optionName}_${optionVO.addPrice}">
                                            </label>
                                            </c:if>
                                            </c:forEach>
                                        </div>
                                        </c:forEach>
                                    </div>
                                </form>
                            </div>

                            <div>
                                <form name="myform" method="post">
                                  <input type="hidden" name="userId" value="${sUid}"/>
                                  <input type="hidden" name="productPrice" value="${productVO.productPrice}"/>
                                  <input type="hidden" name="flag" id="flag"/>
                                  <div id="product1"></div>
                                </form>
                            </div>
                            <div>
                            <hr/>
                            <div class="text-left"><font size="4" color="black">총 상품 금액</font></div>
                                <p class="text-right">
                                    <b><input type="text" class="totalPrice text-right" id="totalPrice" value="<fmt:formatNumber value='0'/>" readonly /></b>
                                </p>
                                <a href="${ctp}/shop/addToCart" class="primary-btn mr-2">바로 구매하기</a>
                                <a type="button" onclick="cart()" class="primary-btn mr-2">장바구니 담기</a>
                            </div>
                            <div class="line"></div>
                            <div class="product__details__last__option">
                                <h5><span>제품 정보</span></h5>
                                <ul>
                                    <li><span>상품 태그 : </span> [ ${productVO.productTags} ]</li>
                                    <li><span>상품 코드 : </span> [ ${productVO.productCode} ]</li>
                                    <li><span>상품 브랜드 : </span> [ ${productVO.productBrand} ]</li>
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
                                    role="tab">제품 상세보기</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-6" role="tab">리뷰(0)</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" data-toggle="tab" href="#tabs-7" role="tab">상세정보</a>
                                </li>
                            </ul>
                            <div class="tab-content">
                                <div class="tab-pane active" id="tabs-5" role="tabpanel">
                                    <div class="product__details__tab__content">
                                        <div class="product__details__tab__content__item">
                                            <div id="content" class="text-center">
                                                ${productVO.content}
                                            </div>
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

<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</div>
<p><br/></p>
<script src="${ctp}/js/shop/jquery.nice-select.min.js"></script>
<script src="${ctp}/js/shop/jquery.slicknav.js"></script>
<script src="${ctp}/js/shop/jquery-ui.min.js"></script>
<script src="${ctp}/js/shop/main.js"></script>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
<script>
    /*-------------------
        Radio Btn
    --------------------- */
    $(".product__color__select label, .shop__sidebar__size label, .product__details__option__size label").on('click', function () {
        $(".product__color__select label, .shop__sidebar__size label, .product__details__option__size label").removeClass('active');
        $(this).addClass('active');
    });
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>productCart</title>
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <link rel="stylesheet" href="${ctp}/css/shop/elegant-icons.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/nice-select.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/slicknav.min.css" type="text/css">
    <link rel="stylesheet" href="${ctp}/css/shop/style.css" type="text/css">
    <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
    <script>
        // 주문할 총 가격 계산하기
        function onTotal() {
            let total = 0;
            let checkedItems = $(".product__cart__item input:checked").closest("tr").find(".cart__price");
            checkedItems.each(function() {
                total += parseFloat($(this).text().replace(/,/g, ''));
            });
            document.getElementById("total").innerText = numberWithCommas(total);

            // 배송비 결정(50000원 이상이면 배송비는 0원으로 처리)
            let shippingCost = total >= 50000 ? 0 : 3000;
            document.getElementById("baesong").innerText = numberWithCommas(shippingCost);

            let lastPrice = total + shippingCost;
            document.getElementById("lastPrice").innerText = numberWithCommas(lastPrice);
            document.getElementById("orderTotalPrice").innerText = numberWithCommas(lastPrice);
        }

        // 장바구니에서 구매한 상품에 대한 '삭제'처리
        function cartDelete(cartIdx) {
            let ans = confirm("선택하신 현재상품을 장바구니에서 제거 하시겠습니까?");
            if (!ans) return false;

            $.ajax({
                type: "post",
                url: "${ctp}/shop/productCartDelete",
                data: { cartIdx: cartIdx },
                success: function(res) {
                    if (res != 0) {
                        location.reload();
                    } else {
                        alert("삭제 실패");
                    }
                },
                error: function() {
                    alert("전송에러!");
                }
            });
        }

        // 장바구니에서 선택한 상품만 '주문'처리하기
        function order() {
            let checkedItems = $(".product__cart__item input:checked").length;
            if (checkedItems == 0) {
                alert("장바구니에서 주문처리할 상품을 선택해주세요!");
                return false;
            } else {
                location.href = "${ctp}/shop/checkout";
            }
        }

        // 상품 체크박스에 상품을 구매하기 위해 체크했을 때 처리하는 함수
        function onCheck() {
            let allChecked = true;
            $('.product__cart__item input[type="checkbox"]').each(function() {
                if (!$(this).is(":checked")) {
                    allChecked = false;
                }
            });
            document.getElementById("allcheck").checked = allChecked;
            onTotal();
        }

        // allCheck 체크박스를 체크/해제할 때 수행하는 함수
        function allCheck() {
            let allChecked = document.getElementById("allcheck").checked;
            $('.product__cart__item input[type="checkbox"]').prop('checked', allChecked);
            onTotal();
        }

        // 천단위마다 쉼표처리
        function numberWithCommas(x) {
            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
                        <h4>장바구니</h4>
                        <div class="breadcrumb__links">
                            <a href="${ctp}/main">메인페이지</a>
                            <a href="${ctp}/shop/productList">제품판매</a>
                            <span>나의 장바구니</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shopping Cart Section Begin -->
    <section class="shopping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-8">
                    <div class="shopping__cart__table">
                        <table>
                            <thead>
                                <tr>
                                    <th><input type="checkbox" id="allcheck" onclick="allCheck()"></th>
                                    <th>제품명</th>
                                    <th>수량</th>
                                    <th>가격</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="productCartVO" items="${productCartVOS}">
                                    <c:forEach var="CartVO" items="${productCartVO.items}">
                                        <tr>
                                            <td class="quantity__item">
                                                <input type="checkbox" id="idx${productCartVO.cartIdx}" onclick="onCheck()">
                                            </td>
                                            <td class="product__cart__item">
                                                <div class="product__cart__item__pic mt-4">
                                                    <img src="${ctp}/product/${CartVO.productThumb}" alt="thumbnail" style="width:100px;height:auto;">
                                                </div>
                                                <div class="product__cart__item__text">
                                                    <h5>${CartVO.productName}</h5>
                                                    <c:choose>
                                                        <c:when test="${CartVO.optionGroupName != '기본'}">
                                                            <h6>옵션: ${CartVO.optionGroupName} - ${CartVO.optionName}</h6>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <h6>- 기본 옵션</h6>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    <p><input type="button" class="badge badge-warning"></p>
                                                </div>
                                            </td>
                                            <td class="quantity__item">
                                                <div class="quantity">
                                                    <div class="pro-qty-2">
                                                        <input type="number" value="${CartVO.quantity}">
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="cart__price"><fmt:formatNumber value="${CartVO.productPrice}" /> 원</td>
                                            <td class="cart__close"><i class="fa fa-close" onclick="cartDelete(${productCartVO.cartIdx})"></i></td>
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="continue__btn">
                                <a href="#">쇼핑 더하기</a>
                                <a href="#">삭제하기</a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="continue__btn update__btn">
                                <a href="#"><i class="fa fa-spinner"></i> 장바구니 새로고침</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="cart__discount">
                        <h6>쿠폰/포인트 적용하기</h6>
                        <form action="#" class="mb-2">
                            <select class="form-control">
                                <option>쿠폰내역</option>
                            </select>
                        </form>
                        <form action="#">
                            <input type="text" placeholder="포인트">
                            <button type="submit">적용하기</button>
                        </form>
                    </div>
                    <div class="cart__total">
                        <h6>장바구니</h6>
                        <ul>
                            <li>상품금액 <span id="total">0</span></li>
                            <li>할인내역 <span id="discount">0</span></li>
                            <li>배송비 <span id="baesong">0</span></li>
                            <li>총금액 <span id="lastPrice">0</span></li>
                        </ul>
                        <a href="#" class="primary-btn" onclick="order()">결제하기</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Shopping Cart Section End -->
    <div class="line"></div>
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
    <div class="line"></div>
</div>
<p><br></p>
<script src="${ctp}/js/shop/jquery.nice-select.min.js"></script>
<script src="${ctp}/js/shop/jquery.slicknav.js"></script>
<script src="${ctp}/js/shop/main.js"></script>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>

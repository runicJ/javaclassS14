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
		    let checkedItems = $(".quantity__item input:checked").closest("tr");
		    
		    checkedItems.each(function() {
		        let price = parseFloat($(this).find(".cart__price").text().replace(/,/g, ''));
		        let quantity = parseInt($(this).find(".pro-qty-2 input").val(), 10);
		        total += price * quantity;
		    });
		    
		    document.getElementById("total").innerText = numberWithCommas(total);
		
		    // 배송비 결정(50000원 이상이면 배송비는 0원으로 처리)
		    let shippingCost = total >= 50000 ? 0 : 3000;
		    document.getElementById("charge").innerText = numberWithCommas(shippingCost);
		
		    let lastPrice = total + shippingCost;
		    document.getElementById("lastPrice").innerText = numberWithCommas(lastPrice);
		    document.getElementById("orderTotalPrice").value = lastPrice; // hidden input에 값 설정
		    document.getElementById("charge").value = shippingCost; // hidden input에 값 설정
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

     	// 상품 체크박스에 상품을 구매하기 위해 체크했을 때 처리하는 함수
        function onCheck() {
            let allChecked = true;
            $(".quantity__item input[type='checkbox']").each(function() {
                let cartIdx = $(this).val();
                if (!$(this).is(":checked")) {
                    allChecked = false;
                    $("input[name='isChecked_" + cartIdx + "']").val(0);
                } else {
                    $("input[name='isChecked_" + cartIdx + "']").val(1);
                }
            });
            document.getElementById("allcheck").checked = allChecked;
            onTotal();
        }

     	// allCheck 체크박스를 체크/해제할 때 수행하는 함수
        function allCheck() {
            let isChecked = document.getElementById("allcheck").checked;
            $(".quantity__item input[type='checkbox']").prop('checked', isChecked);
            $(".quantity__item input[type='checkbox']").each(function() {
                let cartIdx = $(this).val();
                $("input[name='isChecked_" + cartIdx + "']").val(isChecked ? 1 : 0);
            });
            onTotal();
        }

        function applyCouponAndPoints() {
            const couponIdx = document.getElementById("couponIdx").value;
            const pointUse = document.getElementById("pointUse").value;

            document.getElementById("hiddenCouponIdx").value = couponIdx;
            document.getElementById("hiddenPointUse").value = pointUse;

            onTotal();
        }
     
        // 장바구니에서 선택한 상품만 '주문'처리하기
		function order() {
		    let checkedItems = $(".quantity__item input:checked");
		    if (checkedItems.length == 0) {
		        alert("장바구니에서 주문처리할 상품을 선택해주세요!");
		        return false;
		    }
		
		    // 선택된 항목에 대해 isChecked 값 설정
		    $(".quantity__item input[type='checkbox']").each(function() {
		        let cartIdx = $(this).val();
		        $("input[name='isChecked_" + cartIdx + "']").val($(this).is(":checked") ? 1 : 0);
		    });
		
		    // 쿠폰과 포인트 값을 확인하고 숨겨진 필드에 설정
		    applyCouponAndPoints();
		
		    // 폼 제출
		    document.myform.submit();
		}
        
        $(document).ready(function() {
            $(".pro-qty-2 input").on("change", function() {
                onTotal();
            });
        });
        
        $(document).ready(function() {
            $(".pro-qty-2 input").on("change", function() {
                let $row = $(this).closest("tr");
                let cartIdx = $row.find("input[type='checkbox']").val();
                let productIdx = $row.find("a").attr("href").split("=")[1]; // productIdx 추출
                let quantity = $(this).val();

                if (quantity < 1) {
                    alert("최소 수량은 1개입니다.");
                    $(this).val(1);
                    return;
                }

                $.ajax({
                    url: "${ctp}/shop/productCartUpdate",
                    type: "POST",
                    data: { cartIdx: cartIdx, productIdx: productIdx, quantity: quantity },
                    success: function(response) {
                        console.log("응답 데이터:", response);

                        if (response.status === "success") {
                            // 개별 상품 총 금액 업데이트
                            $row.find(".cart__price").text(numberWithCommas(response.itemTotalPrice) + " 원");

                            // 전체 총 금액 업데이트
                            $("#total").text(numberWithCommas(response.totalPrice));
                            $("#charge").text(numberWithCommas(response.shippingCost));
                            $("#lastPrice").text(numberWithCommas(response.finalPrice));
                        } else {
                            alert("수량 변경에 실패했습니다.");
                        }
                    },
                    error: function() {
                        alert("서버 오류가 발생했습니다.");
                    }
                });
            });
        });

        // 숫자를 천 단위 콤마 추가하여 반환하는 함수
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
						<form name="myform" method="post" action="${ctp}/order/productOrder">
						    <table>
						        <thead>
						            <tr>
						                <th><input type="checkbox" id="allcheck" name="allcheck" onclick="allCheck()"></th>
						                <th>제품명</th>
						                <th>수량</th>
						                <th>가격</th>
						                <th></th>
						            </tr>
						        </thead>
						        <tbody>
						            <c:forEach var="productCartVO" items="${productCartVOS}">
						                <c:forEach var="cartVO" items="${productCartVO.items}">
						                    <tr>
						                        <td class="quantity__item">
						                            <input type="checkbox" name="idxChecked" value="${productCartVO.cartIdx}" id="idx${productCartVO.cartIdx}" onclick="onCheck()">
						                            <input type="hidden" name="isChecked_${productCartVO.cartIdx}" value="0">
						                        </td>
						                        <td class="product__cart__item">
						                            <div class="product__cart__item__pic mt-4">
						                                <img src="${ctp}/product/${cartVO.productThumb}" alt="thumbnail" style="width:100px;height:auto;">
						                            </div>
						                            <div class="product__cart__item__text">
						                                <h5><a href="${ctp}/shop/productDetails?productIdx=${cartVO.productIdx}">${cartVO.productName}</a></h5>
						                                <c:choose>
						                                    <c:when test="${cartVO.optionGroupName != '기본'}">
						                                        <h6>옵션: ${cartVO.optionGroupName} - ${cartVO.optionName}</h6>
						                                    </c:when>
						                                    <c:otherwise>
						                                        <h6>- 기본 옵션</h6>
						                                    </c:otherwise>
						                                </c:choose>
						                            </div>
						                        </td>
						                        <td class="quantity__item">
						                            <div class="quantity">
						                                <div class="pro-qty-2">
						                                    <input type="number" value="${cartVO.quantity}">
						                                </div>
						                            </div>
						                        </td>
						                        <td class="cart__price"><fmt:formatNumber value="${cartVO.productPrice}" /> 원</td>
						                        <td class="cart__close"><i class="fa fa-close" onclick="cartDelete(${productCartVO.cartIdx})"></i></td>
						                    </tr>
						                </c:forEach>
						            </c:forEach>
						        </tbody>
						    </table>
						
						    <!-- 숨겨진 입력 필드 추가 -->
						    <input type="hidden" name="orderTotalPrice" id="orderTotalPrice"/>
						    <input type="hidden" name="charge" id="charge"/>    
						    <input type="hidden" name="couponIdx" id="hiddenCouponIdx"/>
						    <input type="hidden" name="pointUse" id="hiddenPointUse"/>
						</form>
                    </div>
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="continue__btn">
                                <a href="${ctp}/shop/productList">쇼핑 더하기</a>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-6">
                            <div class="continue__btn update__btn">
                                <a href="#"><i class="fa fa-spinner"></i> 삭제하기</a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="cart__discount">
                        <h6>쿠폰/포인트 적용하기</h6>
					    <form>
					        <select class="form-control" name="couponIdx" id="couponIdx">
					            <option value="">쿠폰내역</option>
					            <!-- 가능한 쿠폰 목록을 동적으로 추가 -->
					            <c:forEach var="coupon" items="${availableCoupons}">
					                <option value="${coupon.id}">${coupon.name} - 할인: ${coupon.discountAmount}원</option>
					            </c:forEach>
					        </select>
					        <div>
						        <input type="text" class="form-control" name="pointUse" id="pointUse" placeholder="포인트">
						        <button type="submit" class="form-control-append">적용하기</button>
					        </div>
					    </form>
                    </div>
                    <div class="cart__total">
                        <h6>장바구니</h6>
                        <ul>
                            <li>상품금액 <span id="total">0</span></li>
                            <li>할인내역 <span id="discount">0</span></li>
                            <li>배송비 <span id="charge">0</span></li>
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
                    <h3 class="related-title">관련 제품 추천</h3>
                </div>
            </div>
            <div class="row">
            	<c:forEach var="relatedVO" items="${relatedVOS}">
                <div class="col-lg-3 col-md-6 col-sm-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="${ctp}/product/${relatedVO.productThumb}" style="object-fit:cover;">
                            <c:if test="${relatedVO.createDiff > -7}"><span class="label">New</span></c:if>
                            <ul class="product__hover">
	                            <li><a href="#"><i class="fa-solid fa-heart"></i><span>관심등록</span></a></li>
	                            <li><a href="#"><i class="fa-solid fa-share"></i><span>공유하기</span></a></li>
	                            <li><a href="#"><i class="fa-solid fa-bag-shopping"></i><span>장바구니</span></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h5><a href="${ctp}/shop/productDetails?productIdx=${relatedVO.productIdx}">${relatedVO.productName}</a></h5>
							<h6 class="float-right">￦ <fmt:formatNumber value="${relatedVO.productPrice}"/></h6>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <p>${relatedVO.productTags}</p>
                        </div>
                    </div>
                </div>
                </c:forEach>
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

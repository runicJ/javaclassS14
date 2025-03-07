<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <%@ include file="/WEB-INF/views/include/user/bs4.jsp" %>
    <script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
    <script src="http://developers.kakao.com/sdk/js/kakao.js"></script>
    <title>좋아요한 상품</title>
    <style>
        .liked-products-container {
            margin-top: 30px;
        }
        .product-card {
            display: flex;
            align-items: center;
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 15px;
            padding: 15px;
            transition: 0.3s;
        }
        .product-card:hover {
            transform: scale(1.02);
        }
        .product-img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 5px;
            margin-right: 15px;
        }
        .product-info {
            flex: 1;
        }
        .product-title {
            font-size: 16px;
            font-weight: bold;
        }
        .product-price {
            color: #FF4500;
            font-size: 14px;
            font-weight: bold;
        }
        .remove-like-btn {
            background: #ff4d4d;
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }
        .remove-like-btn:hover {
            background: #cc0000;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/include/user/header.jsp" %>
<%@ include file="/WEB-INF/views/include/user/nav.jsp" %>

<section class="page liked-products-container">
    <div class="container">
        <div class="row">
            <jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
            <div class="col-xs-12 col-md-8">
                <h2 class="mb-4">좋아요한 상품</h2>

                <c:choose>
                    <c:when test="${empty likedProducts}">
                        <div class="alert alert-warning text-center">
                            좋아요한 상품이 없습니다. 💔
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="row">
                            <c:forEach var="product" items="${likedProducts}">
                                <div class="col-md-12">
                                    <div class="product-card">
                                        <img src="${ctp}/product/${product.productThumb}" class="product-img" alt="상품 이미지">
                                        <div class="product-info">
                                            <a href="${ctp}/shop/productDetails?productIdx=${product.productIdx}" class="product-title">
                                                ${product.productName}
                                            </a>
                                            <p class="product-price">￦ <fmt:formatNumber value="${product.productPrice}" type="currency"/></p>
                                        </div>
                                        <button class="remove-like-btn" onclick="removeLike(${product.productIdx})">좋아요 취소</button>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<%@ include file="/WEB-INF/views/include/user/footer.jsp" %>

<script>
    function removeLike(productIdx) {
        if (confirm("좋아요를 취소하시겠습니까?")) {
            location.href = "${ctp}/users/removeLike?productIdx=" + productIdx;
        }
    }
</script>
</body>
</html>
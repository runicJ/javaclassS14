<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>title</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<style>
		/* iCheck plugin skins
		----------------------------------- */
/* 		@import url("minimal/_all.css");
		
		@import url("square/_all.css");
		
		@import url("flat/_all.css");
		
		@import url("line/_all.css");
		
		@import url("polaris/polaris.css");
		
		@import url("futurico/futurico.css"); */
		.product-card img {
		    width: 100%; /* 가로 크기를 카드 너비에 맞춤 */
		    height: 200px; /* 고정 높이 설정 */
		    object-fit: cover; /* 비율을 유지하면서 크기에 맞춤 */
		    border-radius: 8px; /* 둥근 모서리 효과 */
		}
		
		.review-card img {
		    width: 100%;
		    height: 150px;
		    object-fit: cover;
		    border-radius: 8px;
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="search">
    <div class="container">
        <h2>"${keyword}" 검색 결과</h2>

        <div class="search-result">
            <p>관련 상품 (${products != null ? products.size() : 0}개)</p>
            <div class="row">
                <c:choose>
                    <c:when test="${not empty products}">
                        <c:forEach var="product" items="${products}">
                            <div class="col-md-4">
                                <div class="product-card">
                                    <img src="${ctp}/product/${product.productThumb}" alt="${product.productName}">
                                    <h3>${product.productName}</h3>
                                    <p>가격: ${product.productPrice}원</p>
                                    <p>태그: ${product.productTags}</p>
                                    <a href="${ctp}/shop/productDetails?productIdx=${product.productIdx}" class="btn btn-primary">자세히 보기</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>검색된 상품이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <hr>

        <div class="search-result">
            <p>관련 포토리뷰 (${photoReviews != null ? photoReviews.size() : 0}개)</p>
            <div class="row">
                <c:choose>
                    <c:when test="${not empty photoReviews}">
                        <c:forEach var="review" items="${photoReviews}">
                            <div class="col-md-6">
                                <div class="review-card">
                                    <h3>${review.title}</h3>
                                    <p>${review.content}</p>
                                    <a href="${ctp}/photoReview/photoReviewContent?photoReviewIdx=${review.photoReviewIdx}" class="btn btn-secondary">더 보기</a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <p>검색된 포토리뷰가 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</section>

<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
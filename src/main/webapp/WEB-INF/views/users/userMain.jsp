<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userMain</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
	<section class="userMain" style="padding-top: 245.125px;">
		<div class="container">
			<div class="row">
				<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
				<div class="col-xs-12 col-md-8">
						<div class="row">
							<article class="article col-md-12">
								<div class="inner">
									<div class="padding">
										<h2 class="text-center"><a href="${ctp}/users/myOrderList">최근 주문내역</a></h2>
										<table class="table table-hover">
											<tr>
												<th>주문번호</th>
												<th>총가격</th>
												<th>주문일</th>
												<th>주문상태</th>
											</tr>
											<c:choose>
												<c:when test="${empty orderVOS}">
													<tr>
														<td colspan="4" style="text-align:center;">주문내역이 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="orderVO" items="${orderVOS}">
														<tr>
															<td>${orderVO.orderNumber}</td>
															<td><fmt:formatNumber value="${orderVO.totalPrice}"/></td>
															<td>${fn:substring(orderVO.orderDate,0,10)}</td>
															<td>${orderVO.orderStatus}</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</table>
										<footer>
											<a class="btn btn-primary more" href="${ctp}/users/myOrderList">
												<span>더보기</span>
											</a>
										</footer>
									</div>
								</div>
							</article>
						</div>
						<div class="row">
							<article class="article col-md-12">
								<div class="inner">
									<div class="padding">
										<h2 class="text-center"><a href="${ctp}/users/myLikedList">관심 제품</a></h2>
										<table class="table table-hover">
											<tr>
												<th>상품명</th>
												<th>가격</th>
												<th>등록일</th>
												<th>품절여부</th>
											</tr>
											<c:choose>
												<c:when test="${empty likedVOS}">
													<tr>
														<td colspan="4" style="text-align:center;">관심제품 등록내역이 존재하지 않습니다.</td>
													</tr>
												</c:when>
												<c:otherwise>
													<c:forEach var="likedVO" items="${likedVOS}">
														<tr>
															<td>${likedVO.productName}</td>
															<td><fmt:formatNumber value="${likedVO.productPrice}"/></td>
															<td>${fn:substring(likedVO.likedAddDate,0,10)}</td>
           					 								<td>${likedVO.productStock > 0 ? 'N' : 'Y'}</td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</table>
										<footer>
											<a class="btn btn-primary more" href="${ctp}/users/myLikedList">
												<span>더보기</span>
											</a>
										</footer>
									</div>
								</div>
							</article>
						</div>
						<div class="row">
							<article class="article col-md-12">
								<div class="inner">
									<div class="padding">
										<h2 class="text-center">최근 관심 내역</h2>
										<table class="table table-hover">
											<c:if test="${empty recentProducts}">
												<tr>
													<td colspan="4" style="text-align:center;">최근 본 상품이 존재하지 않습니다</td>
												</tr>
											</c:if>
											<c:forEach var="recentProduct" items="${recentProducts}">
												<tr>
													<td>
										                <a href="${ctp}/shop/productDetails?productIdx=${recentProduct.productIdx}">
										                    <img src="${ctp}/product/${recentProduct.productThumb}" alt="${recentProduct.productName}" width="100px" height="55px">
										                </a>
										            </td>
									                <td>
									                    <a href="${ctp}/shop/productDetails?productIdx=${recentProduct.productIdx}">
									                        ${recentProduct.productName}
									                    </a>
									                </td>
									                <td>
									                    <div class="tag">${recentProduct.productTags}</div>
									                </td>
										    	</tr>
											</c:forEach>
										</table>
									</div>
								</div>
							</article>
						</div>
						<!--
						<div class="row">
							<article class="article col-md-12">
								<div class="row">
								<article class="article col-md-6">
									<div class="inner">
										<div class="padding">
											<h2><a href="single.html">최근 활동</a></h2>
											<p>Maecenas accumsan tortor ut velit pharetra mollis. Proin eu nisl et arcu iaculis placerat sollicitudin ut est. In fringilla dui dui.</p>
											<footer>
												<a class="btn btn-primary more" href="single.html">
													<div>더보기</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
								<article class="article col-md-6">
								<div class="inner">
										<div class="padding">
											<h2><a href="single.html">문의 내역</a></h2>
											<p>Maecenas accumsan tortor ut velit pharetra mollis. Proin eu nisl et arcu iaculis placerat sollicitudin ut est. In fringilla dui dui.</p>
											<footer>
												<a class="btn btn-primary more" href="single.html">
													<div>더보기</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
							</div>
							</article>
						</div>
						-->
					</div>
				</div>
			</div>
	</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
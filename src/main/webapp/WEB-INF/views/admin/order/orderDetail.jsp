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
	<title>orderDetail</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
<p><br></p>
<div class="container">
	<h5>주문 상세 정보</h5>
	<table class="table table-bordered">
		<tr>
			<th>주문번호</th>
			<td>${order.orderNumber}</td>
		</tr>
		<tr>
			<th>아이디</th>
			<td>${order.userId}</td>
		</tr>
		<tr>
			<th>총금액</th>
			<td><fmt:formatNumber value="${order.totalPrice}"/>원</td>
		</tr>
		<tr>
			<th>주문상태</th>
			<td>${order.orderStatus}</td>
		</tr>
		<tr>
			<th>주문일자</th>
			<td>${fn:substring(order.orderDate,0,19)}</td>
		</tr>
		<tr>
			<th>쿠폰 사용 여부</th>
			<td>
				<c:choose>
					<c:when test="${order.couponIdx != null}">
						Y (쿠폰 ID: ${order.couponIdx})
					</c:when>
					<c:otherwise>
						N
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
		<tr>
			<th>포인트 사용 여부</th>
			<td>
				<c:choose>
					<c:when test="${order.pointUse > 0}">
						Y (사용 포인트: <fmt:formatNumber value="${order.pointUse}"/>P)
					</c:when>
					<c:otherwise>
						N
					</c:otherwise>
				</c:choose>
			</td>
		</tr>
	</table>
	
	<h5>상품 목록</h5>
	<table class="table table-bordered">
		<thead>
			<tr>
				<th>상품명</th>
				<th>수량</th>
				<th>가격</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="item" items="${order.items}">
				<tr>
					<td>${item.productName}</td>
					<td>${item.quantity}</td>
					<td><fmt:formatNumber value="${item.price}"/>원</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
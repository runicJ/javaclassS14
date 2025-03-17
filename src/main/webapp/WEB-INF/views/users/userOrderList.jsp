<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
 	<meta charset="UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
 		<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
 	<title>userOrderList</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<script>
	    // 배송지 정보 보기 팝업
	    function nWin(orderIdx) {
	        if (!orderIdx) {
	            alert("잘못된 주문 정보입니다.");
	            return;
	        }
	        var url = "${ctp}/shop/orderDelivery?orderIdx=" + orderIdx;
	        window.open(url, "orderDelivery", "width=400px,height=450px");
	    }
	    
	    // 날짜 및 주문 상태 필터링
	    function myOrderStatus() {
	        var startDateOrder = document.getElementById("startOrder").value;
	        var endDateOrder = document.getElementById("endOrder").value;
	        var conditionOrderStatus = document.getElementById("conditionOrderStatus").value;
	
	        // 날짜 유효성 검사
	        if (!startDateOrder || !endDateOrder) {
	            alert("날짜를 입력하세요.");
	            return;
	        }
	        if (new Date(startDateOrder) > new Date(endDateOrder)) {
	            alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
	            return;
	        }
	
	        location.href = "${ctp}/users/userOrderList?pag=${pageVO.pag}&startOrder=" + startDateOrder + "&endOrder=" + endDateOrder + "&conditionOrderStatus=" + conditionOrderStatus;
	    }
    </script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/user/header.jsp"%>
<%@ include file = "/WEB-INF/views/include/user/nav.jsp"%>
<section class="page">
	<div class="container">
		<div class="row">
            <jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
			<div class="col-xs-12 col-md-8">
			<div>
			    <h2 style="text-align:center;">주문/배송 확인</h2>
			    <table class="table table-borderless">
			        <tr>
			            <td style="text-align:left;">
			                <input type="date" name="startOrder" id="startOrder" value="${startOrder != null ? startOrder : ''}"/>
			                <input type="date" name="endOrder" id="endOrder" value="${endOrder != null ? endOrder : ''}"/>
							<c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
			                <select name="conditionOrderStatus" id="conditionOrderStatus">
			                    <option value="전체" ${conditionOrderStatus == '전체' ? 'selected' : ''}>전체</option>
			                    <option value="결제완료" ${conditionOrderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
			                    <option value="배송중" ${conditionOrderStatus == '배송중' ? 'selected' : ''}>배송중</option>
			                    <option value="배송완료" ${conditionOrderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
			                    <option value="구매완료" ${conditionOrderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
			                    <option value="반품처리" ${conditionOrderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
			                </select>
			                <input type="button" value="조회하기" onclick="myOrderStatus()"/>
			            </td>
			            <td style="text-align:right;">
			                <a href="${ctp}/shop/productCart" class="btn btn-success btn-sm">장바구니조회</a>
			                <a href="${ctp}/shop/productList" class="btn btn-primary btn-sm">계속쇼핑하기</a>
			            </td>
			        </tr>
			    </table>

			    <table class="table table-hover">
			        <tr style="text-align:center;background-color:#ccc;">
			            <th>주문정보</th>
			            <th>상품</th>
			            <th>주문내역</th>
			            <th>주문일시</th>
			        </tr>

			        <c:if test="${empty orderList}">
			            <tr>
			                <td colspan="4" class="text-center"><b>구매하신 상품이 없습니다.</b></td>
			            </tr>
			        </c:if>

					<c:forEach var="order" items="${orderList}">
					    <tr>
					        <td rowspan="${fn:length(order.orderProducts)}">
					            주문번호 : ${order.orderIdx}<br>
					            총 주문액 : <fmt:formatNumber value="${order.totalPrice}"/>원<br>
					            배송 상태 : <span style="color: brown;">${order.orderStatus}</span><br>
					            <input type="button" value="배송지정보" onclick="nWin('${order.orderIdx}')">
					        </td>
					        <c:forEach var="product" items="${order.orderProducts}" varStatus="loop">
					            <c:if test="${loop.index > 0}">
					                <tr>
					            </c:if>
					            <td style="text-align:center;">
					                <img src="${ctp}/product/${product.productThumb}" class="thumb" width="100px"/>
					            </td>
					            <td align="left">
					                모델명 : <span style="color:orange;font-weight:bold;">${product.productName}</span><br/>
					                가격 : <fmt:formatNumber value="${product.price}"/>원<br/>
					                수량 : ${product.orderQuantity}개
					            </td>
					            <c:if test="${loop.index > 0}">
					                </tr>
					            </c:if>
					        </c:forEach>
					    </tr>
					</c:forEach>
			    </table>
			    <div class="pagination justify-content-center">
			        <c:if test="${pageVO.totPage > 0}">
			            <ul class="pagination">
			                <li class="page-item ${pageVO.pag == 1 ? 'disabled' : ''}">
			                    <a href="${ctp}/users/userOrderList?pag=1" class="page-link">◁◁</a>
			                </li>
			                <c:forEach var="i" begin="1" end="${pageVO.totPage}">
			                    <li class="page-item ${i == pageVO.pag ? 'active' : ''}">
			                        <a href="${ctp}/users/userOrderList?pag=${i}" class="page-link">${i}</a>
			                    </li>
			                </c:forEach>
			                <li class="page-item ${pageVO.pag == pageVO.totPage ? 'disabled' : ''}">
			                    <a href="${ctp}/users/userOrderList?pag=${pageVO.totPage}" class="page-link">▷▷</a>
			                </li>
			            </ul>
			        </c:if>
			    </div>
			</div>
		</div>
		</div>
	</div>
</section>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>paymentResult</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
	<style>
		.order-container { width: 80%; margin: auto; padding: 20px; border: 1px solid #ddd; border-radius: 10px; background: #f9f9f9; }
		.order-header { text-align: center; font-size: 24px; font-weight: bold; margin-bottom: 20px; }
		.order-table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
		.order-table th, .order-table td { border: 1px solid #ccc; padding: 10px; text-align: center; }
		.order-table th { background: #eee; }
		.total-price { font-size: 20px; font-weight: bold; text-align: right; margin-top: 20px; }
		.btn-container { text-align: center; margin-top: 20px; }
	</style>
	<script>
		function openDeliveryInfo(orderIdx) {
		  var url = "${ctp}/order/orderDelivery?orderIdx=" + orderIdx;
		  window.open(url, "orderDelivery", "width=400px,height=500px");
		}
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
<p><br></p>
<section>
<div class="container">
    <div class="order-container">
        <div class="order-header">📦 결제 완료</div>

        <h3>📜 주문 정보</h3>
        <p><strong>주문번호:</strong> ${orderVOS[0].orderNumber}</p>
        <table class="order-table">
            <tr>
                <th>상품 이미지</th>
                <th>상품 정보</th>
                <th>수량</th>
                <th>가격</th>
            </tr>
            <c:set var="orderTotal" value="0"/>
            <c:forEach var="vo" items="${sOrderProducts}">
                <c:set var="productTotalPrice" value="${vo.price * vo.orderQuantity}"/>
                <c:set var="orderTotal" value="${orderTotal + productTotalPrice}"/>
                <tr>
                    <td><img src="${ctp}/product/${vo.productThumb}" width="100px"/></td>
                    <td>
                        <p><strong>${vo.productName}</strong></p>
                        <p>옵션: ${vo.optionName}</p>
                    </td>
                    <td>${vo.orderQuantity} 개</td>
                    <td><fmt:formatNumber value="${productTotalPrice}" pattern="#,###"/> 원</td>
                </tr>
            </c:forEach>
        </table>

        <h3>💰 결제 금액</h3>
        <c:set var="shippingCharge" value="${sOrderVOS[0].charge ne null ? sOrderVOS[0].charge : 0}"/>
        <c:set var="finalTotal" value="${orderTotal + shippingCharge}"/>
        <div class="total-price">
            상품 가격 합계: <fmt:formatNumber value="${orderTotal}" pattern="#,###"/> 원 <br/>
            배송비: <fmt:formatNumber value="${shippingCharge}" pattern="#,###"/> 원 <br/>
            <hr/>
            <span style="font-size: 22px; color: red;">총 결제 금액: <fmt:formatNumber value="${finalTotal}" pattern="#,###"/> 원</span>
        </div>

        <h3>🚚 배송 정보</h3>
        <p><strong>주문자:</strong> ${sPaymentVO.buyer_name}</p>
        <p><strong>연락처:</strong> ${sPaymentVO.buyer_tel}</p>
        <p><strong>배송 주소:</strong> ${sPaymentVO.buyer_addr} (${sPaymentVO.buyer_postcode})</p>
        <button class="btn btn-info" onclick="openDeliveryInfo('${orderVOS[0].orderIdx}')">📦 배송 조회</button>

        <h3>💳 결제 정보</h3>
        <p><strong>결제 방식:</strong> 
            <c:choose>
                <c:when test="${fn:startsWith(sPaymentVO.imp_uid, 'C')}">카드 결제</c:when>
                <c:otherwise>무통장 입금</c:otherwise>
            </c:choose>
        </p>
        <c:if test="${fn:startsWith(sPaymentVO.imp_uid, 'C')}">
            <p><strong>사용 카드:</strong> ${sPaymentVO.card_name}</p>
        </c:if>
        <c:if test="${!fn:startsWith(sPaymentVO.imp_uid, 'C')}">
            <p><strong>입금자명:</strong> ${sPaymentVO.buyer_name}</p>
        </c:if>
        <p><strong>결제 고유 ID:</strong> ${sPaymentVO.imp_uid}</p>
        <p><strong>결제 상점 거래 ID:</strong> ${sPaymentVO.merchant_uid}</p>
        <p><strong>승인 번호:</strong> ${sPaymentVO.apply_num}</p>
        <p><strong>실제 결제 금액:</strong> <fmt:formatNumber value="${sPaymentVO.paid_amount}" pattern="#,###"/> 원</p>

        <c:if test="${sPaymentVO.paid_amount ne finalTotal}">
            <p style="color: red; font-weight: bold;">⚠️ 결제 금액과 주문 금액이 일치하지 않습니다! 관리자에게 문의하세요.</p>
        </c:if>

        <div class="btn-container">
            <button class="btn btn-primary" onclick="location.href='${ctp}/shop/productList'">🏠 메인으로</button>
            <button class="btn btn-success" onclick="location.href='${ctp}/user/userOrder'">📜 주문 내역 확인</button>
        </div>
    </div>
</div>
</section>
<br/>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>
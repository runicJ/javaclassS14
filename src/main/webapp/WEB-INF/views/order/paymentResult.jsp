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
  <script>
	  function nWin(orderIdx) {
	  	var url = "${ctp}/order/orderDelivery?orderIdx="+orderIdx;
	  	window.open(url,"orderDelivery","width=350px,height=400px");
	  }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
<p><br></p>
<div class="container">
    <div class="col-lg-4 col-md-6">
        <div class="checkout__order">
            <h4 class="order__title">Your order</h4>
            <div class="checkout__order__products">Product <span>Total</span></div>
            <ul class="checkout__total__products">
                <li>01. Vanilla salted caramel <span>$ 300.0</span></li>
                <li>02. German chocolate <span>$ 170.0</span></li>
                <li>03. Sweet autumn <span>$ 170.0</span></li>
                <li>04. Cluten free mini dozen <span>$ 110.0</span></li>
            </ul>
            <ul class="checkout__total__all">
                <li>Subtotal <span>$750.99</span></li>
                <li>Total <span>$750.99</span></li>
            </ul>
            <div class="checkout__input__checkbox">
                <label for="acc-or">
                    Create an account?
                    <input type="checkbox" id="acc-or">
                    <span class="checkmark"></span>
                </label>
            </div>
            <p>Lorem ipsum dolor sit amet, consectetur adip elit, sed do eiusmod tempor incididunt
            ut labore et dolore magna aliqua.</p>
            <div class="checkout__input__checkbox">
                <label for="payment">
                    Check Payment
                    <input type="checkbox" id="payment">
                    <span class="checkmark"></span>
                </label>
            </div>
            <div class="checkout__input__checkbox">
                <label for="paypal">
                    Paypal
                    <input type="checkbox" id="paypal">
                    <span class="checkmark"></span>
                </label>
            </div>
            <button type="submit" class="site-btn">PLACE ORDER</button>
        </div>
    </div>
  <h2>결제내역</h2>
  <hr/>
  <p>주문 물품명 : ${sPayMentVO.name}</p>
  <p>주문금액 : ${sPayMentVO.amount}(실제구매금액:${orderTotalPrice})</p>
  <p>주문자 메일주소 : ${sPayMentVO.buyer_email}</p>
  <p>주문자 성명 : ${sPayMentVO.buyer_name}</p>
  <p>주문자 전화번호 : ${sPayMentVO.buyer_tel}</p>
  <p>주문자 주소 : ${sPayMentVO.buyer_addr}</p>
  <p>주문자 우편번호 : ${sPayMentVO.buyer_postcode}</p>
  <p>결제 고유ID : ${sPayMentVO.imp_uid}</p>
  <p>결제 상점 거래 ID : ${sPayMentVO.merchant_uid}</p>
  <p>결제 금액 : ${sPayMentVO.paid_amount}</p>
  <p>카드 승인번호 : ${sPayMentVO.apply_num}</p>
  <hr/>
  <h2 class="text-center">주문완료</h2>
  <hr/>
  <table class="table table-bordered">
    <tr style="text-align:center;background-color:#ccc;">
      <th>상품이미지</th>
      <th>주문일시</th>
      <th>주문내역</th>
      <th>비고</th>
    </tr>
    <c:forEach var="vo" items="${orderVOS}">
      <tr>
        <td style="text-align:center;">
          <img src="${ctp}/product/${vo.productThumb}" width="100px"/>
        </td>
        <td style="text-align:center;"><br/>
          <p>주문번호 : ${vo.orderIdx}</p>
          <p>총 주문액 : <fmt:formatNumber value="${vo.totalPrice}"/>원</p>
          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td align="left">
	        <p><br/>모델명 : <span style="color:orange;font-weight:bold;">${vo.productName}</span><br/> &nbsp; &nbsp; <fmt:formatNumber value="${vo.mainPrice}"/>원</p><br/>
	        <c:set var="optionNames" value="${fn:split(vo.optionName,',')}"/>
	        <c:set var="optionPrices" value="${fn:split(vo.optionPrice,',')}"/>
	        <c:set var="optionNums" value="${fn:split(vo.optionNum,',')}"/>
	        <p>
	          - 주문 내역
	          <c:if test="${fn:length(optionNames) > 1}">(옵션 ${fn:length(optionNames)-1}개 포함)</c:if><br/>
	          <c:forEach var="i" begin="1" end="${fn:length(optionNames)}">
	            &nbsp; &nbsp; ㆍ ${optionNames[i-1]} / <fmt:formatNumber value="${optionPrices[i-1]}"/>원 / ${optionNums[i-1]}개<br/>
	          </c:forEach> 
	        </p>
	      </td>
        <td style="text-align:center;"><br/><font color="blue">결제완료</font><br/>(배송준비중)</td>
      </tr>
    </c:forEach>
  </table>
  <hr/>
  <div class="text-center">
    구매한 상품 총 금액(배송비포함) : <fmt:formatNumber value="${totalBaesongOrder}"/>원
  </div>
  <hr/>
  <p class="text-center">
    <a href="${ctp}/shop/productList" class="btn btn-success">제품 더보기</a> &nbsp;
    <a href="${ctp}/user/userOrder" class="btn btn-primary">구매 내역 확인</a>
  </p>
  <hr/>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>
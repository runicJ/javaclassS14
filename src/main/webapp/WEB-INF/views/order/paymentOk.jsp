<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>paymentOk</title>
    <link rel="stylesheet" href="${ctp}/css/shop/elegant-icons.css" type="text/css">
  <link rel="stylesheet" href="${ctp}/css/shop/nice-select.css" type="text/css">
  <link rel="stylesheet" href="${ctp}/css/shop/slicknav.min.css" type="text/css">
  <link rel="stylesheet" href="${ctp}/css/shop/style.css" type="text/css">
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	
	<script>
		var IMP = window.IMP; 
    	IMP.init("imp78204880");
		
		IMP.request_pay({
		    pg : 'html5_inicis',
		    pay_method : 'card',
		    merchant_uid : 'javaclassS14_' + new Date().getTime(),
		    name : '${paymentVO.name}',
		    amount : ${paymentVO.amount},
		    buyer_email : '${paymentVO.buyer_email}',
		    buyer_name : '${paymentVO.buyer_name}',
		    buyer_tel : '${paymentVO.buyer_tel}',
		    buyer_addr : '${paymentVO.buyer_addr}',
		    buyer_postcode : '${paymentVO.buyer_postcode}'
		}, function(rsp) {
			  var paySw = 'no';
		    if ( rsp.success ) {
		        var msg = '결제가 완료되었습니다.';
		        msg += '\n고유ID : ' + rsp.imp_uid;
		        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
		        msg += '\n결제 금액 : ' + rsp.paid_amount;
		        msg += '\n카드 승인번호 : ' + rsp.apply_num;
		        paySw = 'ok';
		    } else {
		        var msg = '결제에 실패하였습니다.';
		        msg += '에러내용 : ' + rsp.error_msg;
		    }
		    alert(msg);
		    if(paySw == 'no') {
			    alert("다시 장바구니로 이동합니다.");
		    	location.href='${ctp}/shop/productCart';
		    }
		    else {
					var temp = "";
					temp += '?name=${paymentVO.name}';
					temp += '&amount=${paymentVO.amount}';
					temp += '&buyer_email=${paymentVO.buyer_email}';
					temp += '&buyer_name=${paymentVO.buyer_name}';
					temp += '&buyer_tel=${paymentVO.buyer_tel}';
					temp += '&buyer_addr=${paymentVO.buyer_addr}';
					temp += '&buyer_postcode=${paymentVO.buyer_postcode}';
					temp += '&imp_uid=' + rsp.imp_uid;
					temp += '&merchant_uid=' + rsp.merchant_uid;
					temp += '&paid_amount=' + rsp.paid_amount;
					temp += '&apply_num=' + rsp.apply_num;
					
					location.href='${ctp}/order/paymentResult'+temp;
		    }
		});
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
<p><br></p>
<div class="container text-center">
 <section class="checkout spad">
  <h2>결제처리 연습</h2>
  <hr/>
  <h3>현재 결제가 진행중입니다.</h3>
  <p><img src="${ctp}/images/payment.gif" width="200px"/></p>
  <hr/>
    </section>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>
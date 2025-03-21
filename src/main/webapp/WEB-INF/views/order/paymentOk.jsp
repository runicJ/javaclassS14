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
		    amount : '${paymentVO.amount}',
		    buyer_email : '${paymentVO.buyer_email}',
		    buyer_name : '${paymentVO.buyer_name}',
		    buyer_tel : '${paymentVO.buyer_tel}',
		    buyer_addr : '${paymentVO.buyer_addr}',
		    buyer_postcode : '${paymentVO.buyer_postcode}'
		}, function(rsp) {
	        var paySw = 'no';
	        var msg = '';
	        
	        if (rsp.success) {
	            paySw = 'ok';
	            msg = '결제가 완료되었습니다.\n';
	            msg += '고유ID: ' + rsp.imp_uid + '\n';
	            msg += '상점 거래ID: ' + rsp.merchant_uid + '\n';
	            msg += '결제 금액: ' + rsp.paid_amount + '원\n';
	            msg += '카드 승인번호: ' + rsp.apply_num;
	        } else {
	            msg = '⚠️ 결제에 실패하였습니다.\n';
	            msg += '이유: ' + rsp.error_msg;
	        }
		    alert(msg);
		    if(paySw == 'no') {
		        alert("결제가 실패하였습니다.\n이유: " + rsp.error_msg + "\n장바구니로 이동합니다.");
		        location.href='${ctp}/shop/productCart';
		    }
		    else {
	            // 서버 검증을 위해 결제 정보 전달
	            var temp = "?name=${paymentVO.name}";
	            temp += "&amount=${paymentVO.amount}";
	            temp += "&buyer_email=${paymentVO.buyer_email}";
	            temp += "&buyer_name=${paymentVO.buyer_name}";
	            temp += "&buyer_tel=${paymentVO.buyer_tel}";
	            temp += "&buyer_addr=${paymentVO.buyer_addr}";
	            temp += "&buyer_postcode=${paymentVO.buyer_postcode}";
	            temp += "&imp_uid=" + rsp.imp_uid;
	            temp += "&merchant_uid=" + rsp.merchant_uid;
	            temp += "&paid_amount=" + rsp.paid_amount;
	            temp += "&apply_num=" + rsp.apply_num;
					
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
    	<h2>결제 처리 중...</h2>
  		<hr/>
        <h3>잠시만 기다려 주세요. 결제가 진행 중입니다.</h3>
  		<p><img src="${ctp}/images/payment.gif" width="200px"/></p>
  		<hr/>
    </section>
</div>
<br/>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>
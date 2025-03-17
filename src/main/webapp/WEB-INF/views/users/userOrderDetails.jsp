<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userOrderDetails</title>
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
  	<style>
		* {
		  box-sizing: border-box;
		}
		
		body {
		  background-color: #f1f1f1;
		  padding: 20px;
		  font-family: Arial;
		}
		
		.main {
		  max-width: 1000px;
		  margin: auto;
		}
		
		h1 {
		  font-size: 50px;
		  word-break: break-all;
		}
		
		.row {
		  margin: 8px -16px;
		}
		
		.row,
		.row > .column {
		  padding: 8px;
		}
		
		.column {
		  float: left;
		  width: 33.33%;
		  display: none;
		}
		
		.row:after {
		  content: "";
		  display: table;
		  clear: both;
		}
		
		.content {
		  background-color: white;
		  padding: 10px;
		}
  	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br/></p>
<section>
    <div class="container">
        <div class="row">
        	<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
	        <div class="col-xs-12 col-md-8">
		        <h2>주문 상세 정보</h2>
		        <table class="table">
		            <tr>
		                <th>주문번호</th>
		                <td>${orderDetails.orderNumber}</td>
		            </tr>
		            <tr>
		                <th>총 가격</th>
		                <td><fmt:formatNumber value="${orderDetails.totalPrice}" /></td>
		            </tr>
		            <tr>
		                <th>주문 날짜</th>
		                <td>${orderDetails.orderDate}</td>
		            </tr>
		            <tr>
		                <th>주문 상태</th>
		                <td>${orderDetails.orderStatus}</td>
		            </tr>
		            <tr>
		                <th>배송 상태</th>
		                <td>${orderDetails.orderStatus}</td>
		            </tr>
		            <tr>
		                <th>결제 방법</th>
		                <td>${orderDetails.paymentMethod}</td>
		            </tr>
		        </table>
		
		        <h3>주문 상품 목록</h3>
		        <table class="table">
		            <tr>
		                <th>상품명</th>
		                <th>수량</th>
		                <th>가격</th>
		            </tr>
		            <c:forEach var="item" items="${orderItems}">
		                <tr>
		                    <td>${item.productName}</td>
		                    <td>${item.orderQuantity}</td>
		                    <td><fmt:formatNumber value="${item.price}" /></td>
		                </tr>
		            </c:forEach>
		        </table>
			</div>
		</div>
    </div>
<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</section>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
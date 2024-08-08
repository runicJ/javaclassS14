<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
  	
  	<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: left;
    }
    th {
        background-color: #f2f2f2;
    }
    .form-control, .qty-control {
        width: 40px;
        padding: 5px;
        text-align: center;
    }
    .btn-qty {
        padding: 5px 10px;
        font-size: 16px;
        width: auto;
        background-color: #f2f2f2;
        border: 1px solid #ccc;
        cursor: pointer;
    }
    .btn-order {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }
    .btn-order:hover {
        background-color: #45a049;
    }
</style>
<script>
function incrementQuantity(inputId) {
    var input = document.getElementById(inputId);
    var currentValue = parseInt(input.value, 10);
    input.value = currentValue + 1;
}

function decrementQuantity(inputId) {
    var input = document.getElementById(inputId);
    var currentValue = parseInt(input.value, 10);
    if (currentValue > 0) {
        input.value = currentValue - 1;
    }
}
</script>
</head>
<body>
    <div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
        <jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
            <div class="card p-5">
                <div class="card-body">
	<h2 class="text-center">발주 신청</h2>
<form action="/submit-order" method="post">
    <label for="branch">지점 선택:</label>
    <select id="branch" name="branch">
        <option value="제천">제천</option>
    </select>
    <table>
        <tr>
            <th>제품 이름</th>
            <th>가격</th>
            <th>원산지</th>
            <th>수량</th>
        </tr>
        	<c:forEach var="bppVO" items="${bppVOS}">
        <tr>
            <td>${bppVO.bppName}</td>
            <td>${bppVO.bppPrice}원</td>
            <td>${bppVO.bppOrigin}</td>
            <td>
                <button type="button" class="btn-qty" onclick="decrementQuantity('quantity1')">-</button>
                <input type="text" class="form-control" id="quantity1" name="quantity1" value="0">
                <button type="button" class="btn-qty" onclick="incrementQuantity('quantity1')">+</button>
            </td>
        </tr>
            </c:forEach>
        <!-- 추가 제품 행 -->
    </table>
    <button type="submit" class="btn-order">주문하기</button>
</form>
</div>
</div>
</div>
<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
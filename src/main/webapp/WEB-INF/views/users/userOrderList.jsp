<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
 	<meta charset="UTF-8">
 	<meta name="viewport" content="width=device-width, initial-scale=1.0">
 	<title>userOrderList</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<script>
    // 배송지 정보보기
    function nWin(orderIdx) {
    	var url = "${ctp}/shop/orderDelivery?orderIdx="+orderIdx;
    	window.open(url,"orderDelivery","width=400px,height=450px");
    }
    
    // 날짜기간에 따른 조건검색
    function myOrderStatus() {
        //var startDateOrder = document.getElementById("startOrder").value;
        //var endDateOrder = document.getElementById("endOrder").value;
        var conditionOrderStatus = document.getElementById("conditionOrderStatus").value;

        // 날짜 유효성 검사
/*         if (!startDateOrder || !endDateOrder) {
            alert("날짜를 입력하세요.");
            return;
        }
        if (new Date(startDateOrder) > new Date(endDateOrder)) {
            alert("시작 날짜가 종료 날짜보다 클 수 없습니다.");
            return;
        } */

        //location.href = "${ctp}/users/userOrderList?pag=${pageVO.pag}&startOrder=" + startDateOrder + "&endOrder=" + endDateOrder + "&conditionOrderStatus=" + conditionOrderStatus;
        location.href = "${ctp}/users/userOrderList?pag=${pageVO.pag}&conditionOrderStatus=" + conditionOrderStatus;
    }
  </script>
</head>
<body>
<c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
<c:set var="orderStatus" value="${orderStatus}"/>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="myOrderList" style="padding-top: 245.125px;">
<%-- <c:if test="${orderStatus eq ''}"><c:set var="orderStatus" value="전체"/></c:if> --%>
	<div class="container">
		<div class="row">
			<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
			<div class="col-xs-12 col-md-8">
  			<c:set var="condition" value="전체 조회"/>
  <h2>주문/배송 확인(${condition})</h2>
  <hr/>
  <table class="table table-borderless">
    <tr>
      <td style="text-align:left;">
<%--         <c:if test="${startOrder == null}">
           <c:set var="startOrder" value="<%=new java.util.Date() %>"/>
	        <c:set var="startOrder"><fmt:formatDate value="${startOrder}" pattern="yyyy-MM-dd"/></c:set>
        </c:if>
        <c:if test="${endOrder == null}">
          <c:set var="endOrder" value="<%=new java.util.Date() %>"/>
	        <c:set var="endOrder"><fmt:formatDate value="${endOrder}" pattern="yyyy-MM-dd"/></c:set>
        </c:if>
<input type="date" name="startOrder" id="startOrder" value="${startOrder}"/> ~ 
    <input type="date" name="endOrder" id="endOrder" value="${endOrder}"/> --%>
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
    <tr>
    	<td colspan="4" class="text-center"><c:if test="${empty orderList}">구매하신 상품이 없습니다.</c:if></td>
    </tr>
    <c:set var="sw" value="0"/>
    <c:set var="tempOrderIdx" value="0"/>
    <c:forEach var="vo" items="${orderList}" varStatus="st">
    	<!-- 같은 주문상품은 한번에 총 금액을 출력처리한다. -->
      <c:if test="${tempOrderIdx != vo.orderIdx}">
        <c:if test="${sw != 0}">
		      <tr class="bg-light">
		        <td colspan="4" class="p-0">
		          <div class="text-center m-3">주문번호 : ${tempOrderIdx} / 총 구입금액 : <fmt:formatNumber value="${tempOrderTotalPrice}" />원</div>
		        </td>
		      </tr>
	      </c:if>
        <c:set var="tempOrderIdx" value="${vo.orderIdx}" />
        <c:set var="tempOrderTotalPrice" value="${vo.orderTotalPrice}" />
	      <c:set var="sw" value="1"/>
      </c:if>
      
<tr>
    <td style="text-align:center;">
        <p>주문번호 : ${vo.orderIdx}</p>
        <p><b>총 주문액 : <font color="blue"><fmt:formatNumber value="${vo.totalPrice}"/>원</font></b></p>
        <p>
	        <c:if test="${not empty vo.orderIdx}">
			    <input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')">
			</c:if>
        </p>
        <p><b>배송 상태 : <span style="color: brown;">${vo.orderStatus}</span></b></p>
    </td>
    <td style="text-align:center;">
        <br/><img src="${ctp}/product/${vo.productThumb}" class="thumb" width="100px"/>
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
    <td style="text-align:center;">
        <br/>주문일자 : ${fn:substring(vo.orderDate,0,10)}<br/><br/>
        <font color="brown">${vo.orderStatus}</font><br/>
        <c:if test="${vo.orderStatus eq '결제완료'}">(배송준비중)</c:if>
    </td>
</tr>
      
      <c:if test="${st.last}">
        <c:set var="lastOrderTotalPrice" value="${vo.orderTotalPrice}"/>
        <c:set var="lastOrderIdx" value="${vo.orderIdx}"/>
      </c:if>
    </c:forEach>
    
    <tr class="bg-light">
      <td colspan="4" class="p-0">
        <div class="text-center m-3">주문번호 : ${lastOrderIdx} / 총 구입금액 : <fmt:formatNumber value="${lastOrderTotalPrice}" />원</div>
      </td>
    </tr>
    <tr><td colspan="4" class="p-0"></td></tr>
  </table>
  <!-- 블록 페이징처리 시작(BS4 스타일적용) -->
	<div>
		<ul class="pagination justify-content-center">
		    <c:if test="${pageVO.totPage == 0}">
		        <p style="text-align:center"><b>자료가 없습니다.</b></p>
		    </c:if>
		    <c:if test="${pageVO.totPage != 0}">
		        <li class="page-item ${pageVO.pag == 1 ? 'disabled' : ''}">
		            <a href="${ctp}/users/userOrderList?pag=1&startOrder=${startOrder}&endOrder=${endOrder}&conditionOrderStatus=${conditionOrderStatus}" class="page-link">◁◁</a>
		        </li>
		        <li class="page-item ${pageVO.curBlock == 0 ? 'disabled' : ''}">
		            <a href="${ctp}/users/userOrderList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&startOrder=${startOrder}&endOrder=${endOrder}&conditionOrderStatus=${conditionOrderStatus}" class="page-link">◀</a>
		        </li>
		        <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
		            <c:if test="${i <= pageVO.totPage}">
		                <li class="page-item ${i == pageVO.pag ? 'active' : ''}">
		                    <a href="${ctp}/users/userOrderList?pag=${i}&startOrder=${startOrder}&endOrder=${endOrder}&conditionOrderStatus=${conditionOrderStatus}" class="page-link">${i}</a>
		                </li>
		            </c:if>
		        </c:forEach>
		        <li class="page-item ${pageVO.curBlock >= pageVO.lastBlock ? 'disabled' : ''}">
		            <a href="${ctp}/users/userOrderList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&startOrder=${startOrder}&endOrder=${endOrder}&conditionOrderStatus=${conditionOrderStatus}" class="page-link">▶</a>
		        </li>
		        <li class="page-item ${pageVO.pag == pageVO.totPage ? 'disabled' : ''}">
		            <a href="${ctp}/users/userOrderList?pag=${pageVO.totPage}&startOrder=${startOrder}&endOrder=${endOrder}&conditionOrderStatus=${conditionOrderStatus}" class="page-link">▷▷</a>
		        </li>
		    </c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
		</div>
	</div>
</div>
</section>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
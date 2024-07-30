<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<html>
<head>
  <meta charset="UTF-8">
  <title>dbMyOrder.jsp(회원 주문확인)</title>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
  <script>
    // 배송지 정보보기
    function nWin(orderIdx) {
    	var url = "${ctp}/shop/orderDelivery?orderIdx="+orderIdx;
    	window.open(url,"orderDelivery","width=400px,height=450px");
    }
    
    // 날짜기간에 따른 조건검색
    function myOrderStatus() {
    	var startDateJumun = new Date(document.getElementById("startJumun").value);
    	var endDateJumun = new Date(document.getElementById("endJumun").value);
    	var conditionOrderStatus = document.getElementById("conditionOrderStatus").value;
    	
    	if((startDateJumun - endDateJumun) > 0) {
    		alert("주문일자를 확인하세요!");
    		return false;
    	}
    	
    	startJumun = moment(startDateJumun).format("YYYY-MM-DD");
    	endJumun = moment(endDateJumun).format("YYYY-MM-DD");
    	location.href="myOrderStatus?pag=${pageVO.pag}&startJumun="+startJumun+"&endJumun="+endJumun+"&conditionOrderStatus="+conditionOrderStatus;
    }
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
<c:set var="conditionOrderStatus" value="${conditionOrderStatus}"/>
<c:set var="orderStatus" value="${orderStatus}"/>
<%-- <c:if test="${orderStatus eq ''}"><c:set var="orderStatus" value="전체"/></c:if> --%>
<p><br/></p>
<div class="container">
  <c:set var="condition" value="전체 조회"/>
  <h2>주문/배송 확인(${condition})</h2>
  <hr/>
  <table class="table table-borderless">
    <tr>
      <td style="text-align:left;">날짜기간 및 조건검색 :
        <c:if test="${startJumun == null}">
          <c:set var="startJumun" value="<%=new java.util.Date() %>"/>
	        <c:set var="startJumun"><fmt:formatDate value="${startJumun}" pattern="yyyy-MM-dd"/></c:set>
        </c:if>
        <c:if test="${endJumun == null}">
          <c:set var="endJumun" value="<%=new java.util.Date() %>"/>
	        <c:set var="endJumun"><fmt:formatDate value="${endJumun}" pattern="yyyy-MM-dd"/></c:set>
        </c:if>
        <input type="date" name="startJumun" id="startJumun" value="${startJumun}"/>~<input type="date" name="endJumun" id="endJumun" value="${endJumun}"/>
        <select name="conditionOrderStatus" id="conditionOrderStatus">
          <option value="전체" ${conditionOrderStatus == '전체' ? 'selected' : ''}>전체</option>
          <option value="결제완료" ${conditionOrderStatus == '결제완료' ? 'selected' : ''}>결제완료</option>
          <option value="배송중"  ${conditionOrderStatus == '배송중' ? 'selected' : ''}>배송중</option>
          <option value="배송완료"  ${conditionOrderStatus == '배송완료' ? 'selected' : ''}>배송완료</option>
          <option value="구매완료"  ${conditionOrderStatus == '구매완료' ? 'selected' : ''}>구매완료</option>
          <option value="반품처리"  ${conditionOrderStatus == '반품처리' ? 'selected' : ''}>반품처리</option>
        </select>
        <input type="button" value="조회하기" onclick="myOrderStatus()"/>
      </td>
      <td style="text-align:right;">
	      <a href="${ctp}/dbShop/dbCartList" class="btn btn-success btn-sm">장바구니조회</a>
	      <a href="${ctp}/dbShop/dbProductList" class="btn btn-primary btn-sm">계속쇼핑하기</a>
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
    	<td colspan="4" class="text-center"><c:if test="${productVos.length == 0}">오늘 구매하신 상품이 없습니다.</c:if></td>
    </tr>
    <c:set var="sw" value="0"/>
    <c:set var="tempOrderIdx" value="0"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
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
          <%-- <p>총 주문액 : <fmt:formatNumber value="vo.totalPrice"/>원</p> --%>
          <p><b>총 주문액 : <font color="blue"><fmt:formatNumber value="${vo.totalPrice}"/>원</font></b></p>
          <p><input type="button" value="배송지정보" onclick="nWin('${vo.orderIdx}')"></p>
        </td>
        <td style="text-align:center;"><br/><img src="${ctp}/data/dbShop/product/${vo.thumbImg}" class="thumb" width="100px"/></td>
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
        <td style="text-align:center;"><br/>
          주문일자 : ${fn:substring(vo.orderDate,0,10)}<br/><br/>
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
	<div class="container">
		<ul class="pagination justify-content-center">
			<c:if test="${pageVO.totPage == 0}"><p style="text-align:center"><b>자료가 없습니다.</b></p></c:if>
			<c:if test="${pageVO.totPage != 0}">
			  <c:if test="${pageVO.pag != 1}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=1&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="첫페이지" class="page-link text-secondary">◁◁</a></li>
			  </c:if>
			  <c:if test="${pageVO.curBlock > 0}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="이전블록" class="page-link text-secondary">◀</a></li>
			  </c:if>
			  <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize)+1}" end="${(pageVO.curBlock*pageVO.blockSize)+pageVO.blockSize}">
			    <c:if test="${i == pageVO.pag && i <= pageVO.totPage}">
			      <li class="page-item active"><a href='${ctp}/dbShop/dbMyOrder?pag=${i}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}' class="page-link text-light bg-secondary border-secondary">${i}</a></li>
			    </c:if>
			    <c:if test="${i != pageVO.pag && i <= pageVO.totPage}">
			      <li class="page-item"><a href='${ctp}/dbShop/dbMyOrder?pag=${i}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}' class="page-link text-secondary">${i}</a></li>
			    </c:if>
			  </c:forEach>
			  <c:if test="${pageVO.curBlock < pageVO.lastBlock}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="다음블록" class="page-link text-secondary">▶</a>
			  </c:if>
			  <c:if test="${pageVO.pag != pageVO.totPage}">
			    <li class="page-item"><a href="${ctp}/dbShop/dbMyOrder?pag=${pageVO.totPage}&startJumun=${startJumun}&endJumun=${endJumun}&conditionOrderStatus=${conditionOrderStatus}" title="마지막페이지" class="page-link" style="color:#555">▷▷</a>
			  </c:if>
			</c:if>
		</ul>
	</div>
	<!-- 블록 페이징처리 끝 -->
<p><br/></p>
</div>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
</body>
</html>
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
	<title>orderList</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
  	<script>
  		function updateOrderStatus(orderIdx, orderNumber, orderStatus) {
			if(!confirm("현재 상태: " + orderStatus + "\n주문 상태를 변경하시겠습니까?")) return;
			
			$.ajax({
				type: "POST",
				url: "${ctp}/admin/order/updateStatus",
				data: {
					orderIdx: orderIdx,
					orderNumber: orderNumber
				},
				success: function(response) {
					alert(response.message);
					location.reload();
				},
				error: function(xhr) {
					try {
						let errorResponse = Json.parse(xhr.responseText);					
						alert("주문 상태 변경 실패: " + errorResponse.message);
					} catch (e) {
						alert("주문 상태 변경 실패: 서버 오류 발생");
					}
				}
			});
		}
		
		function cancelOrder(orderIdx) {
			if(!confirm("주문을 취소하시겠습니까?")) return;
			
			$.ajax({
				type: "POST",
				url: "${ctp}/admin/order/cancel",
				data: {orderIdx: orderIdx},
				success: function(response) {
					alert(response.message);
					location.reload();
				},
				error: function(xhr) {
					try {
						let errorResponse = JSON.parse(xhr.responseText);
						alert("주문 취소 실패: " + errorResponse.message);
					} catch (e) {						
						alert("주문 취소 실패: 서버 오류 발생");
					}
				}
			});
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
            <div class="page-breadcrumb">
                <div class="row">
                    <div class="col-5 align-self-center">
                        <div class="d-flex align-items-center">
                            <nav aria-label="breadcrumb">
                                <ol class="breadcrumb m-0 p-0">
                                    <li class="breadcrumb-item"><a href="${ctp}/main"><i class="fa-solid fa-house"></i> 메인페이지로</a>
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container-fluid">

                <div class="row">
                    <div class="col-12">
                        <div class="card p-3">
					        <div class="card-body text-center">
					            <h2 class="card-title">주문 목록</h2>
					            <div class="table-responsive">
					                <table class="table table-hover">
					                    <thead class="bg-success text-white">
					                        <tr>
					                            <th>번호</th>
					                            <th>아이디</th>
					                            <th>총금액</th>
					                            <th>쿠폰사용여부</th>
					                            <th>포인프사용여부</th>
					                            <th>주문상태</th>
					                            <th>주문일자</th>
					                            <th>비고</th>
					                        </tr>
					                    </thead>
					                    <tbody>
					                    	<c:forEach var="orderVO" items="${orderVOS}" varStatus="st">
					                        <tr>
					                            <td>${st.count}</td>
					                            <td>${orderVO.userId}</td>
					                            <td><fmt:formatNumber value="${orderVO.totalPrice}"/>원</td>
					                            <td>${orderVO.couponIdx !=null ? 'Y' : 'N'}</td>
					                            <td>${orderVO.pointUse !=0 ? 'Y' : 'N'}</td>
					                            <td>${orderVO.orderStatus}</td>
					                            <td>${fn:substring(orderVO.orderDate,0,19)}</td>
					                 		    <td>
						                           	<a type="button" class="badge badge-info text-light mr-1" onclick="updateOrderStatus('${orderVO.orderIdx}', '${orderVO.orderNumber}', '${fn:escapeXml(orderVO.orderStatus)}')">처리</a>
						                           	<a type="button" class="badge badge-danger text-light" onclick="cancelOrder('${orderVO.orderIdx}')">취소</a>
					                           </td>
					                        </tr>
					                        </c:forEach>
					                    </tbody>
					                </table>
					            </div>
					        </div>
    					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
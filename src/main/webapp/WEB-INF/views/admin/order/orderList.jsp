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
						let errorResponse = JSON.parse(xhr.responseText);					
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
		
		// 주문 검색
		function searchOrders() {
			let searchType = $("#searchType").val();
			let searchKeyword = $("#searchKeyword").val();
			let orderStatus = $("#filterStatus").val();
			let startDate = $("#startDate").val();
			let endDate = $("#endDate").val();
			
			location.href = "${ctp}/admin/order/orderList?searchType=" + searchType
					+ "&searchKeyword=" + searchKeyword
					+ "&orderStatus=" + orderStatus
					+ "&startDate=" + startDate
					+ "&endDate=" + endDate;
		}
		
		// 선택한 주문 상태 일괄 변경
		function allUpdateOrderStatus() {
			let selectedOrders = [];
			$(".orderCheckbox:checked").each(function () {
				selectedOrders.push($(this).val());
			});
			
			if (selectedOrders.length === 0) {
				alert("상태를 변경하실 주문을 선택하세요!");
				return;
			}
			
			let nextStatus = $("#allStatus").val();
			if (!confirm("선택한 주문을 '" + nextStatus + "' 상태로 변경하시겠습니까?")) return;
			
			$.ajax({
				type: "POST",
				url: "${ctp}/admin/order/allUpdateStatus",
				data: {orderIds: selectedOrders, nextStatus: nextStatus},
				traditional: true,
				success: function (response) {
					alert(response.message);
					location.reload();
				},
				error: function (xhr) {
					alert("일괄 상태 변경 실패: " + xhr.responseText);
				}
			});
		}
		
		// 전체 선택/해제 가능
		$(document).ready(function() {
			$("#selectAll").click(function() {
				$(".orderCheckbox").prop("checked", this.checked);
			});
			
			$(".orderCheckbox").click(function (){
				if($(".orderCheckbox:checked").length == $(".orderCheckbox").length) {
					$("#selectAll").prop("checked", true);
				} else {
					$("#selectAll").prop("checked", false);
				}
			});
		});
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
					            
					            <!-- 필터 & 검색 -->
					            <div class="row mb-3">
					            	<div class="col-md-2">
					            		<select id="searchType" class="form-control">
					            			<option value="userId">아이디</option>
					            			<option value="orderNumber">주문번호</option>
					            			<option value="productName">상품명</option>
					            		</select>
					            	</div>
					            	<div class="col-md-3">
					            		<input type="text" id="searchKeyword" class="form-control" placeholder="검색어를 입력">
					            	</div>
					            	<div class="col-md-2">
					            		<select id="filterStatus" class="form-control">
					            			<option value="">전체</option>
					            			<option value="주문">주문</option>
					            			<option value="배송 준비 중">배송 준비 중</option>
					            			<option value="배송 중">배송 중</option>
					            			<option value="배송 완료">배송 완료</option>
					            			<option value="취소됨">취소됨</option>
					            		</select>
					            	</div>
					            	<div class="col-md-2">
					            		<input type="date" id="startDate" class="form-control">
					            	</div>
					            	<div class="col-md-2">
					            		<input type="date" id="endDate" class="form-control">
					            	</div>
					            	<div class="col-md-1">
					            		<button class="btn btn-primary" onclick="searchOrders()">검색</button>
					            	</div>
					            </div>
					            
					            <!-- 일괄 처리 -->
					            <div class="row md-3">
					            	<div class="col-md-3">
										<select id="allStatus" class="form-control">
											<option value="배송 준비 중">배송 준비 중</option>
											<option value="배송 중">배송 중</option>
											<option value="배송 완료">배송 완료</option>
										</select>
					            	</div>
					            	<div class="col-md-3">
					            		<button class="btn btn-warning" onclick="allUpdateOrderStatus()">일괄 상태 변경</button>
					            	</div>
					            </div>
					            
					            <div class="table-responsive">
					                <table class="table table-hover">
					                    <thead class="bg-success text-white">
					                        <tr>
					                        	<th><input type="checkbox" id="selectAll"></th>
					                            <th>번호</th>
					                            <th>주문번호</th>
					                            <th>아이디</th>
					                            <th>총금액</th>
					                            <th>주문상태</th>
					                            <th>주문일자</th>
					                            <th>비고</th>
					                        </tr>
					                    </thead>
					                    <tbody>
					                    	<c:forEach var="orderVO" items="${orderVOS}" varStatus="st">
					                        <tr>
					                        	<td></td>
					                            <td>${orderVO.orderIdx}</td>
					                            <td>${orderVO.userId}</td>
					                            <td><fmt:formatNumber value="${orderVO.totalPrice}"/>원</td>
					                            <%-- <td>${orderVO.couponIdx !=null ? 'Y' : 'N'}</td>
					                            <td>${orderVO.pointUse !=0 ? 'Y' : 'N'}</td> --%>
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
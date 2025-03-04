<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userAddressInput</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  	<script src="${ctp}/js/woo.js"></script>
  	<script>
  		'use strict';
  		
  		$(document).ready(function() {
	  		// 배송지 추가 버튼 클릭 => 모달 열기
	  		$("#addAddressBtn").click(function() {
	  			$("#addressForm")[0].reset();  // 폼 초기화
	  			$("#deliveryAddressIdx").val("");  // 새로운 주소 추가이므로 ID 비우기
	  			$("#addressModal").modal("show");
	  		});
  		
  			// 배송지 추가 요청
	  		$("#addressForm").submit(function(event) {
	  			event.preventDefault();
	  			
	  			let formData = {
					postcode: $("#sample6_postcode").val().trim(),
			        roadAddress: $("#sample6_address").val().trim(),
			        detailAddress: $("#sample6_detailAddress").val().trim(),
			        extraAddress: $("#sample6_extraAddress").val().trim(),
		            defaultAddress: $("#defaultAddress").prop("checked")
	  			};
		            
	            if (!formData.postcode || !formData.roadAddress || !formData.detailAddress) {
		            alert("모든 필수 정보를 입력하세요.");
		            return;
		        }
	   
				// AJAX로 서버에ㅔ 전송
		        console.log("전송할 데이터:", formData);
				
		        $.ajax({
		            url: "${ctp}/users/userAddressInput",
		            type: "POST",
		            contentType: "application/json",
		            data: JSON.stringify({
		                address: $("#sample6_postcode").val().trim() + " " +
		                $("#sample6_address").val().trim() + " " +
		                $("#sample6_detailAddress").val().trim() + " " +
		                $("#sample6_extraAddress").val().trim(),
		                defaultAddress: $("#defaultAddress").prop("checked") ? "Y" : "N"
		            }),
		            success: function(response) {
		                alert(response.msg);
		                location.reload();
		            },
		            error: function() {
		                alert("배송지 저장에 실패했습니다.");
		            }
		        });
	  		});
  		});
  		
  		// 배송지 삭제
  		function deleteAddress(addressId) {
  			if(!confirm("정말 삭제하시겠습니까?")) return;
  			
  			$.ajax({
  				url: "${ctp}/users/deleteAddress/" + addressId,
  				type: "POST",
  			    contentType: "application/json",
  				success: function(response) {
  					alert("삭제되었습니다.");
  					location.reload();
  				},
  				error: function() {
  					alert("삭제에 실패했습니다.");
  				}
  			});
  		}
  		
  		// 대표 배송지 설정
  		function setDefaultAddress(addressId) {
  			$.ajax({
  				url: "${ctp}/users/setDefaultAddress/" + addressId,
  				type: "POST",
  				success: function(response) {
  					alert("대표 배송지가 설정되었습니다.");
  					location.reload();
  				},
  				error: function() {
  					alert("설정에 실패했습니다.");
  				}
  			});
  		}
  	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="userAddress" style="padding-top: 245.125px;">
	<div class="container">
		<div class="row">
			<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
			<div class="col-xs-12 col-md-8">
				<div>
					<h3>나의 주소록</h3>
					<ul class="list">
						<li>자주 사용하시는 배송지는 주소록에 등록 해 두시면 편리하게 이용하실 수 있습니다.</li>
						<li>배송지는 기본 배송지를 포함하여 3개 까지 등록하실 수 있습니다.</li>
					</ul>
				</div>
				<div class="mySection">
					<fieldset>
						<table class="table table-bordered">
							<thead>
								<tr>
									<th scope="col">배송지명</th>
									<th scope="col">주소</th>
									<th scope="col">대표</th>
									<th scope="col">관리</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="address" items="${addressList}" varStatus="loop">
									<tr>
										<td>배송지 ${loop.index + 1}</td>
										<td>${address.address}</td>
										<td>
											<c:choose>
												<c:when test="${address.defaultAddress eq 'Y'}">
													<span class="badge badge-success">대표</span>
												</c:when>
												<c:otherwise>
													<button type="button" class="btn btn-sm btn-outline-primary" 
														onclick="setDefaultAddress(${address.deliveryAddressIdx})">설정</button>
												</c:otherwise>
											</c:choose>
										</td>
										<td>
											<button type="button" class="btn btn-sm btn-danger" onclick="deleteAddress(${address.deliveryAddressIdx})">삭제</button>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${fn:length(addressList) < 3}">
									<tr>
										<td colspan="4" class="text-center">
											<button type="button" id="addAddressBtn" class="btn btn-primary">새 배송지 추가</button>
										</td>
									</tr>
								</c:if>
							</tbody>
						</table>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
</section>
<p><br></p>
<div class="modal fade" id="addressModal" tabindex="-1" role="dialog">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">배송지 관리</h5>
				<button type="button" class="close" data-dismiss="modal">&times;</button>
			</div>
			<div class="modal-body">
				<form id="addressForm">
                    <div class="form-group">
                    	<label>우편번호</label>
                        <div class="input-group mb-1">
							<input type="text" id="sample6_postcode" class="form-control" readonly>
                            <div class="input-group-append">
                                <button type="button" class="btn btn-secondary" onclick="sample6_execDaumPostcode()">우편번호 찾기</button>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>도로명 주소</label>
                        <input type="text" id="sample6_address" class="form-control" readonly>
                    </div>

                    <div class="form-group">
                        <label>상세 주소</label>
                        <input type="text" id="sample6_detailAddress" class="form-control">
                    </div>

                    <div class="form-group">
                        <label>참고 항목</label>
                        <input type="text" id="sample6_extraAddress" class="form-control" readonly>
                    </div>
                    
                    <div class="form-check">
                        <input type="checkbox" class="form-check-input" id="defaultAddress">
                        <label class="form-check-label" for="defaultAddress">기본 배송지로 설정</label>
                    </div>

                    <button type="submit" class="btn btn-primary">저장</button>
				</form>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>userAddressInput</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  	<script src="${ctp}/js/woo.js"></script>
  	<script>
  		$(document).ready(function() {
	  		// 배송지 추가 버튼 클릭 => 모달 열기
	  		$("#addAddressBtn").click(function() {
	  			$("#addressForm")[0].reset();  // 폼 초기화
	  			$("#deliveryAddressId").val("");  // 새로운 주소 추가이므로 ID 비우기
	  			$("#addressModal").modal("show");
	  		});
  		
  			// 배송지 추가 요청
	  		$("#addressForm").submit(function(event) {
	  			event.preventDefault();
	  			
				let postcode = $("#sample6_postcode").val().trim();
		        let roadAddress = $("#sample6_address").val().trim();
		        let detailAddress = $("#sample6_detailAddress").val().trim();
		        let extraAddress = $("#sample6_extraAddress").val().trim();
				
				// 주소를 하나로 합쳐서 저장
				//let fullAddress = postcode + " / " + roadAddress + " / " + detailAddress + " / " + extraAddress;
				let fullAddress = `${postcode} / ${roadAddress} / ${detailAddress} / extraAddress`;
	  			
				if ($("#address1").val() === "") {
					$("#address1").val(fullAddress);
				}
				// address1이 있으면 address2로 이동
				else if ($("#address2").val() === "") {
					$("#address2").val(fullAddress);
				}
				else if ($("#address3").val() === "") {
					$("#address3").val(fullAddress);
				}
				// 3개가 다 차있으면 삭제해야 함
				else {
					alert("최대 3개의 주소만 저장할 수 있습니다. 기존 주소를 삭제하세요.");
					return;
				}
				
				// AJAX로 서버에ㅔ 전송
				let formData = $(this).serialize();
		        console.log("전송할 데이터:", formData);
				
	  			$.ajax({
	  				url: "/users/userAddressInput",
	  				type: "POST",
	  				data: formData,
	  				success: function(response) {
	  					alert(response.msg);
	  					location.reload();  // 페이지 새로고침
	  				},
	  				error: function() {
	  					alert("배송지 저장에 실패했습니다.");
	  				}
	  			});
	  		});
  		});
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
							<colgroup>
								<col width="120"> <col width="88"> <col width="*"> <col width="110"> <col width="110"> <col width="130">
							</colgroup>
							<thead>
							<tr>
								<th scope="col">배송지명</th>
								<th scope="col">수령인</th>
								<th scope="col">주소</th>
								<th scope="col">휴대폰</th>
								<th scope="col">이메일</th>
								<th scope="col">관리</th>
							</tr>
							</thead>
							<tbody>
								<!-- 등록된 배송지가 없는 경우 -->
								<c:if test="${empty addressList}">
									<tr>
										<td colspan="6" class="text-center">등록된 배송지가 없습니다.</td>
									</tr>
									<tr>
										<td colspan="6" class="text-center">
											<button type="button" id="addAddressBtn" class="btn btn-primary">새 배송지 추가</button>
										</td>
									</tr>
								</c:if>
								
								<!-- 등록된 배송지가 있는 경우 -->
								<c:forEach var="address" items="${addressList}" varStatus="loop">
									<tr>
										<td>배송지 ${loop.index + 1}</td>
										<td class="lt">${address.adress1} ${address.adress2} ${address.adress3}</td>
										<td>
											<button type="button" onclick ="deleteAddress(${address.deliveryAddressId})" class="btn btnS2 btnGry2 fn">삭제</button>
										</td>
									</tr>
								</c:forEach>
								
								<!-- 배송지가 3개 미만일때 추가 버튼 -->
								<c:if test="${fn:length(addressList) < 3}">
									<tr>
										<td colspan="6" class="text-center">
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
<div class="modal fade" id="addressModal" tabindex="-1" role="dialog" aria-labelledby="addressModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="addressModalLabel">배송지 관리</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="addressForm">
					<input type="hidden" id="deliveryAddressId" name="deliveryAddressId" />
					
                    <div class="form-group">
                        <label for="address1">주소</label>
                        <div class="input-group mb-1">
                            <input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" class="form-control" readonly>
                            <div class="input-group-append">
                                <button type="button" onclick="sample6_execDaumPostcode()" class="btn btn-secondary">우편번호 찾기</button>
                            </div>
                        </div>
                        <input type="text" name="roadAddress" id="sample6_address" placeholder="도로명 주소" class="form-control mb-1" readonly>
                        <div class="input-group mb-1">
                            <input type="text" name="detailAddress" id="sample6_detailAddress" placeholder="상세주소" class="form-control">
                            <div class="input-group-append">
                                <input type="text" name="extraAddress" id="sample6_extraAddress" placeholder="참고항목" class="form-control" readonly>
                            </div>
                        </div>
                    </div>
                    
                    <!-- 최종 주소를 자동으로 저장할 필드 -->
                    <div class="form-group">
                        <label for="address1">최종 주소</label>
                        <input type="text" id="address1" name="address1" class="form-control" readonly>
                    </div>
                    
                    <!-- 추가 주소 -->
                    <div class="form-group">
                        <label for="address2">추가 주소 (선택)</label>
                        <input type="text" id="address2" name="address2" class="form-control" readonly>
                    </div>

                    <div class="form-group">
                        <label for="address3">추가 주소 (선택)</label>
                        <input type="text" id="address3" name="address3" class="form-control" readonly>
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
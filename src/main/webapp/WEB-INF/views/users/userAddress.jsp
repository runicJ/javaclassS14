<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>userAddressInput</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  	<script src="${ctp}/js/woo.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<p><br/></p>
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
							<tr>
								<td></td>
								<td></td>
								<td class="lt"></td>
								<td></td>
								<td></td>
								<td>
									<a href="${ctp}/users/userAddressInput" onclick="${ctp}/users/userAddressInput" onfocus="blur()" class="btn btnS2 btnGry2 fn">수정</a>
									<a href="${ctp}/users/userAddressDelete;" onfocus="blur()" class="btn btnS2 btnGry2 fn">삭제</a>
								</td>
							</tr>
							</tbody>
						</table>
					</fieldset>
				</div>
			</div>
		</div>
	</div>
</section>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
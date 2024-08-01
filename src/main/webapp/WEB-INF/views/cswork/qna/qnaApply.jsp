<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>qnaApply</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
	<section class="page">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<h1 class="page-title text-center mb-2">문의하기</h1>
					<p class="page-subtitle text-center mt-2">'괄호 안 쉼표'에서는 회원님의 목소리에<br>항상 귀 기울이고 있습니다.</p>
					<div class="line thin"></div>
					<div class="page-description">
						<div class="row">
							<div class="col-md-6 col-sm-6">
								<h3>괄호 안 쉼표</h3>
								<h5>Pause In Parentheses</h5>
								<p>문의하신 내용은 마이페이지에서 답변 확인 가능합니다.</p>
								<p>
									연락처 <br>
									<span class="bold">043 - 225 - 2111</span>
									<br>
									이용가능시간 <br>
									<span class="bold">평일 09:00 ~ 22:30 | 토요일 09:00 ~ 18:30</span>
									<br><br>
									주소 <br>
									<span class="bold">충청북도 청주시 서원구 사직대로 109, 4,5층</span>
								</p>
							</div>
							<div class="col-md-6 col-sm-6">
								<form class="row contact" id="contact-form">
									<div class="col-md-6">
										<div class="form-group">
											<label>신청자<br>(비회원은 성함을 기입해주세요) <span class="required"></span></label>
											<input type="text" class="form-control" name="name" value="${!empty sUid ? sUid : ''}" required>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>이메일<br>(비회원은 이메일 필수사항입니다.) <c:if test="${empty sUid}"><span class="required"></span></c:if></label>
											<input type="text" class="form-control" name="email" required>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label>문의유형 </label>
											<input type="text" class="form-control" name="subject" placeholder="예) 알레르기 정보, 상품, 신고 등">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label>문의내용 <span class="required"></span></label>
											<textarea class="form-control" name="message" required></textarea>
										</div>
									</div>
									<div class="col-md-12 mt-3 text-center">
										<button class="btn btn-primary mr-2">문의 신청하기</button>
										<button class="btn btn-warning">카카오톡 문의하기</button>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
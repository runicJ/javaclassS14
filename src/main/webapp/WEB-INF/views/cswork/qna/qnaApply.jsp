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
          <ol class="breadcrumb">
          	<li><a href="#">메인페이지</a></li>
            <li class="active">광고 신청 문의</li>
          </ol>
					<h1 class="page-title">문의하기</h1>
					<p class="page-subtitle">회원님의 목소리에 항상 귀 기울이고 있습니다.</p>
					<div class="line thin"></div>
					<div class="page-description">
						<div class="row">
							<div class="col-md-6 col-sm-6">
								<h3>문의사항</h3>
								<p>문의하신 내용은 마이페이지에서 답변 확인 가능합니다.</p>
								<p>
									Phone: <span class="bold">+123 45 678 9</span> <br>
									Email: <span class="bold">hi@yourcompany.com</span>
									<br>
									<br>
									Syarifuddin Street<br>
									Indonesia, Bogor Barat 16115
								</p>
							</div>
							<div class="col-md-6 col-sm-6">
								<form class="row contact" id="contact-form">
									<div class="col-md-6">
										<div class="form-group">
											<label>Name <span class="required"></span></label>
											<input type="text" class="form-control" name="name" required="">
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>Email <span class="required"></span></label>
											<input type="text" class="form-control" name="email" required="">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label>Subject</label>
											<input type="text" class="form-control" name="subject" placeholder="예) 알레르기 정보, 상품, 신고 등">
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<label>Your message <span class="required"></span></label>
											<textarea class="form-control" name="message" required=""></textarea>
										</div>
									</div>
									<div class="col-md-12">
										<button class="btn btn-primary">Send Message</button>
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
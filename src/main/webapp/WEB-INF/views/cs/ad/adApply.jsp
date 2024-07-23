<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
	<link rel="icon" type="image/png" href="ctp/images/favicon-mark.png">
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
						<h1 class="page-title">Contact Us</h1>
						<p class="page-subtitle">We hear you</p>
						<div class="line thin"></div>
						<div class="page-description">
							<div class="row">
								<div class="col-md-6 col-sm-6">
									<h3>Contact</h3>
									<p>
										Aliquam in maximus massa. In magna dolor, efficitur vitae faucibus sagittis, elementum quis lacus. Aliquam pretium sem lectus, vitae gravida ex efficitur vitae.
									</p>
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
												<input type="text" class="form-control" name="subject">
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

		<section class="maps">
			<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d7927.32512614206!2d106.75366058323345!3d-6.564206896052583!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x0%3A0x1377e9bdc02eea68!2zNsKwMzMnNDkuOCJTIDEwNsKwNDUnMjAuNiJF!5e0!3m2!1sen!2sid!4v1495165466482" width="100%" height="450" frameborder="0" style="border:0" allowfullscreen></iframe>
		</section>
<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
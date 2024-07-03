<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userLogin</title>
  	<%@ include file = "/WEB-INF/views/include/bs4.jsp"%>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/header.jsp"%>
<%@ include file = "/WEB-INF/views/include/nav.jsp"%>
	<section class="login first grey">
		<div class="container">
			<div class="box-wrapper">				
				<div class="box box-border">
					<div class="box-body">
						<h4>Login</h4>
						<form>
							<div class="form-group">
								<label>아이디</label>
								<input type="text" name="uid" id="uid" class="form-control">
							</div>
							<div class="form-group">
								<label class="fw">Password
									<a href="forgot.html" class="pull-right">Forgot Password?</a>
								</label>
								<input type="password" name="pwd" id="pwd" class="form-control">
							</div>
							<div class="form-group text-right">
								<button class="btn btn-primary btn-block">로그인</button>
							</div>
							<div class="form-group text-center">
								<span class="text-muted">아직 계정이 없으신가요?</span> <a href="${ctp}/users/userRegister">회원가입</a>
							</div>
							<div class="title-line">
								or
							</div>
             				<a href="#" class="btn btn-social btn-block facebook"><i class="ion-social-facebook"></i> Login with Google</a>
             				<a href="#" class="btn btn-social btn-block facebook"><i class="ion-social-facebook"></i> Login with Kakao</a>
             				<a href="#" class="btn btn-social btn-block facebook"><i class="ion-social-facebook"></i> Login with Naver</a>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@ include file = "/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
  	<%@ include file = "/WEB-INF/views/include/bs4.jsp"%>
<title>title</title>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/header.jsp"%>
<%@ include file = "/WEB-INF/views/include/nav.jsp"%>
<p><br/></p>
<div class="container">
	<section class="login first grey">
		<div class="container">
			<div class="box-wrapper">				
				<div class="box box-border">
					<div class="box-body">
						<h4>회원 가입</h4>
						<form>
							<div class="form-group">
								<label>아이디</label>
								<input type="text" name="name" class="form-control">
							</div>
							<div class="form-group">
								<label class="fw">비밀번호</label>
								<input type="password" name="password" class="form-control">
							</div>
							<div class="form-group">
								<label class="fw">비밀번호 확인</label>
								<input type="password" name="password" class="form-control">
							</div>
							<div class="form-group">
								<label>이름</label>
								<input type="text" name="name" class="form-control">
							</div>
							<div class="form-group">
								<label>닉네임</label>
								<input type="text" name="username" class="form-control">
							</div>
							<div class="form-group">
								<label>이메일</label>
								<input type="email" name="email" class="form-control">
							</div>
							<div class="form-group">
								<label>연락어</label>
								<input type="email" name="email" class="form-control">
							</div>

							<div class="form-group text-right">
								<button class="btn btn-primary btn-block">Register</button>
							</div>
							<div class="form-group text-center">
								<span class="text-muted">Already have an account?</span> <a href="login.html">Login</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</div>
<p><br/></p>
<%@ include file = "/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
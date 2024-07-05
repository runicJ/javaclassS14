<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=divice-width, initial-scale=1.0">
<title>userFindId</title>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</head>
<body>
	<img src="${ctp}/images/logo.png" alt="logo" style="width:100px;height:auto;"/>
	<section class="login first grey">
		<div class="container">
			<div class="box-wrapper">				
				<div class="box box-border">
					<div class="box-body">
						<h4 class="text-center">아이디 찾기</h4>
						<form>
							<div class="form-group">
								<label>이름</label>
								<input type="text" name="name" id="name" class="form-control">
							</div>
							<div class="form-group">
								<label>이메일</label>
								<input type="email" name="email" id="email" class="form-control">
							</div>
							<div class="form-group text-right">
								<button class="btn btn-primary btn-block">아이디 검색</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
</body>
</html>
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
						<h4 class="text-center">로그인</h4>
						<form name="myform" method="post">
							<div class="form-group">
								<label class="fw">아이디
									<a href="${ctp}/users/userFindId" class="float-right">아이디를 잊으셨나요?</a>
								</label>
								<input type="text" name="userId" id="userId" class="form-control">
							</div>
							<div class="form-group">
								<label class="fw">비밀번호
									<a href="${ctp}/users/userFindPw" class="float-right">비밀번호를 잊으셨나요?</a>
								</label>
								<input type="password" name="userPwd" id="userPwd" class="form-control">
							</div>
							<div class="form-group text-right">
								<button class="btn btn-primary btn-block" onclick="location.href='${ctp}/users/userLoginOk';">로그인</button>
							</div>
							<div class="form-group">
					    		<input type="checkbox" name="idSave" checked /> 아이디 저장
								<p class="float-right"><span class="text-muted">아직 계정이 없으신가요? </span><a href="${ctp}/users/userRegister">회원가입</a></p>
							</div>
							<div class="title-line">
								or
							</div>
             				<a href="#" class="btn btn-logo btn-block facebook"><i class="ion-logo-google"></i> Login with Google</a>
             				<a href="#" class="btn btn-social btn-block facebook"><i class="ion-social-facebook"></i> Login with Kakao</a>
             				<a href="#" class="btn btn-social btn-block facebook"><i class="ion-social-facebook"></i> Login with Naver</a>
						</form>
				    	<table class="table table-bordered p-0">
					      <tr>
					        <td class="text-center">
					        </td>
					      </tr>
					   </table>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@ include file = "/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
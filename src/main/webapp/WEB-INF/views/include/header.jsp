<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<header class="primary">
	<div class="firstbar">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-12">
					<div class="brand">
						<a href="http://localhost:9090/javalclassS14">
							<img src="${ctp}/basic/logo.png" alt="Magz Logo">
						</a>
					</div>						
				</div>
				<div class="col-md-6 col-sm-12">
					<form class="search" autocomplete="off">
						<div class="form-group">
							<div class="input-group">
								<input type="text" name="q" class="form-control" placeholder="Type something here">									
								<div class="input-group-btn">
									<button class="btn btn-primary"><i class="ion-search"></i></button>
								</div>
							</div>
						</div>
						<div class="help-block">
							<div>Popular:</div>
							<ul>
								<li><a href="#">HTML5</a></li>
								<li><a href="#">CSS3</a></li>
								<li><a href="#">Bootstrap 3</a></li>
								<li><a href="#">jQuery</a></li>
								<li><a href="#">AnguarJS</a></li>
							</ul>
						</div>
					</form>								
				</div>
				<div class="col-md-3 col-sm-12 text-right">
					<ul class="nav-icons">
						<li><a href="${ctp}/users/userRegister"><i class="ion-person-add"></i><span>회원가입</span></a></li>
						<li><a href="${ctp}/users/userLogin"><i class="ion-person"></i><span>로그인</span></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>

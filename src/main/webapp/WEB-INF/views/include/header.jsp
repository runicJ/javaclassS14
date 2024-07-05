<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<header class="primary">
	<div class="firstbar">
		<div class="container">
			<div class="row">
				<div class="col-md-3 col-sm-12">
					<div class="brand">
						<a href="http://localhost:9090/javaclassS14/main">
							<img src="${ctp}/images/logo.png" alt="myLogo">
						</a>
					</div>						
				</div>
				<div class="col-md-6 col-sm-12">
					<form class="search" autocomplete="off">
						<div class="form-group">
							<div class="input-group">
								<input type="text" name="q" class="form-control" placeholder="당신의 걱정을 털어내세요">									
								<div class="input-group-btn">
									<button class="btn btn-primary"><i class="ion-search"></i></button>
								</div>
							</div>
						</div>
						<div class="help-block">
							<div>인기검색어:</div>
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
						<c:if test="${empty sUid}">
							<li><a href="${ctp}/users/userRegister"><i class="ion-person-add"></i><span>회원가입</span></a></li>
							<li><a href="${ctp}/users/userLogin"><i class="ion-person"></i><span>로그인</span></a></li>
						</c:if>
						<c:if test="${!empty sUid}">
							<c:if test="${sUid == 'admin'}">
								<li><a href="${ctp}/admin/adminMain"><i class="ion-person"></i><span>관리자페이지</span></a></li>
							</c:if>
							<c:if test="${sUid != 'admin'}">
								<li><a href="${ctp}/users/userMain"><i class="ion-person"></i><span>마이페이지</span></a></li>
							</c:if>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>

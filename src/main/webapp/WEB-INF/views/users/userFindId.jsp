<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userFindId</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<style>
		.box {
		  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
		  transition: 0.3s;
		}
		
		.box:hover {
		  background-color: #dbe4e6;
		}
	</style>
	<script>
		'use strict';
		
		$(document).keydown(function(e){
		    let code = e.keyCode || e.which;
		 
		    if (code == 27) { // 27은 ESC 키번호
		    	window.close();
		    }
		});
		
		function userFindId() {
			let name = $('#name').val();
			let email = $('#email').val();
			
			if (name.trim() == "" || email.trim() == "") {
				alert("이름과 이메일을 입력하세요.");
				return false;
			}
			
			$.ajax({
				url : "${ctp}/users/userFindId",
				type : "post",
				data : {
					name : name,
					email : email
				},
				success: function(resMap) {
					if(resMap.res == "1") {
						let userId = resMap.userId;
						let createDate = resMap.createDate;
						let blurLength = Math.ceil(userId.length / 2);
						let maskingId = userId.substring(0, blurLength) + '*'.repeat(userId.length - blurLength);
						alert("회원 아이디: " + maskingId + " (가입일: " + createDate + ")");
						window.close(); // 현재 창 닫기
						//opener.location.href = "${ctp}/users/userLogin"; // 부모 창을 로그인 페이지로
						window.opener.location.reload();
					} 
					else {
						alert("입력하신 정보와 일치하는 계정이 존재하지 않습니다.\n회원정보를 확인해주세요!");
						$('#name').focus();
						$('#name').val("");
						$('#email').val("");
						$('#name').focus();
					}
				},
				error: function() {
					alert("전송오류!");
				}	
			});
		}
	</script>
</head>
<body>
	<div class="container align-middle text-center">
	<div class="mt-5 mb-3"><img src="${ctp}/images/logo.png" alt="logo" style="width:150px;height:auto;"/></div>
		<div class="box-wrapper" style="width:400px;">
			<div class="box box-border">
				<div class="box-body">
					<h4>아이디 찾기</h4>
					<form name="myform" method="post">
						<div class="input-group mb-3">
							<div class="input-group-prepend"><span class="input-group-text"> 이 름 </span></div>
							<input type="text" name="name" id="name" class="form-control">
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend"><span class="input-group-text">이메일</span></div>
							<input type="email" name="email" id="email"class="form-control">
						</div>
						<div class="text-center">
							<input type="button" class="btn btn-info mt-3 mr-2" value="아이디 검색" onclick="userFindId()">
							<button class="btn btn-danger mt-3" onclick="window.close();">취소</button>
						</div>
					</form>
					<!-- <div id="demo" style="color:red;font-weight:bold;"></div> -->
				</div>
			</div>
		</div>
	</div>
</body>
</html>
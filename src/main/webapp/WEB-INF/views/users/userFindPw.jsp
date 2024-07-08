<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>userFindPw</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
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
		'use strict'
		
		$(document).keydown(function(e){
		    let code = e.keyCode || e.which;
		 
		    if (code == 27) { // 27은 ESC 키번호
		    	window.close();
		    }
		});
		
		function userFindPw() {
	    	let userId = $("#userId").val().trim();
	    	let email = $("#email").val().trim();
	    	
	    	if(userId == "" || email == "") {
	    		alert("회원님의 아이디와 이메일 주소를 입력하세요");
	    		$("#userId").focus();
	    		return false;
	    	}
	    	
	    	$.ajax({
	    		url  : "${ctp}/users/userTempPwd",
	    		type : "post",
	    		data : {
	    			userId : userId,
	    			email : email
	    		},
	    		success:function(res) {
	    			if(res != "0") {
	    				let ans = confirm("새로운 비밀번호가 회원님 메일로 발송 되었습니다.\n메일주소를 확인하세요.");
	    				if (ans) {
	    					window.close();
	    				}
	    			}
	    			else {
	    				alert("등록하신 정보가 일치하지 않습니다.\n회원정보를 확인해 주세요!");
	    			}
	  				location.reload();
	    		},
	    		error : function() {
	    			alert("전송오류!!")
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
					<h4>비밀번호 찾기</h4>
					<form method="post">
						<div class="input-group mb-3">
							<div class="input-group-prepend"><span class="input-group-text">아이디</span></div>
							<input type="text" name="userId" id="userId" class="form-control">
						</div>
						<div class="input-group mb-3">
							<div class="input-group-prepend"><span class="input-group-text">이메일</span></div>
							<input type="email" name="email" id="email" class="form-control">
						</div>
						<div class="text-center">
							<!-- <button type="button" class="btn btn-info mt-3 mr-2" onclick="userFindPw()">임시 비밀번호 발급</button> -->
							<!-- <a type="button" tabindex="0" class="btn btn-info mt-3 mr-2" onclick="userFindPw()">임시 비밀번호 발급</a> -->  <!-- submit으로 하면 {res : 0} 형식으로 넘어오고, 모달은 a태그 사용해야함 -->
							<input type="button" class="btn btn-info mt-3 mr-2" value="임시 비밀번호 발급" onclick="userFindPw();">
							<button class="btn btn-danger mt-3" onclick="window.close();">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
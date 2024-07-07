<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userLogin</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
  	<%@ include file = "/WEB-INF/views/include/bs4.jsp"%>
  	<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
  	<script src="http://developers.kakao.com/sdk/js/kakao.js"></script>
  	<style>
  		ul {
  			margin: 0;
  			padding: 0;
  		}
  		ul .login-app {
  			display: inline-block; 
  			width:52px;
  			height:52px;
  			border-radius:50%;
  			text-align:center;
  			text-decoration:none;
  		}
  		ul .login-app:hover {
  			opacity:0.7;
  			box-shadow: 0px 8px 6px -6px #666
  		}
  		ul .login-app .app-i {
			margin-top: 13px;
			align-items: center;
  		}
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
  		
  		// 카카오 로그인(자바스크립트 앱키 등록)
     	window.Kakao.init("f8adb2181213318e34c8e8f99a4eb70c");
  	    
  	    function kakaoLogin() {
  	    	window.Kakao.Auth.login({
  	    		scope: 'profile_nickname, account_email',
  	    		success:function(autoObj) {
  	    			console.log(Kakao.Auth.getAccessToken(), "정상 토큰 발급됨...");
  	    			window.Kakao.API.request({
  	    				url : '/v2/user/me',
  	    				success:function(res) {
  	    					const kakao_account = res.kakao_account;
  	    					console.log(kakao_account);
  	    					location.href = "${ctp}/users/userKakaoLogin?nickName="+ kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
  	    				}
  	    			});
  	    		}
  	    	});
  	    }
  	    
  	    function popupFindId() {
	  	    let popupX = Math.round(window.screenX + (window.outerWidth/2) - (500/2));
	  	    let popupY = Math.round(window.screenY + (window.outerHeight/2) - (550/2));
	  	  	let popOption = "width=500px, height=550px, left=:"+popupX+", top="+popupY;
	  	  	let openUrl = '${ctp}/users/userFindId';
  	    	window.open(openUrl, 'popup', popOption);	
  	    }
  	    
  	    function popupFindPw() {
	  	    let popupX = Math.round(window.screenX + (window.outerWidth/2) - (500/2));
	  	    let popupY = Math.round(window.screenY + (window.outerHeight/2) - (550/2));
	  	  	let popOption = "width=500px, height=550px, left=:"+popupX+", top="+popupY;
  		    let openUrl = '${ctp}/users/userFindPw';
  	    	window.open(openUrl, 'popup', popOption);	
  	    }
  	</script>
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
									<a onclick="popupFindId();" class="float-right" style="cursor:pointer;">아이디를 잊으셨나요?</a>
								</label>
								<input type="text" name="userId" id="userId" value="admin" class="form-control">
							</div>
							<div class="form-group">
								<label class="fw">비밀번호
									<a onclick="popupFindPw();" class="float-right" style="cursor:pointer;">비밀번호를 잊으셨나요?</a>
								</label>
								<input type="password" name="userPwd" id="userPwd" value="1234" class="form-control">
							</div>
							<div class="form-group text-right">
								<button class="btn btn-primary btn-block" onclick="location.href='${ctp}/users/userLogin';">로그인</button>
							</div>
							<div class="form-group">
					    		<input type="checkbox" id="idSave" name="idSave" checked /> 아이디 저장
								<p class="float-right"><span class="text-muted mr-2" style="font-size:0.8em;">아직 계정이 없으신가요? </span><a class="p-1" href="${ctp}/users/userRegister" style="border:1px solid #ccc;box-shadow: 0px 0px 2px #444;background-color:#fff;">회원가입</a></p>
							</div>
							<p><br></p>
							<div class="title-line">
								<span style="color:#252e38;">or</span>
							</div>
							<br>
							<div class="text-center">
								<ul class="btn-group align-center" style="list-style:none;">
									<li>
		             					<a href="${ctp}/user/userGoogleLogin" class="login-app mr-4" style="background-color:#f3f2f0;border:#eee"><img class="app-i" src="${ctp}/images/google-icon.png" alt="google-icon" style="width:25px;height:auto;"></a>
		             				</li>
									<li>
		             					<a id="naverIdLogin_loginButton" href="javascript:naverLogin(0)" class="login-app mr-4" style="background-color:#1ec800;padding:5px 0 0 0"><span style="font-size:28px;font-weight:bolder;color:#ffffff;">N</span></a>
		             				</li>
									<li>
		             					<a href="javascript:kakaoLogin()" class="login-app" style="background-color:#fee500"><i class="app-i fa-solid fa-comment" style="font-size:22px;color:#391b1b"></i></a>
		             				</li>
	             				</ul>
             				</div>
							<p><br></p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
<%@ include file = "/WEB-INF/views/include/footer.jsp"%>
</body>
</html>
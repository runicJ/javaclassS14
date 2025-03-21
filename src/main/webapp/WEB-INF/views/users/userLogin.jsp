<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userLogin</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
  	<%@ include file = "/WEB-INF/views/include/user/bs4.jsp"%>
	<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script src="https://accounts.google.com/gsi/client" async defer></script>
	<script>
		Kakao.init("3fe3ad77eb298aac7a938386f756b9b1"); // 여기에 JavaScript 키 입력 (REST API 키 아님)
		console.log("Kakao SDK 초기화 상태:", Kakao.isInitialized()); // true여야 정상
	</script>
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
		  background-color: #fef4db;
		}
		
		@media screen and (min-width:992px) {
			div.box.box-border {
				margin:0 auto;
				width:700px;
				padding: 40px;
			}
			.box-body h4 {
				font-size: 30px;
				margin-bottom:50px;
			}
		}
  	</style>
  	<script>
  		'use strict';
  		/*
  		window.onload = function() {
  			let cookieValue = getCookieValue('cUid');
  			if (cookieValue) {
  				document.getElementById('userId').value = cookieValue;
  				document.getElementById('idSave').checked = true;
  			}
  		}
  		*/
  		// 카카오 로그인(자바스크립트 앱키 등록)
  		function kakaoLogin() {
  		    window.Kakao.Auth.authorize({
  		        scope: 'profile_nickname, account_email, phone_number',
	      		redirectUri: "http://localhost:9090/javaclassS14/users/userKakaoLogin"
  		    });
  		}
  		
  		// 네이버 로그인
/* 		function naverLogin() {
		    console.log("네이버 로그인 버튼 클릭됨!"); // ✅ 실행 확인용 로그
		
		    let clientId = "Ef3o1usAXraCQUMkzGlf";
		    let redirectUri = "http://localhost:9090/javaclassS14/users/userNaverLogin"; // 네이버에서 로그인 후 리디렉트할 주소
		    let state = "RANDOM_STATE"; // CSRF 방지용 state 값
		    let scope = "name,email,mobile"; // 요청할 정보
		
		    let encodedRedirectUri = encodeURIComponent(redirectUri); // ✅ JavaScript에서 인코딩
		    let naverAuthUrl = `https://nid.naver.com/oauth2.0/authorize?response_type=code
		                         &client_id=${clientId}
		                         &redirect_uri=${encodedRedirectUri}
		                         &state=${state}
		                         &scope=${scope}`;
		
		    console.log("네이버 로그인 URL: ", naverAuthUrl); // ✅ URL이 정상적으로 생성되는지 확인
		
		    window.location.href = naverAuthUrl; // 네이버 로그인 창으로 이동
		} */
  	    
	    window.onload = function () {
	        google.accounts.id.initialize({
	            client_id: "574823940925-80u6kt99t4qntsq370ml9qr8qrhf77mv.apps.googleusercontent.com",
	            callback: handleCredentialResponse
	        });

	        google.accounts.id.renderButton(
	            document.getElementById("google-login-button"), // ✅ 버튼 ID를 지정해서 랜더링 가능
	            { theme: "outline", size: "large" }  // 옵션 설정 가능
	        );
	    };
	    
	    function googleLogin() {
	        google.accounts.id.prompt(); // ✅ Google 로그인 창 띄우기
	    }
	    
	    function handleCredentialResponse(response) {
	        console.log("Google 로그인 성공:", response);

	        // Google에서 제공한 ID 토큰을 백엔드로 전송
	        fetch("${ctp}/users/userGoogleLogin", {
	            method: "POST",
	            headers: {
	                "Content-Type": "application/json"
	            },
	            body: JSON.stringify({ credential: response.credential })
	        })
	        .then(res => res.json())
	        .then(data => {
	            if (data.success) {
	                alert("로그인 성공!");
	                window.location.href = "${ctp}/";
	            } else {
	                alert("로그인 실패. 다시 시도해주세요.");
	            }
	        })
	        .catch(error => console.error("Error:", error));
	    }
		
  	    function popupFindId() {
  	    	let popName = "popId"
  	    	let popWidth = 500;
  	    	let popHeight = 550;
	  	    let popupX = Math.round((window.screen.width/2) - (popWidth/2));
	  	    let popupY = Math.round((window.screen.height/2) - (popHeight/2));
	  	  	let popOpt = "width=" + popWidth + ", height=" + popHeight + ", left=" + popupX + ", top=" + popupY;
	  	  	let popUrl = "${ctp}/users/userFindId";
  	    	window.open(popUrl, popName, popOpt);	
  	    }
  	    
  	    function popupFindPw() {
  	    	let popName = "popPw"
  	    	let popWidth = 500;
  	    	let popHeight = 550;
	  	    let popupX = Math.round((window.screen.width/2) - (popWidth/2));
	  	    let popupY = Math.round((window.screen.height/2) - (popHeight/2));
	  	  	let popOpt = "width=" + popWidth + ", height=" + popHeight + ", left=" + popupX + ", top=" + popupY;
	  	  	let popUrl = "${ctp}/users/userFindPw";
  	    	window.open(popUrl, popName, popOpt);	
  	    }
  	</script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/user/header.jsp"%>
<%@ include file = "/WEB-INF/views/include/user/nav.jsp"%>
	<section class="login first grey">
		<div class="box-wrapper">				
			<div class="box box-border">
				<div class="box-body">
					<h4 class="text-center">로그인</h4>
					<form name="myform" method="post">
						<div class="form-group">
							<label class="fw">아이디
								<a onclick="popupFindId();" class="float-right" style="cursor:pointer;">아이디를 잊으셨나요?</a>
							</label>
							<input type="text" name="userId" id="userId" value="${userId}" class="form-control">
						</div>
						<div class="form-group">
							<label class="fw">비밀번호
								<a onclick="popupFindPw();" class="float-right" style="cursor:pointer;">비밀번호를 잊으셨나요?</a>
							</label>
							<input type="password" name="userPwd" id="userPwd" class="form-control">
						</div>
						<div class="form-group text-right">
							<button class="btn btn-primary btn-block" onclick="location.href='${ctp}/users/userLogin';">로그인</button>
						</div>
						<div class="form-group">
				    		<input type="checkbox" id="idSave" name="idSave" checked />
				    		<span style="font-size:0.8em;"> 아이디 저장</span>
							<p class="float-right">
								<span class="text-muted mr-2" style="font-size:0.8em;">아직 계정이 없으신가요? </span>
								<a class="p-1" href="${ctp}/users/userPolicy" style="border:1px solid #ccc;box-shadow: 0px 0px 2px #444;background-color:#fff;">회원가입</a>
							</p>
						</div>
						<p><br></p>
						<div class="title-line">
							<span style="color:#252e38;">or</span>
						</div>
						<br>
						<div class="text-center">
							<ul class="btn-group align-center" style="list-style:none;">
								<li>
								    <a href="javascript:googleLogin()" class="login-app mr-4" style="background-color:#f3f2f0;border:#eee">
								        <img class="app-i" src="${ctp}/images/google-icon.png" alt="google-icon" style="width:25px;height:auto;">
								    </a>
								</li>
								<li>
									<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code
									&client_id=Ef3o1usAXraCQUMkzGlf
									&redirect_uri=http://localhost:9090/javaclassS14/users/userNaverLogin
									&state=RANDOM_STATE
									&scope=name,email"
									class="login-app mr-4" style="background-color:#1ec800;">
									    <span style="font-size:28px; font-weight:bolder; color:#ffffff;">N</span>
									</a>
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
	</section>
<%@ include file = "/WEB-INF/views/include/user/footer.jsp"%>
</body>
</html>
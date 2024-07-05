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
  	    					location.href = "${ctp}/user/userKakaoLogin?nickName="+ kakao_account.profile.nickname+"&email="+kakao_account.email+"&accessToken="+Kakao.Auth.getAccessToken();
  	    				}
  	    			});
  	    		}
  	    	});
  	    }
  	    function popupIdFind() {
	  	    let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
  		    let openUrl = '${ctp}/users/userFindId';
  	    	window.open(openUrl, 'pop', popOption);	
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
									<a onclick="popupIdFind(this);" class="float-right" style="pointer:cursor;">아이디를 잊으셨나요?</a>
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
								<button class="btn btn-primary btn-block" onclick="location.href='${ctp}/users/userLogin';">로그인</button>
							</div>
							<div class="form-group">
					    		<input type="checkbox" id="idSave" name="idSave" checked /> 아이디 저장
								<p class="float-right"><span class="text-muted mr-2" style="font-size:0.8em;">아직 계정이 없으신가요? </span><a class="p-1" href="${ctp}/users/userRegister" style="border:1px solid #ccc;box-shadow: 0px 0px 2px #444">회원가입</a></p>
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
<!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script>

var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "80mdf88flkWWJT1f93Tz", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
			callbackUrl: "http://localhost:8181/naverLogin", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
			isPopup: false,
			callbackHandle: true
		}
	);	

naverLogin.init();

window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
    		
			console.log(naverLogin.user); 
    		
            if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});


var testPopUp;
function openPopUp() {
    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
    testPopUp.close();
}

function naverLogout() {
	openPopUp();
	setTimeout(function() {
		closePopUp();
		}, 1000);
	
	
}
</script><!-- 네이버 스크립트 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

<script>

var naverLogin = new naver.LoginWithNaverId(
		{
			clientId: "Ef3o1usAXraCQUMkzGlf",
			callbackUrl: "http://localhost:9090/javaclassS14/users/userLogin",
			isPopup: false,
			callbackHandle: true
		}
	);	

naverLogin.init();

window.addEventListener('load', function () {
	naverLogin.getLoginStatus(function (status) {
		if (status) {
			var nickName = naverLogin.user.getNickName(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
			var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.
    		
			console.log(naverLogin.user); 
    		
            if( email == undefined || email == null) {
				alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
            if( nickName == undefined || nickName == null) {
				alert("닉네임은 필수정보입니다. 정보제공을 동의해주세요.");
				naverLogin.reprompt();
				return;
			}
		} else {
			console.log("callback 처리에 실패하였습니다.");
		}
	});
});


var testPopUp;
function openPopUp() {
    testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
}
function closePopUp(){
    testPopUp.close();
}

function naverLogout() {
	openPopUp();
	setTimeout(function() {
		closePopUp();
		}, 1000);
	
	
}
</script>
</body>
</html>
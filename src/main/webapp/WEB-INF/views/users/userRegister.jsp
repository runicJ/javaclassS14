<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userRegister</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
 <script>
    'use strict';
    
    let uidCheckSw = 0;
    let nickCheckSw = 0;
    let emailCheckSw = 0;
    let timerInterval;
    
    function fCheck(event) {
    	event.preventDefault();  // 기본 제출 동작 방지 (페이지 새로고침 X)
    	
    	let userId = myform.userId.value.trim();
    	let userPwd = myform.userPwd.value.trim();
    	let pwdCheck = myform.pwdCheck.value.trim();
    	
    	let name = myform.name.value.trim();
    	let nickName = myform.nickName.value.trim();
    	
       	let email1 = myform.email1.value.trim();
       	let email2 = myform.email2.value;
       	let email = email1 + "@" + email2;
       	
    	let tel1 = myform.tel1.value;
       	let tel2 = myform.tel2.value.trim();
       	let tel3 = myform.tel3.value.trim();
       	let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
		let regUid = /^[a-zA-Z0-9_-]{4,20}$/;
        let regPwd = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&^])[A-Za-z\d@$!%*#?&^]{4,30}$/;
		let regName = /^[가-힣a-zA-Z]+$/;
	    let regNickName = /^[a-zA-Z0-9가-힣]+$/;
	    let regTel = /^010-\d{3,4}-\d{4}$/;
	    let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
        
		if(userId == "") {
			alert("아이디를 입력하세요");
			myform.userId.focus();
			return false;
		}
		if(!regUid.test(userId)) {
    		alert("아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_),하이픈(-)만 사용가능합니다.");
    		myform.userId.focus();
    		return false;
    	}
		
		if(userPwd == "") {
			alert("비밀번호를 입력하세요");
	        myform.userPwd.focus();
			return false;
		}

 		if(!regPwd.test(userPwd)) {
	        alert("비밀번호는 4~30자리의 영문 대/소문자, 숫자, 특수문자를 최소 하나씩 포함하여 작성해주세요.");
	        myform.userPwd.focus();
	        return false;
      	}
		
    	if(pwdCheck == "" || pwdCheck != userPwd) {
    		alert("입력하신 비밀번호와 일치하지 않습니다. 비밀번호를 확인해 주세요.");
            myform.pwdCheck.focus();
            return false;
    	}
    	
		if(name == "") {
			alert("이름을 입력하세요");
			myform.name.focus();
			return false;
		}
		if(!regName.test(name)) {
			alert("이름은 한글과 영문 대/소문자만 사용가능합니다.");
			myform.name.focus();
			return false;
		}
		
		if(nickName == "") {
			alert("닉네임을 입력하세요");
			$("#nickName").focus();
			return false;
		}
		if(!regNickName.test(nickName)) {
			alert("닉네임은 한글, 영문 대/소문자, 숫자만 사용가능합니다.");
			myform.nickName.focus();
			return false;
		}
		
  		if(tel2 == "" || tel3 == "") {
			alert("전화번호를 입력하세요");
			myform.tel2.focus();
			return false;
  		}
  		if(!regTel.test(tel)) {
			alert("올바른 전화번호 형식을 입력하세요");
			myform.tel2.focus();
			return false;
  		}
    	
  		if(email1 == "") {
			alert("이메일을 입력하세요");
			myform.tel2.focus();
			return false;
  		}
  		if (!regEmail.test(email)) {
	        alert("올바른 이메일 주소를 입력하세요.");
	        myform.email1.focus();
	        return false;
	    }
  		
  		let fName = document.getElementById("file").value;
  		if (fName.trim() != "") {
  			let ext = fName.substring(fName.lastIndexOf(".")+1).toLowerCase(); 
	  		let maxSize = 1024 * 1024 * 10;
			if(!['jpg','jpeg','png','gif'].includes(ext)) {
	  			alert("JPG, JPEG, PNG, GIF 파일만 업로드 가능합니다.");
	  			return false;
	  		}
	  		if(document.getElementById("file").files[0].size > maxSize) {
	  			alert("업로드할 파일의 최대용량은 10Mbyte입니다.");
	  			return false;
	  		}	  			
  		}
  		
    	if(uidCheckSw == 0) {
    		alert("아이디 중복체크 버튼을 눌러주세요");
    		document.getElementById("uidBtn").focus();
    		return false;
    	}
    	if(nickCheckSw == 0) {
    		alert("닉네임 중복체크 버튼을 눌러주세요");
    		document.getElementById("nickNameBtn").focus();
    		return false;
    	}
 
        if (emailCheckSw == 0) {
            alert("이메일 중복체크 버튼을 눌러주세요");
            document.getElementById("emailCheckSw").focus();
            return false;
        }

		myform.email.value = email;
		myform.tel.value = tel;
		
		myform.submit();
		// return true;  // 제출 허용 → 자동으로 폼이 제출됨
    }
		
    function idCheck() {
    	let userId = myform.userId.value.trim();
    	
    	if(userId == "") {
    		alert("아이디를 입력하세요!");
    		myform.uid.focus();
    	}
    	else {
	    	$.ajax({
	    		url : "${ctp}/users/uidCheck",
	    		type : "get",
	    		data : {userId : userId},
	    		success:function(res) {
	    			if(res != "0") {
	    				alert("이미 사용중인 아이디입니다. 다시 입력하세요.");
	    				myform.userId.focus();
	    			}
	    			else {
	    				alert("사용 가능한 아이디입니다.");
	    				uidCheckSw = 1;
	    				$("#uidBtn").attr("disabled",true);
	    				myform.userPwd.focus();
	    			}
	    		},
	    		error:function() {
	    			alert("전송 오류!");
	    		}
	    	});
    	}
    }
    
    function nickCheck() {
    	let nickName = myform.nickName.value.trim();
    	
    	if(nickName.trim() == "") {
    		alert("닉네임을 입력하세요!");
    		myform.nickName.focus();
    	}
    	else {    		
	    	$.ajax({
	    		url : "${ctp}/users/nickCheck",
	    		type : "get",
	    		data : {nickName : nickName},
	    		success:function(res) {
	    			if(res != 0) {
	    				alert("이미 사용중인 닉네임입니다. 다시 입력하세요.");
	    				myform.nickName.focus();
	    			}
	    			else {
	    				alert("사용 가능한 닉네임입니다.");
	    	    		nickCheckSw = 1;
	    				$("#nickNameBtn").attr("disabled",true);
	    				myform.email1.focus();
	    			}
	    		},
	    		error:function() {
	    			alert("전송 오류!");
	    		}
	    	});
    	}
    }
   
     function emailCheck() {
		let email1 = myform.email1.value;
		let email2 = myform.email2.value;
		let email = email1 + "@" + email2;
      if (email1 == "" || email2 == "") {
        alert("이메일 주소를 입력하세요!");
        myform.email1.focus();
      } 
      else {
        $.ajax({
          url: "${ctp}/users/emailCheck",
          type: "get",
          data: {email : email},
          success: function(res) {
            if (res !== '0') {
              alert("이미 사용중인 이메일입니다. 정보를 확인해 주세요");
              myform.email1.focus();
            } 
            else {
                alert("사용 가능한 이메일입니다. 인증 코드를 발송했습니다.");
                emailCheckSw = 1;
                $("#emailCheckBtn").attr("disabled", true);
                confirmCodeSection.style.display = 'block';
                emailCheckTimer(); // 타이머 시작
            }
          },
          error: function() {
            alert("전송 오류!");
          }
        });
      }
    }
 
    function emailCheckTimer() {
        let timeLeft = 2 * 60; // 2분 (120초)
        function updateTimer() {
	        let min = Math.floor(timeLeft / 60);
	        let sec = timeLeft % 60;
	        if(sec < 10) sec = '0' + sec;
	        document.getElementById("timer").innerText = min + " : " + sec;

            if (timeLeft >= 0) {
	            timeLeft--;
            }
            else {
                clearInterval(timerInterval);
                alert("이메일 인증 시간이 초과되었습니다. 다시 시도해 주세요.");
                $("#emailCheckBtn").removeAttr("disabled");
                document.getElementById("confirmCodeSection").style.display = 'none';
            }
        }
        updateTimer();
        timerInterval = setInterval(updateTimer, 1000);
    }

    function confirmCodeCheck() {
        let email1 = myform.email1.value.trim();
        let email2 = myform.email2.value;
        let email = email1 + "@" + email2;
        let checkKey = document.getElementById("confirmCode").value.trim();

        if (!checkKey) {
            alert("인증 코드를 입력하세요!");
            document.getElementById("confirmCode").focus();
            return;
        }

        $.ajax({
            url: "${ctp}/users/confirmCodeCheck",
            type: "get",
            data: { 
                email: email, 
                checkKey: checkKey 
            },
            success: function(res) {
                if (res != '0') {
                    alert("이메일 인증이 완료되었습니다.");
                    clearInterval(timerInterval); // 타이머 정지
                    document.getElementById("confirmCodeSection").style.display = 'none';
                } 
                else {
                    alert("인증 코드가 일치하지 않습니다. 다시 확인해 주세요.");
                }
            },
            error: function() {
                alert("전송 오류!");
            }
        });
    }

    function confirmCodeReCheck() {
    	clearInterval(timerInterval);
        emailCheck(); // 이메일 인증 코드 재발급 요청
    }

    window.onload = function(){
    	document.getElementById('userId').addEventListener('click',function(){
    		uidCheckSw = 0;
    		$("#uidBtn").removeAttr("disabled");
    	});
    	document.getElementById('nickName').addEventListener('click',function(){
    		nickCheckSw = 0;
    		$("#nickNameBtn").removeAttr("disabled");
    	});

      	document.getElementById('email1').addEventListener('click',function(){
    		emailCheckSw = 0;
        	clearInterval(timerInterval);
            document.getElementById("confirmCodeSection").style.display = 'none';
    		$("#emailCheckBtn").removeAttr("disabled");
    	});
      	document.getElementById('email2').addEventListener('change',function(){
      		emailCheckSw = 0;
        	clearInterval(timerInterval);
            document.getElementById("confirmCodeSection").style.display = 'none';
    		$("#emailCheckBtn").removeAttr("disabled");
    	});
      	
      	document.getElementById('file').addEventListener('change', previewImage);
    }
    
    function previewImage() {
        let file = document.getElementById("file").files[0];
        let preview = document.getElementById("imageDemo");
        let modalImage = document.getElementById("modalImage");
        if (file) {
            let imageURL = URL.createObjectURL(file);
            preview.src = imageURL;
            modalImage.src = imageURL;
            preview.style.display = 'block';
            preview.onload = function() {
                URL.revokeObjectURL(preview.src);
            };
        }
        else {
            preview.style.display = 'none';
        }
    }
  </script>
  <style>
	.box {
	  box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
	  transition: 0.3s;
	}
	.box:hover {
	  background-color: #fef4db;
	}
  	div .invalid-feedback {
  		font-size: 13px;
  	}
  	select {
  		font-size: 16px;
  	}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
	<section class="register first grey">
		<div class="container">
			<div class="box-wrapper">				
				<div class="box box-border">
					<div class="box-body">
						<h4 class="text-center">회 원 가 입</h4>
<!-- 						<form name="myform" method="post" class="was-validated" enctype="multipart/form-data" onsubmit="return fCheck();"> -->
						<form name="myform" method="post" class="was-validated" enctype="multipart/form-data">
							<div class="form-group">
								<label for="uid"><i class="fa-solid fa-caret-right"></i> 아이디</label>
								<div class="input-group">
									<input type="text" name="userId" id="userId" class="form-control" placeholder="아이디를 입력하세요" required autofocus>
									<input type="button" value="아이디 중복체크" id="uidBtn" class="input-group-append btn btn-info btn-sm" onclick="idCheck()"/>
									<div class="invalid-feedback">아이디는 4~20자리의 영문 대/소문자와 숫자, 언더바(_),하이픈(-)만 사용가능합니다.</div>
								</div>
							</div>
							
							<div class="form-group">
								<label class="fw" for="userPwd"><i class="fa-solid fa-caret-right"></i> 비밀번호</label>
								<input type="password" name="userPwd" id="userPwd" class="form-control" placeholder="비밀번호를 입력하세요" required>
								<div class="invalid-feedback">비밀번호는 4~30자리의 영문 대/소문자, 숫자, 특수문자를 최소 하나씩 포함하여 작성해주세요.</div>
							</div>
							
							<div class="form-group">
								<label class="fw" for="pwdCheck"><i class="fa-solid fa-caret-right"></i> 비밀번호 확인</label>
								<input type="password" name="pwdCheck" id="pwdCheck" class="form-control" placeholder="동일한 비밀번호를 입력하세요" required>
							    <div class="invalid-feedback">입력하신 비밀번호와 일치하지 않습니다. 비밀번호를 확인해 주세요.</div>
							</div>
							
							<div class="form-group">
								<label for="name"><i class="fa-solid fa-caret-right"></i> 이름</label>
								<input type="text" name="name" id="name" class="form-control" placeholder="이름을 입력하세요." required>
								<div class="invalid-feedback">이름은 한글과 영문 대/소문자만 사용가능합니다.</div>
							</div>
							
							<div class="form-group">
								<label for="nickName"><i class="fa-solid fa-caret-right"></i> 닉네임</label>
								<div class="input-group">
									<input type="text" name="nickName" id="nickName" class="form-control" required>
									<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="input-group-append btn btn-info btn-sm" onclick="nickCheck()"/>
									<div class="invalid-feedback">닉네임은 한글, 영문 대/소문자, 숫자만 사용가능합니다.</div>
								</div>
							</div>
						    
						    <div class="form-group">
						      <label for="email1"><i class="fa-solid fa-caret-right"></i> 이메일</label>
						        <div class="input-group">
									<input type="text" id="email1" name="email1" class="form-control mr-2" placeholder="이메일 주소를 입력하세요." required />
									<span style="font-size:1.1em;">@</span>
									<select id="email2" name="email2" class="ml-2" style="width:120px;">
										<option value="naver.com" selected>naver.com</option>
										<option value="gmail.com">gmail.com</option>
										<option value="daum.net">daum.net</option>
									</select>
									<input type="button" value="이메일 중복체크" id="emailCheckBtn" class="input-group-append btn btn-info btn-sm" onclick="emailCheck()"/>
						        </div>
						    </div>
						    
							<div id="confirmCodeSection" style="display:none;">
							    <div class="form-group">
							    	<div class="m-0 p-0">
								        <label for="confirmCode" style="font-size:1.1em;">인증코드 확인</label>
										<p class="float-right" id="timer" style="font-size:1.1em; color:red;"></p>
									</div>
							        <div class="input-group">
							            <input type="text" id="confirmCode" name="confirmCode" class="form-control" placeholder="인증 코드를 입력하세요." />
							            <input type="button" value="인증코드 제출" id="confirmCodeBtn" class="btn btn-info btn-sm" onclick="confirmCodeCheck()" />
							            <input type="button" value="인증코드 재발급" id="confirmCodeReBtn" class="input-group-append btn btn-danger btn-sm" onclick="confirmCodeReCheck()" />
							        </div>
							    </div>
							</div>
							
							<div class="form-group">
								<label for="tel2"><i class="fa-solid fa-caret-right"></i> 연락처</label>
								<div class="input-group">
									<div class="input-group-prepend">
							            <select name="tel1" id="tel1" class="form-control">
							              <option value="010" selected>010</option>
							            </select>
							        </div>
									<span>&nbsp;&nbsp; - &nbsp;&nbsp;</span>
							        <input type="text" id="tel2" name="tel2" size=4 maxlength=4 class="form-control" required />
							        <span>&nbsp;&nbsp; - &nbsp;&nbsp;</span>
							        <input type="text" id="tel3" name="tel3" size=4 maxlength=4 class="form-control" required />
							    </div>
							</div>
							
							<div class="form-group">
								<label class="mr-3"><i class="fa-solid fa-caret-right"></i> 성별</label>
						      	<div class="form-check-inline">
							        <label class="form-check-label">
							          	<input type="radio" class="form-check-input" name="gender" value="n" checked>미선택
							        </label>
								</div>
						      	<div class="form-check-inline">
							        <label class="form-check-label">
							          	<input type="radio" class="form-check-input" name="gender" value="m">남자
							        </label>
								</div>
								<div class="form-check-inline">
									<label class="form-check-label">
										<input type="radio" class="form-check-input" name="gender" value="f">여자
									</label>
								</div>
							</div>
							
							<div class="form-group">
								<div class="input-group d-flex justify-content-between">
								    <label><i class="fa-solid fa-caret-right"></i> 홈페이지 가입 목적(선택)</label>
								    <select class="form-select" id="registerWay" name="registerWay">
								        <option value="미선택" selected>미선택</option>
								        <option value="정보 취득">정보 취득</option>
								        <option value="본인의 알레르기">본인의 알레르기</option>
								        <option value="자녀 혹은 주변인의 알레르기">자녀 혹은 주변인의 알레르기</option>
								        <option value="환경에 대한 관심">환경에 대한 관심</option>
								        <option value="알레르기 물품 구입">물품 구입</option>
								        <option value="기타">기타</option>
								    </select>
							    </div>
							</div>
							
							<div class="form-group mb-3 d-flex align-items-center">
							    <div class="mr-3">
									<img id="imageDemo" style="width:100px;height:100px;cursor: pointer;" onclick="$('#imageModal').modal('show');">
							    </div>
							    <div>
							        <label for="fName"><i class="fa-solid fa-caret-right"></i> 프로필 사진(파일용량:10MByte이내) : </label>
									<input type="file" name="fName" id="file" onchange="previewImage();" class="form-control-file">
							    </div>
							</div>
							<div class="form-group text-right">
								<button class="btn btn-primary btn-block" onclick="fCheck(event)">회원가입</button>
							</div>
							<div class="form-group d-flex float-right">
								<span class="text-muted mr-3" style="font-size:0.8em;">이미 계정이 있으신가요?</span><a href="${ctp}/users/userLogin">로그인 페이지로</a>
							</div>
						    <input type="hidden" name="email" />
    						<input type="hidden" name="tel" />
    						<p><br><p>
						</form>
					</div>
				</div>
			</div>
		</div>
	</section>
<p><br/></p>
	<div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="imageModalLabel">프로필 사진 미리보기</h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <img id="modalImage" src="" class="img-fluid">
                </div>
            </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
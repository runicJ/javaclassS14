<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userUpdate</title>
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
 <script>
    'use strict';
    
    let nickCheckSw = 1;
    let emailCheckSw = 1;
    let timerInterval;
    
    function fCheck() {
    	 let userPwd = myform.userPwd.value.trim();
         let pwdNew = myform.pwdNew.value.trim();
         let pwdNewCheck = myform.pwdNewCheck.value.trim();
         
         let name = myform.name.value.trim();
         let nameNew = myform.nameNew.value.trim();
         if(nameNew) name = nameNew; // 새로운 값이 있으면 이를 사용
         
         let nickName = myform.nickName.value.trim();
         let nickNameNew = myform.nickNameNew.value.trim();
         if(nickNameNew) nickName = nickNameNew; // 새로운 값이 있으면 이를 사용
         
         let email1 = myform.email1.value.trim();
         let email2 = myform.email2.value;
         
         let email = email1 + "@" + email2;
         
         let tel1 = myform.tel1.value;
         let tel1New = myform.tel1New.value;
         if(tel1New) tel1 = tel1New; // 새로운 값이 있으면 이를 사용
         
         let tel2 = myform.tel2.value.trim();
         let tel2New = myform.tel2New.value.trim();
         if(tel2New) tel2 = tel2New; // 새로운 값이 있으면 이를 사용
         
         let tel3 = myform.tel3.value.trim();
         let tel3New = myform.tel3New.value.trim();
         if(tel3New) tel3 = tel3New; // 새로운 값이 있으면 이를 사용
         
         let tel = tel1 + "-" + tel2 + "-" + tel3;
    	
        let regPwd = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&^])[A-Za-z\d@$!%*#?&^]{4,30}$/;
		let regName = /^[가-힣a-zA-Z]+$/;
	    let regNickName = /^[a-zA-Z0-9가-힣]+$/;
	    let regTel = /^010-\d{3,4}-\d{4}$/;
	    let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
	    if(userPwd == "") {
	        alert("정보를 수정하시려면 비밀번호를 입력해주세요.");
	        myform.userPwd.focus();
	        return false;
	    }
	    
	    if(pwdNew != "" && userPwd == pwdNew) {
	        alert("새 비밀번호는 현재 비밀번호와 다르게 입력해야 합니다.");
	        myform.pwdNew.focus();
	        return false;
	    }

    	if(pwdNew != "" && pwdNew != pwdNewCheck) {
    		alert("새로 입력하신 비밀번호와 일치하지 않습니다. 비밀번호를 확인해 주세요.");
            myform.pwdNew.focus();
            return false;
    	}
    	
 		if(pwdNew != "" && !regPwd.test(pwdNew)) {
	        alert("비밀번호는 4~30자리의 영문 대/소문자, 숫자, 특수문자를 최소 하나씩 포함하여 작성해주세요.");
	        myform.userPwd.focus();
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
    }
	
    function nickCheck() {
    	let nickName = myform.nickNameNew.value.trim();
    	
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
    
    
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById('nameUpdateBtn').addEventListener('click', function() {
          $("#nameUpdateInput").show();
        });
        document.getElementById('nickUpdateBtn').addEventListener('click', function() {
          nickCheckSw = 0; // 새로운 값 입력 시 스위치 초기화
          $("#nickUpdateInput").show();
        });
        
        
        $(document).ready(function() {
            $('#email1').on('input', function() {
                $('#emailCheckBtn').prop('disabled', false);
            });

            $('#email2').on('change', function() {
                $('#emailCheckBtn').prop('disabled', false);
            });
        });
        
        document.getElementById('email1').addEventListener('input', function() {
            document.getElementById('emailCheckBtn').disabled = false;
        });

        document.getElementById('email2').addEventListener('change', function() {
            document.getElementById('emailCheckBtn').disabled = false;
        });
        document.getElementById('telUpdateBtn').addEventListener('click', function() {
          $("#telUpdateInput").show();
        });

        // 이미지 미리보기
        document.getElementById('file').addEventListener('change', previewImage);
        
     	// 체크박스 변경 시 hidden 필드 업데이트
        document.querySelector('input[name="agreeOptional"]').addEventListener('change', updatePolicyFlag);
      });

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
    
    function updatePolicyFlag() {
        let agreeOptional = document.querySelector('input[name="agreeOptional"]').checked;
        document.querySelector('input[name="policyFlag"]').value = agreeOptional ? "y" : "n";
    }
  </script>
  <style>
  	.box-body {
  		margin: 0;
  	}
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
  	
    .file-input-container {
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
      margin-top: 10px;
    }
    
    #file {
      display: none;
    }
  	
    .file-input-label {
      display: inline-block;
      padding: 10px 15px;
      font-size: 20px;
      cursor: pointer;
      background-color: #000d35;
      color: white;
      border-radius: 22px;
      margin-top: 10px;
      position: absolute;
      bottom: -30px;
      right: 200px;
    }
    .file-input-label:hover {
      background-color: #F39C12;
    }
    
    .file-input-group {
      position: relative;
      display: flex;
      flex-direction: column;
      align-items: center;
      justify-content: center;
    }
    
    .file-input-group img {
    	display: block;
    }
    
/* Style the Image Used to Trigger the Modal */
#imageDemo {
  border-radius: 5px;
  cursor: pointer;
  transition: 0.3s;
}

#imageDemo:hover {opacity: 0.7;}

.modal {
	width: 50%;
	margin-top:200px;
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
}

#modalImage {
	width:auto;
	max-height: 500px;
}

/* Caption of Modal Image (Image Text) - Same Width as the Image */
#caption {
  margin: auto;
  display: block;
  width: 80%;
  max-width: 700px;
  text-align: center;
  color: #ccc;
  padding: 10px 0;
  height: 150px;
}

/* Add Animation - Zoom in the Modal */
.modal-content, #caption {
  animation-name: zoom;
  animation-duration: 0.6s;
}

@keyframes zoom {
  from {transform:scale(0)}
  to {transform:scale(1)}
}

/* 100% Image Width on Smaller Screens */
@media only screen and (max-width: 700px){
  .modal-content {
    width: 100%;
  }
}
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
	<section class="userUpdate" style="padding-top: 245.125px;">
		<div class="container">
			<div class="row">
				<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
				<div class="col-xs-12 col-md-8">
					<div class="box box-border" style="width:700px;">
						<div class="box-body">
							<h4 class="text-center">내 정보 수정</h4>
							<form name="myform" method="post" enctype="multipart/form-data" action="${ctp}/users/userUpdate">
								<div class="file-input-group text-center mb-5" style="display:flex;justify-content:center;align-items:center;">
		                  			<img id="imageDemo" style="width:200px;height:220px;cursor:pointer;" src="${ctp}/user/${sImage}" onclick="$('#imageModal').modal('show');">
									<label for="file" class="file-input-label"><i class="fas fa-tools"></i></label>
									<input type="file" id="file" name="fName" onchange="previewImage()">
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">아이디</span>
								    </div>
								    <input type="text" name="userId" class="form-control" value="${vo.userId}" readonly>
								</div>
								
								<div class="input-group mb-3" style="display:block;">
									<div class="input-group-prepend">
								      	<span class="input-group-text">현재 비밀번호</span>
								    </div>
									<input type="password" name="userPwd" id="userPwd" class="form-control" placeholder="정보 수정시 비밀번호를 입력하세요">
								</div>
								
								<div class="input-group mb-3" style="display:block;">
									<div class="input-group-prepend">
								      	<label class="fw input-group-text">변경할 비밀번호</label>
								    </div>
									<input type="password" name="pwdNew" id="pwdNew" class="form-control" placeholder="비밀번호 변경시 입력하세요">
								</div>
								
								<div class="input-group mb-3" style="display:block;">
									<div class="input-group-prepend">
								      	<span class="input-group-text">새 비밀번호 확인</span>
								    </div>
									<input type="password" name="pwdNewCheck" id="pwdNewCheck" class="form-control" placeholder="비밀번호 변경시 입력하세요">
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">이름</span>
								    </div>
								    <input type="text" name="name" id="name" class="form-control" value="${vo.name}" readonly>
								    <div class="input-group-append">
								      	<a type="button" id="nameUpdateBtn" class="btn btn-warning">정보 수정</a>
								    </div>
								</div>
								
								<div class="form-group" id="nameUpdateInput" style="display:none;">
									<label for="name"><i class="fa-solid fa-caret-right"></i> 이름</label>
									<input type="text" name="nameNew" id="nameNew" class="form-control" placeholder="이름을 입력하세요." required>
									<div class="invalid-feedback">이름은 한글과 영문 대/소문자만 사용가능합니다.</div>
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">닉네임</span>
								    </div>
								    <input type="text" name="nickName" id="nickName" class="form-control" value="${vo.nickName}" readonly>
								    <div class="input-group-append">
								      	<a type="button" id="nickUpdateBtn" class="btn btn-warning">정보 수정</a>
								    </div>
								</div>
								
								<div class="form-group" id="nickUpdateInput" style="display:none;">
									<label for="nickName"><i class="fa-solid fa-caret-right"></i> 닉네임</label>
									<div class="input-group">
										<input type="text" name="nickNameNew" id="nickNameNew" class="form-control" required>
										<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="input-group-append btn btn-info btn-sm" onclick="nickCheck()"/>
										<div class="invalid-feedback">닉네임은 한글, 영문 대/소문자, 숫자만 사용가능합니다.</div>
									</div>
								</div>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">이메일</span>
								    </div>
								    <c:set var="email" value="${fn:split(vo.email,'@')}" />
								    <input type="text" id="email1" name="email1" class="form-control mr-2" value="${email[0]}"/>
										<span style="font-size:1.1em;">@</span>
										<select id="email2" name="email2" class="ml-2" style="width:120px;">
											<option value="naver.com" ${email[1]=='naver.com' ? 'selected' : ''}>naver.com</option>
											<option value="gmail.com" ${email[1]=='gmail.com' ? 'selected' : ''}>gmail.com</option>
											<option value="daum.net" ${email[1]=='daum.net' ? 'selected' : ''}>daum.net</option>
										</select>
								    <div class="input-group-append">
								      	<input type="button" value="이메일 중복체크" id="emailCheckBtn" class="input-group-append btn btn-info btn-sm" onclick="emailCheck()" disabled/>
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
								
								<div class="form-group mb-3">
									<label for="tel2"><i class="fa-solid fa-caret-right"></i> 연락처</label>
									<div class="input-group">
										<div class="input-group-prepend">
								            <select name="tel1" id="tel1" class="form-control">
								              <option value="010" selected>010</option>
								            </select>
								        </div>
								        <c:set var="tel" value="${fn:split(vo.tel,'-')}" />
										<span>&nbsp;&nbsp; - &nbsp;&nbsp;</span>
								        <input type="text" id="tel2" name="tel2" value="${tel[1]}" class="form-control" readonly />
								        <span>&nbsp;&nbsp; - &nbsp;&nbsp;</span>
								        <input type="text" id="tel3" name="tel3" value="${tel[2]}" class="form-control" readonly />
									    <div class="input-group-append">
									      	<a type="button" id="telUpdateBtn" class="btn btn-warning">정보 수정</a>
									    </div>
								    </div>
							    </div>
								
								<div class="form-group" id="telUpdateInput" style="display:none;">
									<label for="tel2"><i class="fa-solid fa-caret-right"></i> 연락처</label>
									<div class="input-group">
										<div class="input-group-prepend">
								            <select name="tel1New" id="tel1New" class="form-control">
								              <option value="010" selected>010</option>
								            </select>
								        </div>
										<span>&nbsp;&nbsp; - &nbsp;&nbsp;</span>
								        <input type="text" id="tel2New" name="tel2New" size=4 maxlength=4 class="form-control" />
								        <span>&nbsp;&nbsp; - &nbsp;&nbsp;</span>
								        <input type="text" id="tel3New" name="tel3New" size=4 maxlength=4 class="form-control" />
								    </div>
								</div>
								
								<div class="form-group">
									<label class="mr-3"><i class="fa-solid fa-caret-right"></i> 성별</label>
							      	<div class="form-check-inline">
								        <label class="form-check-label">
								          	<input type="radio" class="form-check-input" name="gender" value="n" ${vo.gender =='n' ? 'checked' : ''}>미선택
								        </label>
									</div>
							      	<div class="form-check-inline">
								        <label class="form-check-label">
								          	<input type="radio" class="form-check-input" name="gender" value="m" ${vo.gender =='m' ? 'checked' : ''}>남자
								        </label>
									</div>
									<div class="form-check-inline">
										<label class="form-check-label">
											<input type="radio" class="form-check-input" name="gender" value="f" ${vo.gender =='f' ? 'checked' : ''}>여자
										</label>
									</div>
								</div>
								
								<div class="form-group">
									<div class="input-group d-flex justify-content-between">
									    <label><i class="fa-solid fa-caret-right"></i> 홈페이지 가입 목적(선택)</label>
									    <select class="form-select" id="registerWay" name="registerWay">
									        <option value="미선택" ${vo.registerWay =='미선택' ? 'selected' : ''}>미선택</option>
									        <option value="정보 취득" ${vo.registerWay =='정보 취득' ? 'selected' : ''}>정보 취득</option>
									        <option value="본인의 알레르기" ${vo.registerWay =='본인의 알레르기' ? 'selected' : ''}>본인의 알레르기</option>
									        <option value="자녀 혹은 주변인의 알레르기" ${vo.registerWay =='자녀 혹은 주변인의 알레르기' ? 'selected' : ''}>자녀 혹은 주변인의 알레르기</option>
									        <option value="환경에 대한 관심" ${vo.registerWay =='환경에 대한 관심' ? 'selected' : ''}>환경에 대한 관심</option>
									        <option value="알레르기 물품 구입" ${vo.registerWay =='알레르기 물품 구입' ? 'selected' : ''}>물품 구입</option>
									        <option value="기타" ${vo.registerWay =='기타' ? 'selected' : ''}>기타</option>
									    </select>
								    </div>
								</div>
								
								<div class="form-group">
									<label class="mr-3"><i class="fa-solid fa-caret-right"></i> 선택 약관 동의 &nbsp;&nbsp;&nbsp;</label>
                                    <label class="form-check-label">
                                        <input type="checkbox" class="form-check-input" name="agreeOptional"
                                               value="y" ${vo.policyFlag == 'y' ? 'checked' : ''}>동의함
                                    </label>
								</div>
								
								<div class="form-group text-center">
									<input type="button" class="btn btn-success mr-3" value="개인정보 수정" onclick="fCheck()">
									<a type="button" class="btn btn-danger" onclick="location.href='${ctp}/users/userMain';">취소</a>
								</div>
							    <input type="hidden" name="email" />
	    						<input type="hidden" name="tel" />
	    						<input type="hidden" name="policyFlag" value="${vo.policyFlag}" />
	    						<p><br><p>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
<p><br/></p>
	<div class="modal fade bottom" id="imageModal" tabindex="-1" role="dialog" aria-labelledby="imageModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 class="modal-title" id="imageModalLabel">프로필 사진 미리보기</h3>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <img id="modalImage" src="${ctp}/user/${sImage}" class="img-fluid">
                </div>
            </div>
          	<div id="caption">${vo.name}</div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
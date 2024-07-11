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
    
    let uidCheckSw = 0;
    let nickCheckSw = 0;
    let emailCheckSw = 0;
    let timerInterval;
    
    function fCheck(event) {
    	event.preventDefault();  // 페이지가 새로고침 되는 것을 막음?
    	
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
    	
        //let regPwd = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[@$!%*#?&^])[A-Za-z\d@$!%*#?&^]{4,30}$/;
		let regName = /^[가-힣a-zA-Z]+$/;
	    let regNickName = /^[a-zA-Z0-9가-힣]+$/;
	    let regTel = /^010-\d{3,4}-\d{4}$/;
	    let regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		
		if(userPwd == "") {
			alert("비밀번호를 입력하세요");
	        myform.userPwd.focus();
			return false;
		}

/* 		if(!regPwd.test(userPwd)) {
	        alert("비밀번호는 4~30자리의 영문 대/소문자, 숫자, 특수문자를 최소 하나씩 포함하여 작성해주세요.");
	        myform.userPwd.focus();
	        return false;
      	} */
		
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

    	if(nickCheckSw == 0) {
    		alert("닉네임 중복체크 버튼을 눌러주세요");
    		document.getElementById("nickNameBtn").focus();
    		return false;
    	}
/* 
        if (emailCheckSw == 0) {
            alert("이메일 중복체크 버튼을 눌러주세요");
            document.getElementById("emailCheckSw").focus();
            return false;
        } */

		myform.email.value = email;
		myform.tel.value = tel;
		
		myform.submit();
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
	/*    
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
    */
    
    document.addEventListener("DOMContentLoaded", function() {
        document.getElementById('nameUpdateBtn').addEventListener('click', function() {
            $("#name").removeAttr("readonly");
            $("#nameUpdateInput").show();
        });
        document.getElementById('nickUpdateBtn').addEventListener('click', function() {
            $("#nickUpdateInput").show();
        });
        document.getElementById('emailUpdateBtn').addEventListener('click', function() {
            $("#emailUpdateInput").show();
        });
        document.getElementById('telUpdateBtn').addEventListener('click', function() {
            $("#telUpdateInput").show();
        });

        // 이미지 미리보기
        document.getElementById('file').addEventListener('change', previewImage);
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
        } else {
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
	  background-color: #dbe4e6;
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
	<section class="userMain" style="padding-top: 245.125px;">
		<div class="container">
			<div class="row">
				<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
				<div class="col-xs-12 col-md-8">
					<div class="box box-border" style="width:700px;">
						<div class="box-body">
							<h4 class="text-center">내 정보 수정</h4>
							<form name="myform" method="post" enctype="multipart/form-data">
								<div class="mb-3 text-center">
								    <img id="imageDemo" style="width:200px;height:220px;cursor:pointer;" src="${ctp}/user/${vo.userImage}" onclick="$('#imageModal').modal('show');">
								    <p><input type="file" name="fName" id="file"><i class="fa-solid fa-wrench"></i> 프로필 사진 변경</p>
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">아이디</span>
								    </div>
								    <input type="text" class="form-control" value="${vo.userId}" readonly>
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">현재 비밀번호</span>
								    </div>
									<input type="password" name="userPwd" id="userPwd" class="form-control" placeholder="정보 수정시 비밀번호를 입력하세요">
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">변경할 비밀번호</span>
								    </div>
									<input type="password" name="userPwdNew" id="userPwdNew" class="form-control" placeholder="비밀번호 변경시 입력하세요">
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">새 비밀번호 확인</span>
								    </div>
									<input type="password" name="pwdNewCheck" id="pwdNewCheck" class="form-control" placeholder="비밀번호 변경시 입력하세요">
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">이름</span>
								    </div>
								    <input type="text" class="form-control" value="${vo.name}" readonly>
								    <div class="input-group-append">
								      	<a type="button" id="nameUpdateBtn" class="btn btn-warning">정보 수정</a>
								    </div>
								</div>
								
								<div class="form-group" id="nameUpdateInput" style="display:none;">
									<label for="name"><i class="fa-solid fa-caret-right"></i> 이름</label>
									<input type="text" name="name" id="name" class="form-control" placeholder="이름을 입력하세요." required>
									<div class="invalid-feedback">이름은 한글과 영문 대/소문자만 사용가능합니다.</div>
								</div>
								
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">닉네임</span>
								    </div>
								    <input type="text" class="form-control" value="${vo.nickName}" readonly>
								    <div class="input-group-append">
								      	<a type="button" id="nickUpdateBtn" class="btn btn-warning">정보 수정</a>
								    </div>
								</div>
								
								<div class="form-group" id="nickUpdateInput" style="display:none;">
									<label for="nickName"><i class="fa-solid fa-caret-right"></i> 닉네임</label>
									<div class="input-group">
										<input type="text" name="nickName" id="nickName" class="form-control" required>
										<input type="button" id="nickNameBtn" value="닉네임 중복체크" class="input-group-append btn btn-info btn-sm" onclick="nickCheck()"/>
										<div class="invalid-feedback">닉네임은 한글, 영문 대/소문자, 숫자만 사용가능합니다.</div>
									</div>
								</div>
																
								<div class="input-group mb-3">
									<div class="input-group-prepend">
								      	<span class="input-group-text">이메일</span>
								    </div>
								    <c:set var="email" value="${fn:split(vo.email,'@')}" />
								    <input type="text" id="email1" name="email1" class="form-control mr-2" value="${email[0]}" readonly />
										<span style="font-size:1.1em;">@</span>
										<select id="email2" name="email2" class="ml-2" style="width:120px;" disabled>
											<option value="naver.com" ${email[1]=='naver.com' ? 'selected' : ''}>naver.com</option>
											<option value="gmail.com" ${email[1]=='gmail.com' ? 'selected' : ''}>gmail.com</option>
											<option value="daum.net" ${email[1]=='daum.net' ? 'selected' : ''}>daum.net</option>
										</select>
								    <div class="input-group-append">
								      	<a type="button" id="emailUpdateBtn" class="btn btn-warning">정보 수정</a>
								    </div>
								</div>
							    
							    <div class="form-group" id="emailUpdateInput" style="display:none;">
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
								
								<div class="input-group mb-3">
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
								
								<div class="form-group text-center">
									<a type="button" class="btn btn-success mr-3" onclick="fCheck(event)">개인정보 수정</a>
									<a type="button" class="btn btn-danger" onclick="location.href='${ctp}/users/userMain';">취소</a>
								</div>
							    <input type="hidden" name="email" />
	    						<input type="hidden" name="tel" />
	    						<p><br><p>
							</form>
						</div>
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
                <div class="modal-body">
                    <img id="modalImage" src="" class="img-fluid">
                </div>
            </div>
        </div>
    </div>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
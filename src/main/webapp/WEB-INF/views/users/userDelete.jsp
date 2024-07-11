<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userDelete</title>
  	<%@ include file = "/WEB-INF/views/include/user/bs4.jsp"%>
  	<style>
	  	.myContent {
		    float: right;
		    width: 848px;
		    min-height: 703px;
		    height: auto !important;
		    height: 703px;
		    padding: 40px 30px;
		    border-top: 2px solid #555;
		    background: #fff;
		    font-size: 12px;
		}
		li {
			text-decoration:none;
		}
  	</style>
  	<script>
  		'use Strict'
  		
  		function byeCheck() {
	  		let userPwd = $("#userPwd").val().trim();
	  		if(userPwd == "") {
	  			alert("현재 비밀번호를 입력하세요!");
	  			$("#userPwd").focus();
	  		}
	  		else if(userPwd != ${vo.userPwd}) {
	  			alert("비밀번호가 일치하지 않습니다!");
	  			$("userPwd").focus();
	  		}
	  		else {
	  			let ans = confirm("회원 탈퇴 신청을 하시겠습니까?");
	  			if(ans) {
	  				ans = confirm("회원 탈퇴하시면 1개월간 같은 아이디 및 이메일로 가입하실 수 없습니다.\n계속 진행하시겠습니까?");
	  				if(ans) myform.submit();
	  			}
	  		}
	  	}
  	</script>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/user/header.jsp"%>
<%@ include file = "/WEB-INF/views/include/user/nav.jsp"%>
<p><br/></p>
	<section class="userDelete" style="padding-top: 245.125px;">
		<div class="container">
			<div class="row">
				<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
				<div class="col-xs-12 col-md-8">
				<div class="box box-border" style="width:700px;">
					<div class="box-body">
					<div class="titleSection subTitle withdrawal">
						<div class="text-center">
							<h4>회원탈퇴 안내</h4>
							<ol class="guide">
								<li><span>1.</span> <strong>회원탈퇴 시</strong> 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한 '괄호안쉼표' 고객정보 보호정책에 따라 관리됩니다.</li>
								<li><span>2.</span> <strong>회원탈퇴 시</strong> 회원님께서 보유하셨던 쿠폰 및 포인트는 모두 삭제되며, 환급 또한 불가능합니다.</li>
								<li><span>3.</span> 탈퇴한 아이디 및 이메일은 1개월 동안 사용하실 수 없습니다.</li>
								<li><span>4.</span> 회원님의 주문정보 및 작성한 게시글 등은 보관될 수 있고, 삭제되지 않습니다.</li>
								<li><span>5.</span> 회원탈퇴는 신청일 후 7일 이후에 삭제되며, 중간에 언제든 취소하실 수 있습니다.</li>
							</ol>
						</div>
					</div>
					<div class="mySection">
						<div class="myTopic">
							<div class="alert alert-danger">
						  		현재 고객님의 사용가능 마일리지는 <strong>${vo.point}</strong>point 입니다.
							</div>
						</div>
						<form name="byeFrm" method="post" action="/users/userDelete" onsubmit="return false;">
						<input type="hidden" name="email" value="${vo.email}">
						<input type="hidden" name="tel" value="${vo.tel}">
						<h4>탈퇴사유 확인</h4>
						<fieldset>
							<table class="baseTable rowTable docForm">
							<colgroup>
								<col width="140"> <col width="">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" class="ct"><label for="reason01">탈퇴사유</label></th>
								<td>
									<div class="itemField lPad15">
										<ul>
											<li><input type="radio" name="deleteReason" value="01" id="reason01"> <label for="reason01">상품품질 불만</label></li>
											<li><input type="radio" name="deleteReason" value="02" id="reason02"> <label for="reason02">이용빈도 낮음</label></li>
											<li><input type="radio" name="deleteReason" value="04" id="reason03"> <label for="reason03">개인정보유출 우려</label></li>
											<li><input type="radio" name="deleteReason" value="03" id="reason04"> <label for="reason04">배송지연</label></li>
											<li><input type="radio" name="deleteReason" value="05" id="reason05"> <label for="reason05">교환/환불/품질 불만</label></li>
											<li><input type="radio" name="deleteReason" value="07" id="reason06"> <label for="reason06">A/S 불만</label></li>
											<li><input type="radio" name="deleteReason" value="06" id="reason07"> <label for="reason07">기타</label></li>
										</ul>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="ct"><label for="wdEtc">기타</label></th>
								<td>
									<textarea id="wdEtc" name="deleteReason" cols="60" rows="5" style="width:96%; height:110px;" onclick="jsClearThis();">기타 불편사항 및 텐바이텐에 바라는 고객님의 충고를 부탁 드립니다.</textarea>
								</td>
							</tr>
							</tbody>
							</table>
						</fieldset>

						<h4>본인확인</h4>
						<fieldset>
							<table class="baseTable rowTable docForm">
							<colgroup>
								<col width="140"> <col width="">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" class="ct">아이디</th>
								<td><strong>${vo.userId}</strong></td>
							</tr>
						
							<tr>
								<th scope="row" class="fw"><label for="inpPw">비밀번호</label></th>
								<td>
									<input type="password" name="userPwd" id="userPwd" class="form-control">
								</td>
							</tr>
						
							<tr>
								<th scope="row" class="ct"><label for="certificate">본인확인</label></th>
								<td class="fs11">
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
								        </div>
								    </div>
								</td>
							</tr>
							</tbody>
							</table>
						</fieldset>
						<div class="text-center">
							<input type="button" onclick="byeCheck();" class="btn btn-danger mr-3" value="탈퇴하기">
							<input type="button" onclick="location.href='${ctp}/users/userMain';" value="취소하기" class="btn btn-warning">
						</div>
						<input type="hidden" name="userId" value="${vo.userId}" />
						<input type="hidden" name="email" value="${vo.email}" />
					</form>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	</div>
</section>
<p><br/></p>
<%@ include file = "/WEB-INF/views/include/user/footer.jsp"%>
</body>
</html>
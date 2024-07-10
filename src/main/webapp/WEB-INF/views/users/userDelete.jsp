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
		
		.myHeader .breadcrumb {
		    float: left;
		    width: 893px;
		    padding: 2px 0 0 15px;
		    font-size: 12px;
		    font-weight: normal;
		}
  	</style>
</head>
<body>
<%@ include file = "/WEB-INF/views/include/user/header.jsp"%>
<%@ include file = "/WEB-INF/views/include/user/nav.jsp"%>
<p><br/></p>
	<section class="userMain" style="padding-top: 245.125px;">
		<div class="myHeader">
				<h2><a href="/my10x10/" title="MY 10X10 메인 페이지"><img src="http://fiximage.10x10.co.kr/web2015/my10x10/tit_my10x10.png" alt="MY 10X10"></a></h2>
				<div class="breadcrumb">
					<a href="/" title="10X10 메인 페이지">HOME</a> &gt;
					<a href="/my10x10/" title="MY 10X10 메인 페이지">MY TENBYTEN</a>
					
					&gt; MY 회원정보 &gt; <strong>회원탈퇴</strong>
					
				</div>
			</div>
		<div class="container">
			<div class="row">
				<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
				<div class="col-xs-12 col-md-8">
					<div class="myContent">
					<div class="titleSection subTitle withdrawal">
						<h3><img src="http://fiximage.10x10.co.kr/web2013/my10x10/tit_withdrawal.gif" alt="회원탈퇴"></h3>
						<div>
							<p><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_withdrawal01.gif" alt="그동안 텐바이텐을 이용해주셔서 감사합니다."></p>
							<p class="tPad10"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/txt_withdrawal02.gif" alt="불편하였던 점이나ㅏ 불만사항을 남겨주시면 더 좋은 모습으로 찾아 뵙기 위해 노력하겠습니다."></p>
						</div>
						<div class="tMar40">
							<h4>회원탈퇴 안내</h4>
							<ol class="guide">
								<li><span class="fb crRed">1.</span> <strong>회원탈퇴 시</strong> 고객님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한 10x10 고객정보 보호정책에 따라 관리됩니다.</li>
								<li><span class="fb crRed">2.</span> <strong>회원탈퇴 시</strong> 고객님께서 보유하셨던 마일리지 및 현금성 포인트(예치금, gift카드)는 모두 삭제되며, 환급 또한 불가능합니다.</li>
								<li><span class="fb crRed">3.</span> 현금성 포인트(예치금, gift카드)의 잔액을 환급 받으시려면 회원 탈퇴 전에 고객센터로 문의바랍니다. (TEL 1644-6030)<br>단, gift카드의 경우 gift카드 이용약관에 의거해 100분의 60 이상 사용 시에만 잔액환급이 가능합니다.</li>
								<li><span class="fb crRed">4.</span> 한 번 탈퇴한 아이디는 다시 사용할 수 없습니다.</li>
							</ol>
						</div>
						<div class="ico"><img src="http://fiximage.10x10.co.kr/web2013/my10x10/img_withdrawal.gif" alt=""></div>
					</div>
					<div class="mySection">
						<div class="myTopic">
							<div class="box">
								<div class="price ct">현재 고객님의 사용가능 마일리지는 <strong>257</strong> <span>point</span> 입니다.</div>
								
							</div>
						</div>
						<!-- 탈퇴사유 확인 -->
						<form name="byeFrm" method="post" action="/my10x10/userinfo/withdrawal_process.asp" onsubmit="return false;">
						<input type="hidden" name="txEmail" value="">
						<input type="hidden" name="txPhone" value="">
						<h4>탈퇴사유 확인</h4>
						<fieldset>
						<legend>탈퇴사유 작성 폼</legend>
							<table class="baseTable rowTable docForm">
							<caption>탈퇴사유 확인</caption>
							<colgroup>
								<col width="140"> <col width="">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" class="ct"><label for="reason01">탈퇴사유</label></th>
								<td>
									<div class="itemField lPad15">
										<ul>
											<li><input type="radio" name="complaindiv" value="01" id="reason01"> <label for="reason01">상품품질 불만</label></li>
											<li><input type="radio" name="complaindiv" value="02" id="reason02"> <label for="reason02">이용빈도 낮음</label></li>
											<li><input type="radio" name="complaindiv" value="04" id="reason03"> <label for="reason03">개인정보유출 우려</label></li>
											<li><input type="radio" name="complaindiv" value="03" id="reason04"> <label for="reason04">배송지연</label></li>
											<li><input type="radio" name="complaindiv" value="05" id="reason05"> <label for="reason05">교환/환불/품질 불만</label></li>
											<li><input type="radio" name="complaindiv" value="07" id="reason06"> <label for="reason06">A/S 불만</label></li>
											<li><input type="radio" name="complaindiv" value="06" id="reason07"> <label for="reason07">기타</label></li>
										</ul>
									</div>
								</td>
							</tr>
							<tr>
								<th scope="row" class="ct"><label for="wdEtc">기타</label></th>
								<td>
									<textarea id="wdEtc" name="complaintext" cols="60" rows="5" style="width:96%; height:110px;" onclick="jsClearThis();">기타 불편사항 및 텐바이텐에 바라는 고객님의 충고를 부탁 드립니다.</textarea>
								</td>
							</tr>
							</tbody>
							</table>
						</fieldset>
						<!--// 탈퇴사유 확인 -->

						<!-- 본인확인 -->
						<h4>본인확인</h4>
						<fieldset>
						<legend>본인확인 폼</legend>
							<table class="baseTable rowTable docForm">
							<caption>본인확인</caption>
							<colgroup>
								<col width="140"> <col width="">
							</colgroup>
							<tbody>
							<tr>
								<th scope="row" class="ct">아이디</th>
								<td><strong>jhs2468</strong></td>
							</tr>
						
							<tr>
								<th scope="row" class="ct"><label for="inpPw">비밀번호</label></th>
								<td>
									<input type="password" name="txpass" id="inpPw" class="txtInp" style="width:178px;">
								</td>
							</tr>
						
							<tr>
								<th scope="row" class="ct"><label for="certificate">본인확인</label></th>
								<td class="fs11">
									<p class="crRed">회원정보에 등록된 휴대전화 또는 이메일 중 하나를 선택하여 입력하여 주세요.</p>
									<div class="selfConfirm">
										<p>
											<span><input type="radio" name="chkMethod" id="certPhone" value="P" onclick="chgSelEPDiv(this)" checked="checked"> <label for="certPhone">휴대전화</label></span>
											<span><input type="radio" name="chkMethod" id="certMail" value="E" onclick="chgSelEPDiv(this)"> <label for="certMail">이메일</label></span>
										</p>
										<p>
											<!-- 휴대전화 선택 시 -->
											<span id="lyrWDPhone">
											<select name="txCell1" title="휴대전화 앞자리 선택" class="select" style="width:78px;">
												<option value="010">010</option>
												<option value="011">011</option>
												<option value="016">016</option>
												<option value="017">017</option>
												<option value="018">018</option>
												<option value="019">019</option>
											</select>
											<span class="symbol">-</span>
											<input type="text" name="txCell2" maxlength="4" title="휴대전화 가운데자리 입력" class="txtInp" style="width:68px;">
											<span class="symbol">-</span>
											<input type="text" name="txCell3" maxlength="4" title="휴대전화 뒷자리 입력" class="txtInp" style="width:68px;">
											</span>
											<!-- 휴대전화 선택 시 -->
											<!-- 이메일 선택 시 -->
											<span id="lyrWDEmail" style="display:none;">
											<input type="text" title="이메일 아이디 입력" class="txtInp" style="width:118px; ime-mode:disabled;" name="txEmail1" maxlength="32">
											<span class="symbol">@</span>
											<input type="text" name="selfemail" title="이메일 직접 입력" class="txtInp" style="width:118px;display:none; ime-mode:disabled;" maxlength="80">
											<select name="txEmail2" onchange="EmailChecker(this.form)" title="이메일 서비스 선택" class="select emailSelect" style="width:102px;">
												<option value="" selected="selected">선택해 주세요</option>
												<option value="@naver.com">naver.com</option>
												<option value="@gmail.com">gmail.com</option>
												<option value="@daum.net">daum.net</option>
												<option value="@hanmail.net">hanmail.net</option>
												<option value="@nate.com">nate.com</option>
												<option value="@kakao.com">kakao.com</option>
												<option value="@icloud.com">icloud.com</option>
												<option value="etc">직접입력</option>
											</select>
											</span>
											<!--// 이메일 선택 시 -->
										</p>
									</div>
								</td>
							</tr>
							</tbody>
							</table>
						</fieldset>
						<!--// 본인확인 -->
						<div class="btnArea ct tPad30">
							<input type="button" onclick="TnByeBye(document.byeFrm);" class="btn btnS1 btnRed btnW160 fs12" value="탈퇴하기">
							<button type="button" onclick="history.back();" class="btn btnS1 btnGry btnW160 fs12">취소하기</button>
						</div>
					</form>
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
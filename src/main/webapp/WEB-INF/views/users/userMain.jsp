<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
	.lnbMy10x10V15 .profile {
	    padding-top: 29px;
	    background-color: #fff;
	    text-align: center;
	}
	
	.lnbMy10x10V15 .profile .figure {
    position: relative;
    margin-top: 15px;
	}
	
	.lnbMy10x10V15 .profile .figure a {
	    display: block;
	    position: absolute;
	    top: 0;
	    left: 50%;
	    width: 112px;
	    height: 112px;
	    margin-left: -56px;
	    background: url(http://fiximage.10x10.co.kr/web2015/my10x10/bg_sprite.png) no-repeat 0 0;
	    font-size: 11px;
	    text-indent: -999em;
	}
	
	.lnbMy10x10V15 .profile ul {
    margin-top: 24px;
    border-top: 1px dotted #ccdbe1;
    margin-left: -1px;
	}
	
	.lnbMy10x10V15 .profile ul li a {
    display: block;
    padding: 13px 0;
    border-left: 1px solid #f4eade;
    background-color: #f9f9f9;
    color: #555;
    font-size: 13px;
	}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<p><br/></p>
<div class="container">
	<div class="article profile new_pro21">
		<p class="hello">Hello, jhs2468</p>
		<div class="figure" id="myProfile">
			
			<strong onclick="location.href='/my10x10/special_info.asp';" class="classV18 g-white" style="cursor:pointer;">WHITE 회원</strong>
			<div class="profile_container">
				<img src="http://fiximage.10x10.co.kr/web2015/common/img_profile_17.png" width="100" height="100" alt="프로필이미지" />
			</div>
			<!-- <a href="/my10x10/userinfo/memberprofile.asp" onclick="window.open(this.href, 'popProfile', 'width=580, height=750, scrollbars=yes'); return false;" target="_blank" title="프로필 이미지 팝업">EDIT</a> -->
			<a href="javascript:void(0);" onclick="openProfileWriteModal(); return false;" title="프로필 이미지 팝업">EDIT</a>
			<!-- 21-10-03 프로필 추가 -->
			<div class="pro_info_area">
				<p class="glade"></p>
				<p class="nick_name"></p>
			</div>
			<!-- // -->
		</div>

		<!-- my badge-->
		<div class="nodata" style="display:none;"><span></span></div>

		<ul>
			<li><a href="/my10x10/couponbook.asp" title="쿠폰/보너스쿠폰 조회하기"><strong>4장</strong>쿠폰</a></li>
			<li class="mymileage"><a href="/my10x10/mymileage.asp" title="마일리지 현황 조회하기"><strong>257P</strong>마일리지</a><span id="mileageCreditAvailable"></span></li>
			<li><a href="/my10x10/myTenCash.asp" title="예치금 조회하기"><strong>0원</strong>예치금</a></li>
			<li><a href="/my10x10/giftcard/" title="기프트카드 조회하기"><strong>0원</strong>기프트카드</a></li>
		</ul>
	</div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/df66332deb.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Lato">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<script src="https://unpkg.com/ionicons@4.5.10-0/dist/ionicons.js"></script>
<script src="https://t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js" integrity="sha384-TiCUE00h649CAMonG018J2ujOgDKW/kVWlChEuu4jK2vxfAAD0eZxzCKakxg55G4" crossorigin="anonymous"></script>
<script>
  Kakao.init('f8adb2181213318e34c8e8f99a4eb70c');
</script>
	<style>
		.upBtn {
			display:none;
			position:fixed;
			bottom:30px;
			right:30px;
			width:45px;
			height:45px;
			z-index:999;
			-webkit-transition: all .5s;
			border:1px solid #ddd;
			outline:none;
			background-color:white;
			color:#333;
			cursor:pointer;
			text-align:center;
			line-height:2.5;
		    will-change: opacity, visibility;
		    visibility: visible;
		    background-color: rgba(247, 247, 248, 0.9);
		    border-radius: 18px;
		    transition: visibility 400ms ease 0s;
		    animation: 400ms cubic-bezier(0.36, 0, 0, 1) 0s 1 normal both running jBcSpD;
		    box-shadow: rgba(255, 255, 255, 0.2) 0px 0px 0px 1px inset, rgba(0, 0, 0, 0.1) 0px 4px 6px, rgba(0, 0, 0, 0.15) 0px 8px 30px;
		}
	</style>
	
<!-- OwlCarousel -->
<link rel="stylesheet" href="${ctp}/css/owl.carousel.min.css">
<link rel="stylesheet" href="${ctp}/css/owl.theme.default.min.css">
<!-- Magnific Popup -->
<link rel="stylesheet" href="${ctp}/css/magnific-popup.css">
<link rel="stylesheet" href="${ctp}/css/sweetalert.css">
<!-- Custom style -->
<link rel="stylesheet" href="${ctp}/css/style.css">
<link rel="stylesheet" href="${ctp}/css/all.css">
<link rel="stylesheet" href="${ctp}/css/demo.css">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>kakaomap.jsp</title>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
  <jsp:include page="/WEB-INF/views/include/user/header.jsp" />
  <jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br><p>
<div class="container">
	<div id="map" style="width:100%;height:500px;"></div>
	
	<!-- 카카오맵 Javascript API -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=f8adb2181213318e34c8e8f99a4eb70c"></script>
	<script>
		// 1. 지도를 띄워주는 기본 코드(지도 생성)
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3  // 지도의 확대/축소 레벨
		};

		var map = new kakao.maps.Map(container, options);
	</script>
	<hr>
	<jsp:include page="kakaoMenu.jsp" />
</div>
<p><br><p>
  <jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
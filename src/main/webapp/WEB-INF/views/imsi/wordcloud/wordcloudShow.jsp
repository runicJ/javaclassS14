<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>wordcloudShow.jsp</title>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<img src="${ctp}/${imagePath}" width="1000px" />  <!-- default가 원형 -->
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>productInput</title>
	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <script src="${ctp}/resources/ckeditor/ckeditor.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
<p><br></p>
<div class="container">

</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>title</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<section class="page">
<div class="container">
    <h2>${hospital.hospitalName} 후기</h2>
    <button onclick="location.href='${ctp}/community/hospitalCommentForm?hospitalIdx=${hospital.hospitalIdx}'">후기 작성</button>
    <ul>
        <c:forEach var="comment" items="${comments}">
            <li>
                <strong>${comment.hospitalCommentTitle}</strong> by ${comment.userId}<br>
                별점: ${comment.star} / 대기 시간: ${comment.waiting_time}분<br>
                ${comment.hospitalComment}
            </li>
        </c:forEach>
    </ul>
</div>
</section>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>noticeList</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<style>
		table {
		  border-collapse: collapse;
		  width: 100%;
		}
		
		th, td {
		  padding: 8px;
		  text-align: center;
		  border-bottom: 1px solid #DDD;
		}
		
		.trhover:hover {background-color: #D6EEEE;}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<section class="page">
<div class="container">
	<h2 class="mb-4"><i class="fa-solid fa-paperclip"></i> 공지사항</h2>
	
	<table>
		<tr>
			<th></th>
			<th>번호</th>
			<th>제목</th>
			<th>작성일</th>
			<th></th>
		</tr>
		<c:forEach var="noticeVO" items="${noticeVOS}" varStatus="st">
		<tr class="trhover">
			<td></td>
			<td>${st.count}</td>
			<td><a href="${ctp}/cswork/notice/noticeDetails?noticeIdx=${noticeVO.noticeIdx}">${noticeVO.noticeTitle}</a></td>
			<td>${fn:substring(noticeVO.createDate,0,10)}</td>
			<td></td>
		</tr>
	  </c:forEach>
	</table>

</div>
</section>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
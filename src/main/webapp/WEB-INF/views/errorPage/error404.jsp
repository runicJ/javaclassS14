<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>error404.jsp</title>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br/></p>
<div class="container">
  <h2>현재 시스템 정비중입니다.(404에러 발생시 보이는 화면)</h2>
  <div>(사용에 불편을 드려서 죄송합니다.)</div>
  <div>빠른시일내에 복구되도록 하겠습니다.</div>
  <hr/>
  <div><img src="${ctp}/images/la.jpg" width="300px" /></div>
  <hr/>
  <div>
    <a href="${ctp}/errorPage/errorMain" class="btn btn-success">돌아가기</a>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
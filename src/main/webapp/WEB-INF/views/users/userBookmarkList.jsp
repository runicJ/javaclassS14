<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
  	<style>
		* {
		  box-sizing: border-box;
		}
		
		body {
		  background-color: #f1f1f1;
		  padding: 20px;
		  font-family: Arial;
		}
		
		.main {
		  max-width: 1000px;
		  margin: auto;
		}
		
		h1 {
		  font-size: 50px;
		  word-break: break-all;
		}
		
		.row {
		  margin: 8px -16px;
		}
		
		.row,
		.row > .column {
		  padding: 8px;
		}
		
		.column {
		  float: left;
		  width: 33.33%;
		  display: none;
		}
		
		.row:after {
		  content: "";
		  display: table;
		  clear: both;
		}
		
		.content {
		  background-color: white;
		  padding: 10px;
		}
  	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br/></p>
<div class="container">
	<div class="row">
		<c:forEach var="vo" items="${vos}">
	  	<div class="column ${wishVo.residence}">
	    	<div class="content">
	      		
	    	</div>
  		</div>
  		</c:forEach>
	</div>
<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
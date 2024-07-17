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
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="page">
<div class="container">
	<form name="searchForm" method="get">
		<fieldset>
			<div class="bg-box bg-white">
				<div class="form-group">
					<label>병원검색</label>
					<select name="searchKey" class="form-control">
						<option>전체</option>
						<option>지역</option>
						<option>병원명</option>
					</select>
					<input type="text" id="keyword" class="form-control" placeholder="검색어를 입력하세요">
				</div>
			</div>
			<div class="text-center">
				<input type="button" class="btn btn-dark text-light" onclick="searchHospital();">
			</div>
		</fieldset>
	</form>
	<div class="demo">
		<ul name="regionList">
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>서울특별시</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>경기도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>강원도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>충청도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>경상도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>전라도</strong></a></li>
			<li><a href="#"><span class="num">0</span><strong><span>알레르기 전문병원</span>제주도</strong></a></li>
		</ul>
	</div>
	<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
</div>
</section>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
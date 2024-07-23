<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>title</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<style>
		/* iCheck plugin skins
		----------------------------------- */
		@import url("minimal/_all.css");
		
		@import url("square/_all.css");
		
		@import url("flat/_all.css");
		
		@import url("line/_all.css");
		
		@import url("polaris/polaris.css");
		
		@import url("futurico/futurico.css");
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="search">
	<div class="container">
		<div class="nav-tabs-group">
			<ul class="nav-tabs-list">
				<li class="active"><a href="#">All</a></li>
				<li><a href="#">Latest</a></li>
				<li><a href="#">Popular</a></li>
				<li><a href="#">Trending</a></li>
				<li><a href="#">Videos</a></li>
			</ul>
			<div class="nav-tabs-right">
				<select class="form-control">
					<option>Limit</option>
					<option>10</option>
					<option>20</option>
					<option>50</option>
					<option>100</option>
				</select>
			</div>
		</div>
		<div class="search-result">
			Search results for keyword "hello" found in 5,200 posts.
		</div>
		<div class="row">
			<p>광고</p>
			<article class="col-md-12 article-list">
				<div class="inner">
					<div class="badge">
						Sponsored
					</div>
					<figure>
						<a href="single.html">
							<img src="images/news/img02.jpg">
						</a>
					</figure>
					<div class="details">
						<div class="detail">
							<div class="category">
								<a href="#">Travel</a>
							</div>
							<time>December 18, 2016</time>
						</div>
						<h1><a href="single.html">Maecenas accumsan tortor ut velit pharetra mollis</a></h1>
						<p>
							Maecenas accumsan tortor ut velit pharetra mollis. Proin eu nisl et arcu iaculis placerat sollicitudin ut est. In fringilla dui.
						</p>
						<footer>
							<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>4209</div></a>
							<a class="btn btn-primary more" href="single.html">
								<div>More</div>
								<div><i class="ion-ios-arrow-thin-right"></i></div>
							</a>
						</footer>
					</div>
				</div>
			</article>
			
			<article class="col-md-12 article-list">
				<div class="inner">
					<figure>
						<a href="single.html">
							<img src="images/news/img11.jpg">
						</a>
					</figure>
					<div class="details">
						<div class="detail">
							<div class="category">
								<a href="#">Film</a>
							</div>
							<time>December 19, 2016</time>
						</div>
						<h1><a href="single.html">Donec consequat arcu at ultrices sodales quam erat aliquet diam</a></h1>
						<p>
						Donec consequat, arcu at ultrices sodales, quam erat aliquet diam, sit amet interdum libero nunc accumsan nisi.
						</p>
						<footer>
							<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>273</div></a>
							<a class="btn btn-primary more" href="single.html">
								<div>More</div>
								<div><i class="ion-ios-arrow-thin-right"></i></div>
							</a>
						</footer>
					</div>
				</div>
			</article>
		</div>
		<div class="line"></div>
		<div class="row">
			<p>제품</p>
		</div>
		<div class="line"></div>
		<div class ="row">
			<p>정보</p>
		</div>
		<div class="line"></div>
		<div class="row">
			<p>뉴스</p>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
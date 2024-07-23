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
		<div class="row">
			<div class="col-md-3">
				<aside>
					<h2 class="aside-title">Search</h2>
					<div class="aside-body">
						<p>Search with other keywords or use filters for more accurate results.</p>
						<form>
							<div class="form-group">
								<div class="input-group">
									<input type="text" name="q" class="form-control" placeholder="Type something ..." value="hello">
									<div class="input-group-btn">
										<button class="btn btn-primary">
											<i class="ion-search"></i>
										</button>
									</div>
								</div>
							</div>
						</form>
					</div>
				</aside>
				<aside>
					<h2 class="aside-title">Filter</h2>
					<div class="aside-body">
						<form class="checkbox-group">
							<div class="group-title">Date</div>
							<div class="form-group">
								<label><input type="radio" name="date" checked> Anytime</label>
							</div>
							<div class="form-group">
								<label><input type="radio" name="date"> Today</label>
							</div>
							<div class="form-group">
								<label><input type="radio" name="date"> Last Week</label>
							</div>
							<div class="form-group">
								<label><input type="radio" name="date"> Last Month</label>
							</div>
							<br>
							<div class="group-title">Categories</div>
							<div class="form-group">
								<label><input type="checkbox" name="category" checked> All Categories</label>
							</div>
							<div class="form-group">
								<label><input type="checkbox" name="category"> Lifestyle</label>
							</div>
							<div class="form-group">
								<label><input type="checkbox" name="category"> Travel</label>
							</div>
							<div class="form-group">
								<label><input type="checkbox" name="category"> Computer</label>
							</div>
							<div class="form-group">
								<label><input type="checkbox" name="category"> Film</label>
							</div>
							<div class="form-group">
								<label><input type="checkbox" name="category"> Sport</label>
							</div>
						</form>
					</div>
				</aside>
			</div>
			<div class="col-md-9">
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
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
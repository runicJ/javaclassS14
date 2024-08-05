<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>allergic1</title>
  	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
		<section class="single">
			<div class="container">
				<div class="row">
					<div class="col-md-4 sidebar" id="sidebar">
						<aside>
							<div class="aside-body">
								<figure class="ads">
									<img src="${ctp}/images/ad2.png">
									<figcaption>Advertisement</figcaption>
								</figure>
							</div>
						</aside>
						<aside>
							<h1 class="aside-title">Recent Post</h1>
							<div class="aside-body">
								<article class="article-fw">
									<div class="inner">
										<figure>
											<a href="single.html">												
												<img src="images/news/img16.jpg">
											</a>
										</figure>
										<div class="details">
											<h1><a href="single.html">Lorem Ipsum Dolor Sit Amet Consectetur Adipisicing Elit</a></h1>
											<p>
											Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
											tempor incididunt ut labore et dolore magna aliqua.
											</p>
											<div class="detail">
												<div class="time">December 26, 2016</div>
												<div class="category"><a href="category.html">Lifestyle</a></div>
											</div>
										</div>
									</div>
								</article>
								<div class="line"></div>
								<article class="article-mini">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="images/news/img05.jpg">
											</a>
										</figure>
										<div class="padding">
											<h1><a href="single.html">Duis aute irure dolor in reprehenderit in voluptate velit</a></h1>
											<div class="detail">
												<div class="category"><a href="category.html">Lifestyle</a></div>
												<div class="time">December 22, 2016</div>
											</div>
										</div>
									</div>
								</article>
								<article class="article-mini">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="images/news/img02.jpg">
											</a>
										</figure>
										<div class="padding">
											<h1><a href="single.html">Fusce ullamcorper elit at felis cursus suscipit</a></h1>
											<div class="detail">
												<div class="category"><a href="category.html">Travel</a></div>
												<div class="time">December 21, 2016</div>
											</div>
										</div>
									</div>
								</article>
								<article class="article-mini">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="images/news/img13.jpg">
											</a>
										</figure>
										<div class="padding">
											<h1><a href="single.html">Duis aute irure dolor in reprehenderit in voluptate velit</a></h1>
											<div class="detail">
												<div class="category"><a href="category.html">International</a></div>
												<div class="time">December 20, 2016</div>
											</div>
										</div>
									</div>
								</article>
							</div>
						</aside>
					</div>
					<div class="col-md-8">
						<ol class="breadcrumb">
						  <li><a href="#">Home</a></li>
						  <li class="active">[ 식품 알레르기 ]</li>
						</ol>
						<article class="article main-article">
							<header>
								<h1>${vo.item2}</h1>
							</header>
							<div class="main">
								<p>${vo.item3}</p>
								<div>
									
								</div>
								<p>${vo.item4}</p>
							</div>
							<p class="text-center">
								<button type="button" class="btn btn-light rounded-circle border border-2 border-end mr-2"><i class="fa-solid fa-bookmark"></i></button>
								<button type="button" class="btn btn-light rounded-circle border border-2 border-end"><i class="fa-solid fa-share-nodes"></i></button>
							</p>
						</article>
						<div class="line"><div>You May Also Like</div></div>
						<div class="row">
							<article class="article related col-md-6 col-sm-6 col-xs-12">
								<div class="inner">
									<figure>
										<a href="#">
											<img src="images/news/img03.jpg">
										</a>
									</figure>
									<div class="padding">
										<h2><a href="#">Duis aute irure dolor in reprehenderit in voluptate</a></h2>
										<div class="detail">
											<div class="category"><a href="category.html">Lifestyle</a></div>
											<div class="time">December 26, 2016</div>
										</div>
									</div>
								</div>
							</article>
							<article class="article related col-md-6 col-sm-6 col-xs-12">
								<div class="inner">
									<figure>
										<a href="#">
											<img src="images/news/img08.jpg">
										</a>
									</figure>
									<div class="padding">
										<h2><a href="#">Duis aute irure dolor in reprehenderit in voluptate</a></h2>
										<div class="detail">
											<div class="category"><a href="category.html">Lifestyle</a></div>
											<div class="time">December 26, 2016</div>
										</div>
									</div>
								</div>
							</article>
						</div>
					</div>
				</div>
			</div>
			<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
		</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
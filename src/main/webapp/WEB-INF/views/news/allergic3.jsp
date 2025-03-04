<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>allergic3</title>
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
									<img src="${ctp}/images/ad3.png">
									<figcaption>Advertisement</figcaption>
								</figure>
							</div>
						</aside>
						<aside>
							<div class="aside-body">
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
						  <li class="active">[ 아토피 피부염 ]</li>
						</ol>
						<article class="article main-article">
							<header>
								<h1>${vo.item2}</h1>
							</header>
							<div class="main">
								<p>${vo.item3}</p>
								<div class="featured">
									<figure>
										<img src="https://www.thermofisher.com${vo.item1}" alt="allergic3" style="object-fit:cover; width: 100%; height: auto;">
										<figcaption>Image by pexels.com</figcaption>
									</figure>
								</div>

								<p>${vo.item4}</p>

								<p>${vo.item5}</p>
							</div>
							<p class="text-center">
								<button type="button" class="btn btn-light rounded-circle border border-2 border-end mr-2"><i class="fa-solid fa-bookmark"></i></button>
								<button type="button" class="btn btn-light rounded-circle border border-2 border-end"><i class="fa-solid fa-share-nodes"></i></button>
							</p>
						</article>
						<div class="line thin"></div>
						<div class="comments">
							<h2 class="title"> 댓글</h2>
							<div class="comment-list">
							</div>
							<form class="row">
								<div class="col-md-12">
									<h3 class="title">의견 남기기</h3>
								</div>
								<div class="form-group col-md-12">
									<label for="userId">아이디 <span class="required"></span></label>
									<input type="text" id=""userId"" name=""userId"" class="form-control">
								</div>
								<div class="form-group col-md-12">
									<label for="message">의견 <span class="required"></span></label>
									<textarea class="form-control" name="message" placeholder="여러분의 의견을 적어주세요 ..."></textarea>
								</div>
								<div class="form-group col-md-12">
									<button class="btn btn-primary">의견 등록하기</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
		</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
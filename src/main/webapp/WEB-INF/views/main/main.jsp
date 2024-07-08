<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>Home</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<script>
		'use strict';
	    
		window.onload(function() {
			if(${sLogin == "Ok"}) {
				alert("현재 임시비밀번호를 발급하여 메일로 전송처리 되어 있습니다.\n개인정보를 확인하시고, 비밀번호를 새로 변경해 주세요!")
			}
		})
	</script>
</head>
<body class="skin-orange">
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<section class="home">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-sm-12 col-xs-12">
					<div class="headline">
						<div class="nav" id="headline-nav">
							<a class="left carousel-control" role="button" data-slide="prev">
								<span class="ion-ios-arrow-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="right carousel-control" role="button" data-slide="next">
								<span class="ion-ios-arrow-right" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
						<div class="owl-carousel owl-theme" id="headline">							
							<div class="item">
								<a href="#"><div class="badge">Tip!</div> Vestibulum ante ipsum primis in faucibus orci</a>
							</div>
							<div class="item">
								<a href="#">Ut rutrum sodales mauris ut suscipit</a>
							</div>
						</div>
					</div>
					<div class="owl-carousel owl-theme slide" id="featured">
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/basic/img04.jpg" alt="Sample Article">
								</figure>
								<div class="details">
									<div class="category"><a href="category.html">Computer</a></div>
									<h1><a href="single.html">Phasellus iaculis quam sed est elementum vel ornare ligula venenatis</a></h1>
									<div class="time">December 26, 2016</div>
								</div>
							</article>
						</div>
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/basic/img14.jpg" alt="Sample Article">
								</figure>
								<div class="details">
									<div class="category"><a href="category.html">Travel</a></div>
									<h1><a href="single.html">Class aptent taciti sociosqu ad litora torquent per conubia nostra</a></h1>
									<div class="time">December 10, 2016</div>
								</div>
							</article>
						</div>
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/basic/img13.jpg" alt="Sample Article">
								</figure>
								<div class="details">
									<div class="category"><a href="category.html">International</a></div>
									<h1><a href="single.html">Maecenas accumsan tortor ut velit pharetra mollis</a></h1>
									<div class="time">October 12, 2016</div>
								</div>
							</article>
						</div>
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/basic/img05.jpg" alt="Sample Article">
								</figure>
								<div class="details">
									<div class="category"><a href="category.html">Lifestyle</a></div>
									<h1><a href="single.html">Mauris elementum libero at pharetra auctor Fusce ullamcorper elit</a></h1>
									<div class="time">November 27, 2016</div>
								</div>
							</article>
						</div>
					</div>
					<div class="line">
						<div>알레르기 대표 정보</div>
					</div>
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="row">
								<article class="article col-md-12">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/basic/img10.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="time">December 10, 2016</div>
												<div class="category"><a href="category.html">Healthy</a></div>
											</div>
											<h2><a href="single.html">Duis aute irure dolor in reprehenderit in voluptate</a></h2>
											<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</p>
											<footer>
												<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>1263</div></a>
												<a class="btn btn-primary more" href="single.html">
													<div>More</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
								<article class="article col-md-12">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/basic/img06.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="time">December 22, 2016</div>
												<div class="category"><a href="category.html">Healthy</a></div>
											</div>
											<h2><a href="single.html">Exercitation ullamco laboris nisi ut aliquip</a></h2>
											<p>Maecenas accumsan tortor ut velit pharetra mollis. Proin eu nisl et arcu iaculis placerat sollicitudin ut est. In fringilla dui dui.</p>
											<footer>
												<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>327</div></a>
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
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="row">
								<article class="article col-md-12">
									<div class="inner">
										<figure>                                
											<a href="single.html">
												<img src="${ctp}/basic/img05.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="time">December 09, 2016</div>
												<div class="category"><a href="category.html">Lifestyle</a></div>
											</div>
											<h2><a href="single.html">Mauris elementum libero at pharetra auctor</a></h2>
											<p>Vivamus in efficitur mi. Nullam semper justo ut elit lacinia lacinia. Class aptent taciti sociosqu ad litora torquent per conubia nostra.</p>
											<footer>
												<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>1083</div></a>
												<a class="btn btn-primary more" href="single.html">
													<div>More</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
								<article class="article col-md-12">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/basic/img07.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="time">December 21, 2016</div>
												<div class="category"><a href="category.html">Sport</a></div>
											</div>
											<h2><a href="single.html">Sed do eiusmod tempor incididunt ut labore</a></h2>
											<p>Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris elementum libero at pharetra auctor.</p>
											<footer>
												<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>980</div></a>
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
					<div class="banner">
						<a href="#">
							<img src="${ctp}/basic/ads.png" alt="Sample Article">
						</a>
					</div>
					<div class="line transparent little"></div>
					<div class="row">
						<div class="col-md-6 col-sm-6 trending-tags">
							<h1 class="title-col">Trending Tags</h1>
							<div class="body-col">
								<ol class="tags-list">
									<li><a href="#">HTML5</a></li>
									<li><a href="#">CSS3</a></li>
									<li><a href="#">JavaScript</a></li>
									<li><a href="#">jQuery</a></li>
									<li><a href="#">Bootstrap</a></li>
									<li><a href="#">Responsive</a></li>
									<li><a href="#">AuteIrure</a></li>
									<li><a href="#">Voluptate</a></li>
									<li><a href="#">Veit</a></li>
									<li><a href="#">Reprehenderit</a></li>
								</ol>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<h1 class="title-col">
								Hot News
								<div class="carousel-nav" id="hot-news-nav">
									<div class="prev">
										<i class="ion-ios-arrow-left"></i>
									</div>
									<div class="next">
										<i class="ion-ios-arrow-right"></i>
									</div>
								</div>
							</h1>
							<div class="body-col vertical-slider" data-max="5" data-nav="#hot-news-nav" data-item="article">
								<article class="article-mini">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/basic/img09.jpg" alt="Sample Article">
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
												<img src="${ctp}/basic/img01.jpg" alt="Sample Article">
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
												<img src="${ctp}/basic/img05.jpg" alt="Sample Article">
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
												<img src="${ctp}/basic/img02.jpg" alt="Sample Article">
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
												<img src="${ctp}/basic/img13.jpg" alt="Sample Article">
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
								<article class="article-mini">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/basic/img08.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<h1><a href="single.html">Aliquam et metus convallis tincidunt velit ut rhoncus dolor</a></h1>
											<div class="detail">
												<div class="category"><a href="category.html">Computer</a></div>
												<div class="time">December 19, 2016</div>
											</div>
										</div>
									</div>
								</article>
							</div>
						</div>
					</div>
					<div class="line top">
						<div>Just Another News</div>
					</div>
					<div class="row">
						<article class="col-md-12 article-list">
							<div class="inner">
								<figure>
									<a href="single.html">
										<img src="${ctp}/basic/img11.jpg" alt="Sample Article">
									</a>
								</figure>
								<div class="details">
									<div class="detail">
										<div class="category">
											<a href="#">Film</a>
										</div>
										<div class="time">December 19, 2016</div>
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
						<article class="col-md-12 article-list">
							<div class="inner">
								<div class="badge">
									Sponsored
								</div>
								<figure>
									<a href="single.html">
										<img src="${ctp}/basic/img02.jpg" alt="Sample Article">
									</a>
								</figure>
								<div class="details">
									<div class="detail">
										<div class="category">
											<a href="#">Travel</a>
										</div>
										<div class="time">December 18, 2016</div>
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
										<img src="${ctp}/basic/img03.jpg" alt="Sample Article">
									</a>
								</figure>
								<div class="details">
									<div class="detail">
										<div class="category">
										<a href="#">Travel</a>
										</div>
										<div class="time">December 16, 2016</div>
									</div>
									<h1><a href="single.html">Nulla facilisis odio quis gravida vestibulum Proin venenatis pellentesque arcu</a></h1>
									<p>
										Nulla facilisis odio quis gravida vestibulum. Proin venenatis pellentesque arcu, ut mattis nulla placerat et.
									</p>
									<footer>
										<a href="#" class="love active"><i class="ion-android-favorite"></i> <div>302</div></a>
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
										<img src="${ctp}/basic/img09.jpg" alt="Sample Article">
									</a>
								</figure>
								<div class="details">
									<div class="detail">
										<div class="category">
											<a href="#">Healthy</a>
										</div>
										<div class="time">December 16, 2016</div>
									</div>
									<h1><a href="single.html">Maecenas blandit ultricies lorem id tempor enim pulvinar at</a></h1>
									<p>
										Maecenas blandit ultricies lorem, id tempor enim pulvinar at. Curabitur sit amet tortor eu ipsum lacinia malesuada.
									</p>
									<footer>
										<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>783</div></a>
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
				<div class="col-xs-6 col-md-4 sidebar" id="sidebar">
					<div class="sidebar-title for-tablet">Sidebar</div>
					<aside>
						<div class="aside-body">
							<div class="featured-author">
								<div class="featured-author-inner">
									<div class="featured-author-cover" style="background-image: url('${ctp}/basic/img15.jpg');">
										<div class="badges">
											<div class="badge-item"><i class="ion-star"></i> Featured</div>
										</div>
										<div class="featured-author-center">
											<figure class="featured-author-picture">
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
											</figure>
											<div class="featured-author-info">
												<h2 class="name">${!empty sUid ? sNickName : '입문자'}</h2>
												<div class="desc">@${!empty sUid ? sUid : 'guest'}</div>
											</div>
										</div>
									</div>
									<div class="featured-author-body">
										<div class="featured-author-count">
											<div class="item">
												<a href="#">
													<div class="name">Posts</div>
													<div class="value">208</div>														
												</a>
											</div>
											<div class="item">
												<a href="#">
													<div class="name">Stars</div>
													<div class="value">3,729</div>														
												</a>
											</div>
											<div class="item">
												<a href="#">
													<div class="icon">
														<div>More</div>
														<i class="ion-chevron-right"></i>
													</div>														
												</a>
											</div>
										</div>
										<div class="featured-author-quote">
											"Eur costrict mobsa undivani krusvuw blos andugus pu aklosah"
										</div>
										<div class="block">
											<h2 class="block-title">Photos</h2>
											<div class="block-body">
												<ul class="item-list-round" data-magnific="gallery">
													<li><a href="${ctp}/basic/img06.jpg" style="background-image: url('${ctp}/basic/img06.jpg');"></a></li>
													<li><a href="${ctp}/basic/img07.jpg" style="background-image: url('${ctp}/basic/img07.jpg');"></a></li>
													<li><a href="${ctp}/basic/img08.jpg" style="background-image: url('${ctp}/basic/img08.jpg');"></a></li>
													<li><a href="${ctp}/basic/img09.jpg" style="background-image: url('${ctp}/basic/img09.jpg');"></a></li>
													<li><a href="${ctp}/basic/img10.jpg" style="background-image: url('${ctp}/basic/img10.jpg');"></a></li>
													<li><a href="${ctp}/basic/img11.jpg" style="background-image: url('${ctp}/basic/img11.jpg');"></a></li>
													<li><a href="${ctp}/basic/img12.jpg" style="background-image: url('${ctp}/basic/img12.jpg');"><div class="more">+2</div></a></li>
													<li class="hidden"><a href="${ctp}/basic/img13.jpg" style="background-image: url('${ctp}/basic/img13.jpg');"></a></li>
													<li class="hidden"><a href="${ctp}/basic/img14.jpg" style="background-image: url('${ctp}/basic/img14.jpg');"></a></li>
												</ul>
											</div>
										</div>
										<div class="featured-author-footer">
											<a href="#">See All Authors</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</aside>
					<aside>
						<h1 class="aside-title">상단 뉴스 목록 
							<div class="carousel-nav" id="hot-news-nav">
								<div class="prev">
									<i class="ion-ios-arrow-left"></i>
								</div>
								<div class="next">
									<i class="ion-ios-arrow-right"></i>
								</div>
							</div>
						</h1>
						<div class="aside-body vertical-slider" data-max="5" data-nav="#hot-news-nav" data-item="article">
						<c:if test="${!empty naverVos}">
						<c:forEach var="naverVo" items="${naverVos}" varStatus="st">
					        <c:if test="${st.index % 6 == 0}">
			                    <div class="news-group">
			                        <c:forEach var="innerVo" items="${naverVos}" varStatus="innerSt" begin="${st.index}" end="${st.index + 4}">
			                            <article class="article-mini">
			                                <div class="inner">
			                                    <figure><a style="object-fit:fill;">${innerVo.item2}</a></figure>
			                                    <div class="padding">
			                                        <h1><a href="${innerVo.itemUrl}" target="_blank">${innerVo.item1}</a></h1>
			                                        <div class="detail">
														<div class="category"><a href="category.html">Lifestyle</a></div>
														<div class="time">${innerVo.item4}</div>
													</div>
			                                    </div>
			                                </div>
			                            </article>
			                        </c:forEach>
			                    </div>
			                </c:if>
					    </c:forEach>
						</c:if>
						<c:if test="${empty naverVos}">
							<p>spinner</p>
							<span>뉴스 업데이트 중입니다..<br>잠시만 기다려주세요..<br>(네트워크 '수리중'일 수 있습니다.)</span>
						</c:if>
						</div>
						<span class="float-right"><a href="#" class="all">더보기 <i class="ion-ios-arrow-right"></i></a></span>
					</aside>
					<aside>
						<ul class="nav nav-tabs nav-justified" role="tablist">
							<li class="active">
								<a href="#recomended" aria-controls="recomended" role="tab" data-toggle="tab">
									<i class="ion-android-star-outline"></i> Recomended
								</a>
							</li>
							<li>
								<a href="#comments" aria-controls="comments" role="tab" data-toggle="tab">
									<i class="ion-ios-chatboxes-outline"></i> Comments
								</a>
							</li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="recomended">
								<article class="article-fw">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/basic/img16.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="details">
											<div class="detail">
												<div class="time">December 31, 2016</div>
												<div class="category"><a href="category.html">Sport</a></div>
											</div>
											<h1><a href="single.html">Donec congue turpis vitae mauris</a></h1>
											<p>
												Donec congue turpis vitae mauris condimentum luctus. Ut dictum neque at egestas convallis. 
											</p>
										</div>
									</div>
								</article>
								<div class="line"></div>
								<article class="article-mini">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/basic/img05.jpg" alt="Sample Article">
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
												<img src="${ctp}/basic/img02.jpg" alt="Sample Article">
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
												<img src="${ctp}/basic/img10.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<h1><a href="single.html">Duis aute irure dolor in reprehenderit in voluptate velit</a></h1>
											<div class="detail">
												<div class="category"><a href="category.html">Healthy</a></div>
												<div class="time">December 20, 2016</div>
											</div>
										</div>
									</div>
								</article>
							</div>
							<div class="tab-pane comments" id="comments">
								<div class="comment-list sm">
									<div class="item">
										<div class="user">                                
											<figure>
												<img src="${ctp}/basic/img01.jpg" alt="User Picture">
											</figure>
											<div class="details">
												<h5 class="name">Mark Otto</h5>
												<div class="time">24 Hours</div>
												<div class="description">
													Lorem ipsum dolor sit amet, consectetur adipisicing elit.
												</div>
											</div>
										</div>
									</div>
									<div class="item">
										<div class="user">                                
											<figure>
												<img src="${ctp}/basic/img01.jpg" alt="User Picture">
											</figure>
											<div class="details">
												<h5 class="name">Mark Otto</h5>
												<div class="time">24 Hours</div>
												<div class="description">
													Lorem ipsum dolor sit amet, consectetur adipisicing elit.
												</div>
											</div>
										</div>
									</div>
									<div class="item">
										<div class="user">                                
											<figure>
												<img src="${ctp}/basic/img01.jpg" alt="User Picture">
											</figure>
											<div class="details">
												<h5 class="name">Mark Otto</h5>
												<div class="time">24 Hours</div>
												<div class="description">
													Lorem ipsum dolor sit amet, consectetur adipisicing elit.
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</aside>
					<aside>
						<h1 class="aside-title">Videos
							<div class="carousel-nav" id="video-list-nav">
								<div class="prev"><i class="ion-ios-arrow-left"></i></div>
								<div class="next"><i class="ion-ios-arrow-right"></i></div>
							</div>
						</h1>
						<div class="aside-body">
							<ul class="video-list" data-youtube='"carousel":true, "nav": "#video-list-nav"'>
								<li><a data-youtube-id="SBjQ9tuuTJQ" data-action="magnific"></a></li>
								<li><a data-youtube-id="9cVJr3eQfXc" data-action="magnific"></a></li>
								<li><a data-youtube-id="DnGdoEa1tPg" data-action="magnific"></a></li>
							</ul>
						</div>
					</aside>
					<aside id="sponsored">
						<h1 class="aside-title">Sponsored</h1>
						<div class="aside-body">
							<ul class="sponsored">
								<li>
									<a href="#">
										<img src="${ctp}/basic/sponsored.png" alt="Sponsored">
									</a>
								</li> 
								<li>
									<a href="#">
										<img src="${ctp}/basic/sponsored.png" alt="Sponsored">
									</a>
								</li> 
								<li>
									<a href="#">
										<img src="${ctp}/basic/sponsored.png" alt="Sponsored">
									</a>
								</li> 
								<li>
									<a href="#">
										<img src="${ctp}/basic/sponsored.png" alt="Sponsored">
									</a>
								</li> 
							</ul>
						</div>
					</aside>
				</div>
			</div>
		</div>
	</section>

	<section class="best-of-the-week">
		<div class="container">
			<h1>
				<div class="text">Best Of The Week</div>
				<div class="carousel-nav" id="best-of-the-week-nav">
					<div class="prev">
						<i class="ion-ios-arrow-left"></i>
					</div>
					<div class="next">
						<i class="ion-ios-arrow-right"></i>
					</div>
				</div>
			</h1>
			<div class="owl-carousel owl-theme carousel-1">
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/basic/img03.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
									<div class="time">December 11, 2016</div>
									<div class="category"><a href="category.html">Travel</a></div>
							</div>
							<h2><a href="single.html">tempor interdum Praesent tincidunt</a></h2>
							<p>Praesent tincidunt, leo vitae congue molestie.</p>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/basic/img16.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 09, 2016</div>
								<div class="category"><a href="category.html">Sport</a></div>
							</div>
							<h2><a href="single.html">Maecenas porttitor sit amet turpis a semper</a></h2>
							<p> Proin vulputate, urna id porttitor luctus, dui augue facilisis lacus.</p>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/basic/img15.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 26, 2016</div>
								<div class="category"><a href="category.html">Lifestyle</a></div>
							</div>
							<h2><a href="single.html">Fusce ac odio eu ex volutpat pellentesque</a></h2>
							<p>Vestibulum ante ipsum primis in faucibus orci luctus</p>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/basic/img14.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 26, 2016</div>
								<div class="category"><a href="category.html">Travel</a></div>
							</div>
							<h2><a href="single.html">Nulla facilisis odio quis gravida vestibulum</a></h2>
							<p>Proin venenatis pellentesque arcu, ut mattis nulla placerat et.</p>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/basic/img01.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 26, 2016</div>
								<div class="category"><a href="category.html">Travel</a></div>
							</div>
							<h2><a href="single.html">Fusce Ullamcorper Elit At Felis Cursus Suscipit</a></h2>
							<p>Proin venenatis pellentesque arcu, ut mattis nulla placerat et.</p>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/basic/img11.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 26, 2016</div>
								<div class="category"><a href="category.html">Travel</a></div>
							</div>
							<h2><a href="single.html">Donec consequat arcu at ultrices sodales</a></h2>
							<p>Proin venenatis pellentesque arcu, ut mattis nulla placerat et.</p>
						</div>
					</div>
				</article>
			</div>
		</div>
	</section>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>
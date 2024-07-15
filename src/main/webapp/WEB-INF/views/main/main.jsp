<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>Home</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<style>
		.upBtn {
			display:none;
			position:fixed;
			bottom:30px;
			right:30px;
			width:45px;
			height:45px;
			z-index:999;
			-webkit-transition: all .5s;
			border:1px solid #ddd;
			outline:none;
			background-color:white;
			color:#333;
			cursor:pointer;
			text-align:center;
			line-height:2.5;
		    will-change: opacity, visibility;
		    visibility: visible;
		    background-color: rgba(247, 247, 248, 0.9);
		    border-radius: 18px;
		    transition: visibility 400ms ease 0s;
		    animation: 400ms cubic-bezier(0.36, 0, 0, 1) 0s 1 normal both running jBcSpD;
		    box-shadow: rgba(255, 255, 255, 0.2) 0px 0px 0px 1px inset, rgba(0, 0, 0, 0.1) 0px 4px 6px, rgba(0, 0, 0, 0.15) 0px 8px 30px;
		}
        .carousel-nav .prev:hover, .carousel-nav .next:hover {
            color: #FF4500;
            opacity: 0.7;
        }
	</style>
</head>

<body class="skin-orange">
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
	<section class="home">
		<div class="container">
			<div class="row">
				<div class="col-md-8 col-sm-12 col-xs-12">
					<div class="headline">
						<div class="nav text-center" id="headline-nav">
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
								<a href="#"><span class="badge">Tip!</span> 이벤트 공지</a>
							</div>
							<div class="item">
								<a href="#">홈페이지 오픈</a>
							</div>
						</div>
					</div>
					<div class="owl-carousel owl-theme slide" id="featured">
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/images/banner1.jpg" alt="Sample Article">
								</figure>
								<div class="details">
									<div class="category"><a href="#">공지사항</a></div>
									<h1><a href="#">첫가입, 첫구매 시 적립금/쿠폰 지급</a></h1>
									<div class="time">2024.7.13.</div>
								</div>
							</article>
						</div>
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/images/banner2.jpg" alt="Sample Article">
								</figure>
								<div class="details">
									<div class="category"><a href="${ctp}/event/eventList">이벤트</a></div>
									<h1><a href="${ctp}/survey/surveyList">설문조사 이벤트</a></h1>
									<div class="time">D-100</div>
								</div>
							</article>
						</div>
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/images/banner3.jpg" alt="Sample Article">
								</figure>
								<div class="details">
									<div class="category"><a href="${ctp}/event/eventList">이벤트</a></div>
									<h1><a href="${ctp}/review/photoReview/photoGalleryList">포토리뷰 이벤트</a></h1>
									<div class="time">D-200</div>
								</div>
							</article>
						</div>
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/images/banner4.jpg" alt="Sample Article">
								</figure>
								<div class="details">
									<div class="category"><a href="#">공지사항</a></div>
									<h1><a href="single.html">카톡 친구 추가시 쿠폰 지급</a></h1>
									<div class="time">2024.7.13.</div>
								</div>
							</article>
						</div>
					</div>		
					<div class="line">
						<div>대표적인 알레르기 정보</div>
					</div>
					<div class="row">
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="row">
								<article class="article col-md-12">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="time">December 10, 2016</div>
												<div class="category"><a href="category.html">Healthy</a></div>
											</div>
											<h2><a href="single.html">호흡기 알레르기</a></h2>
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="time">December 22, 2016</div>
												<div class="category"><a href="category.html">Healthy</a></div>
											</div>
											<h2><a href="single.html">식품 알레르기</a></h2>
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="time">December 09, 2016</div>
												<div class="category"><a href="category.html">Lifestyle</a></div>
											</div>
											<h2><a href="single.html">아토피 피부염</a></h2>
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="time">December 21, 2016</div>
												<div class="category"><a href="category.html">Sport</a></div>
											</div>
											<h2><a href="single.html">기타 알레르기(실내, 계절성 등)</a></h2>
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
							<img src="${ctp}/images/ad.png" alt="알레르망">
						</a>
					</div>
					<div class="line transparent little"></div>
					<div class="row">
						<div class="col-md-6 col-sm-6 trending-tags">
							<h1 class="title-col">검색 순위</h1>
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
								워드클라우드(인기단어)
								<div class="carousel-nav" id="hot-news-nav">
									<div class="prev">
										<i class="ion-ios-arrow-left"></i>
									</div>
									<div class="next">
										<i class="ion-ios-arrow-right"></i>
									</div>
								</div>
							</h1>
							<div class="body-col vertical-slider" data-max="4" data-nav="#hot-news-nav" data-item="article">
								<article class="article-mini">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
						<div>인기 제품</div>
					</div>
					    <!-- Categories Section Begin -->
    <section class="categories">
        <div class="container">
            <div class="row">
                <div class="categories__slider owl-carousel">
                    <div class="col-lg-3">
                        <div class="categories__item set-bg" data-setbg="${ctp}/user/noImage.jpg">
                            <h5><a href="#">Fresh Fruit</a></h5>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="categories__item set-bg" data-setbg="${ctp}/user/noImage.jpg">
                            <h5><a href="#">Dried Fruit</a></h5>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="categories__item set-bg" data-setbg="${ctp}/user/noImage.jpg">
                            <h5><a href="#">Vegetables</a></h5>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="categories__item set-bg" data-setbg="${ctp}/user/noImage.jpg">
                            <h5><a href="#">drink fruits</a></h5>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="categories__item set-bg" data-setbg="${ctp}/user/noImage.jpg">
                            <h5><a href="#">drink fruits</a></h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Categories Section End -->

				</div>
				<div class="col-xs-6 col-md-4 sidebar" id="sidebar">
					<div class="sidebar-title for-tablet">Sidebar</div>
					<aside>
						<div class="aside-body">
							<div class="featured-author">
								<div class="featured-author-inner">
									<div class="featured-author-cover" style="background-image: url('${ctp}/images/bg.jpg');">
										<div class="badges">
											<div class="badge-item"><i class="ion-star"></i> 귀한분</div>
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
													<div class="name">북마크</div>
													<div class="value">0</div>														
												</a>
											</div>
											<div class="item">
												<a href="#">
													<div class="name">좋아요</div>
													<div class="value">0</div>														
												</a>
											</div>
											<div class="item">
												<a href="${ctp}/users/userMain">
													<div class="icon"><i class="fa-solid fa-gear"></i>
														<div>내정보</div>
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
													<li><a href="${ctp}/images/noImage.jpg" style="background-image: url('${ctp}/images/noImage.jpg');"></a></li>
													<li><a href="${ctp}/images/noImage.jpg" style="background-image: url('${ctp}/images/noImage.jpg');"></a></li>
													<li><a href="${ctp}/images/noImage.jpg" style="background-image: url('${ctp}/images/noImage.jpg');"><div class="more">+2</div></a></li>
													<li class="hidden"><a href="${ctp}/images/noImage.jpg" style="background-image: url('${ctp}/images/noImage.jpg');"></a></li>
													<li class="hidden"><a href="${ctp}/images/noImage.jpg" style="background-image: url('${ctp}/images/noImage.jpg');"></a></li>
												</ul>
											</div>
										</div>
										<div class="featured-author-footer">
											<a href="${ctp}/community/chat/userChat">커뮤니티(유저 채팅방)</a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</aside>
					<aside>
						<div class="d-flex justify-content-between align-items-center">
					    	<h1 class="aside-title">네이버 상위 뉴스 목록 ('알레르기')</h1>
					        <div class="carousel-nav" id="hot-news-nav" style="display:flex;">
					            <div class="prev mr-3" data-target="#hot-news-carousel" data-slide="prev" style="cursor:pointer;">
					                <i class="ion-ios-arrow-left"></i>
					            </div>
					            <div class="next mr-3" data-target="#hot-news-carousel" data-slide="next" style="cursor:pointer;">
					                <i class="ion-ios-arrow-right"></i>
					            </div>
					        </div>
						</div>
					    <div id="hot-news-carousel" class="carousel slide" data-max="6" data-ride="carousel">
					        <div class="carousel-inner">
					            <c:if test="${!empty vos}">
					                <c:forEach var="vo" items="${vos}" varStatus="status">
					                    <c:if test="${status.index % 5 == 0}">
					                        <div class="carousel-item ${status.index == 0 ? 'active' : ''}">
					                            <div class="news-group">
					                    </c:if>
					                    <article class="article-mini">
					                        <div class="inner">
					 							<figure>
					                                <c:choose>
					                                    <c:when test="${!empty vo.item2}">
					                                        <img src="${vo.item2}" alt="news image" style="object-fit:cover; width: 100%; height: auto;">
					                                    </c:when>
					                                    <c:otherwise>
					                                        <img src="${ctp}/images/noImage.jpg" alt="default image" style="object-fit:cover; width: 100%; height: auto;">
					                                    </c:otherwise>
					                                </c:choose>
					                            </figure>
					                            <div class="padding">
					                                <h1><a href="${vo.itemUrl1}" target="_blank">${vo.item1}</a></h1>
					                                <div class="detail">
					                                    <div class="category"><a href="${vo.itemUrl2}">${vo.item4}</a></div>
					                                    <div class="time">${vo.item5}</div>
				                                	</div>
				                            	</div>
					                        </div>
					                    </article>
					                    <c:if test="${(status.index + 1) % 5 == 0 || status.index + 1 == vos.size()}">
					                            </div>
					                        </div>
					                    </c:if>
					                </c:forEach>
					            </c:if>
					            <c:if test="${empty vos}">
					                <p>spinner</p>
					                <span>뉴스 업데이트 중입니다..<br>잠시만 기다려주세요..<br>(서버 '수리중'일 수 있습니다.)</span>
					            </c:if>
					        </div>
					    </div>
					    <p class="float-right">
					        <a href="${ctp}/news/newsList" class="all">더보기 <i class="ion-ios-arrow-right"></i></a>
					    </p>
					</aside>
					<aside>
						<div class="aside-body">
							<form class="newsletter">
								<h1>Newsletter</h1>
								<p>By subscribing you will receive new articles in your email.</p>
							</form>
						</div>
					</aside>
					<aside>
						<ul class="nav nav-tabs nav-justified" role="tablist">
							<li class="active">
								<a href="#recomended" aria-controls="recomended" role="tab" data-toggle="tab">
									<i class="ion-android-star-outline"></i> 맞춤 정보 [베타]
								</a>
							</li>
							<li>
								<a href="#comments" aria-controls="comments" role="tab" data-toggle="tab">
									<i class="ion-ios-chatboxes-outline"></i> 인기 게시글
								</a>
							</li>
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="recomended">
								<article class="article-fw">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
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
												<img src="${ctp}/user/noImage.jpg" alt="User Picture">
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
												<img src="${ctp}/user/noImage.jpg" alt="User Picture">
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
												<img src="${ctp}/user/noImage.jpg" alt="User Picture">
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
						<h1 class="aside-title">유튜브 영상
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
						<h1 class="aside-title">유료 광고 배너</h1>
						<div class="aside-body">
							<ul class="sponsored">
								<li>
									<a href="#">
										<img src="${ctp}/images/ad1.png" alt="Sponsored">
									</a>
								</li> 
								<li>
									<a href="#">
										<img src="${ctp}/images/ad2.png" alt="Sponsored">
									</a>
								</li> 
								<li>
									<a href="#">
										<img src="${ctp}/images/ad3.png" alt="Sponsored">
									</a>
								</li> 
								<li>
									<a href="#">
										<img src="${ctp}/images/ad4.jpg" alt="Sponsored">
									</a>
								</li> 
							</ul>
						</div>
					</aside>
				</div>
		</section>

	<section class="best-of-the-week">
		<div class="container">
			<h1><div class="text">추천 후기글</div>
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
								<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
									<div class="time">December 11, 2016</div>
									<div class="category"><a href="category.html">Travel</a></div>
							</div>
							<h2><a href="single.html">tempor interdum Praesent tincidunt</a></h2>
							<p>Praesent tincidunt, leo vitae congue molestie.</p>
							<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>980</div></a>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 09, 2016</div>
								<div class="category"><a href="category.html">Sport</a></div>
							</div>
							<h2><a href="single.html">Maecenas porttitor sit amet turpis a semper</a></h2>
							<p> Proin vulputate, urna id porttitor luctus, dui augue facilisis lacus.</p>
							<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>980</div></a>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 26, 2016</div>
								<div class="category"><a href="category.html">Lifestyle</a></div>
							</div>
							<h2><a href="single.html">Fusce ac odio eu ex volutpat pellentesque</a></h2>
							<p>Vestibulum ante ipsum primis in faucibus orci luctus</p>
							<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>980</div></a>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 26, 2016</div>
								<div class="category"><a href="category.html">Travel</a></div>
							</div>
							<h2><a href="single.html">Nulla facilisis odio quis gravida vestibulum</a></h2>
							<p>Proin venenatis pellentesque arcu, ut mattis nulla placerat et.</p>
							<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>980</div></a>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 26, 2016</div>
								<div class="category"><a href="category.html">Travel</a></div>
							</div>
							<h2><a href="single.html">Fusce Ullamcorper Elit At Felis Cursus Suscipit</a></h2>
							<p>Proin venenatis pellentesque arcu, ut mattis nulla placerat et.</p>
							<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>980</div></a>
						</div>
					</div>
				</article>
				<article class="article">
					<div class="inner">
						<figure>
							<a href="single.html">
								<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
							</a>
						</figure>
						<div class="padding">
							<div class="detail">
								<div class="time">December 26, 2016</div>
								<div class="category"><a href="category.html">Travel</a></div>
							</div>
							<h2><a href="single.html">Donec consequat arcu at ultrices sodales</a></h2>
							<p>Proin venenatis pellentesque arcu, ut mattis nulla placerat et.</p>
							<a href="#" class="love"><i class="ion-android-favorite-outline"></i> <div>980</div></a>
						</div>
					</div>
				</article>
			</div>
		</div>
		<a href="#" class="upBtn"><span><i class="fa-solid fa-angle-up"></i></span></a>
	</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
<script>
    $(document).ready(function(){
        $('.prev').click(function(){
            $('#hot-news-carousel').carousel('prev');
        });
        $('.next').click(function(){
            $('#hot-news-carousel').carousel('next');
        });
    });
    
    $(window).scroll(function(){
    	if ($(this).scrollTop() > 300){
    		$('.upBtn').show();
    	} else{
    		$('.upBtn').hide();
    	}
    });
    $('.upBtn').click(function(){
    	$('html, body').animate({scrollTop:0},400);
    	return false;
    });
</script>
</body>
</html>
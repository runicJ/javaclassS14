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
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <link rel="stylesheet" href="${ctp}/css/shop/style.css" type="text/css">
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
        
        .ad {
        	position: relative;
			overflow: hidden;
			cursor: pointer;
			opacity: 0.6;        	
        }
        
        .ad img {
        	width: 100%;
        	height: 100%;
        	animation : enlarge 6s infinite alternate;
        }
        
        @keyframes enlarge {
        	from {
        		transform:scale(1.1);
        	}
        	to {
        		transform:scale(1);
        	}
        }
        
        .good { color: green; }
        .moderate { color: orange; }
        .bad { color: red; }
	</style>
	<script>
		function getAirQualityData() {
	        var xhr = new XMLHttpRequest();
	        var url = 'http://apis.data.go.kr/B552584/ArpltnInforInqireSvc/getUnityAirEnvrnIdexSnstiveAboveMsrstnList';
	        var queryParams = '?' + encodeURIComponent('serviceKey') + '=' + 'otJChM%2F2%2FlhEU46DhF2TXCxo%2FN9BNwpNNkd7XGrlrOdggtMr%2FDciosXbEvJ4D4KWcS5sjYmneyYHiQSWh%2ByUMQ%3D%3D';
	        queryParams += '&' + encodeURIComponent('returnType') + '=' + encodeURIComponent('json');
	        queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('1');
	        queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1');
	        xhr.open('GET', url + queryParams);
	        xhr.onreadystatechange = function () {
	            if (this.readyState == 4) {
	                if (this.status == 200) {
	                    var response = JSON.parse(this.responseText);
	                    var airQualityValue = response.response.body.items[0].pm10Value;
	                    var airQualityLevel = '';
	                    var icon = '';
	
	                    if (airQualityValue <= 30) {
	                        airQualityLevel = 'Good';
	                        icon = 'good_icon.png';
	                    } else if (airQualityValue <= 80) {
	                        airQualityLevel = 'Moderate';
	                        icon = 'moderate_icon.png';
	                    } else {
	                        airQualityLevel = 'Bad';
	                        icon = 'bad_icon.png';
	                    }
	
	                    document.getElementById('airQualityIcon').src = icon;
	                    document.getElementById('airQualityText').innerHTML = '현재 대기오염 수치: ' + airQualityValue;
	                    document.getElementById('airQualityText').className = airQualityLevel.toLowerCase();
	                } else {
	                    alert('Error: ' + this.status);
	                }
	            }
	        };
	        xhr.send('');
	    }
	
	    window.onload = function() {
	        getAirQualityData();
	    };
	</script>
</head>

<body class="skin-pulple">
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
								<span class="sr-only">이전</span>
							</a>
							<a class="right carousel-control" role="button" data-slide="next">
								<span class="ion-ios-arrow-right" aria-hidden="true"></span>
								<span class="sr-only">다음</span>
							</a>
						</div>
						<div class="owl-carousel owl-theme" id="headline">							
							<div class="item">
								<a href="#"><span class="badge">공지</span> 이벤트 공지</a>
							</div>
							<div class="item">
								<a href="#"><span class="badge">주목</span> 홈페이지 오픈 기념 무료 배송</a>
							</div>
						</div>
					</div>
					<div class="owl-carousel owl-theme slide" id="featured">
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
									<img src="${ctp}/images/banner1.png" alt="Sample Article">
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
									<img src="${ctp}/images/banner2.png" alt="Sample Article">
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
									<img src="${ctp}/images/banner3.png" alt="Sample Article">
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
									<img src="${ctp}/images/banner4.png" alt="Sample Article">
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
					            <c:if test="${!empty vos1}">
				                <c:forEach var="vo1" items="${vos1}">
								<article class="article col-md-12">
									<div class="inner">
										<figure style="height:100px;">
											<a href="single.html">
												<img src="https://www.thermofisher.com/${vo1.item1}" alt="allergic1" style="object-fit:cover; width: 100%; height: auto;">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="category"><a href="${ctp}/#">[ 호흡기 알레르기 ]</a></div>
											</div>
											<h2><a href="single.html">${vo1.item2}</a></h2>
											<p>
												<c:choose>
												  <c:when test="${fn:length(vo1.item3) gt 80}">
												    <c:out value="${fn:substring(vo1.item3,0,80)}" />...
												  </c:when>
												  <c:otherwise>
												    <c:out value="${vo1.item3}" />
												  </c:otherwise>
												</c:choose>
											</p>
											<footer>
												<a href="${ctp}/users/saveBookmarkToggle" class="bookmark"><i class="fa-solid fa-bookmark"></i><div>0</div></a>
												<a class="btn btn-primary more" href="${ctp}/news/allergic1">
													<div>더보기</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
								</c:forEach>
								</c:if>
				            	<c:if test="${!empty vos2}">
				                <c:forEach var="vo2" items="${vos2}">
								<article class="article col-md-12">
									<div class="inner">
										<figure style="height:100px;">
											<a href="single.html">
												<img src="https://www.thermofisher.com/${vo2.item1}" alt="allergic2" style="object-fit:cover; width: 100%; height: auto;">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="category"><a href="category.html">[ 식품 알레르기 ]</a></div>
											</div>
											<h2><a href="single.html">${vo2.item2}</a></h2>
											<p>
												<c:choose>
												  <c:when test="${fn:length(vo2.item3) gt 80}">
												    <c:out value="${fn:substring(vo2.item3,0,80)}" />...
												  </c:when>
												  <c:otherwise>
												    <c:out value="${vo2.item3}" />
												  </c:otherwise>
												</c:choose>
											</p>
											<footer>
												<a href="${ctp}/users/saveBookmarkToggle" class="bookmark"><i class="fa-solid fa-bookmark"></i><div>0</div></a>
												<a class="btn btn-primary more" href="${ctp}/news/allergic2">
													<div>더보기</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
								</c:forEach>
								</c:if>
							</div>
						</div>
						<div class="col-md-6 col-sm-6 col-xs-12">
							<div class="row">
				            	<c:if test="${!empty vos3}">
				                <c:forEach var="vo3" items="${vos3}">
								<article class="article col-md-12">
									<div class="inner">
										<figure style="height:100px;">                                
											<a href="single.html">
												<img src="https://www.thermofisher.com/${vo3.item1}" alt="allergic3" style="object-fit:cover; width: 100%; height: auto;">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="category"><a href="category.html">[ 아토피 피부염 ]</a></div>
											</div>
											<h2><a href="single.html">${vo3.item2}</a></h2>
											<p>
												<c:choose>
												  <c:when test="${fn:length(vo3.item3) gt 80}">
												    <c:out value="${fn:substring(vo3.item3,0,80)}" />...
												  </c:when>
												  <c:otherwise>
												    <c:out value="${vo3.item3}" />
												  </c:otherwise>
												</c:choose>
											</p>
											<footer>
												<a href="${ctp}/users/saveBookmarkToggle" class="bookmark"><i class="fa-solid fa-bookmark"></i><div>0</div></a>
												<a class="btn btn-primary more" href="${ctp}/news/allergic3">
													<div>더보기</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
								</c:forEach>
								</c:if>
			            		<c:if test="${!empty vos4}">
				                <c:forEach var="vo4" items="${vos4}">
								<article class="article col-md-12">
									<div class="inner">
										<figure style="height:100px;">                                
											<a href="single.html">
												<img src="https://www.thermofisher.com/${vo4.item1}" alt="allergic4" style="object-fit:cover; width: 100%; height: auto;">
											</a>
										</figure>
										<div class="padding">
											<div class="detail">
												<div class="category"><a href="category.html">[ 기타 알레르기 ]</a></div>
											</div>
											<h2><a href="single.html">${vo4.item2}</a></h2>
											<p>
												<c:choose>
												  <c:when test="${fn:length(vo4.item3) gt 80}">
												    <c:out value="${fn:substring(vo4.item3,0,80)}" />...
												  </c:when>
												  <c:otherwise>
												    <c:out value="${vo4.item3}" />
												  </c:otherwise>
												</c:choose>
											</p>
											<footer>
												<a href="${ctp}/users/saveBookmarkToggle" class="bookmark"><i class="fa-solid fa-bookmark"></i><div>0</div></a>
												<a class="btn btn-primary more" href="${ctp}/news/allergic4">
													<div>더보기</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
								</c:forEach>
								</c:if>
							</div>
						</div>
					</div>
					<div class="banner">
						<a href="https://www.allerman.com/" target="_blank">
							<img src="${ctp}/images/ad1.png" alt="알레르망">
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
							</h1>
						</div>
					</div>
					<div class="line top">
						<div>신제품 목록</div>
					</div>
            <div class="row">
            	<c:forEach var="productVO" items="${productVOS}">
                <div class="col-lg-4 col-md-6 col-sm-6">
                    <div class="product__item">
                        <div class="product__item__pic set-bg" data-setbg="${ctp}/product/${productVO.productThumb}" style="object-fit:cover;">
                            <c:if test="${productVO.createDiff > -7}"><span class="label">New</span></c:if>
                            <ul class="product__hover">
	                            <li><a href="#"><i class="fa-solid fa-heart"></i><span>관심등록</span></a></li>
	                            <li><a href="#"><i class="fa-solid fa-share"></i><span>공유하기</span></a></li>
	                            <li><a href="#"><i class="fa-solid fa-bag-shopping"></i><span>장바구니</span></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h5><a href="${ctp}/shop/productDetails?productIdx=${productVO.productIdx}">${productVO.productName}</a></h5>
                            <div class="rating">
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                                <i class="fa fa-star-o"></i>
                            </div>
                            <h6>￦ <fmt:formatNumber value="${productVO.productPrice}"/></h6>
                            <div class="product__color__select">
                                <label for="pc-1">
                                    <input type="radio" id="pc-1">
                                </label>
                                <label class="active black" for="pc-2">
                                    <input type="radio" id="pc-2">
                                </label>
                                <label class="grey" for="pc-3">
                                    <input type="radio" id="pc-3">
                                </label>
                            </div>
                        </div>
                    </div>
                </div>
                </c:forEach>
            </div>
       		<div class="float-right">
				<a href="${ctp}/shop/productList" class="all">더보기 <i class="ion-ios-arrow-right"></i></a>
			</div>

				</div>
				<div class="col-xs-6 col-md-4 sidebar" id="sidebar">
					<div class="sidebar-title for-tablet">Sidebar</div>
					<aside>
						<div class="aside-body">
							<div class="featured-author">
								<div class="featured-author-inner">
									<div class="featured-author-cover">
										<div class="badges">
											<div class="badge-item"><i class="ion-star"></i> 귀한분</div>
										</div>
										<div class="featured-author-center">
											<figure class="featured-author-picture">
												<img src="${ctp}/user/${!empty sUid ? sImage : 'noImage.jpg'}" alt="userImage">
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
					    	<h1 class="aside-title">네이버 관련 뉴스 목록</h1>
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
								<h1>날씨API</h1>
								<p>한국환경공단_에어코리아_대기오염정보</p>
				                <div id="airQualityInfo">
				                    <img id="airQualityIcon" src="" alt="Air Quality Icon">
				                    <p id="airQualityText">데이터 로딩 중...</p>
				                </div>
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
								<li><a data-youtube-id="S_vzMufytlY" data-action="magnific"></a></li>
								<li><a data-youtube-id="9cVJr3eQfXc" data-action="magnific"></a></li>
								<li><a data-youtube-id="DnGdoEa1tPg" data-action="magnific"></a></li>
							</ul>
						</div>
					</aside>
					<aside id="sponsored">
						<h1 class="aside-title">유료 광고 배너</h1>
						<div class="aside-body">
							<ul class="sponsored">
								<li class="ad mb-3">
									<a href="#">
										<img src="${ctp}/images/ad3.png" alt="Sponsored">
									</a>
								</li>
								<li class="ad">
									<a href="#">
										<img src="${ctp}/images/ad5.png" alt="Sponsored">
									</a>
								</li> 
							</ul>
						</div>
					</aside>
				</div>
		</section>
   <section class="categories spad m-1" style="padding: 70px 0 30px 0">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="categories__text">
                        <h2>알레르기 완화 <br /> <span>알러지 프리</span> <br /> 유기농</h2>
                    </div>
                </div>
                <div class="col-lg-4">
                    <div class="categories__hot__deal">
                        <img src="${ctp}/images/product-sale.png" alt="">
                        <div class="hot__deal__sticker">
                            <span>세일 가격</span>
                            <h5>29880</h5>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 offset-lg-1">
                    <div class="categories__deal__countdown">
                        <span>BIG DEAL</span>
                        <h2>신촌 입점 기념 세일</h2>
                        <div class="categories__deal__countdown__timer" id="countdown">
                            <div class="cd-item">
                                <span>3</span>
                                <p>일</p>
                            </div>
                            <div class="cd-item">
                                <span>1</span>
                                <p>시간</p>
                            </div>
                            <div class="cd-item">
                                <span>50</span>
                                <p>분</p>
                            </div>
                            <div class="cd-item">
                                <span>18</span>
                                <p>초</p>
                            </div>
                        </div>
                        <a href="${ctp}/shop/productList" class="primary-btn">바로 구매하기</a>
                    </div>
                </div>
            </div>
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
    $('.set-bg').each(function () {
        var bg = $(this).data('setbg');
        $(this).css('background-image', 'url(' + bg + ')');
    });

    //Search Switch
    $('.search-switch').on('click', function () {
        $('.search-model').fadeIn(400);
    });

    $('.search-close-switch').on('click', function () {
        $('.search-model').fadeOut(400, function () {
            $('#search-input').val('');
        });
    });
</script>
</body>
</html>
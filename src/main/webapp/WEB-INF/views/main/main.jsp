<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        
        #wordcloud {
            width: 100%;
            height: 400px;
            border: 1px solid #ddd;
            margin-top: 20px;
        }
	</style>
	<script>
	    window.onload = function() {
            var airVOSJson = '${airVOSJson}';
            var airVOS = JSON.parse(airVOSJson);
	        function getAirQualityData() {
	            let str = '';
	            for(let i=0; i<3; i++) {
					str += '<br>[측정일시] : ' + airVOS[i].dataTime + '<br/>';
					//str += '아황산가스 농도(단위: ppm) : ' + airVOS[i].so2Value + '<br/>';
					//str += '일산화탄소 농도(단위: ppm) : ' + airVOS[i].coValue + '<br/>';
					str += '오존 농도(단위: ppm) : ' + airVOS[i].o3Value + '<br/>';
					//str += '이산화질소 농도(단위: ppm) : ' + airVOS[i].no2Value + '<br/>';
					str += '미세먼지(PM10) 농도(단위: ug/m3) : ' + airVOS[i].pm10Value + '<br/>';
					//str += '미세먼지(PM10) 24시간 예측이동농도(단위: ug/m3) : ' + airVOS[i].pm10Value24 + '<br/>';
					str += '초미세먼지(PM2.5) 농도(단위: ug/m3) : ' + airVOS[i].pm25Value + '<br/>';
					//str += '초미세먼지(PM2.5) 24시간 예측이동농도(단위: ug/m3) : ' + airVOS[i].pm25Value24 + '<br/>';
					str += '통합대기환경수치 : ' + airVOS[i].khaiValue + '<br/>';
					//str += '통합대기환경지수 : ' + airVOS[i].khaiGrade + '<br/>';
					//str += '아황산가스 지수 : ' + airVOS[i].so2Grade + '<br/>';
					//str += '일산화탄소 지수 : ' + airVOS[i].coGrade + '<br/>';
					//str += '오존 지수 : ' + airVOS[i].o3Grade + '<br/>';
					//str += '이산화질소 지수 : ' + airVOS[i].no2Grade + '<br/>';
					//str += '미세먼지(PM10) 24시간 등급자료 : ' + airVOS[i].pm10Grade + '<br/>';
					//str += '초미세먼지(PM2.5) 24시간 등급자료 : ' + airVOS[i].pm25Grade + '<br/>';
					//str += '미세먼지(PM10) 1시간 등급자료 : ' + airVOS[i].pm10Grade1h + '<br/>';
					//str += '초미세먼지(PM2.5) 1시간 등급자료 : ' + airVOS[i].pm25Grade1h + '<br/>';
				}
	            let airQualityLevel = '';
	            let icon = '';
	            if (airVOS[0].pm10Value <= 30) {
	                airQualityLevel = 'good';
	                icon = '${ctp}/images/happiness.png';
	            } 
	            else if (airVOS[0].pm10Value <= 80) {
	                airQualityLevel = 'moderate';
	                icon = '${ctp}/images/soso.png';
	            } 
	            else {
	                airQualityLevel = 'bad';
	                icon = '${ctp}/images/anger.png';
	            }
	
	            document.getElementById('airQualityIcon').src = icon;
	            document.getElementById('airQualityText').innerHTML = str;
	            document.getElementById('airQualityText').className = airQualityLevel;
	        }
	
	        getAirQualityData();
	        
	        // 카운트다운 시작
	        const countdown = () => {
                const countDate = new Date("Aug 9, 2024 00:00:00").getTime();
                const now = new Date().getTime();
                const gap = countDate - now;

                const second = 1000;
                const minute = second * 60;
                const hour = minute * 60;
                const day = hour * 24;

                const textDay = Math.floor(gap / day);
                const textHour = Math.floor((gap % day) / hour);
                const textMinute = Math.floor((gap % hour) / minute);
                const textSecond = Math.floor((gap % minute) / second);

                document.querySelector(".cd-item span[data-days]").innerText = textDay;
                document.querySelector(".cd-item span[data-hours]").innerText = textHour;
                document.querySelector(".cd-item span[data-minutes]").innerText = textMinute;
                document.querySelector(".cd-item span[data-seconds]").innerText = textSecond;
            };

            setInterval(countdown, 1000);
	    };
	    
	    function toggleBookmark(productId) {
	        $.ajax({
	            url: '${ctp}/recent/bookmarkToggle',
	            type: 'POST',
	            data: { productIdx: productId },
	            success: function(response) {
	                alert(response.message);
	            },
	            error: function(xhr, status, error) {
	                alert("북마크 처리 중 오류가 발생했습니다.");
	            }
	        });
	    }
	    
	    function updateAirQuality() {
	        let stationName = $('#station').val();
	        
	        $.ajax({
	            url: '${ctp}/cswork/getAirQuality',
	            type: 'POST',
	            data: { stationName: stationName },
	            success: function(response) {
	                const airVOS = response;
	                let str = '';
	                for(let i = 0; i < 3; i++) {
	                    str += '<br>[측정일시] : ' + airVOS[i].dataTime + '<br/>';
	                    str += '오존 농도(단위: ppm) : ' + airVOS[i].o3Value + '<br/>';
	                    str += '미세먼지(PM10) 농도(단위: ug/m3) : ' + airVOS[i].pm10Value + '<br/>';
	                    str += '초미세먼지(PM2.5) 농도(단위: ug/m3) : ' + airVOS[i].pm25Value + '<br/>';
	                    str += '통합대기환경수치 : ' + airVOS[i].khaiValue + '<br/>';
	                }

	                let airQualityLevel = '';
	                let icon = '';
	                if (airVOS[0].pm10Value <= 30) {
	                    airQualityLevel = 'good';
	                    icon = '${ctp}/images/happiness.png';
	                } else if (airVOS[0].pm10Value <= 80) {
	                    airQualityLevel = 'moderate';
	                    icon = '${ctp}/images/soso.png';
	                } else {
	                    airQualityLevel = 'bad';
	                    icon = '${ctp}/images/anger.png';
	                }

	                document.getElementById('airQualityIcon').src = icon;
	                document.getElementById('airQualityText').innerHTML = str;
	                document.getElementById('airQualityText').className = airQualityLevel;
	            },
	            error: function() {
	                alert("Failed to retrieve air quality data.");
	            }
	        });
	    }
	    
        // 워드클라우드 데이터
        const wordData = [
            ['알레르기', 50],
            ['천식', 30],
            ['꽃가루', 20],
            ['비염', 40],
            ['음식 알레르기', 15],
            ['피부', 25],
            ['아토피', 35],
            ['두드러기', 10]
            // 데이터를 추가적으로 삽입 가능
        ];

        WordCloud(document.getElementById('wordcloud'), {
            list: wordData,
            gridSize: Math.round(16 * $('#wordcloud').width() / 1024),
            weightFactor: 2,
            fontFamily: 'Times, serif',
            color: 'random-dark',
            rotateRatio: 0.5,
            backgroundColor: '#f0f0f0'
        });
	    
	    function toggleLiked(productIdx, element) {
	        $.ajax({
	            url: '${ctp}/recent/saveLikedProduct',  // 관심등록/취소 처리하는 URL
	            type: 'POST',
	            data: { productIdx: productIdx },
	            success: function(response) {
	                if (response.success) {
	                    // 관심등록 상태에 따라 하트 색상 변경
	                    if (response.isInterested) {
	                        $(element).find('i').css('color', 'red');  // 하트 아이콘을 빨간색으로 변경
	                        alert("관심등록 되었습니다.");
	                    } else {
	                        $(element).find('i').css('color', ''); // 기본 색상으로 되돌림
	                        alert("관심등록이 취소되었습니다.");
	                    }
	                } else {
	                    alert("처리 중 오류가 발생했습니다.");
	                }
	            },
	            error: function(xhr, status, error) {
	                alert("관심등록 처리 중 오류가 발생했습니다.");
	            }
	        });
	    }
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
						<c:forEach var="noticeVO" items="${noticeVOS}">
						<div class="item">
							<article class="featured">
								<div class="overlay"></div>
								<figure>
                    				<img src="${ctp}/notice/${noticeVO.noticeThumb}" alt="Notice Thumb" />
								</figure>
								<div class="details">
									<div class="category"><a href="#">공지사항</a></div>
									<h1><a href="${ctp}/cswork/notice/noticeDetails?noticeIdx=${noticeVO.noticeIdx}">${noticeVO.noticeTitle}</a></h1>
									<div class="time">${fn:substring(noticeVO.createDate,0,10)}</div>
								</div>
							</article>
						</div>
						</c:forEach>
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
											<h2><a href="${ctp}/news/allergic1">${vo1.item2}</a></h2>
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
												<a href="javascript:void(0);" class="bookmark" onclick="toggleBookmark());">
												<i class="fa-solid fa-bookmark"></i><div>0</div></a>
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
											<h2><a href="${ctp}/news/allergic2">${vo2.item2}</a></h2>
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
												<a href="javascript:void(0);" class="bookmark" onclick="toggleBookmark(${productVO.productIdx});">
												<i class="fa-solid fa-bookmark"></i><div>0</div></a>
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
											<h2><a href="${ctp}/news/allergic3">${vo3.item2}</a></h2>
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
												<a href="javascript:void(0);" class="bookmark" onclick="toggleBookmark(${productVO.productIdx});">
												<i class="fa-solid fa-bookmark"></i><div>0</div></a>
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
											<h2><a href="${ctp}/news/allergic4">${vo4.item2}</a></h2>
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
												<a href="javascript:void(0);" class="bookmark" onclick="toggleBookmark(${productVO.productIdx});">
												<i class="fa-solid fa-bookmark"></i><div>0</div></a>
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
					<!--
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
								</ol>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<h1 class="title-col">
								워드클라우드(인기단어)
							</h1>
							<img src="${ctp}/wordcloud/${wordCloudImage}" alt="Word Cloud Image" />
						</div>
					</div>
					  -->
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
	                            <li>
			                        <!-- 관심등록 버튼 클릭 시 JavaScript 함수 호출 -->
			                        <a href="javascript:void(0);" onclick="toggleLiked(${productVO.productIdx}, this)">
			                            <i class="fa-solid fa-heart"></i>
			                            <span>관심등록</span>
			                        </a>
			                    </li>
	                            <li><a href="${ctp}/"><i class="fa-solid fa-share"></i><span>공유하기</span></a></li>
	                            <li><a href="${ctp}/"><i class="fa-solid fa-bag-shopping"></i><span>장바구니</span></a></li>
                            </ul>
                        </div>
                        <div class="product__item__text">
                            <h5><a href="${ctp}/shop/productDetails?productIdx=${productVO.productIdx}">${productVO.productName}</a></h5>
                            <h6 class="float-right">￦ <fmt:formatNumber value="${productVO.productPrice}"/></h6>
			                <div class="rating">
			                    <c:forEach var="i" begin="1" end="5">
			                        <c:choose>
			                            <c:when test="${i <= productVO.averageRating}">
			                                <font color="gold"><i class="fas fa-star"></i></font>
			                            </c:when>
			                            <c:otherwise>
			                                <i class="fa fa-star"></i>
			                            </c:otherwise>
			                        </c:choose>
			                    </c:forEach>
			                </div>
                        	<p>${fn:substring(productVO.productDetails,0,30)}${productVO.averageRating}...</p>
							<p>${productVO.productTags}</p>
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
											<div class="badge-item"><i class="ion-star"></i> ${!empty sUid ? strLevel : "손님"}</div>
										</div>
										<div class="featured-author-center">
											<figure class="featured-author-picture">
												<img src="${ctp}/user/${!empty sUid ? sImage : 'noImage.png'}" alt="userImage">
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
										<!--
										<div class="featured-author-quote">
											"Eur costrict mobsa undivani krusvuw blos andugus pu aklosah"
										</div>
										<div class="block">
											<h2 class="block-title">Photos</h2>
											<div class="block-body">
												<ul class="item-list-round" data-magnific="gallery">
													<li><a href="${ctp}/images/noImage.png" style="background-image: url('${ctp}/images/noImage.png');"></a></li>
													<li><a href="${ctp}/images/noImage.png" style="background-image: url('${ctp}/images/noImage.png');"></a></li>
													<li><a href="${ctp}/images/noImage.png" style="background-image: url('${ctp}/images/noImage.png');"><div class="more">+2</div></a></li>
													<li class="hidden"><a href="${ctp}/images/noImage.png" style="background-image: url('${ctp}/images/noImage.png');"></a></li>
													<li class="hidden"><a href="${ctp}/images/noImage.png" style="background-image: url('${ctp}/images/noImage.png');"></a></li>
												</ul>
											</div>
										</div>
										  -->
										<div class="featured-author-footer">
											<a href="${ctp}/community/userChat">커뮤니티(유저 채팅방)</a>
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
					                                        <img src="${ctp}/images/noImage.png" alt="default image" style="object-fit:cover; width: 100%; height: auto;">
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
								<h4>한국환경공단 대기오염정보</h4>
				                <div id="airQualityInfo">
					                <select class="form-input-control float-right" id="station" onchange="updateAirQuality()" style="font-size:20px;">
					                	<option value="종로구" selected>기본값 : 종로구<option>
				                    <c:forEach var="airStationVO" items="${airStationVOS}">
					                	<option value="${airStationVO.stationName}">${airStationVO.stationRegion} : ${airStationVO.stationName}</option>
					                </c:forEach>
					                </select>
				                    <img id="airQualityIcon" src="" alt="Air Quality Icon" style="width:200px;">
				                    <p id="airQualityText">...</p>
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
							<!--
							<li>
								<a href="#comments" aria-controls="comments" role="tab" data-toggle="tab">
									<i class="ion-ios-chatboxes-outline"></i> 인기 게시글
								</a>
							</li>
							  -->
						</ul>
						<div class="tab-content">
							<div class="tab-pane active" id="recomended">
								<!--
								<article class="article-fw">
									<div class="inner">
										<figure>
											<a href="single.html">
												<img src="${ctp}/user/noImage.png" alt="Sample Article">
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
								  -->
								<h5>최근 본 제품</h5>
								<c:forEach var="recentProduct" items="${recentProducts}">
								    <article class="article-mini">
								        <div class="inner">
								            <figure>
								                <a href="${ctp}/shop/productDetails?productIdx=${recentProduct.productIdx}">
								                    <img src="${ctp}/product/${recentProduct.productThumb}" alt="${recentProduct.productName}">
								                </a>
								            </figure>
								            <div class="padding">
								                <h1>
								                    <a href="${ctp}/shop/productDetails?productIdx=${recentProduct.productIdx}">
								                        ${recentProduct.productName}
								                    </a>
								                </h1>
								                <div class="detail">
								                    <div class="tag">${recentProduct.productTags}</div>
								                </div>
								            </div>
								        </div>
								    </article>
								</c:forEach>
								<c:if test="${empty recentProducts}">
									<p>최근 본 상품이 존재하지 않습니다</p>
								</c:if>
								<c:if test="${sUid}">
									<p>로그인 이후에 확인 가능합니다</p>
								</c:if>
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
								<li><a data-youtube-id="X_dopDAdFms" data-action="magnific"></a></li>
								<li><a data-youtube-id="S_vzMufytlY" data-action="magnific"></a></li>
								<li><a data-youtube-id="rsQ0566tNdY" data-action="magnific"></a></li>
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
                            <span>할인 가격</span>
                            <h5 style="font-weight:bold;">29880원</h5>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 offset-lg-1">
                    <div class="categories__deal__countdown">
                        <span>감사 이벤트</span>
                        <h2>신촌 입점 기념 세일</h2>
                        <div class="categories__deal__countdown__timer" id="countdown">
              				<div class="cd-item">
                                <span data-days>0</span>
                                <p>일</p>
                            </div>
                            <div class="cd-item">
                                <span data-hours>0</span>
                                <p>시간</p>
                            </div>
                            <div class="cd-item">
                                <span data-minutes>0</span>
                                <p>분</p>
                            </div>
                            <div class="cd-item">
                                <span data-seconds>0</span>
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
								<img src="${ctp}/user/noImage.png" alt="Sample Article">
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
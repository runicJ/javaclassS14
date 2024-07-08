<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

	<!-- Start nav -->
	<nav class="menu">
		<div class="container">
			<div class="brand">
				<a href="${ctp}/main">
					<img src="${ctp}/images/logo.png" alt="logo" style="height:40px;width:auto;margin-top:8px;">
				</a>
			</div>
			<div class="mobile-toggle">
				<a href="#" data-toggle="menu" data-target="#menu-list"><i class="ion-navicon-round"></i></a>
			</div>
			<div class="mobile-toggle">
				<a href="#" data-toggle="sidebar" data-target="#sidebar"><i class="ion-ios-arrow-left"></i></a>
			</div>
			<div id="menu-list">
				<ul class="nav-list">
					<li class="for-tablet nav-title"><a>Menu</a></li>
					<li class="for-tablet"><a href="${ctp}/users/userLogin">로그인</a></li>
					<li class="for-tablet"><a href="${ctp}/users/userRegister">회원가입</a></li>
					<li class="dropdown magz-dropdown">
						<a href="${ctp}/">소개합니다<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li><a href="${ctp}/">인사말</a></li>
							<li><a href="${ctp}/">홈페이지소개</a></li>
							<li><a href="${ctp}/">설립목적</a></li>
							<li><a href="${ctp}/">지점위치</a></li>
						</ul>
					</li>
					<li class="dropdown magz-dropdown magz-dropdown-megamenu"><a href="#">알레르기 정보<i class="ion-ios-arrow-right"></i> <span class="badge">인기</span></a>
						<div class="dropdown-menu megamenu">
							<div class="megamenu-inner">
								<div class="row">
									<div class="col-md-3">
										<div class="row">
											<div class="col-md-12">
												<h2 class="megamenu-title">Trending</h2>
											</div>
										</div>
										<ul class="vertical-menu">
											<li><a href="${ctp}/research/crawling"><i class="ion-ios-circle-outline"></i> 뉴스정보</a></li>
											<li><a href="#"><i class="ion-ios-circle-outline"></i> This is an example</a></li>
											<li><a href="#"><i class="ion-ios-circle-outline"></i> For a submenu item</a></li>
											<li><a href="#"><i class="ion-ios-circle-outline"></i> You can add</a></li>
											<li><a href="#"><i class="ion-ios-circle-outline"></i> Your own items</a></li>
										</ul>
									</div>
									<div class="col-md-9">
										<div class="row">
											<div class="col-md-12">
												<h2 class="megamenu-title">Featured Posts</h2>
											</div>
										</div>
										<div class="row">
											<article class="article col-md-4 mini">
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
													</div>
												</div>
											</article>
											<article class="article col-md-4 mini">
												<div class="inner">
													<figure>
														<a href="single.html">
															<img src="${ctp}/basic/img11.jpg" alt="Sample Article">
														</a>
													</figure>
													<div class="padding">
														<div class="detail">
															<div class="time">December 13, 2016</div>
															<div class="category"><a href="category.html">Lifestyle</a></div>
														</div>
														<h2><a href="single.html">Duis aute irure dolor in reprehenderit in voluptate</a></h2>
													</div>
												</div>
											</article>
											<article class="article col-md-4 mini">
												<div class="inner">
													<figure>
														<a href="single.html">
															<img src="${ctp}/basic/img14.jpg" alt="Sample Article">
														</a>
													</figure>
													<div class="padding">
														<div class="detail">
															<div class="time">December 14, 2016</div>
															<div class="category"><a href="category.html">Travel</a></div>
														</div>
														<h2><a href="single.html">Duis aute irure dolor in reprehenderit in voluptate</a></h2>
													</div>
												</div>
											</article>
										</div>
									</div>
								</div>								
							</div>
						</div>
					</li>
					<li class="dropdown magz-dropdown magz-dropdown-megamenu"><a href="#">제품구매<i class="ion-ios-arrow-right"></i></a>
						<div class="dropdown-menu megamenu">
							<div class="megamenu-inner">
								<div class="row">
									<div class="col-md-3">
										<h2 class="megamenu-title">비염완화</h2>
										<ul class="vertical-menu">
											<li><a href="#">비염치료기기</a></li>
											<li><a href="#">피부의료기기</a></li>
											<li><a href="#">의약외품</a></li>
											<li><a href="#">마스크</a></li>
										</ul>
									</div>
									<div class="col-md-3">
										<h2 class="megamenu-title">침구제품(알러지프리)</h2>
										<ul class="vertical-menu">
											<li><a href="#">매트리스</a></li>
											<li><a href="#">베딩</a></li>
											<li><a href="#">베개</a></li>
											<li><a href="#">이불솜</a></li>
											<li><a href="#">키즈</a></li>
										</ul>
									</div>
									<div class="col-md-3">
										<h2 class="megamenu-title">유기농제품</h2>
										<ul class="vertical-menu">
											<li><a href="#">검증 식제품</a></li>
											<li><a href="#">유기농 완구</a></li>
											<li><a href="#">유기농 화장품</a></li>
											<li><a href="#">건강보조식품</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li class="dropdown magz-dropdown">
						<a href="category.html">커뮤니티<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li><a href="${ctp}/">커뮤니티 소개</a></li>
							<li class="dropdown magz-dropdown">
								<a href="#">구독정보<i class="ion-ios-arrow-right"></i></a>
								<ul class="dropdown-menu">
									<li><a href="${ctp}/users/userLogin">구독 정보 소개</a></li>
									<li><a href="${ctp}/users/userRegister">구독 금액</a></li>
									<li><a href="forgot.html">구독 후기</a></li>
								</ul>
							</li>
							<li><a href="category.html">알레르기 병원리스트</a></li>
							<li><a href="single.html">병원 후기</a></li>
							<li><a href="search.html">정보를 나눠요(유저채팅)</a></li>
						</ul>
					</li>
					<li class="dropdown magz-dropdown"><a href="#">고객센터<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li><a href="category.html">공지사항</a></li>
							<li class="dropdown magz-dropdown"><a href="category.html">자주묻는질문<i class="ion-ios-arrow-right"></i></a></li>
							<li class="dropdown magz-dropdown"><a href="#">1:1문의 <i class="ion-ios-arrow-right"></i></a>
								<ul class="dropdown-menu">
									<li><a href="category.html">구독문의</a></li>
									<li><a href="category.html">정보문의</a></li>
									<li><a href="category.html">제품문의</a></li>
									<li><a href="category.html">신고문의</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="dropdown magz-dropdown">
						<a href="category.html">이벤트<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li><a href="${ctp}/">진행중인 이벤트</a></li>
							<li class="dropdown magz-dropdown">
								<a href="#">종료된 이벤트<i class="ion-ios-arrow-right"></i></a>
							</li>
							<li><a href="category.html">구매 제품 후기</a></li>
						</ul>
					</li>
					<c:if test="${!empty sUid}">
					<li class="dropdown magz-dropdown"><a href="${ctp}/${sUid == 'admin' ? 'admin/adminMain' : 'user/userMain'}">나의곳간<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li><a href="#"><i class="icon ion-person"></i>마이페이지</a></li>
							<li><a href="#"><i class="icon ion-heart"></i>관심목록</a></li>
							<li><a href="#"><i class="icon ion-heart"></i>북마크목록</a></li>
							<li><a href="#"><i class="icon ion-chatbox"></i>내가쓴게시글</a></li>
							<li><a href="#"><i class="icon ion-key"></i>회원정보수정</a></li>
							<li><a href="#"><i class="icon ion-settings"></i>설정변경</a></li>
							<li class="divider"></li>
							<li><a href="${ctp}/users/userLogout"><i class="icon ion-log-out"></i>로그아웃</a></li>
						</ul>
					</li>
					</c:if>
				</ul>
			</div>
		</div>
	</nav>
	<!-- End nav -->
</header>
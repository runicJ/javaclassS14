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
							<li><a href="${ctp}/introduce/greeting">인사말</a></li>
							<li><a href="${ctp}/introduce/introduce">홈페이지소개</a></li>
							<li><a href="${ctp}/introduce/purpose">설립목적</a></li>
							<li><a href="${ctp}/introduce/branch/branchMap">지점위치</a></li>
						</ul>
					</li>
					<li class="dropdown magz-dropdown magz-dropdown-megamenu"><a href="#">알레르기 정보<i class="ion-ios-arrow-right"></i> <span class="badge">인기</span></a>
						<div class="dropdown-menu megamenu">
							<div class="megamenu-inner">
								<div class="row">
									<div class="col-md-3">
										<div class="row">
											<div class="col-md-12">
												<h2 class="megamenu-title">알레르기 목록</h2>
											</div>
										</div>
										<ul class="vertical-menu">
											<li><a href="${ctp}/news/newsList"><i class="ion-ios-circle-outline"></i> 뉴스정보</a></li>
											<li><a href="${ctp}/news/allergic1"><i class="ion-ios-circle-outline"></i> 호흡기 알레르기</a></li>
											<li><a href="${ctp}/news/allergic3"><i class="ion-ios-circle-outline"></i> 아토피 피부염</a></li>
											<li><a href="${ctp}/news/allergic2"><i class="ion-ios-circle-outline"></i> 식품 알레르기</a></li>
											<li><a href="${ctp}/news/allergic4"><i class="ion-ios-circle-outline"></i> 기타 알레르기</a></li>
										</ul>
									</div>
									<div class="col-md-9">
										<div class="row">
											<div class="col-md-12">
												<h2 class="megamenu-title">인기있는 추천 기사</h2>
											</div>
										</div>
										<div class="row">
											<c:forEach var="topNewsVO" items="${topNewsVOS}">
											<article class="article col-md-4 mini">
												<div class="inner">
													<figure>
                                                        <a href="${topNewsVO['partUrl']}">
                                                            <img src="${ctp}/images/default-thumbnail.jpg" alt="Bookmarked Article">
                                                        </a>
                                                    </figure>
													<div class="padding">
                                                        <div class="detail">
                                                            <div class="time">Bookmark</div>
                                                            <div class="category"><a href="${bookmark['partUrl']}">Category</a></div>
                                                        </div>
                                                        <h2><a href="${bookmark['partUrl']}">${bookmark['partUrl']}</a></h2>
                                                    </div>
												</div>
											</article>
											</c:forEach>
										</div>
									</div>
								</div>								
							</div>
						</div>
					</li>
					<li class="dropdown magz-dropdown magz-dropdown-megamenu"><a href="#">제품판매<i class="ion-ios-arrow-right"></i></a>
						<div class="dropdown-menu megamenu">
							<div class="megamenu-inner">
								<div class="row">
									<div class="col-md-3">
										<h2 class="megamenu-title"><a href="${ctp}/shop/productList">전체 제품 조회</a></h2>
									</div>
									<div class="col-md-3">
										<h2 class="megamenu-title">알레르기 완화 제품</h2>
										<ul class="vertical-menu">
											<li><a href="${ctp}/shop/productList" class="text-muted">비염 치료기기</a></li>
											<li><a href="${ctp}/shop/productList" class="text-muted">피부 관리기기</a></li>
											<li><a href="${ctp}/shop/productList" class="text-muted">마스크 외</a></li>
										</ul>
									</div>
									<div class="col-md-3">
										<h2 class="megamenu-title">침구 제품(알러지프리)</h2>
										<ul class="vertical-menu">
											<li><a href="${ctp}/shop/productList" class="text-muted">매트리스</a></li>
											<li><a href="${ctp}/shop/productList" class="text-muted">이불</a></li>
											<li><a href="${ctp}/shop/productList" class="text-muted">키즈</a></li>
										</ul>
									</div>
									<div class="col-md-3">
										<h2 class="megamenu-title">유기농 제품</h2>
										<ul class="vertical-menu">
											<li><a href="${ctp}/shop/productList" class="text-muted">유기농 인증 식제품</a></li>
											<li><a href="${ctp}/shop/productList" class="text-muted">유기농 완구</a></li>
											<li><a href="${ctp}/shop/productList" class="text-muted">비건 화장품</a></li>
										</ul>
									</div>
								</div>
							</div>
						</div>
					</li>
					<li class="dropdown magz-dropdown">
						<a href="#">커뮤니티<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li class="dropdown magz-dropdown">
								<a href="#">구독정보<i class="ion-ios-arrow-right"></i></a>
								<ul class="dropdown-menu">
									<li><a href="${ctp}/users/userLogin">구독 소개</a></li>
									<li><a href="${ctp}/users/userRegister">구독 신청</a></li>
									<li><a href="forgot.html">구독 후기</a></li>
								</ul>
							</li>
							<li><a href="${ctp}/community/hospirtal/hospitalList">알레르기 병원리스트</a></li>
							<li><a href="${ctp}/community/hospirtal/hospitalReview">병원 후기</a></li>
							<li><a href="${ctp}/community/chat/userChat">정보를 나눠요(유저채팅)</a></li>
						</ul>
					</li>
					<li class="dropdown magz-dropdown"><a href="#">고객센터<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li><a href="${ctp}/cs/notice">공지사항</a></li>
							<li class="dropdown magz-dropdown"><a href="${ctp}/cs/faq">자주묻는질문</a></li>
							<li class="dropdown magz-dropdown"><a href="#">1:1문의 <i class="ion-ios-arrow-right"></i></a>
								<ul class="dropdown-menu">
									<li><a href="${ctp}/cs/inquery/subscribe">구독문의</a></li>
									<li><a href="${ctp}/cs/inquery/news">알레르기 정보문의</a></li>
									<li><a href="${ctp}/cs/inquery/product">제품문의</a></li>
									<li><a href="category.html">신고문의</a></li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="dropdown magz-dropdown">
						<a href="#">이벤트<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li><a href="${ctp}/cs/event/eventList">이벤트 목록</a></li>
							<li><a href="${ctp}/review/photoReview/photoGalleryList">포토 후기</a></li>
							<li><a href="${ctp}/survey/surveyList">설문 조사 참여</a></li>
						</ul>
					</li>
					<c:if test="${!empty sUid}">
					<li class="dropdown magz-dropdown"><a href="${ctp}/${sUid == 'admin' ? 'admin/adminMain' : 'user/userMain'}">내정보<i class="ion-ios-arrow-right"></i></a>
						<ul class="dropdown-menu">
							<li><a href="${ctp}/users/userMain"><i class="icon ion-person"></i>내정보관리</a></li>
							<li><a href="${ctp}/users/userLikedList"><i class="icon ion-heart"></i>관심목록</a></li>
							<li><a href="${ctp}/users/userBookmarkList"><i class="icon ion-heart"></i>북마크목록</a></li>
							<li><a href="${ctp}/users/userCommentList"><i class="icon ion-chatbox"></i>내가쓴게시글</a></li>
							<li><a href="${ctp}/users/userUpdate"><i class="icon ion-settings"></i>회원정보수정</a></li>
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
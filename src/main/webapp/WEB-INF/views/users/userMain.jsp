<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>userMain</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
	<style>
		.sidenav {
		  height: 100%;
		  width: 200px;
		  position: relative;
		  z-index: 1;
		  top: 0;
		  left: 0;
		  background-color: #111;
		  overflow-x: hidden;
		  padding-top: 20px;
		}
		
		/* Style the sidenav links and the dropdown button */
		.sidenav a, .dropdown-btn {
		  padding: 6px 8px 6px 16px;
		  text-decoration: none;
		  font-size: 20px;
		  color: #818181;
		  display: block;
		  border: none;
		  background: none;
		  width:100%;
		  text-align: left;
		  cursor: pointer;
		  outline: none;
		}
		
		/* On mouse-over */
		.sidenav a:hover, .dropdown-btn:hover {
		  color: #f1f1f1;
		}
		
		/* Main content */
		.main {
		  margin-left: 200px; /* Same as the width of the sidenav */
		  font-size: 20px; /* Increased text to enable scrolling */
		  padding: 0px 10px;
		}
		
		/* Add an active class to the active dropdown button */
		.active {
		  background-color: green;
		  color: white;
		}
		
		/* Dropdown container (hidden by default). Optional: add a lighter background color and some left padding to change the design of the dropdown content */
		.dropdown-container {
		  display: none;
		  background-color: #262626;
		  padding-left: 8px;
		}
		
		/* Optional: Style the caret down icon */
		.fa-caret-down {
		  float: right;
		  padding-right: 8px;
		}
		
		@media screen and (max-height: 450px) {
		  .sidenav {padding-top: 15px;}
		  .sidenav a {font-size: 18px;}
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" />
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<section class="userMain" style="padding-top: 245.125px;">
		<div class="container">
			<div class="row">
				<div class="col-xs-12 col-md-4 sidebar" id="sidebar">
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
												<p>안녕하세요! ${nickName}님</p>
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
												<div class="userItem">
													<a href="#">
														<div class="value">0</div>														
														<div class="name">쿠폰</div>
													</a>
												</div>
												<div class="userItem">
													<a href="#">
														<div class="value">0</div>														
														<div class="name">포인트</div>
													</a>
												</div>
											</div>
											<div class="featured-author-count">
												<div class="userItem">
													<a href="#">
														<div class="value">0</div>														
														<div class="name">북마크</div>
													</a>
												</div>
												<div class="userItem">
													<a href="#">
														<div class="value">0</div>														
														<div class="name">좋아요</div>
													</a>
												</div>
											</div>
											<div class="block sidenav">
												<h2 class="block-title">회원 관리 목록</h2>
												<div class="block-body">
													  <button class="dropdown-btn">주문정보
													    <i class="fa fa-caret-down"></i>
													  </button>
													  <div class="dropdown-container">
															<a href="#">주문배송조회</a>
															<a href="#">주문정보변경</a>
															<a href="#">주문취소</a>
															<a href="#">반품환불</a>
													  </div>
													  <button class="dropdown-btn">등급별혜택
													    <i class="fa fa-caret-down"></i>
													  </button>
													  <div class="dropdown-container">
															<a href="#">쿠폰 조회</a>
															<a href="#">포인트 현황</a>
															<a href="#">회원혜택 안내</a>
													  </div>
													  <button class="dropdown-btn">회원활동내역
													    <i class="fa fa-caret-down"></i>
													  </button>
													  <div class="dropdown-container">
															<a href="#">1:1문의</a>
															<a href="#">문의글 조회</a>
															<a href="#">상품후기</a>
															<a href="#">구매한 상품</a>
															<a href="#">이벤트내역</a>
													  </div>
													  <button class="dropdown-btn">관심목록
													    <i class="fa fa-caret-down"></i>
													  </button>
													  <div class="dropdown-container">
															<a href="#">찜한상품</a>
															<a href="#">게시글 북마크</a>
															<a href="#">작성한 게시글</a>
															<a href="#">작성한 리뷰글</a>
															<a href="#">최근 내역</a>
															<a href="#">입고 알림 신청 내역</a>
													  </div>
													  <button class="dropdown-btn">회원정보
													    <i class="fa fa-caret-down"></i>
													  </button>
													  <div class="dropdown-container">
															<a href="#">개인정보 수정</a>
															<a href="#">배송지 관리</a>
															<a href="#">회원탈퇴</a>
													  </div>
												</div>
												<p><a href="images/news/img11.jpg">탈퇴하기</a></p>
											</div>
											<div class="featured-author-footer">
												<a href="#">커뮤니티(유저 채팅방)</a>
											</div>
										</div>
								</div>
							</div>
						</div>
					</aside>
				</div>
				<div class="col-xs-12 col-md-8">
						<div class="row">
							<article class="article col-md-12">
								<div class="inner">
									<div class="padding">
										<h2><a href="single.html">최근 주문내역</a></h2>
										<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</p>
										<footer>
											<a class="btn btn-primary more" href="single.html">
												<div>더보기</div>
												<div><i class="ion-ios-arrow-thin-right"></i></div>
											</a>
										</footer>
									</div>
								</div>
							</article>
						</div>
						<div class="row">
							<article class="article col-md-12">
								<div class="inner">
									<div class="padding">
										<h2><a href="single.html">찜한상품</a></h2>
										<p>Maecenas accumsan tortor ut velit pharetra mollis. Proin eu nisl et arcu iaculis placerat sollicitudin ut est. In fringilla dui dui.</p>
										<footer>
											<a class="btn btn-primary more" href="single.html">
												<div>더보기</div>
												<div><i class="ion-ios-arrow-thin-right"></i></div>
											</a>
										</footer>
									</div>
								</div>
							</article>
						</div>
						<div class="row">
							<article class="article col-md-12">
								<div class="inner">
									<div class="padding">
										<h2><a href="single.html">북마크 게시글</a></h2>
										<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.</p>
										<footer>
											<a class="btn btn-primary more" href="single.html">
												<div>더보기</div>
												<div><i class="ion-ios-arrow-thin-right"></i></div>
											</a>
										</footer>
									</div>
								</div>
							</article>
						</div>
						<div class="row">
							<article class="article col-md-12">
								<div class="row">
								<article class="article col-md-6">
									<div class="inner">
										<div class="padding">
											<h2><a href="single.html">작성한 후기글</a></h2>
											<p>Maecenas accumsan tortor ut velit pharetra mollis. Proin eu nisl et arcu iaculis placerat sollicitudin ut est. In fringilla dui dui.</p>
											<footer>
												<a class="btn btn-primary more" href="single.html">
													<div>더보기</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
								<article class="article col-md-6">
								<div class="inner">
										<div class="padding">
											<h2><a href="single.html">작성한 게시글</a></h2>
											<p>Maecenas accumsan tortor ut velit pharetra mollis. Proin eu nisl et arcu iaculis placerat sollicitudin ut est. In fringilla dui dui.</p>
											<footer>
												<a class="btn btn-primary more" href="single.html">
													<div>더보기</div>
													<div><i class="ion-ios-arrow-thin-right"></i></div>
												</a>
											</footer>
										</div>
									</div>
								</article>
							</div>
							</article>
						</div>
					</div>
				</div>
			</div>
	</section>
<jsp:include page="/WEB-INF/views/include/bs4.jsp" />
<script>
var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
    this.classList.toggle("active");
    var dropdownContent = this.nextElementSibling;
    if (dropdownContent.style.display === "block") {
      dropdownContent.style.display = "none";
    } else {
      dropdownContent.style.display = "block";
    }
  });
}
</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<style>
	.sidenav {
	  height: 100%;
	  width: 100%;
	  position:relative;
	  z-index: 1;
	  top: 0;
	  left: 0;
	  background-color: #111;
	  overflow-x: hidden;
	  padding: 40px 0;
	}
	
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
	
	.sidenav a:hover, .dropdown-btn:hover {
	  color: #f1f1f1;
	}
	
	.sidenav .main {
	  margin-left: 200px;
	  font-size: 20px;
	  padding: 0px 10px;
	}
	
	.sidenav .dropdown-btn .active {
	  background-color: green;
	  color: white;
	}
	
	.sidenav .dropdown-container {
	  display: none;
	  background-color: #262626;
	  padding-left: 8px;
	}
	
	.sidenav .fa-caret-down {
	  float: right;
	  padding-right: 8px;
	}
	
	@media screen and (max-height: 450px) {
	  .sidenav {padding-top: 15px;}
	  .sidenav a {font-size: 18px;}
	}
	
	.block-body .blockdown-btn {
		margin 50px 0;
	}
</style>

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
								<p>안녕하세요!</p>
								<figure class="featured-author-picture">
									<img src="${ctp}/user/noImage.jpg" alt="Sample Article">
								</figure>
								<div class="featured-author-info">
									<h2 class="name">${sNickName}</h2>
									<div class="desc">@${sUid}</div>
								</div>
							</div>
						</div>
						<div class="featured-author-body">
							<div class="featured-author-count">
								<div class="userItem">
									<a href="#">
										<div class="value">0</div>														
										<div class="name">등급</div>
									</a>
								</div>
								<div class="userItem">
									<a href="#">
										<div class="value">0</div>														
										<div class="name">주문</div>
									</a>
								</div>
							</div>
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
							<div class="block sidenav">
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
										<a href="${ctp}/users/userUpdate">개인정보 수정</a>
										<a href="${ctp}/users/userAddress">배송지 관리</a>
										<a href="${ctp}/users/userDelete">회원탈퇴</a>
								  </div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</aside>
	</div>
</div>
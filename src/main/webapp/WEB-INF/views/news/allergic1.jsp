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
  	<script>
  		'use strict';
  		
  		function bookmarkToggle() {
  			partUrl = $(location).attr('href');
  			
  			if(${sUid == null || sUid == ""}) {
  				alert("로그인 이후에 가능한 기능입니다!");
  				let ans = confirm("로그인 이후에 가능한 기능입니다. 로그인 페이지로 이동하시겠습니까?");
  				if(ans) {
  					alert("로그인페이지로 이동합니다.");
  					location.href="${ctp}/users/userLogin";
  				}
  				else return;
  			}
  			
  			$.ajax({
  				url: "${ctp}/users/saveBookmarkInput",
  				type: "post",
  				data: {partUrl : partUrl},
  		        success: function(res) {
  		        	let icon = document.getElementById("bookmark-icon-" + partUrl);
  		            if (res.trim() == "true") {
  		                icon.classList.remove('fa-solid', 'fa-bookmark');
  		                icon.classList.add('fa-regular', 'fa-bookmark');
  		                icon.style.color = 'gray';
  		                alert("해당 게시글이 북마크에 저장되었습니다.");
  		            } else {
  		                icon.classList.remove('fa-regular', 'fa-bookmark');
  		                icon.classList.add('fa-solid', 'fa-bookmark');
  		                icon.style.color = 'red';
  		                alert("북마크에서 삭제되었습니다.");
  		            }
  		        },
  		        error: function() {
  		            alert("전송 오류!");
  		        }
  			});
  			
  		}
  		
  		//현재 url 변수로 가져오기
  		let nowUrl = window.location.href;

  		function copyUrl(){ 
  		  //nowUrl 변수에 담긴 주소를
  		  	navigator.clipboard.writeText(nowUrl).then(res=>{
  			  alert("이 글의 URL이 클립보드에 복사되었습니다.");
  			})
  		}
  	</script>
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
									<img src="${ctp}/images/ad1.png">
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
						  <li class="active">[ 호흡기 알레르기 ]</li>
						</ol>
						<article class="article main-article">
							<header>
								<h1>${vo.item2}</h1>
							</header>
							<div class="main">
								<p>${vo.item3}</p>
								<div class="featured">
									<figure>
										<img src="https://www.thermofisher.com${vo.item1}" alt="allergic1" style="object-fit:cover; width: 100%; height: auto;">
										<figcaption>Image by pexels.com</figcaption>
									</figure>
								</div>

								<p>${vo.item4}</p>

								<p>${vo.item5}</p>
							</div>
							<p class="text-center">
								<a type="button" class="btn btn-light rounded-circle border border-2 border-end mr-2" onclick="bookmarkToggle()" id="saveBookmark">
									<%-- <c:if test="${vo.isBookmared == 1}">
										<i id="bookmark-icon-${vo.partUrl}" class="fa-solid fa-bookmark" style="color:red;"></i>
									</c:if>
									<c:if test="${vo.isBookmared == 0}">
										<i id="bookmark-icon-${vo.partUrl}" class="fa-regular fa-bookmark" style="color:gray;"></i>
									</c:if> --%>
								</a>
								<a type="button" class="btn btn-light rounded-circle border border-2 border-end" id="kakaotalk-sharing-btn" href="javascript:shareMessage()"><i class="fa-solid fa-share-nodes"></i></a>
								<button type="button" class="copy-btn" onclick="copyUrl()">링크 복사</button>
							</p>
						</article>
						<div class="line"><div>관련된 게시글</div></div>
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
<script>
  function shareMessage() {
	let url = $(location).attr('href');
    Kakao.Share.sendDefault({
      objectType: 'text',
      text: '괄호 안 쉼표 입니다.',
      imageUrl : 'https://search1.kakaocdn.net/argon/0x200_85_hr/8x5qcdbcQwi',
        url,
      link: {
        mobileWebUrl: 'http://localhost:9090',
        webUrl: 'http://localhost:9090',
      },
    });
  }
</script>
</body>
</html>
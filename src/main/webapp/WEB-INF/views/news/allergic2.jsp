<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>allergic2</title>
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
									<img src="${ctp}/images/ad2.png">
									<figcaption>Advertisement</figcaption>
								</figure>
							</div>
						</aside>
					</div>
					<div class="col-md-8">
						<ol class="breadcrumb">
						  <li><a href="#">Home</a></li>
						  <li class="active">[ 식품 알레르기 ]</li>
						</ol>
						<article class="article main-article">
							<header>
								<h1>${vo.item2}</h1>
							</header>
							<div class="main">
								<p>${vo.item3}</p>
								<div>
									
								</div>
								<p>${vo.item4}</p>
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
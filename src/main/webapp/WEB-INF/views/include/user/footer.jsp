<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>

<!-- Start footer -->
<footer class="footer">
	<div class="container">
		<div class="row">
			<div class="col-md-3 col-sm-12">
				<div class="block">
					<h1 class="block-title">회사 정보란</h1>
					<div class="block-body">
						<figure class="foot-logo">
							<img src="${ctp}/images/logo.png" class="img-responsive" alt="myLogo">
						</figure>
						<p class="brand-description">
							괄호 안에서 살아가는 우리에게 <br>쉼표가 되어드리고 싶습니다.
						</p>
						<a href="${ctp}/introduce/greeting" class="btn btn-magz white">우리를 소개합니다 <i class="ion-ios-arrow-thin-right"></i></a>
					</div>
				</div>
			</div>
			<div class="col-md-4 col-sm-12">
				<div class="block">
					<h1 class="block-title">인기 태그(#) <span class="right"><a href="#">더보기 <i class="ion-ios-arrow-thin-right"></i></a></span></h1>
					<div class="block-body">
						<ul class="tags">
							<li><a href="#">#도도새</a></li>
							<li><a href="#">#알레르기</a></li>
							<li><a href="#">#알레르망</a></li>
							<li><a href="#">#아이</a></li>
							<li><a href="#">#아토피</a></li>
							<li><a href="#">#비염</a></li>
							<li><a href="#">#이불</a></li>
						</ul>
					</div>
				</div>
				<div class="line"></div>
				<p class="d-flex justify-content-between">
					<a href="#" class="btn btn-magz white">광고 입점 신청 <i class="ion-ios-arrow-thin-right"></i></a>
					<a href="#" class="btn btn-magz white">가맹점 신청 문의 <i class="ion-ios-arrow-thin-right"></i></a>
				</p>
			</div>
			<div class="col"></div>
			<div class="col-md-4 col-xs-12">
				<div class="block">
					<h1 class="block-title">문의하기</h1>
					<div class="block-body">
						<p><i class="fa-solid fa-location-dot"></i> 충청북도 청주시 서원구 사직대로 109 4층</p>
						<p><i class="fa-solid fa-paperclip"></i> 그린컴퓨터 아트학원 청주점</p>
						<ul class="social trp">
							<li>
								<a href="#" class="facebook">
									<svg><rect width="0" height="0"/></svg>
									<i class="ion-social-facebook"></i>
								</a>
							</li>
							<li>
								<a href="#" class="youtube">
									<svg><rect width="0" height="0"/></svg>
									<i class="ion-social-youtube-outline"></i>
								</a>
							</li>
							<li>
								<a href="#" class="googleplus">
									<svg><rect width="0" height="0"/></svg>
									<i class="ion-social-googleplus"></i>
								</a>
							</li>
							<li>
								<a href="#" class="instagram">
									<svg><rect width="0" height="0"/></svg>
									<i class="ion-social-instagram-outline"></i>
								</a>
							</li>
						</ul>
						<a href="#" class="btn btn-magz white btn-block">1:1문의하기 <i class="ion-ios-arrow-thin-right"></i></a>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<div class="copyright">
					COPYRIGHT &copy; PAUSE IN BRACE 2024. ALL RIGHT RESERVED.
					<div>
						Made by RUNIC.
					</div>
				</div>
			</div>
		</div>
	</div>
</footer>
<!-- End Footer -->
<!-- JS -->
<script src="${ctp}/js/jquery.migrate.js"></script>
<script>var $target_end=$(".best-of-the-week");</script>
<script src="${ctp}/js/jquery.number.min.js"></script>
<script src="${ctp}/js/owl.carousel.min.js"></script>
<script src="${ctp}/js/jquery.magnific-popup.min.js"></script>
<script src="${ctp}/js/jquery.easeScroll.js"></script>
<script src="${ctp}/js/sweetalert.min.js"></script>
<%-- <script src="${ctp}/js/jquery.toast.min.js"></script> --%>
<script src="${ctp}/js/demo.js"></script>
<script src="${ctp}/js/e-magz.js"></script>
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
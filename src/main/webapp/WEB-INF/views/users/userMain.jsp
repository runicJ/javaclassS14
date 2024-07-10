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
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
	<section class="userMain" style="padding-top: 245.125px;">
		<div class="container">
			<div class="row">
			<jsp:include page="/WEB-INF/views/include/user/sidebar.jsp" />
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
<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
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
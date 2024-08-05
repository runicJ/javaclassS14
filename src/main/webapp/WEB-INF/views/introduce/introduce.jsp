<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>introduce</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
	<style>
		@media (min-width: 320px) and (max-width: 980px) {
		    .web-show {
		        display: none !important;
		    }
		}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<p><br></p>
<div class="container">
<section class="about-cont01 web-show">	
	<div class="continner">
		<div>
			<h2 class="mb-4">'괄호 안 쉼표' 소개</h2>
			<img src="${ctp}/images/logo.png" alt="메인 로고 이미지" style="width:300px;" class="float-right">
		</div>
		<div class="cont01-gallery">
			<div class="cont01-list">
				<div class="cont01-txt">
					<strong>
						숨, 공기,<br>더 나은 미래를 위한 노력
					</strong>
					<p>
						지금은 어느 시대보다 미래의 최소한의 삶의 질에 대한 기로에 서있습니다.<br>저희 모두 미래의 사람들과 지구를 지키는 책임감이 가지고 생활해야 합니다.
					</p>
				</div>
			</div>
			<div class="cont01-list">
				<div class="cont01-txt">
					<p>
						불과 몇 년 전에는 알지 못 했지만, 대기나 기타 여러가지 환경적 요소에 따라<br>삶의 질이 우리의 건강이 얼마나 달라질 수 있는지 우리 모두 느끼고 있습니다. 
					</p>
				</div>
			</div>
			<div class="cont01-list">
				<div class="cont01-txt">
					<p>
						저희 '괄호 안 쉼표'에서는 성인들을 위한, 그리고 미래를 살아갈 우리 아이들을 위해 환경적 요소에 따라 편차가 큰 알레르기 관련 정보를 제공하고 있으며,<br>
						알레르기 정보를 서로 공유하고 검증된 알러지프리 제품을 판매하여, 알레르기의 발현을 방지하기 위해 노력하고 있습니다.<br>
						이외에도 저희 사이트에서는 다양한 정보를 제공하기 위해 발전을 게을리 하지 않으며, 성장하는 '괄호'가 되도록 하겠습니다!
					</p>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="about-cont02">
	<div class="cont-inner">
		<h2 class="mb-4"> 파트너</h2>
		<ul>
		   <li>
				<figure class="float-right"><img src="${ctp}/images/logoSN.png" alt="Serene Nest logo" style="width:300px;"></figure>
				<dl>
					<dt>Serene Nest</dt>
					<dd>Serene Nest에서는 인구감소지역의 지역의 방문적 특성을 분석하여 축적된 데이터를 기반으로 해당 지역의 주요 관광적 요소와 특성을 도출하고,<br>
					이를 바탕으로 지역경제활성화 방안을 마련하기 위해 노력하고 있습니다.<br>
					또한 정부에서도 '정주인구'가 아닌 '생활인구'에 대한 정의가 새로 만들어지고, 「인구감소지역 지원 특별법」의 시행으로 인구감소 및 지방소멸 문제에 대해<br>
					효과적으로 대응하기 위해 노력하고 있으며, 지역 관광지 확장으로 일자리 창출과 외국인 관광객 유치를 기대하고 있습니다.</dd>
					<dd><a href="http://49.142.157.251:9090/javaclassJ14/Main" class="btn btn-info" target="_blank">웹사이트 바로가기</a></dd>
				</dl>
		   </li>
		   <li>						   
				<dl>
					<dt>너나들이 작은 도서관</dt>
					<dd>너나들이 작은 도서관은 지역 단위로 지어지는 작은 도서관을 계획 하에, 시민들에게 도서 기증 공모를 통해 참여에 대한 보상을 제공하고 있습니다.<br>
					이를 통해 같은 예산으로 더 많은 도서를 제공할 수 있고 환경에 대해 긍정적인 요소를 생각해 볼 수 있습니다.<br>
					또한 시민들이 직접 작은 도서관을 함께 만들어가며, 시민들의 참여가 중심이 되는 프로그램을 제공할 수 있도록 노력하고 있습니다.</dd>
				</dl>
		   </li>
	   </ul>
   </div>
</section>
</div>
<p><br></p>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
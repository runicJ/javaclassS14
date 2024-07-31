<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=divice-width, initial-scale=1.0">
	<title>title</title>
	<link rel="icon" type="image/png" href="images/favicon-mark.png">
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
	<div class="cont-inner">
		<h2>'괄호 안 쉼표' 소개</h2>
		<div class="cont01-gallery">
			<div class="cont01-list">
				<img src="${ctp}/images/logo.png" alt="메인 로고 이미지" style="width:100px;">
				<div class="cont01-txt">
					<strong>
						숨, 공기,<br>더 나은 미래를 위한 노력
					</strong>
					<p>
						지금은 어느 시대보다 미래의 최소한의 삶의 질에 대한 기로에 서있습니다. 저희 모두 미래의 사람들과 지구를 지키는 책임감이 가지고 생활해야 합니다.
					</p>
				</div>
			</div>
			<div class="cont01-list">
				<div class="cont01-txt">
					<p>
						몇 년 전에는 알지 못했던 대기나 기타 여러가지 환경적 요소에 따라 삶의 질이 우리의 건강이 얼마나 달라질 수 있는지 우리 모두 느끼고 있습니다. 
					</p>
				</div>
				<img src="${ctp}/images/logo2.png" alt="서브 로고 이미지1" style="width:100px;">
			</div>
			<div class="cont01-list">
				<img src="${ctp}/images/logologo.png" alt="서브 로고 이미지2" style="width:100px;">
				<div class="cont01-txt">
					<p>
						2017년 진행된 스웨덴 코리아 영 디자인 위크(Sweden Korea Young Design Week)는 스웨덴과 한국의 새로운 협업을 통해 디자인의 오늘을 이야기하고, 내일을 엿볼 수 있는 시간이었으며, 이는 KSYDA의 초석의 된 행사였습니다.<br>스웨덴 Ung Svensk Form에서 선정된 디자이너들과 이케아 코리아, 그리고 한국의 디자인 전공 학생들의 협업으로 이루어진 이 전시는 신진 디자이너들의 개성 넘치는 작품들과 함께 이케아의 데모크래틱 디자인을 기반으로 개발된 대표적인 제품들을 선보였으며, KSYDA의 시작을 선포했습니다.
					</p>
				</div>
			</div>
		</div>
	</div>
</section>
<section class="about-cont02">
	<div class="cont-inner">
		<h2> 파트너</h2>
		<ul>
		   <li>
				<figure><img src="/eng/images/sub/about_partner01.png" alt="Embassy of Sweden in Seoul logo"></figure>
				<dl>
					<dt>주한스웨덴대사관</dt>
					<dd>주한스웨덴대사관은 문화·사회·정치·경제 제반 분야에서 스웨덴과 한국 양국간 관계를 증진시키고자 다양한 노력을 기울이고 있습니다. 1959년 수교 이후 스웨덴과 한국의 오랜 협력 관계를 유지하며, 다양한 분야에서 교류를 확대해 가고 있습니다. 한국 정부, 공공기관, 기업 및 유관기관과의 지속적인 대화를 통해 끊임없는 상호 협력을 추구함과 동시에, 한국의 문화, 정치, 경제, 사회 발전에 대해 스웨덴과 공유하는 역할을 수행하고 있습니다.</dd>
					<dd class="btn-guide"><a href="https://www.swedenabroad.se/ko/embassies/%EB%8C%80%ED%95%9C%EB%AF%BC%EA%B5%AD-%EC%84%9C%EC%9A%B8/" class="btn" target="_blank">웹사이트 바로가기</a></dd>
				</dl>
		   </li>
		   <li>						   
				<figure><img src="/eng/images/sub/about_partner02.png" alt="KIDP logo"></figure>
				<dl>
					<dt>한국디자인진흥원</dt>
					<dd>한국디자인진흥원은 디자인 주도 혁신으로 국민 행복을 도모하고 국가경쟁력을 강화하기 위해 1970년에 설립된 산업통상자원부 산하 공공기관입니다. 
					국내 유일의 국가 주도 디자인 기관으로, 디자인 인재육성 및 교육, 연구 및 정책개발, 해외시장 진출, 기업지원 및 창업육성, 연구 및 정책개발, 정보제공 등 디자인 영역 전반을 아우르며 한국 디자인 산업 경쟁력 향상을 위해 노력하고 있습니다.</dd>
					<dd class="btn-guide"><a href="https://kidp.or.kr/?menuno=773" class="btn" target="_blank">웹사이트 바로가기</a></dd>
				</dl>
		   </li>
		   <li>
				<figure><img src="/eng/images/sub/about_partner03.png" alt="IKEA logo"></figure>
				<dl>
					<dt>이케아 코리아</dt>
					<dd>이케아 코리아는 2014년 이케아 광명점을 시작으로 국내에 공식 진출했으며, 현재 이케아 고양점, 기흥점, 동부산점 등 4개의 오프라인 매장과 이커머스를 운영 중입니다. ‘많은 사람들을 위한 더 좋은 생활을 만든다’는 이케아 비전을 실현하기 위해 한국에서 더 많은 사람들이 홈퍼니싱을 통해 집을 더욱 사랑할 수 있도록 돕고 있으며, 최근에는 모든 온·오프라인 접점에서 옴니채널 솔루션을 강화해 더 낮은 가격과 편리함을 제공하고 지속가능한 이케아가 되기 위해 노력하고 있습니다. 또한 사람 중심적인 기업으로서 다양한 경험과 지식을 가진 직원들에게 일하기 좋은 환경을 제공하고, 좋은 이웃으로서 지역사회에 긍정적인 영향을 줄 수 있도록 지속적으로 힘쓰고 있습니다.</dd>
					<dd class="btn-guide"><a href="https://www.ikea.com/kr/ko/" class="btn" target="_blank">웹사이트 바로가기</a></dd>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>greeting</title>
	<link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
	<jsp:include page="/WEB-INF/views/include/user/bs4.jsp" />
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp" />
<jsp:include page="/WEB-INF/views/include/user/nav.jsp" />
<section class="page">
	<div class="container">
		<ol class="breadcrumb">
			<li><a href="${ctp}/main">Home &nbsp;</a></li>
			<li><i class="fa-solid fa-hashtag"></i></li>
			<li class="active">인사말</li>
		</ol>
		<h1 class="page-title">이곳은, { '괄호 안 쉼표' } 입니다</h1>
		<p class="page-subtitle">안녕하세요. 이곳에 오신 것을 환영합니다!</p>
		<div class="line thin"></div>
		<div class="page-description">
			<div class="row">
				<div class="col-6">
					<p><br></p>
					<img src="${ctp}/images/greeting.jpg" alt="환영합니다!" height="600px" width="auto"/>
				</div>
				<div class="col-6">
					<h4>괄호 안 쉼표 { , }</h4><br>
					<p>
						안녕하세요. 이곳은 제가 만든 공간입니다. 여기까지 오신 분들, 진심으로 환영합니다. <br>
						오신 분들 모두 각자의 사정으로 이 사이트에 방문하시게 되었을 것입니다. <br>
						부디 원하시고, 찾고자 하시는 '해답'을 가져가실 수 있기를 바랍니다. <br>
						이곳에서 말하는 '괄호'는 여러분의 해석에 따라 달라질 수 있겠지만, <br>
						제가 생각한 '괄호'는 우리가 살아가는 이곳, 세계-공간을 상징한다고 생각했습니다. <br>
					</p>
					<p>
						이 '괄호' 안에서 우리는 숨을 쉬고 생활하며, 이 안에서 삶을 이어갑니다. <br>
						그러나 한정된 공간 안에서 점차 삶이 각박해지고 어려워지며, <br>
						우리가 무한히 누리던 공기마저 변화되면서 이 안온한 공간이 점점 답답해지고 <br>
						우리를 힘들게 하는 방향으로 변화하고 있다고 생각했습니다. <br>
						이러한 공간 안에서, 우리의 '괄호'를 더 나은 방향으로 이끌기 위해 노력하고 있는 <br>
						저희 모두에게 '쉼표'를 찍고 싶다는 생각을 하게 되었습니다. <br>
						여러분 모두, 저를 포함한 모두에게 여러분의 '쉼표'를 누릴 수 있기를 진심으로 바랍니다. <br>
						감사합니다! <br>
					</p>
					<p> 
						feat, 이것은 저의 '괄호 안 쉼표'입니다. <br> 
					 	여러분 각자의 '괄호'를 생각하셔도 좋고,<br>
					 	함께 누리고 싶은 '쉼표'를 떠올리셔도 좋습니다.<br>
					 	부디 저희 사이트에서 함께 생각을 논해주세요:)
					</p>
					<span class="float-right"> 관리자 올림 </span>
		
				</div>
			</div>
			<p><br></p>
			<div class="question">
				이 사이트에 대해 궁금하신가요? <a href="${ctp}/cswork/qna/qnaApply" class="btn btn-primary">관리자에게 질문하세요</a>
			</div>
		</div>
	</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp" />
</body>
</html>
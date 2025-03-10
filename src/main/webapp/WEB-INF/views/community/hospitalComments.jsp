<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>hospitalComments</title>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
  <style>
  	.review-details {
  		display: none;
  		background-color: #f8f8fa;
  		padding: 15px;
  		border-left: 3px solid #007aff;
  		max-width: 100%;
  		min-height: 100px;
  	}
  </style>
  <script>
  	'use strict';
  	
  	$(document).ready(function() {
  		$(".toggle-comment").click(function(e){
  			e.preventDefault();
  			
  			var commentId = $(this).data("id");
  			var contentDiv = $("#content-" + commentId);
  			var commentRow = $("#comment-" + commentId);
  			
  			if (commentRow.is(":visible")) {
  				commentRow.hide();  // 후기가 열려있으면 닫기
  			} else {
  				$(".comment-details-row").hide();  // 다른 후기 닫기
  				commentRow.show();  // 후기 열기
  				
  				if(contentDiv.is(":empty")) {
  					$.ajax({
  						url: "${ctp}/community/hospitalCommentView",
  						type: "GET",
  						data: {hospitalCommentIdx: commentId},
  						success: function(data) {
  							contentDiv.html(data);
  						},
  						error: function() {
  							contentDiv.html("<p class='text-danger'>후기를 불러오지 못했습니다.</p>");
  						}
  					});
  				}
  			}
  		});
  	});
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
<section class="page">
<div class="container">
  <h2 class="text-center"><b>🏥 병원 후기 리스트</b></h2>
  <br/><hr/><br/>
  <table class="table table-hover">
    <thead class="table-dark text-center">
      <tr>
        <th>번호</th>
        <th>제목</th>
        <th>별점</th>
        <th>대기 시간</th>
        <th>작성자</th>
        <th>작성일</th>
      </tr>
    </thead>
    <tbody>
      <c:set var="cnt" value="${fn:length(comments)}"/>
      <c:forEach var="comment" items="${comments}">
        <tr class="text-center">
          <td>${cnt}</td>
          <td>
            <a href="#" class="toggle-comment" data-id="${comment.hospitalCommentIdx}">
              ${comment.hospitalCommentTitle}
            </a>
          </td>
          <td>⭐ ${comment.starRating}</td>
          <td>⏳ ${comment.waitingTime}분</td>
          <td>${comment.maskedUserId}</td>
          <td>${fn:substring(comment.createdAt,0,10)}</td>
        </tr>
        
        <tr class="comment-details-row" id="comment-${comment.hospitalCommentIdx}" style="display:none;">
        	<td colspan="7">
        		<div class="comment-details" id="content-${comment.hospitalCommentIdx}">
        			${fn:replace(comment.hospitalComment, newLine, '<br/>')}
        		</div>
        	</td>
        </tr>
        <c:set var="cnt" value="${cnt - 1}"/>
      </c:forEach>
    </tbody>
  </table>
</div>
</section>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
<p><br/></p>
</body>
</html>

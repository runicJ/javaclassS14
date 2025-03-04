<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<%-- <c:set var="content" value="${fn:replace(fn:replace(vo.content, '\r\n', '<br/>'), '\n', '<br/>')}"/> --%>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>NoticeList</title>
  <jsp:include page="/WEB-INF/views/include/user/bs4.jsp"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/user/header.jsp"/>
<jsp:include page="/WEB-INF/views/include/user/nav.jsp"/>
<p><br/></p>
<div class="container">
  <table class="table table-borderless">
    <tr>
      <td align="center" colspan=2><font size=5><b>📢 공지사항 리스트</b></font></td>
    </tr>
  </table>
  <div id="notifyContent">
	  <form name="myform" method="get">
	    <ul>
	      <c:set var="cnt" value="1"/>
	      <c:forEach var="vo" items="${vos}" varStatus="st">
	        <c:if test="${vo.popupSw == 'Y'}">
		        <li><hr>
		          <span>
		            <div class="container mt-3">
		              <div class="d-flex justify-content-between mb-3">
		                <div class="p-2">
		                  <h5><b>[공지${cnt}] ${vo.title}</b></h5>&nbsp; &nbsp;
		                </div>
		              </div>
		            </div>
		          </span>
		          <ul style="background-color:#fff5ee" class="ml-2 pt-2 pb-2">
		            <c:set var="content" value="${fn:replace(vo.content,newLine,'<br/>')}"/>
		            <li>${content}</li><br/>
		            <li>게시일 : ${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</li>
		          </ul>
		        </li>
		        <c:set var="cnt" value="${cnt+1}"/>
	        </c:if>
	      </c:forEach>
	    </ul>
	  </form>
	  <br/><hr/><br/>
	  <h3 class="text-center">-공 지 사 항-</h3><br/>
	    <table class="table table-hover">
	      <tr class="table-dark text-dark text-center">
	        <th>번호</th>
	        <th>제목</th>
	        <th>게시기간</th>
	      </tr>
	      <c:set var="cnt" value="${fn:length(vos)}"/>
			  <c:forEach var="vo" items="${vos}">
					<tr class="text-center">
					  <td>${cnt}</td>
					  <td><a href="javascript:window.open('${ctp}/notify/notifyView?idx=${vo.idx}','mnList','width=560px,height=600px')">${vo.title}</a></td>
					  <td>${fn:substring(vo.startDate,0,10)} ~ ${fn:substring(vo.endDate,0,10)}</td>
					</tr>
					<c:set var="cnt" value="${cnt - 1}"/>
					<tr><td colspan="3" class="m-0 p-0"></td></tr>
		    </c:forEach>
	    </table>
  </div>
</div>
<jsp:include page="/WEB-INF/views/include/user/footer.jsp"/>
<p><br/></p>
</body>
</html>
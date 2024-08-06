<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert</title>
  	<jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
  	<script>
  		'use strict';
  		
  		function userDelete(delFlag, userId) {
  			
  		}
  	</script>
</head>
<body>
	<div class="preloader">
        <div class="lds-ripple">
            <div class="lds-pos"></div>
            <div class="lds-pos"></div>
        </div>
    </div>
    <div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
        <jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
		<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />
        <div class="page-wrapper">
            <div class="card">
                <div class="card-body text-center">
                    <h2 class="card-title mb-3">탈퇴 회원 목록</h2>
                   	<div class="float-right mb-1">
						<select name="part" id="part" onchange="optChange()" class="custom-select mr-3" style="width:150px;">
					        <option selected>선택</option>
					        <option value="탈퇴신청" ${part == '탈퇴신청' ? 'selected' : ''}>탈퇴신청</option>
					        <option value="탈퇴유예만료" ${part == '탈퇴유예만료' ? 'selected' : ''}>탈퇴유예만료</option>
					        <option value="탈퇴완료" ${part == '탈퇴완료' ? 'selected' : ''}>탈퇴완료</option>
					    </select>
					    <a type="button" href="${ctp}/users/usersDelete" class="btn btn-info btn-sm mr-1">일괄 탈퇴승인</a>
					    <a type="button" href="${ctp}/users/usersDelete" class="btn btn-danger btn-sm">일괄 탈퇴취소</a>
					</div>
                    <div class="table-responsive">
                        <table class="table bg-dark text-light">
                            <thead class="bg-inverse text-white">
                                <tr>
                                    <th>
                                    	<div class="custom-control custom-checkbox">
		                                    <input type="checkbox" class="custom-control-input" id="customCheck">
	                                    	<label class="custom-control-label" for="customCheck">번호</label>
                                    	</div>
                                    </th>
                                    <th>아이디</th>
                                    <th>이메일</th>
                                    <th>탈퇴 일자</th>
                                    <th>탈퇴진행상태</th>
                                    <th>탈퇴 사유</th>
                                    <th>비고</th>
                                </tr>
                            </thead>
                            <tbody>
			  					<c:forEach var="vo" items="${vos}" varStatus="st">
                                <tr>
                                    <td>
										<div class="custom-control custom-checkbox">
		                                    <input type="checkbox" class="custom-control-input" id="customCheck${st.count}">
	                                    	<label class="custom-control-label" for="customCheck${st.count}">${st.count}</label>
                                    	</div>
                                    </td>
                                    <td>${vo.userId}</td>
                                    <td>${vo.email}</td>
                                    <td>${fn:substring(vo.deleteDate,0,19)}</td>
                                    <td>${vo.deleteDiff <= -30 ? "탈퇴유예만료" : "탈퇴신청"} (${-vo.deleteDiff}일)</td>
                                    <td>${vo.deleteReason}</td>
                                    <td>
                                    	<%-- <a type="button" href="userDelete('Ok', ${vo.userId})" class="badge badge-info text-light mr-1">탈퇴승인</a>
		                            	<a type="button" onclick="${ctp}/admin/user/userDelete?delFlag=No&userId=${vo.userId}" class="badge badge-danger text-light">탈퇴취소</a> --%>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />
</body>
</html>
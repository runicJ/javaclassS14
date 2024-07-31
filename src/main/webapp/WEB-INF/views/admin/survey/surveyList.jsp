<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" type="image/png" href="${ctp}/images/favicon-mark.png">
    <title>surveyList</title>
    <jsp:include page="/WEB-INF/views/include/admin/bs4.jsp" />
    <style>
        h2 {
            margin: 20px 0;
        }
        table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        th, td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #6C757D;
            color: white;
        }
        .survtitle a {
            color: black;
            text-decoration: none;
        }
        .survtitle a:hover {
            color: pink;
        }
        button {
            margin: 10px;
            padding: 0.5rem 1rem;
            font-size: 1rem;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: black;
            color: white;
        }
    </style>
    <script>
        function viewRslt(surveyIdx) {
            location.href = '/admin/surveyResult?surveyIdx=' + surveyIdx;
        }

        function editSurv(surveyIdx) {
            location.href = '/admin/editSurvey?surveyIdx=' + surveyIdx;
        }

        function deleteSurv(surveyIdx) {
            if (confirm('정말로 이 설문을 삭제하시겠습니까?')) {
                location.href = '/admin/deleteSurvey?surveyIdx=' + surveyIdx;
            }
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
        <div class="card p-5">
			<h2><i class="fa-solid fa-list-check"></i> 설문 목록</h2>
        <br>
        <span style="font-weight: bold;">전체 설문 수: <c:out value="${total}" /></span>
        <div class="table">
            <table>
                <thead>
                    <tr>
                        <th>설문 번호</th>
                        <th>설문 제목</th>
                        <th>사용 여부</th>
                        <th>등록 날짜</th>
                        <th>최종 수정 날짜</th>
                        <th>결과</th>
                        <th>수정</th>
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${not empty survList}">
                        <c:forEach var="surv" items="${survList}">
                            <tr>
                                <td class="survno"><c:out value="${surv.surveyIdx}" /></td>
                                <td class="survtitle">
                                    <a href="#" onclick="editSurv(${surv.surveyIdx});"><c:out value="${surv.surveyTitle}" /></a>
                                </td>
                                <td class="useFlag">
                                    <c:choose>
                                        <c:when test="${surv.useFlag == 'y'}">사용중</c:when>
                                        <c:otherwise>사용 안함</c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="createDate"><c:out value="${surv.createDate}" /></td>
                                <td class="modDate"><c:out value="${surv.modDate}" /></td>
                                <td class="result">
                                    <button onclick="viewRslt(${surv.surveyIdx});">결과 보기</button>
                                </td>
                                <td class="edit">
                                    <button onclick="editSurv(${surv.surveyIdx});">수정</button>
                                </td>
                                <td class="delete">
                                    <button onclick="deleteSurv(${surv.surveyIdx});">삭제</button>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty survList}">
                        <tr>
                            <td colspan="8" style="text-align: center;">등록된 설문이 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
    </div>
</div>
</body>
</html>

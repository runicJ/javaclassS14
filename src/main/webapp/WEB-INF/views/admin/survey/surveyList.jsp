<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 - 설문 목록</title>

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
        .action-buttons button {
            margin: 5px;
            padding: 5px 10px;
            font-size: 14px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .action-buttons button:hover {
            background-color: black;
            color: white;
        }
        .search-bar {
            margin-bottom: 20px;
        }
        .search-bar select, .search-bar input {
            padding: 5px;
            font-size: 14px;
        }
    </style>

    <script>
        function editSurvey(surveyIdx) {
            location.href = '${ctp}/admin/survey/editSurvey?surveyIdx=' + surveyIdx;
        }

        function deleteSurvey(surveyIdx) {
            if (confirm('정말로 이 설문을 삭제하시겠습니까?')) {
                location.href = '${ctp}/admin/survey/deleteSurvey?surveyIdx=' + surveyIdx;
            }
        }
    </script>
</head>
<body>
<div id="main-wrapper" data-theme="light" data-layout="vertical" data-navbarbg="skin6" data-sidebartype="full" data-sidebar-position="fixed" data-header-position="fixed" data-boxed-layout="full">
<jsp:include page="/WEB-INF/views/include/admin/header.jsp" />
<jsp:include page="/WEB-INF/views/include/admin/sidebar.jsp" />

<div class="container">
    <h2><i class="fa-solid fa-list-check"></i> 설문 목록 (관리자)</h2>

    <div class="search-bar">
        <strong>전체 설문 수:</strong> <c:out value="${total}" />
    </div>

    <table>
        <thead>
            <tr>
                <th>설문 번호</th>
                <th>설문 제목</th>
                <th>사용 여부</th>
                <th>등록 날짜</th>
                <th>최종 수정 날짜</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${not empty survList}">
                    <c:forEach var="surv" items="${survList}">
                        <tr>
                            <td>${surv.surveyIdx}</td>
		                    <td>
		                        <a href="${ctp}/admin/survey/surveyResult?surveyIdx=${surv.surveyIdx}" style="text-decoration:none; color:inherit;">
		                            ${surv.surveyTitle}
		                        </a>
		                    </td>
                            <td>
                                <c:choose>
                                    <c:when test="${surv.useFlag == 'y'}">사용중</c:when>
                                    <c:otherwise>사용 안함</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${fn:substring(surv.createDate, 0, 10)}</td>
                            <td>${fn:substring(surv.modDate, 0, 10)}</td>
                            <td class="action-buttons">
                                <button onclick="editSurvey(${surv.surveyIdx});">수정</button>
                            </td>
                            <td class="action-buttons">
                                <button onclick="deleteSurvey(${surv.surveyIdx});">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="8">등록된 설문이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>
</div>
<jsp:include page="/WEB-INF/views/include/admin/footer.jsp" />

</body>
</html>
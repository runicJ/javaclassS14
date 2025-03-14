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
        
        document.addEventListener("DOMContentLoaded", function() {
            const buttons = document.querySelectorAll(".toggle-useFlag");

            buttons.forEach(button => {
                button.addEventListener("click", function() {
                    let surveyIdx = this.getAttribute("data-surveyidx");
                    let currentFlag = this.getAttribute("data-useflag");
                    let newFlag = (currentFlag === 'y') ? 'n' : 'y';  // 현재 값 반전

                    if (confirm("설문을 " + (newFlag === 'y' ? '사용' : '사용 안함') + " 상태로 변경하시겠습니까?")) {
                        fetch("${ctp}/admin/survey/updateUseFlag", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/x-www-form-urlencoded"
                            },
                            body: "surveyIdx=" + surveyIdx + "&useFlag=" + newFlag
                        })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                alert("사용 여부가 변경되었습니다.");
                                location.reload(); // 변경 사항 반영
                            } else {
                                alert("변경에 실패했습니다.");
                            }
                        })
                        .catch(error => console.error("Error:", error));
                    }
                });
            });
        });
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
							    <button class="toggle-useFlag" data-surveyidx="${surv.surveyIdx}" data-useflag="${surv.useFlag}">
							        <c:choose>
							            <c:when test="${surv.useFlag eq 'y'}">사용</c:when>
							            <c:otherwise>사용 안함</c:otherwise>
							        </c:choose>
							    </button>
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